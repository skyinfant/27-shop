/**
 *
 */
package com.xdclass.shop.service;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xdclass.shop.common.Constants;
import com.xdclass.shop.common.OrderCouponDto;
import com.xdclass.shop.common.Page;
import com.xdclass.shop.model.*;
import com.xdclass.shop.repository.CouponRepository;
import com.xdclass.shop.repository.OrderItemRepository;
import com.xdclass.shop.repository.OrderRepository;
import com.xdclass.shop.repository.UserCouponRepository;
import org.apache.rocketmq.client.producer.DefaultMQProducer;
import org.apache.rocketmq.client.producer.SendCallback;
import org.apache.rocketmq.client.producer.SendResult;
import org.apache.rocketmq.common.message.Message;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;

/**
 * @author Daniel
 */
@Service
@Transactional
public class OrderService {

    @Autowired
    OrderRepository orderDao;
    @Autowired
    OrderItemRepository orderItemDao;
    @Autowired
    UserAddressService userAddressService;
    @Autowired
    UserCouponRepository userCouponRepository;
    @Autowired
    private CouponRepository couponRepository;
    @Autowired
    private DefaultMQProducer producer;

    private static final Logger log = LoggerFactory.getLogger(OrderService.class);


    public void save(Order order) {
        orderDao.save(order);
    }

    public Order findById(Integer id) {
        return orderDao.findOne(id);
    }

    public List<Order> findAll() {
        return orderDao.findAll();
    }

    public List<Order> findOrders(Page<Order> page) {
        page.setResult(orderDao.findAll(page.getPageable()).getContent());
        page.setTotalCount(orderDao.count());
        return page.getResult();
    }

    public List<Order> findOrders(Page<Order> page, Integer userId) {
        page.setResult(orderDao.findByUserId(userId, page.getPageable()).getContent());
        page.setTotalCount(orderDao.countByUserId(userId));
        return null;
    }

    /**
     * ????????????????????????????????????
     *
     * @param id ??????ID
     */
    public void deleteOrder(Integer id) {
        orderItemDao.deleteByOrderId(id);
        orderDao.delete(id);
    }



    /**
     * ?????????????????????
     *
     * @param orderId
     * @param userId
     * @return
     */
    public boolean checkOwned(Integer orderId, Integer userId) {
        return orderDao.findOne(orderId).getUser().getId().equals(userId);
    }

    /**
     * @description:  ????????????mq??????
     * @param: message
     * @return: void
     */
    private void send(Message message) {
        try {
            producer.send(message, new SendCallback() {
                @Override
                public void onSuccess(SendResult sendResult) {
                    log.info("????????????");
                    log.info(JSON.toJSONString(sendResult));
                }

                @Override
                public void onException(Throwable e) {
                    log.error("????????????", e);
                }
            });
        } catch (Exception e) {
            log.error("????????????", e);
        }
    }

    /**
     * ????????????
     *
     * @param order
     * @param orderItemList
     * @param userAddress
     */
    public String addOrder(Order order, List<OrderItem> orderItemList, UserAddress userAddress, String userCouponCode) {
        List<UserCoupon> userCoupons = userCouponRepository.findByUserCouponCode(userCouponCode);
        if (CollectionUtils.isEmpty(userCoupons)) {
            return "?????????????????????????????????";
        }
        UserCoupon userCoupon = userCoupons.get(0);
        Coupon conpon = couponRepository.findOne(userCoupon.getCouponId());
        if (conpon == null) {
            return "?????????????????????????????????";
        }
        int reduceAmount = conpon.getReduceAmount();
        int achieveAmount = conpon.getAchieveAmount();
        if (achieveAmount > order.getFinalPrice()) {
            return "???????????????????????????????????????";
        }
        order.setFinalPrice(order.getFinalPrice() - reduceAmount);
        userAddressService.save(userAddress);
        //????????????
        save(order);

        for (OrderItem orderItem : orderItemList) {
            orderItemDao.save(orderItem);
        }

//        userCoupon.setOrderId(order.getId());
//        userCoupon.setStatus(1);
//        userCouponRepository.saveAndFlush(userCoupon);

        updateUserCouponAfterOrder(order.getId(), order.getUser().getId(), userCouponCode);

        return null;
    }


    /**
     * @description:  ?????????????????????coupon???order????????????
     *                ??????????????????????????????????????????????????????????????????
     *                ??????????????????t_user_coupon??????????????????????????????????????????????????????
     * @param: orderId
     * @param: userId
     * @param: couponCode
     * @return: void
     */
    private void updateUserCouponAfterOrder(int orderId, int userId, String couponCode) {
        OrderCouponDto dto = new OrderCouponDto(couponCode, orderId, userId);
        //?????????????????????mq?????????coupon????????????????????????t_user_coupon???
        Message message = new Message("saveOrder", "Tag1", "12345", JSONObject.toJSONBytes(dto));
        send(message);
    }


    /**
     * @description:  ????????????
     * @param: orderId
     * @return: void
     */
    public void pay(Integer orderId) {
        Order order = orderDao.findOne(orderId);
        order.setStatus(Constants.OrderStatus.PAYED);
        order.setPayTime(new Date());
        orderDao.save(order);
        updateUserCouponAfterPay(orderId, order.getUser().getId());
        log.info("send pay result success");
    }

    /**
     * @description:  ???????????????????????????mq??????coupon??????????????????coupon?????????coupon?????????
     * @param: orderId
     * @param: userId
     * @return: void
     */
    private void updateUserCouponAfterPay(int orderId, int userId) {
        OrderCouponDto dto = new OrderCouponDto(orderId, userId, 0);
        Message message = new Message("payResult", "Tag1", "12345", JSONObject.toJSONBytes(dto));
        //????????????mq??????
        send(message);
    }

    /**
     * ??????????????????
     *
     * @param orderID
     * @param status
     */
    public void updateOrderStatus(Integer orderID, Integer status) {
        Order order = orderDao.findOne(orderID);
        order.setStatus(status);
        //???????????????????????????????????????
        if (status == Constants.OrderStatus.PAYED) {
            order.setPayTime(new Date());
        } else if (status == Constants.OrderStatus.SHIPPED) {
            order.setShipTime(new Date());
        } else if (status == Constants.OrderStatus.ENDED) {
            order.setConfirmTime(new Date());
        }

        orderDao.save(order);
    }

    /**
     * @description: ?????????????????????????????????????????????????????????????????????????????????????????????
     * @param: orderId
     * @param: userId
     * @return: void
     */
    public void updateUserCouponAfterCancelOrder(int orderId, int userId) {
        OrderCouponDto dto = new OrderCouponDto(orderId, userId, 1);
        Message message = new Message("cancelOrder", "Tag1", "12345", JSONObject.toJSONBytes(dto));
        send(message);
    }
}

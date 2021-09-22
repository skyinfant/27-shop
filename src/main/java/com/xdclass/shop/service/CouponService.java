/**
 *
 */
package com.xdclass.shop.service;

import com.google.common.collect.Lists;
import com.tomorrowcat.couponserviceapi.dto.CouponDto;
import com.xdclass.shop.common.Page;
import com.xdclass.shop.dto.UserCouponDTO;
import com.xdclass.shop.model.*;
import com.xdclass.shop.repository.CouponRepository;
import com.xdclass.shop.repository.UserCouponRepository;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author daniel
 */
@Service
@Transactional
public class CouponService {


    @Autowired
    private CouponRepository couponRepository;

    @Autowired
    private UserCouponRepository userCouponRepository;


    @Reference
    private com.tomorrowcat.couponserviceapi.service.CouponService iCouponService;


    public void saveType(Coupon type) {
        couponRepository.save(type);
    }

    public List<Coupon> findType() {
        return couponRepository.findAll();
    }

    public void save(Coupon product) {
        couponRepository.save(product);
    }

    public Coupon findById(Integer id) {
        return couponRepository.findOne(id);
    }

    public List<Coupon> findAll() {
        return couponRepository.findAll();
    }


    /**
     * @description:  获取某一页的优惠券列表
     * @param: page
     * @return: List<CouponDto>
     */
    public List<CouponDto> findCoupon(Page<CouponDto> page) {
//        List<Coupon> coupons = couponRepository.findAll(page.getPageable()).getContent();
//        page.setResult(coupons);
//        page.setTotalCount(couponRepository.count());
//        return page.getResult();

        List<CouponDto> couponList = iCouponService.getCouponList();
        int pageSize = page.getPageSize();
        int pageNum = page.getPageNo();

        int start = (pageNum - 1) * pageSize;
        int end = pageNum * pageSize;
        List<CouponDto> pageList = Lists.newArrayList();
        for (int i = start; i < end; i++) {

            if(i > couponList.size()-1){
                break;
            }
            pageList.add(couponList.get(i));
            
        }
        page.setResult(pageList); //指定页的优惠券
        page.setTotalCount(couponList.size()); //优惠券总数量
        return page.getResult();
    }

    /**
     * @description: 用户领券
     * @param: userCoupon
     * @return String
     * @author: kim
     * @date: 2021/8/4 16:31
     */
    public String saveUserCoupon(UserCoupon userCoupon) {


        if (userCoupon.getCouponId() == null) {
            return "couponId不能为空";
        }
        Coupon coupon = couponRepository.findOne(userCoupon.getCouponId());
        if (coupon == null) {
            return "couponId无效";
        }
        userCoupon.setPicUrl(coupon.getPicUrl());
        userCoupon.setCreateTime(new Date());
        userCoupon.setUserCouponCode(UUID.randomUUID().toString().replaceAll("-", ""));
        userCouponRepository.save(userCoupon);
        return "领取成功";
    }

    /**
     * 组装UserCouponDTO信息
     *
     * @param userId
     * @return
     */
    public List<UserCouponDTO> warpUserCoupon(int userId) {
        List<UserCouponDTO> userCouponDTOs = Lists.newArrayList();
        List<UserCoupon> userCoupons = userCouponRepository.findByUserId(userId);
        userCouponDTOs = userCoupons.stream().map(userCoupon -> {
            UserCouponDTO userCouponDTO = new UserCouponDTO();
            Coupon coupon = findById(userCoupon.getCouponId());
            if (coupon != null) {
                BeanUtils.copyProperties(userCoupon, userCouponDTO);
                userCouponDTO.setAchieveAmount(coupon.getAchieveAmount());
                userCouponDTO.setReduceAmount(coupon.getReduceAmount());
            }
            return userCouponDTO;
        }).collect(Collectors.toList());
        return userCouponDTOs;
    }



}

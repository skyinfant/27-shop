/**
 *
 */
package com.xdclass.shop.controller;

import com.alibaba.fastjson.JSON;
import com.tomorrowcat.couponserviceapi.dto.CouponDto;
import com.tomorrowcat.couponserviceapi.dto.UserCouponDto;
import com.xdclass.shop.common.Page;
import com.xdclass.shop.model.Coupon;
import com.xdclass.shop.model.User;
import com.xdclass.shop.service.CouponService;
import com.xdclass.shop.service.UserService;
import com.xdclass.shop.util.UserUtil;
import org.apache.dubbo.config.annotation.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author Daniel
 *
 */
@Controller
@RequestMapping(value = "/coupon")
public class CouponController {

    private static final Logger logger = LoggerFactory.getLogger(CouponController.class);

    @Autowired
    CouponService couponService;

    @Autowired
    UserService userService;

    @Reference
    private com.tomorrowcat.couponserviceapi.service.CouponService iCouponService;


    /**
     * @description: 优惠券列表
     * @param: model
     * @param: request
     * @return: ModelAndView
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView listCoupon(ModelAndView model, HttpServletRequest request) {

        Page<CouponDto> page = new Page<CouponDto>(request);
        couponService.findCoupon(page);
        logger.info(JSON.toJSONString(page));

        model.addObject("page", page);
        model.setViewName("coupon/couponList");
        return model;
    }


    /**
     * @description:  用户领券
     * @param: request
     * @param: userCoupon
     * @param: session
     * @return: String
     */
    @RequestMapping(value = "/saveUserCoupon", method = RequestMethod.POST)
    @ResponseBody
    public String saveUserCoupon(HttpServletRequest request, UserCouponDto userCoupon, HttpSession session) {
        User user = userService.findOne(UserUtil.getUserFromSession(session).getId());
        if (user == null || user.getId() == null) {
            return "保存失败，用户不存在";
        }
        userCoupon.setUserId(user.getId());
        return iCouponService.saveUserCoupon(userCoupon);
    }

}

package com.xdclass.shop.controller;

import com.xdclass.shop.common.AppConfig;
import com.xdclass.shop.common.Constants;
import com.xdclass.shop.common.Page;
import com.xdclass.shop.common.web.JsonResult;
import com.xdclass.shop.model.Order;
import com.xdclass.shop.model.Remember;
import com.xdclass.shop.model.User;
import com.xdclass.shop.model.UserAddress;
import com.xdclass.shop.service.OrderService;
import com.xdclass.shop.service.RememberService;
import com.xdclass.shop.service.UserAddressService;
import com.xdclass.shop.service.UserService;
import com.xdclass.shop.util.CookieUtil;
import com.xdclass.shop.util.UserUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import static com.xdclass.shop.util.UserUtil.getUserFromSession;

/**
 * @author Daniel
 */
@Controller
@RequestMapping("/user")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    AppConfig appConfig;

    @Autowired
    UserService userService;

    @Autowired
    OrderService orderService;

    @Autowired
    UserAddressService userAddressService;

    @Autowired
    RememberService rememberService;

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "user/index";
    }

    @RequestMapping(value = "/reg", method = RequestMethod.GET)
    public String reg() {
        return "user/userReg";
    }

    @RequestMapping(value = "/reg", method = RequestMethod.POST)
    public String doReg(@Valid User user, Model model, BindingResult result) {
        if (result.hasErrors()) {
            for (ObjectError or : result.getAllErrors()) {
                logger.warn("????????????:{}\n????????????:{}", or.getCode(), or.getDefaultMessage());
            }
            model.addAttribute("error", "????????????,?????????");
            return "user/userReg";
        }
        userService.save(user);
        logger.info("??????????????????:{}", user);
        return "redirect:/";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginForm(HttpServletRequest request, HttpSession session) {
        String uuid;
        if (StringUtils.isNotBlank(uuid = CookieUtil.getCookieValue(request, appConfig.USER_COOKIE_NAME))) {
            Remember remember = rememberService.findById(uuid);
            if (remember != null && remember.getUser() != null) {
                if (userService.checkLogin(remember.getUser())) {
                    UserUtil.saveUserToSession(session, remember.getUser());
                    logger.info("??????[{}]??????cookie????????????.", remember.getUser().getUsername());
                    return "redirect:/";
                }
            }
        }
        return "user/userLogin";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String doLogin(User user, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        if (userService.checkLogin(user)) {
            user = userService.findByUsernameAndPassword(user.getUsername(), user.getPassword());
            UserUtil.saveUserToSession(session, user);
            logger.info("???????????????????????????{}", request.getParameter("remember"));

            if ("on".equals(request.getParameter("remember"))) {
                String uuid = UUID.randomUUID().toString();
                Remember remember = new Remember();
                remember.setId(uuid);
                remember.setUser(user);
                remember.setAddTime(new Date());
                rememberService.add(remember);
                CookieUtil.addCookie(response, appConfig.USER_COOKIE_NAME, uuid, appConfig.USER_COOKIE_AGE);
            } else {
                CookieUtil.removeCookie(response, appConfig.USER_COOKIE_NAME);
            }
            logger.info("??????[{}]????????????", user.getUsername());
            return "redirect:/";
        }
        return "redirect:/user/login?errorPwd=true";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session, HttpServletResponse response) {
        UserUtil.deleteUserFromSession(session);
        CookieUtil.removeCookie(response, appConfig.USER_COOKIE_NAME);
        return "redirect:/";
    }

    @RequestMapping(value = "/profile")
    public String profile(HttpSession session, Model model) {
        User user = getUserFromSession(session);
        if (user == null) {
            return "redirect:/user/login?timeout=true";
        }
        model.addAttribute("user", user);
        return "user/userProfile";
    }

    /**
     * ????????????
     *
     * @param session
     * @return
     */
    @RequestMapping(value = "/order", method = RequestMethod.GET)
    public String orderList(Model model, HttpSession session, HttpServletRequest request) {
        User user = getUserFromSession(session);
        org.springframework.util.Assert.notNull(user, "??????????????????????????????");
        Page<Order> page = new Page<>(request);
        orderService.findOrders(page, user.getId());
        model.addAttribute("page", page);
        return "order/orderList";
    }

    /**
     * ????????????
     *
     * @param session
     * @return
     */
    @RequestMapping(value = "/order/{id}", method = RequestMethod.GET)
    public String orderView(@PathVariable Integer id, Model model, HttpSession session, HttpServletRequest request) {
        User user = getUserFromSession(session);
        org.springframework.util.Assert.notNull(user, "??????????????????????????????");
        Order order = orderService.findById(id);
        model.addAttribute("order", order);
        return "order/orderView";
    }

    /**
     * ????????????
     *
     * @param session
     * @return
     */
    @RequestMapping(value = "/order/confirm/{id}")
    @ResponseBody
    public JsonResult orderConfirm(@PathVariable Integer id, Model model, HttpSession session, HttpServletRequest request) {
        User user = getUserFromSession(session);
        org.springframework.util.Assert.notNull(user, "??????????????????????????????");
        Order order = orderService.findById(id);

        JsonResult result = new JsonResult();
        if (Objects.equals(order.getUser().getId(), user.getId())) {
            orderService.updateOrderStatus(id, Constants.OrderStatus.ENDED);
            result.setToSuccess();
        } else {
            result.setToFail();
        }
        return result;
    }

    /**
     * ??????????????????
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/userAddressList/{id}")
    @ModelAttribute
    @ResponseBody
    public List<UserAddress> getUserAddressList(@PathVariable int id) {
        return userAddressService.findByUserId(id);
    }

    @RequestMapping(value = "/userAddress", method = RequestMethod.GET)
    public String userAddress(Model model, HttpSession session) {
        model.addAttribute("title", "????????????");
        List<UserAddress> userAddressList = userAddressService.findByUserId(getUserFromSession(session).getId());
        model.addAttribute("userAddressList", userAddressList);
        return "user/userAddress";
    }

    @RequestMapping(value = "/userAddress/add", method = RequestMethod.GET)
    public String addUserAddress(Model model) {
        model.addAttribute("title", "??????????????????");
        return "user/addUserAddress";
    }

    @RequestMapping(value = "/userAddress/add", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult doAddUserAddress(HttpSession session, UserAddress userAddress) {
        userAddress.setUser(getUserFromSession(session));
        userAddressService.save(userAddress);
        logger.debug("????????????????????????.");

        JsonResult result = new JsonResult();
        result.setToSuccess();
        return result;
    }

    @RequestMapping(value = "/userAddress/update", method = RequestMethod.POST)
    @ResponseBody
    public String doUpdateUserAddress(UserAddress userAddress) {
        userAddressService.updateUserAddress(userAddress);
        return "success";
    }

    @RequestMapping(value = "/userAddress/{id}")
    @ResponseBody
    public UserAddress findAddress(@PathVariable Integer id) {
        return userAddressService.findById(id);
    }

    @RequestMapping(value = "/userAddress/delete/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String delUserAddress(@PathVariable Integer id) {
        userAddressService.deleteById(id);
        logger.debug("????????????????????????...");
        return "success";
    }


}

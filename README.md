购物系统
=====================
[![Build Status](https://travis-ci.org/xdclass/shop.svg?branch=master)](https://travis-ci.org/xdclass/shop) [![Coverage Status](https://coveralls.io/repos/github/xdclass/shop/badge.svg?branch=master)](https://coveralls.io/github/xdclass/shop?branch=master)  

在线商城项目，持续完善中...

![功能导图](img/module.png)


主页：[http://localhost:8081/](localhost:8081/)  
后台：[http://localhost:8081/admin/login](localhost:8081/admin/login)  

## 配置修改
可以在application.properties中修改相关配置（http服务端口、数据库配置...）

- 访问端口：server.port
- 数据库相关配置：jdbc.***

#----------------------------------------------------------------------

项⽬技术栈：
-----------后端--------------------------
Springboot2.X
SpringMVC
Dubbo          rpc远程过程调用，例如订单服务调商品服务，作用类似springCloud，但后者使用的是http去调用服务
Mybatis3.X
Mysql
Gauva          loadingCache缓存
Caffeine       基于W-tinyLFU的新一代缓存，性能比guava好
Jmeter5.X     接口压测
JMH          方法性能测试
redis        存放coupon公告栏数据
zookeeper    注册中心
RocketMQ     下单和支付时，通知coupon方更新userCoupon的信息
hibernate     orm框架
logback        日志
----------前端-------------------
css
js
jsp
Bootstrap3


本商城项目包括三部分，user，coupon和shop，shop是主体，shop通过dubbo调用user服务和coupon服务,前端代码集合在shop中
user项目地址：https://github.com/skyinfant/27-user
coupon项目地址：https://github.com/skyinfant/27-coupon

项目的主要功能：
1、用户注册登录
2、商品列表
3、优惠券列表
4、用户领券
3、购物车，下单，支付，优惠券抵扣，取消订单
4、优惠券公告栏


部署方式：
1、在mysql创建一个database，然后执行项目中的shop.sql，生成相关表和数据
2、配置好application.properties的各个参数（本项目依赖的组件较多，包括redis，zookeeper和rocketmq，请自行安装）
3、启动redis，zookeeper,rocketMQ
4、在idea启动user
5、在idea启动coupon
6、在idea启动shop
5、访问  http://localhost:8040/




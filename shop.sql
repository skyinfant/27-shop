/*
Navicat MySQL Data Transfer

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2021-09-27 18:45:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for hibernate_sequence
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
INSERT INTO `hibernate_sequence` VALUES ('1');

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('1', 'xiaod', '小D课堂');
INSERT INTO `t_admin` VALUES ('2', 'daniel', 'daniel');

-- ----------------------------
-- Table structure for t_announcement
-- ----------------------------
DROP TABLE IF EXISTS `t_announcement`;
CREATE TABLE `t_announcement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `createAdmin_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKslwp3gcgudths92bk0kbak06t` (`createAdmin_id`),
  CONSTRAINT `FKslwp3gcgudths92bk0kbak06t` FOREIGN KEY (`createAdmin_id`) REFERENCES `t_admin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_announcement
-- ----------------------------

-- ----------------------------
-- Table structure for t_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券码',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券图',
  `reduce_amount` int(11) NOT NULL DEFAULT '0' COMMENT '所减金额',
  `achieve_amount` int(11) NOT NULL DEFAULT '0' COMMENT '达到满减资格金额',
  `stock` bigint(20) NOT NULL DEFAULT '0' COMMENT '库存，当库存为0不可领取',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` int(1) unsigned NOT NULL COMMENT '状态为0表示可用，1为不可用',
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '生效开始时间',
  `end_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '生效结束时间',
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inx_code` (`code`),
  KEY `inx_start_time` (`start_time`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_coupon
-- ----------------------------
INSERT INTO `t_coupon` VALUES ('1', '10086', '/images/l_cou01.png', '99', '500', '1000', '满500减99', '2019-06-07 12:25:05', '0', '2021-09-19 17:25:28', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('2', '9527', '/images/l_cou02.png', '300', '4000', '1000', '满500减300', '2019-06-07 12:25:05', '0', '2021-09-19 17:25:35', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('3', '9528', '/images/l_cou02.png', '120', '4000', '1000', '满500减120', '2019-06-07 12:25:05', '0', '2021-09-19 17:25:35', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('4', '1222c75c-1f8c-4c83-94e5-aba934ef59e3', '/images/l_cou02.png', '399', '1000', '100', '满500减399', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:35', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('5', '1222c75c-1f8c-4c83-94e-aba934ef59e3', '/images/l_cou03.png', '260', '500', '100', '满500减260', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:35', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('6', '1222c75c-1f8c-4c83-4e-aba934ef59e3', '/images/l_cou04.png', '150', '500', '100', '满500减150', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:35', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('7', '1222c75c-f8c-4c83-4e-aba934ef59e3', '/images/l_cou05.png', '180', '500', '100', '满500减180', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('8', '222c75c-f8c-4c83-4e-aba934ef59e3', '/images/l_cou06.png', '450', '500', '100', '满500减450', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('9', '222c75c-f8c-4c83-4e-aba934ef59e', '/images/l_cou07.png', '270', '500', '100', '满500减270', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('10', '222c75c-f8c-4c83-4e-aba934ef5', '/images/l_cou08.png', '130', '500', '100', '满500减130', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('17', '222c75c-f8c-4c83-4e-aba93ef5', '/images/l_cou09.png', '350', '500', '100', '满500减350', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('18', '22c75c-f8c-4c83-4e-aba93ef5', '/images/l_cou09.png', '400', '500', '100', '满500减400', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('19', '22c75-f8c-4c83-4e-aba93ef5', '/images/l_cou09.png', '200', '500', '100', '满500减200', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('20', '75-f8c-4c83-4e-aba93ef5', '/images/l_cou09.png', '250', '500', '100', '满500减250', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);
INSERT INTO `t_coupon` VALUES ('21', '75-f8c-4c83-4e-aba9ef5', '/images/l_cou09.png', '188', '500', '100', '满500减188', '2019-07-08 21:18:00', '0', '2021-09-19 17:25:36', '2028-01-19 17:25:19', null);

-- ----------------------------
-- Table structure for t_coupon1
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon1`;
CREATE TABLE `t_coupon1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(128) NOT NULL DEFAULT '' COMMENT '优惠券码',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券图',
  `achieve_amount` int(11) NOT NULL DEFAULT '0' COMMENT '达到满减资格金额',
  `reduce_amount` int(11) NOT NULL DEFAULT '0' COMMENT '所减金额',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存，当库存为0不可领取',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '优惠券名称',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态为0表示可用，1为不可用',
  `create_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL COMMENT '生效开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '生效结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='优惠券定义表';

-- ----------------------------
-- Records of t_coupon1
-- ----------------------------
INSERT INTO `t_coupon1` VALUES ('1', '10086', '/images/l_cou01.png', '500', '50', '1000', '?500?50???', '0', '2019-06-07 12:25:05', '2019-01-07 12:25:05', '2029-06-07 12:25:05');
INSERT INTO `t_coupon1` VALUES ('2', '9527', '/images/l_cou02.png', '4000', '300', '1000', '?4000?300???', '0', '2019-06-07 12:25:05', '2019-02-07 12:25:05', '2029-06-07 12:25:05');
INSERT INTO `t_coupon1` VALUES ('4', '9528', '/images/l_cou02.png', '4000', '300', '1000', '?4000?300???', '0', '2019-06-07 12:25:05', '2029-06-07 12:25:05', '2030-06-07 12:25:05');

-- ----------------------------
-- Table structure for t_news
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `inputUser_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKspe5cxeewkudeg10usq127fji` (`inputUser_id`),
  CONSTRAINT `FKspe5cxeewkudeg10usq127fji` FOREIGN KEY (`inputUser_id`) REFERENCES `t_admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_news
-- ----------------------------
INSERT INTO `t_news` VALUES ('1', '?????5?', '?????????????', '2019-06-07 08:00:00', '2');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `order_number` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_address` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `confirmTime` datetime DEFAULT NULL,
  `consignee` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `finalPrice` double DEFAULT NULL,
  `orderNumber` varchar(255) DEFAULT NULL,
  `payTime` datetime DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `shipTime` datetime DEFAULT NULL,
  `totalPrice` double DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_75ffb6s55q5aibdhqs2unu49q` (`user_id`),
  KEY `FK_9a6eb7iu2gbn1628cud5w836w` (`user_address`),
  CONSTRAINT `FK_9a6eb7iu2gbn1628cud5w836w` FOREIGN KEY (`user_address`) REFERENCES `t_useraddress` (`id`),
  CONSTRAINT `FKho2r4qgj3txpy8964fnla95ub` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('111', null, null, '1', '2', null, '', null, '', '2021-09-19 20:09:42', '999819', '20210919200960', '2021-09-19 20:09:46', '', null, '999999', '');
INSERT INTO `t_order` VALUES ('112', null, null, '1', '2', null, '', null, '', '2021-09-19 20:11:23', '122933', '20210919201133', '2021-09-19 20:11:27', '', null, '123332', '');
INSERT INTO `t_order` VALUES ('113', null, null, '1', '2', null, '', null, '', '2021-09-19 20:17:38', '22933', '20210919201705', '2021-09-19 20:17:41', '', null, '23332', '');
INSERT INTO `t_order` VALUES ('114', null, null, '1', '3', null, '', null, '', '2021-09-19 21:09:06', '99700', '20210919210900', '2021-09-19 21:09:13', '', null, '100000', '');
INSERT INTO `t_order` VALUES ('115', null, null, '1', '1', null, '', null, '', '2021-09-20 08:25:56', '799880', '20210920082582', '2021-09-20 08:26:05', '', null, '800000', '');

-- ----------------------------
-- Table structure for t_orderitem
-- ----------------------------
DROP TABLE IF EXISTS `t_orderitem`;
CREATE TABLE `t_orderitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `order_id` int(11) DEFAULT NULL,
  `product` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_n7j2urgoicw0qa2b5s2pidind` (`order_id`),
  KEY `FK_cxxgytqnjjrpm4x7k2grbm6iu` (`product`),
  KEY `FK2yx4lqm9mh15mysa9kppvf77r` (`product_id`),
  CONSTRAINT `FK2yx4lqm9mh15mysa9kppvf77r` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`),
  CONSTRAINT `FK_n7j2urgoicw0qa2b5s2pidin1` FOREIGN KEY (`order_id`) REFERENCES `t_order` (`id`),
  CONSTRAINT `FKj435mnwwxw5wci0t6xi15ddxk` FOREIGN KEY (`order_id`) REFERENCES `t_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderitem
-- ----------------------------
INSERT INTO `t_orderitem` VALUES ('185', '1', '111', null, '1');
INSERT INTO `t_orderitem` VALUES ('186', '1', '112', null, '2');
INSERT INTO `t_orderitem` VALUES ('187', '1', '112', null, '3');
INSERT INTO `t_orderitem` VALUES ('188', '1', '112', null, '4');
INSERT INTO `t_orderitem` VALUES ('189', '1', '113', null, '2');
INSERT INTO `t_orderitem` VALUES ('190', '1', '113', null, '4');
INSERT INTO `t_orderitem` VALUES ('191', '1', '114', null, '3');
INSERT INTO `t_orderitem` VALUES ('192', '1', '115', null, '6');

-- ----------------------------
-- Table structure for t_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_payment`;
CREATE TABLE `t_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_payment
-- ----------------------------

-- ----------------------------
-- Table structure for t_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_picture`;
CREATE TABLE `t_picture` (
  `id` int(11) NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `updateAdmin_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf820vwoskrv05yxj80mlbj226` (`updateAdmin_id`),
  CONSTRAINT `FKf820vwoskrv05yxj80mlbj226` FOREIGN KEY (`updateAdmin_id`) REFERENCES `t_admin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_picture
-- ----------------------------

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `pic_url` varchar(255) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `stock` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `masterPic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKknr9ckik7tms7787w9nkpis8g` (`masterPic_id`),
  CONSTRAINT `FKknr9ckik7tms7787w9nkpis8g` FOREIGN KEY (`masterPic_id`) REFERENCES `t_picture` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '2343434', '2a-dd-1s', '???????????????????????????????????????????????????????', '/images/l_pro01.png', '999999', '3', '????????', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('2', 'sdfsdf', 'df', '???', '/images/l_pro02.png', '3333', '123', '????', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('3', 'sdfdsf', 'fddf', '????', '/images/l_pro03.png', '100000', '222', '??????', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('4', 'BMC-SLR01-54', '54', null, '/images/l_pro04.png', '19999', '200', '????1', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('5', 'KDF-SD1-200', '400CM', null, '/images/l_pro05.png', '500000', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('6', 'KDF-SD1-200', '400CM', null, '/images/l_pro06.png', '800000', '200', '????1', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('7', 'KDF-SD1-200', '400CM', null, '/images/l_pro07.png', '900000', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('8', 'KDF-SD1-200', '400CM', null, '/images/l_pro08.png', '600000', '200', '????3', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('9', 'KDF-SD1-200', '400CM', null, '/images/l_pro09.png', '400000', '200', '????4', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('10', 'KDF-SD1-200', '400CM', null, '/images/l_pro10.png', '700000', '200', '????5', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('11', 'KDF-SD1-200', '400CM', null, '/images/l_pro11.png', '200000', '200', '????6', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('12', 'KDF-SD1-200', '400CM', null, '/images/l_pro12.jpg', '300000', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('13', 'KDF-SD1-200', '400CM', null, '/images/l_pro15.jpg', '550000', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('14', 'KDF-SD1-200', '400CM', null, '/images/l_pro16.jpg', '650000', '200', '????1', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('15', 'BMC-SLR01-54', '54', null, '/images/l_pro14.jpg', '19999', '200', '????1', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('16', 'KDF-SD1-200', '400CM', null, '/images/l_pro15.jpg', '350000', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('17', 'BMC-SLR01-54', '54', null, '/images/l_pro13.jpg', '19999', '200', '????1', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('18', 'KDF-SD1-200', '400CM', null, '/images/l_pro15.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('19', 'KDF-SD1-200', '400CM', null, '/images/l_pro17.jpg', '200', '200', '????1', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('20', 'KDF-SD1-200', '400CM', null, '/images/l_pro07.png', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('21', 'KDF-SD1-200', '400CM', null, '/images/l_pro18.jpg', '200', '200', '????3', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('22', 'KDF-SD1-200', '400CM', null, '/images/l_pro19.jpg', '200', '200', '????4', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('23', 'KDF-SD1-200', '400CM', null, '/images/l_pro110.jpg', '200', '200', '????5', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('24', 'KDF-SD1-200', '400CM', null, '/images/l_pro111.jpg', '200', '200', '????6', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('25', 'KDF-SD1-200', '400CM', null, '/images/l_pro112.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('26', 'KDF-SD1-200', '400CM', null, '/images/l_pro113.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('27', 'KDF-SD1-200', '400CM', null, '/images/l_pro114.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('28', 'KDF-SD1-200', '400CM', null, '/images/l_pro115.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('29', 'KDF-SD1-200', '400CM', null, '/images/l_pro116.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('30', 'KDF-SD1-200', '400CM', null, '/images/l_pro117.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('31', 'KDF-SD1-200', '400CM', null, '/images/l_pro118.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('32', 'KDF-SD1-200', '400CM', null, '/images/l_pro119.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);
INSERT INTO `t_product` VALUES ('33', 'KDF-SD1-200', '400CM', null, '/images/l_pro120.jpg', '200', '200', '????2', '2019-06-07 12:25:05', null);

-- ----------------------------
-- Table structure for t_product_t_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_product_t_picture`;
CREATE TABLE `t_product_t_picture` (
  `Product_id` int(11) NOT NULL,
  `slavePic_id` int(11) NOT NULL,
  KEY `FKln4qvwbfxoiypk9mgwyedmtl1` (`slavePic_id`),
  KEY `FKmixcjvbg3qcrp0reaqha7ujk` (`Product_id`),
  CONSTRAINT `FKln4qvwbfxoiypk9mgwyedmtl1` FOREIGN KEY (`slavePic_id`) REFERENCES `t_picture` (`id`),
  CONSTRAINT `FKmixcjvbg3qcrp0reaqha7ujk` FOREIGN KEY (`Product_id`) REFERENCES `t_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_product_t_picture
-- ----------------------------

-- ----------------------------
-- Table structure for t_producttype
-- ----------------------------
DROP TABLE IF EXISTS `t_producttype`;
CREATE TABLE `t_producttype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_producttype
-- ----------------------------
INSERT INTO `t_producttype` VALUES ('1', '????');
INSERT INTO `t_producttype` VALUES ('2', '????');
INSERT INTO `t_producttype` VALUES ('3', '????');
INSERT INTO `t_producttype` VALUES ('4', '????');
INSERT INTO `t_producttype` VALUES ('5', '????');
INSERT INTO `t_producttype` VALUES ('6', '????');

-- ----------------------------
-- Table structure for t_remember
-- ----------------------------
DROP TABLE IF EXISTS `t_remember`;
CREATE TABLE `t_remember` (
  `id` varchar(255) NOT NULL,
  `addTime` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6uc4b3e4xdabyyiamthsb2bqa` (`user_id`),
  CONSTRAINT `FK6uc4b3e4xdabyyiamthsb2bqa` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `t_remember_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_remember
-- ----------------------------
INSERT INTO `t_remember` VALUES ('0d4a2d45-7b13-483a-a07f-48ee371c1efc', '2021-09-19 19:42:35', '3');
INSERT INTO `t_remember` VALUES ('11d60da5-a0bf-47ca-8449-e70ec1b546c1', '2021-09-19 18:26:44', '1');
INSERT INTO `t_remember` VALUES ('19e845a4-4fc6-497a-850e-91404b48ec28', '2021-09-19 15:57:07', '1');
INSERT INTO `t_remember` VALUES ('20d89810-3b51-473c-8dd9-c236c8bcb2ed', '2021-08-01 18:10:54', '1');
INSERT INTO `t_remember` VALUES ('26c7d66d-c28c-44b8-9eea-e9d9bd1c218d', '2021-09-19 18:11:30', '1');
INSERT INTO `t_remember` VALUES ('6981ae5a-a665-4040-9278-81182726e59d', '2021-09-19 18:10:02', '1');
INSERT INTO `t_remember` VALUES ('6f18fd80-1d92-4021-8a5c-6a28e21ba66a', '2019-06-28 21:44:08', '2');
INSERT INTO `t_remember` VALUES ('792b50cd-0cad-4ab8-835e-b40bed21eec4', '2021-09-19 15:18:36', '1');
INSERT INTO `t_remember` VALUES ('7aed558e-07df-4fc8-8982-f86d5d60679a', '2021-09-19 18:19:54', '2');
INSERT INTO `t_remember` VALUES ('7d49a0c9-50c1-496c-9cd9-1cab40306cba', '2019-07-20 11:11:51', '1');
INSERT INTO `t_remember` VALUES ('927e392c-fe31-41e2-a7d0-4a20a0051fe6', '2021-09-19 17:43:52', '3');
INSERT INTO `t_remember` VALUES ('9702147a-b3d4-4a9e-be06-63868e4171f8', '2019-06-08 12:41:14', '2');
INSERT INTO `t_remember` VALUES ('98e2f67d-c322-40dc-96aa-662624d13a7e', '2019-06-11 08:58:51', '2');
INSERT INTO `t_remember` VALUES ('9a4aa39e-4b78-4ef2-8734-891b96bc2c15', '2021-09-19 18:18:23', '3');
INSERT INTO `t_remember` VALUES ('9be1447c-1e28-44b0-9b96-3df07b2bb8a0', '2019-07-26 00:11:49', '1');
INSERT INTO `t_remember` VALUES ('a81bb78d-4609-483b-8594-c7a21f4621ae', '2021-08-03 22:11:55', '1');
INSERT INTO `t_remember` VALUES ('ad7ff360-9e45-4b32-9cc8-eb2b29c4431f', '2021-09-19 20:01:57', '1');
INSERT INTO `t_remember` VALUES ('b329619d-1b2c-4c25-a4fe-8f5079eddb1a', '2019-07-05 08:50:45', '2');
INSERT INTO `t_remember` VALUES ('b333547d-3aae-4c9b-b920-087f52f27b20', '2019-06-07 10:37:05', '2');
INSERT INTO `t_remember` VALUES ('b62e3361-1df2-4366-9436-d70e54d290d5', '2019-08-04 20:23:30', '1');
INSERT INTO `t_remember` VALUES ('beacb26a-6d86-4f0c-ad09-ff5021f5cb2f', '2021-09-19 18:01:02', '1');
INSERT INTO `t_remember` VALUES ('caa7adc0-0573-4979-99af-b10f9a241d90', '2021-09-19 18:29:19', '1');
INSERT INTO `t_remember` VALUES ('d06ddf6b-132b-457d-97f4-f069ea4a1fb5', '2019-06-29 23:42:56', '2');
INSERT INTO `t_remember` VALUES ('e2183413-93ec-4a64-9c7f-c5cf986bda74', '2021-08-01 18:15:58', '1');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL DEFAULT '' COMMENT '??',
  `address` varchar(50) NOT NULL DEFAULT '' COMMENT '??',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '??',
  `phone` char(11) DEFAULT NULL COMMENT '????',
  `point` int(11) DEFAULT NULL COMMENT '???',
  `remark` varchar(50) NOT NULL DEFAULT '',
  `tel_phone` char(11) NOT NULL DEFAULT '' COMMENT '????',
  `username` varchar(15) NOT NULL DEFAULT '' COMMENT '????',
  `zip_code` varchar(6) NOT NULL DEFAULT '' COMMENT '????',
  `balance` bigint(20) DEFAULT NULL COMMENT '????',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='???????';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'kim', '澳大利亚', '123456', '12580125800', '1000', 'admin', '95279527', 'kim', '10000', '10000');
INSERT INTO `t_user` VALUES ('2', 'root', '新加坡', '123456', '12580125800', '1000', 'admin', '95279527', 'root', '10000', '10000');
INSERT INTO `t_user` VALUES ('3', 'tom', '新西兰', '123456', '12580125800', '1000', 'admin', '95279527', 'tom', '10000', '10000');

-- ----------------------------
-- Table structure for t_user_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_user_coupon`;
CREATE TABLE `t_user_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_coupon_code` varchar(255) DEFAULT NULL,
  `pic_url` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` int(1) unsigned DEFAULT '0' COMMENT '0-未核销   1-已核销',
  `order_id` int(11) DEFAULT NULL COMMENT '??id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_couponCode` (`user_coupon_code`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_coupon
-- ----------------------------
INSERT INTO `t_user_coupon` VALUES ('163', '889241827255779328', '/images/l_cou05.png', null, '7', '2', '1', '111', '2021-09-19 20:09:33');
INSERT INTO `t_user_coupon` VALUES ('164', '889242260607074304', '/images/l_cou02.png', null, '4', '2', '1', '112', '2021-09-19 20:11:16');
INSERT INTO `t_user_coupon` VALUES ('165', '889243799132307456', '/images/l_cou02.png', null, '2', '2', '0', null, '2021-09-19 20:17:23');
INSERT INTO `t_user_coupon` VALUES ('166', '889243809848754176', '/images/l_cou02.png', null, '4', '2', '1', '113', '2021-09-19 20:17:26');
INSERT INTO `t_user_coupon` VALUES ('167', '889256784424861696', '/images/l_cou02.png', null, '2', '3', '1', '114', '2021-09-19 21:08:59');
INSERT INTO `t_user_coupon` VALUES ('168', '889427068964569088', '/images/l_cou02.png', null, '3', '1', '1', '115', '2021-09-20 08:25:38');
INSERT INTO `t_user_coupon` VALUES ('169', '889429575442890752', '/images/l_cou01.png', null, '1', '1', '0', null, '2021-09-20 08:35:36');

-- ----------------------------
-- Table structure for t_user_coupon1
-- ----------------------------
DROP TABLE IF EXISTS `t_user_coupon1`;
CREATE TABLE `t_user_coupon1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_coupon_code` varchar(128) NOT NULL DEFAULT '' COMMENT '??????',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '????',
  `coupon_id` int(11) NOT NULL DEFAULT '0' COMMENT 't_coupon???ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '?????id',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '???0??????1????',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '??t_order???',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='?????';

-- ----------------------------
-- Records of t_user_coupon1
-- ----------------------------
INSERT INTO `t_user_coupon1` VALUES ('1', '', '', '0', '0', '0', '0', null);
INSERT INTO `t_user_coupon1` VALUES ('2', '', '', '0', '0', '0', '0', null);
INSERT INTO `t_user_coupon1` VALUES ('3', '', '', '0', '0', '0', '0', null);
INSERT INTO `t_user_coupon1` VALUES ('4', '', '', '0', '0', '0', '0', null);

-- ----------------------------
-- Table structure for t_user1
-- ----------------------------
DROP TABLE IF EXISTS `t_user1`;
CREATE TABLE `t_user1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `password` varchar(14) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `point` int(11) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `tel_phone` varchar(11) DEFAULT NULL,
  `username` varchar(15) DEFAULT NULL,
  `zip_code` varchar(6) DEFAULT NULL,
  `balance` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user1
-- ----------------------------
INSERT INTO `t_user1` VALUES ('2', 'daniel', 'daniel', 'daniel', '1', '1', '1', '1', 'daniel', '1', '1');

-- ----------------------------
-- Table structure for t_useraddress
-- ----------------------------
DROP TABLE IF EXISTS `t_useraddress`;
CREATE TABLE `t_useraddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `consignee` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inx_user` (`user_id`),
  CONSTRAINT `FKivjwmwb9xngrc6ic856ryrb57` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_useraddress
-- ----------------------------
INSERT INTO `t_useraddress` VALUES ('1', '??', '??', '15820681234', '10000', '2');
INSERT INTO `t_useraddress` VALUES ('2', '??', '??', '10086100861', '20000', '2');
INSERT INTO `t_useraddress` VALUES ('11', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('15', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('16', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('17', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('18', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('19', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('20', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('21', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('22', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('23', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('24', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('25', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('26', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('27', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('28', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('29', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('30', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('31', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('32', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('33', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('34', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('35', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('36', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('37', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('38', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('39', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('40', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('41', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('42', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('43', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('44', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('45', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('46', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('47', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('48', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('49', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('50', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('51', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('52', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('53', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('54', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('55', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('56', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('57', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('58', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('59', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('60', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('61', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('62', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('63', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('64', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('65', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('66', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('67', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('68', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('69', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('70', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('71', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('72', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('73', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('74', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('75', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('76', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('77', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('78', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('79', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('80', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('81', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('82', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('83', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('84', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('85', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('86', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('87', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('88', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('89', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('90', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('91', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('92', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('93', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('94', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('95', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('96', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('97', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('98', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('99', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('100', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('101', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('102', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('103', '', '', '', '', '1');
INSERT INTO `t_useraddress` VALUES ('104', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('105', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('106', '', '', '', '', '2');
INSERT INTO `t_useraddress` VALUES ('107', '', '', '', '', '3');
INSERT INTO `t_useraddress` VALUES ('108', '', '', '', '', '1');

-- ----------------------------
-- Procedure structure for proc_batch_insert
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_batch_insert`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `proc_batch_insert`()
BEGIN
DECLARE i int;
SET i=1;
WHILE i < 100000 DO
INSERT INTO `27_coupon`.`coupon`(`code`, `pic_url`,`achieve_amount`,`reduce_amount`,`stock`,`title`,`status`,`create_time`) VALUES(`SELECT REPLACE(UUID()`,'1.jpg',1000,300,9999,'量子计算机',0,CURRENT_TIMESTAMP);
SET i=i+1;
END WHILE;
END
;;
DELIMITER ;

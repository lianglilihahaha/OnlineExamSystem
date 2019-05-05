/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50619
 Source Host           : localhost:3306
 Source Schema         : db_onlineexam

 Target Server Type    : MySQL
 Target Server Version : 50619
 File Encoding         : 65001

 Date: 05/05/2019 19:53:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, '45', '45');
INSERT INTO `t_user` VALUES (2, '1', '1');
INSERT INTO `t_user` VALUES (3, 'admin', '123');
INSERT INTO `t_user` VALUES (4, 'haha', '1');

SET FOREIGN_KEY_CHECKS = 1;

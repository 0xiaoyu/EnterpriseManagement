/*
 Navicat Premium Data Transfer

 Source Server         : yu
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : enterprise

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 25/09/2023 23:05:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_user_dormitory
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_dormitory`;
CREATE TABLE `tb_user_dormitory`  (
  `userid` bigint NOT NULL,
  `dormitoryId` bigint NOT NULL COMMENT '宿舍id',
  PRIMARY KEY (`userid`, `dormitoryId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '人员的宿舍' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_user_dormitory
-- ----------------------------
INSERT INTO `tb_user_dormitory` VALUES (1, 1);

SET FOREIGN_KEY_CHECKS = 1;

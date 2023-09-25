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

 Date: 25/09/2023 23:04:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for d_building
-- ----------------------------
DROP TABLE IF EXISTS `d_building`;
CREATE TABLE `d_building`  (
  `id` int NULL DEFAULT NULL,
  `build_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` tinyint NULL DEFAULT NULL,
  `latitude` double NULL DEFAULT NULL,
  `longitude` double NULL DEFAULT NULL,
  `maxroom` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of d_building
-- ----------------------------
INSERT INTO `d_building` VALUES (1, 'testBuildName', 0, 50, 50, 713);
INSERT INTO `d_building` VALUES (2, '男一', 0, 28.226114, 112.925264, 612);
INSERT INTO `d_building` VALUES (3, 'testName', 0, 28.22621, 112.925004, 720);
INSERT INTO `d_building` VALUES (4, '女1', 1, 28.22823, 112.924788, 515);
INSERT INTO `d_building` VALUES (5, 't3', 0, 28.227061, 112.926791, 514);
INSERT INTO `d_building` VALUES (6, 'new1', 2, 28.227085, 112.926118, 618);
INSERT INTO `d_building` VALUES (10, '在建', 2, 28.227005, 112.926019, 720);
INSERT INTO `d_building` VALUES (11, '女2', 1, 28.228708, 112.924546, 514);

SET FOREIGN_KEY_CHECKS = 1;

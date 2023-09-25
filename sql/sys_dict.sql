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

 Date: 25/09/2023 23:04:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典类型编码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典项名称',
  `value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典项值',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态(1:正常;0:禁用)',
  `defaulted` tinyint NULL DEFAULT 0 COMMENT '是否默认(1:是;0:否)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, 'gender', '男', '1', 1, 1, 0, NULL, '2023-09-25 22:58:44', '2023-09-25 22:58:45');
INSERT INTO `sys_dict` VALUES (2, 'gender', '女', '2', 2, 1, 0, NULL, '2023-09-25 22:58:44', '2023-09-25 22:58:45');
INSERT INTO `sys_dict` VALUES (3, 'gender', '未知', '0', 1, 1, 0, NULL, '2023-09-25 22:58:44', '2023-09-25 22:58:45');
INSERT INTO `sys_dict` VALUES (4, 'building', '男生宿舍', '0', 1, 1, 0, '男生宿舍', '2023-09-25 22:58:44', '2023-09-25 22:58:45');
INSERT INTO `sys_dict` VALUES (5, 'building', '女生宿舍', '1', 1, 1, 0, '女生宿舍', '2023-09-25 22:58:44', '2023-09-25 22:58:45');
INSERT INTO `sys_dict` VALUES (6, 'building', '在建楼', '2', 2, 1, 0, '在建楼', '2023-09-25 22:58:44', '2023-09-25 22:58:45');
INSERT INTO `sys_dict` VALUES (7, 'building', '待拆楼', '3', 3, 1, 0, '待拆楼', '2023-09-25 22:58:44', '2023-09-25 22:58:45');
INSERT INTO `sys_dict` VALUES (8, 'building', '维修楼', '4', 2, 1, 0, '维修楼', '2023-09-25 22:58:44', '2023-09-25 22:58:45');

SET FOREIGN_KEY_CHECKS = 1;

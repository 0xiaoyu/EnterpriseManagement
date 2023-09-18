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

 Date: 18/09/2023 23:28:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clock_log
-- ----------------------------
DROP TABLE IF EXISTS `clock_log`;
CREATE TABLE `clock_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userid` bigint NOT NULL COMMENT '用户id',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态,0上班打卡',
  `day_time` date NOT NULL COMMENT '创建时间,记录哪一天打的卡',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '打卡记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clock_log
-- ----------------------------

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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

-- ----------------------------
-- Table structure for pay_log
-- ----------------------------
DROP TABLE IF EXISTS `pay_log`;
CREATE TABLE `pay_log`  (
  `id` bigint NULL DEFAULT NULL,
  `dormitory_id` bigint NULL DEFAULT NULL,
  `amount` double NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `type` tinyint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_log
-- ----------------------------
INSERT INTO `pay_log` VALUES (1, 1, 50, 1, '2023-09-06 19:08:33', '2023-09-06 19:08:33', 1, 1);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父节点id',
  `tree_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '父节点id路径',
  `sort` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态(1:正常;0:禁用)',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除标识(1:已删除;0:未删除)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建人ID',
  `update_by` bigint NULL DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, '人事部门', 0, '0', 1, 1, 0, NULL, NULL, 1, 1);
INSERT INTO `sys_dept` VALUES (2, '研发部门', 1, '0,1', 1, 1, 0, NULL, '2022-04-19 12:46:37', 2, 2);
INSERT INTO `sys_dept` VALUES (3, '测试部门', 1, '0,1', 1, 1, 0, NULL, '2022-04-19 12:46:37', 2, 2);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, 'gender', '男', '1', 1, 1, 0, NULL, '2019-05-05 13:07:52', '2022-06-12 23:20:39');
INSERT INTO `sys_dict` VALUES (2, 'gender', '女', '2', 2, 1, 0, NULL, '2019-04-19 11:33:00', '2019-07-02 14:23:05');
INSERT INTO `sys_dict` VALUES (3, 'gender', '未知', '0', 1, 1, 0, NULL, '2020-10-17 08:09:31', '2020-10-17 08:09:31');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型编码',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态(0:正常;1:禁用)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '性别', 'gender', 1, NULL, '2019-12-06 19:03:32', '2022-06-12 16:21:28');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NOT NULL COMMENT '父菜单ID',
  `tree_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父节点ID路径',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `type` tinyint NOT NULL COMMENT '菜单类型(1:菜单；2:目录；3:外链；4:按钮)',
  `path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由路径(浏览器地址栏路径)',
  `component` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径(vue页面完整路径，省略.vue后缀)',
  `perm` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `visible` tinyint(1) NOT NULL DEFAULT 1 COMMENT '显示状态(1-显示;0-隐藏)',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `icon` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `redirect` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转路径',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '0', '系统管理', 2, '/system', 'Layout', NULL, 1, 1, 'system', '/system/user', '2021-08-28 09:12:21', '2021-08-28 09:12:21');
INSERT INTO `sys_menu` VALUES (2, 1, '0,1', '用户管理', 1, 'user', 'system/user/index', NULL, 1, 1, 'user', NULL, '2021-08-28 09:12:21', '2021-08-28 09:12:21');
INSERT INTO `sys_menu` VALUES (3, 1, '0,1', '角色管理', 1, 'role', 'system/role/index', NULL, 1, 2, 'role', NULL, '2021-08-28 09:12:21', '2021-08-28 09:12:21');
INSERT INTO `sys_menu` VALUES (4, 1, '0,1', '菜单管理', 1, 'menu', 'system/menu/index', NULL, 1, 3, 'menu', NULL, '2021-08-28 09:12:21', '2021-08-28 09:12:21');
INSERT INTO `sys_menu` VALUES (5, 1, '0,1', '部门管理', 1, 'dept', 'system/dept/index', NULL, 1, 4, 'tree', NULL, '2021-08-28 09:12:21', '2021-08-28 09:12:21');
INSERT INTO `sys_menu` VALUES (6, 1, '0,1', '字典管理', 1, 'dict', 'system/dict/index', NULL, 1, 5, 'dict', NULL, '2021-08-28 09:12:21', '2021-08-28 09:12:21');
INSERT INTO `sys_menu` VALUES (20, 0, '0', '多级菜单', 2, '/multi-level', 'Layout', NULL, 1, 9, 'multi_level', '/multi-level/multi-level1', '2022-02-16 23:11:00', '2022-02-16 23:11:00');
INSERT INTO `sys_menu` VALUES (21, 20, '0,20', '菜单一级', 2, 'multi-level1', 'demo/multi-level/level1', NULL, 1, 1, '', '/multi-level/multi-level2', '2022-02-16 23:13:38', '2022-02-16 23:13:38');
INSERT INTO `sys_menu` VALUES (22, 21, '0,20,21', '菜单二级', 2, 'multi-level2', 'demo/multi-level/children/level2', NULL, 1, 1, '', '/multi-level/multi-level2/multi-level3-1', '2022-02-16 23:14:23', '2022-02-16 23:14:23');
INSERT INTO `sys_menu` VALUES (23, 22, '0,20,21,22', '菜单三级-1', 1, 'multi-level3-1', 'demo/multi-level/children/children/level3-1', NULL, 1, 1, '', '', '2022-02-16 23:14:51', '2022-02-16 23:14:51');
INSERT INTO `sys_menu` VALUES (24, 22, '0,20,21,22', '菜单三级-2', 1, 'multi-level3-2', 'demo/multi-level/children/children/level3-2', NULL, 1, 2, '', '', '2022-02-16 23:15:08', '2022-02-16 23:15:08');
INSERT INTO `sys_menu` VALUES (26, 0, '0', '外部链接', 2, '/external-link', 'Layout', NULL, 1, 8, 'link', 'noredirect', '2022-02-17 22:51:20', '2022-02-17 22:51:20');
INSERT INTO `sys_menu` VALUES (30, 26, '0,26', 'document', 3, 'https://juejin.cn/post/7228990409909108793', '', NULL, 1, 1, 'document', '', '2022-02-18 00:01:40', '2022-02-18 00:01:40');
INSERT INTO `sys_menu` VALUES (31, 2, '0,1,2', '用户新增', 4, '', NULL, 'sys:user:add', 1, 1, '', '', '2022-10-23 11:04:08', '2022-10-23 11:04:11');
INSERT INTO `sys_menu` VALUES (32, 2, '0,1,2', '用户编辑', 4, '', NULL, 'sys:user:edit', 1, 2, '', '', '2022-10-23 11:04:08', '2022-10-23 11:04:11');
INSERT INTO `sys_menu` VALUES (33, 2, '0,1,2', '用户删除', 4, '', NULL, 'sys:user:delete', 1, 3, '', '', '2022-10-23 11:04:08', '2022-10-23 11:04:11');
INSERT INTO `sys_menu` VALUES (36, 0, '0', '组件封装', 2, '/component', 'Layout', NULL, 1, 10, 'menu', '', '2022-10-31 09:18:44', '2022-10-31 09:18:47');
INSERT INTO `sys_menu` VALUES (37, 36, '0,36', '富文本编辑器', 1, 'wang-editor', 'demo/wang-editor', NULL, 1, 1, '', '', NULL, NULL);
INSERT INTO `sys_menu` VALUES (38, 36, '0,36', '图片上传', 1, 'upload', 'demo/upload', NULL, 1, 2, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (39, 36, '0,36', '图标选择器', 1, 'icon-selector', 'demo/icon-selector', NULL, 1, 3, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (40, 0, '0', '接口', 2, '/api', 'Layout', NULL, 1, 7, 'api', '', '2022-02-17 22:51:20', '2022-02-17 22:51:20');
INSERT INTO `sys_menu` VALUES (41, 40, '0,40', '接口文档', 1, 'apidoc', 'demo/api-doc', NULL, 1, 1, 'api', '', '2022-02-17 22:51:20', '2022-02-17 22:51:20');
INSERT INTO `sys_menu` VALUES (70, 3, '0,1,3', '角色新增', 4, '', NULL, 'sys:role:add', 1, 1, '', NULL, '2023-05-20 23:39:09', '2023-05-20 23:39:09');
INSERT INTO `sys_menu` VALUES (71, 3, '0,1,3', '角色编辑', 4, '', NULL, 'sys:role:edit', 1, 2, '', NULL, '2023-05-20 23:40:31', '2023-05-20 23:40:31');
INSERT INTO `sys_menu` VALUES (72, 3, '0,1,3', '角色删除', 4, '', NULL, 'sys:role:delete', 1, 3, '', NULL, '2023-05-20 23:41:08', '2023-05-20 23:41:08');
INSERT INTO `sys_menu` VALUES (73, 4, '0,1,4', '菜单新增', 4, '', NULL, 'sys:menu:add', 1, 1, '', NULL, '2023-05-20 23:41:35', '2023-05-20 23:41:35');
INSERT INTO `sys_menu` VALUES (74, 4, '0,1,4', '菜单编辑', 4, '', NULL, 'sys:menu:edit', 1, 3, '', NULL, '2023-05-20 23:41:58', '2023-05-20 23:41:58');
INSERT INTO `sys_menu` VALUES (75, 4, '0,1,4', '菜单删除', 4, '', NULL, 'sys:menu:delete', 1, 3, '', NULL, '2023-05-20 23:44:18', '2023-05-20 23:44:18');
INSERT INTO `sys_menu` VALUES (76, 5, '0,1,5', '部门新增', 4, '', NULL, 'sys:dept:add', 1, 1, '', NULL, '2023-05-20 23:45:00', '2023-05-20 23:45:00');
INSERT INTO `sys_menu` VALUES (77, 5, '0,1,5', '部门编辑', 4, '', NULL, 'sys:dept:edit', 1, 2, '', NULL, '2023-05-20 23:46:16', '2023-05-20 23:46:16');
INSERT INTO `sys_menu` VALUES (78, 5, '0,1,5', '部门删除', 4, '', NULL, 'sys:dept:delete', 1, 3, '', NULL, '2023-05-20 23:46:36', '2023-05-20 23:46:36');
INSERT INTO `sys_menu` VALUES (79, 6, '0,1,6', '字典类型新增', 4, '', NULL, 'sys:dict_type:add', 1, 1, '', NULL, '2023-05-21 00:16:06', '2023-05-21 00:16:06');
INSERT INTO `sys_menu` VALUES (81, 6, '0,1,6', '字典类型编辑', 4, '', NULL, 'sys:dict_type:edit', 1, 2, '', NULL, '2023-05-21 00:27:37', '2023-05-21 00:27:37');
INSERT INTO `sys_menu` VALUES (84, 6, '0,1,6', '字典类型删除', 4, '', NULL, 'sys:dict_type:delete', 1, 3, '', NULL, '2023-05-21 00:29:39', '2023-05-21 00:29:39');
INSERT INTO `sys_menu` VALUES (85, 6, '0,1,6', '字典数据新增', 4, '', NULL, 'sys:dict:add', 1, 4, '', NULL, '2023-05-21 00:46:56', '2023-05-21 00:47:06');
INSERT INTO `sys_menu` VALUES (86, 6, '0,1,6', '字典数据编辑', 4, '', NULL, 'sys:dict:edit', 1, 5, '', NULL, '2023-05-21 00:47:36', '2023-05-21 00:47:36');
INSERT INTO `sys_menu` VALUES (87, 6, '0,1,6', '字典数据删除', 4, '', NULL, 'sys:dict:delete', 1, 6, '', NULL, '2023-05-21 00:48:10', '2023-05-21 00:48:20');
INSERT INTO `sys_menu` VALUES (88, 2, '0,1,2', '重置密码', 4, '', NULL, 'sys:user:reset_pwd', 1, 4, '', NULL, '2023-05-21 00:49:18', '2023-05-21 00:49:18');
INSERT INTO `sys_menu` VALUES (89, 0, '0', '功能演示', 2, '/function', 'Layout', NULL, 1, 11, 'menu', '', '2022-10-31 09:18:44', '2022-10-31 09:18:47');
INSERT INTO `sys_menu` VALUES (90, 89, '0,89', 'Websocket', 1, 'websocket', 'demo/websocket', NULL, 1, 3, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (91, 89, '0,89', '敬请期待...', 2, 'other', 'demo/other', NULL, 1, 4, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (92, 36, '0,36', '标签输入框', 1, 'taginput', 'demo/taginput', NULL, 1, 5, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (93, 36, '0,36', '签名', 1, 'signature', 'demo/signature', NULL, 1, 6, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (94, 36, '0,36', '表格', 1, 'table', 'demo/table', NULL, 1, 7, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (95, 36, '0,36', '字典组件', 1, 'dict-demo', 'demo/dict', NULL, 1, 4, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (96, 89, '0,89', 'Permission', 1, 'permission', 'demo/permission/page', NULL, 1, 1, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (97, 89, '0,89', 'Icons', 1, 'icon-demo', 'demo/icons', NULL, 1, 2, '', '', '2022-11-20 23:16:30', '2022-11-20 23:16:32');
INSERT INTO `sys_menu` VALUES (102, 26, '0,26', '平台文档(内嵌)', 3, 'internal-doc', 'demo/internal-doc', NULL, 1, 1, 'document', '', '2022-02-18 00:01:40', '2022-02-18 00:01:40');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `sort` int NULL DEFAULT NULL COMMENT '显示顺序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '角色状态(1-正常；0-停用)',
  `data_scope` tinyint NULL DEFAULT NULL COMMENT '数据权限(0-所有数据；1-部门及子部门数据；2-本部门数据；3-本人数据)',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除标识(0-未删除；1-已删除)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'ROOT', 1, 1, 0, 0, '2021-05-21 14:56:51', '2018-12-23 16:00:00');
INSERT INTO `sys_role` VALUES (2, '系统管理员', 'ADMIN', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (3, '访问游客', 'GUEST', 3, 1, 2, 0, '2021-05-26 15:49:05', '2019-05-05 16:00:00');
INSERT INTO `sys_role` VALUES (4, '系统管理员1', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (5, '系统管理员2', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (6, '系统管理员3', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (7, '系统管理员4', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (8, '系统管理员5', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (9, '系统管理员6', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (10, '系统管理员7', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (11, '系统管理员8', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);
INSERT INTO `sys_role` VALUES (12, '系统管理员9', 'ADMIN1', 2, 1, 1, 0, '2021-03-25 12:39:54', NULL);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 5);
INSERT INTO `sys_role_menu` VALUES (2, 6);
INSERT INTO `sys_role_menu` VALUES (2, 11);
INSERT INTO `sys_role_menu` VALUES (2, 12);
INSERT INTO `sys_role_menu` VALUES (2, 19);
INSERT INTO `sys_role_menu` VALUES (2, 18);
INSERT INTO `sys_role_menu` VALUES (2, 17);
INSERT INTO `sys_role_menu` VALUES (2, 13);
INSERT INTO `sys_role_menu` VALUES (2, 14);
INSERT INTO `sys_role_menu` VALUES (2, 15);
INSERT INTO `sys_role_menu` VALUES (2, 16);
INSERT INTO `sys_role_menu` VALUES (2, 9);
INSERT INTO `sys_role_menu` VALUES (2, 10);
INSERT INTO `sys_role_menu` VALUES (2, 37);
INSERT INTO `sys_role_menu` VALUES (2, 20);
INSERT INTO `sys_role_menu` VALUES (2, 21);
INSERT INTO `sys_role_menu` VALUES (2, 22);
INSERT INTO `sys_role_menu` VALUES (2, 23);
INSERT INTO `sys_role_menu` VALUES (2, 24);
INSERT INTO `sys_role_menu` VALUES (2, 32);
INSERT INTO `sys_role_menu` VALUES (2, 33);
INSERT INTO `sys_role_menu` VALUES (2, 39);
INSERT INTO `sys_role_menu` VALUES (2, 34);
INSERT INTO `sys_role_menu` VALUES (2, 26);
INSERT INTO `sys_role_menu` VALUES (2, 30);
INSERT INTO `sys_role_menu` VALUES (2, 31);
INSERT INTO `sys_role_menu` VALUES (2, 36);
INSERT INTO `sys_role_menu` VALUES (2, 38);
INSERT INTO `sys_role_menu` VALUES (2, 39);
INSERT INTO `sys_role_menu` VALUES (2, 40);
INSERT INTO `sys_role_menu` VALUES (2, 41);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 5);
INSERT INTO `sys_role_menu` VALUES (2, 6);
INSERT INTO `sys_role_menu` VALUES (2, 20);
INSERT INTO `sys_role_menu` VALUES (2, 21);
INSERT INTO `sys_role_menu` VALUES (2, 22);
INSERT INTO `sys_role_menu` VALUES (2, 23);
INSERT INTO `sys_role_menu` VALUES (2, 24);
INSERT INTO `sys_role_menu` VALUES (2, 26);
INSERT INTO `sys_role_menu` VALUES (2, 30);
INSERT INTO `sys_role_menu` VALUES (2, 31);
INSERT INTO `sys_role_menu` VALUES (2, 32);
INSERT INTO `sys_role_menu` VALUES (2, 33);
INSERT INTO `sys_role_menu` VALUES (2, 36);
INSERT INTO `sys_role_menu` VALUES (2, 37);
INSERT INTO `sys_role_menu` VALUES (2, 38);
INSERT INTO `sys_role_menu` VALUES (2, 39);
INSERT INTO `sys_role_menu` VALUES (2, 40);
INSERT INTO `sys_role_menu` VALUES (2, 41);
INSERT INTO `sys_role_menu` VALUES (2, 70);
INSERT INTO `sys_role_menu` VALUES (2, 71);
INSERT INTO `sys_role_menu` VALUES (2, 72);
INSERT INTO `sys_role_menu` VALUES (2, 73);
INSERT INTO `sys_role_menu` VALUES (2, 74);
INSERT INTO `sys_role_menu` VALUES (2, 75);
INSERT INTO `sys_role_menu` VALUES (2, 76);
INSERT INTO `sys_role_menu` VALUES (2, 77);
INSERT INTO `sys_role_menu` VALUES (2, 78);
INSERT INTO `sys_role_menu` VALUES (2, 79);
INSERT INTO `sys_role_menu` VALUES (2, 81);
INSERT INTO `sys_role_menu` VALUES (2, 84);
INSERT INTO `sys_role_menu` VALUES (2, 85);
INSERT INTO `sys_role_menu` VALUES (2, 86);
INSERT INTO `sys_role_menu` VALUES (2, 87);
INSERT INTO `sys_role_menu` VALUES (2, 88);
INSERT INTO `sys_role_menu` VALUES (2, 89);
INSERT INTO `sys_role_menu` VALUES (2, 90);
INSERT INTO `sys_role_menu` VALUES (2, 91);
INSERT INTO `sys_role_menu` VALUES (2, 92);
INSERT INTO `sys_role_menu` VALUES (2, 93);
INSERT INTO `sys_role_menu` VALUES (2, 94);
INSERT INTO `sys_role_menu` VALUES (2, 95);
INSERT INTO `sys_role_menu` VALUES (2, 96);
INSERT INTO `sys_role_menu` VALUES (2, 97);
INSERT INTO `sys_role_menu` VALUES (2, 102);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `gender` tinyint(1) NULL DEFAULT 1 COMMENT '性别((1:男;2:女))',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `dept_id` int NULL DEFAULT NULL COMMENT '部门ID',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '用户状态((1:正常;0:禁用))',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识(0:未删除;1:已删除)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `login_name`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'root', '有来技术', 0, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', NULL, 'https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif', '17621590365', 1, 'youlaitech@163.com', 0, NULL, NULL);
INSERT INTO `sys_user` VALUES (2, 'admin', '系统管理员', 1, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', 1, 'https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif', '17621210366', 1, '', 0, '2019-10-10 13:41:22', '2022-07-31 12:39:30');
INSERT INTO `sys_user` VALUES (3, 'test', '测试小用户', 1, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', 3, 'https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif', '17621210366', 1, 'youlaitech@163.com', 0, '2021-06-05 01:31:29', '2021-06-05 01:31:29');
INSERT INTO `sys_user` VALUES (287, '123', '123', 1, '$2a$10$mVoBVqm1837huf7kcN0wS.GVYKEFv0arb7GvzfFXoTyqDlcRzT.6i', 1, '', NULL, 1, NULL, 1, '2023-05-21 14:11:19', '2023-05-21 14:11:25');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (287, 2);

-- ----------------------------
-- Table structure for tb_dormitory
-- ----------------------------
DROP TABLE IF EXISTS `tb_dormitory`;
CREATE TABLE `tb_dormitory`  (
  `id` bigint NULL DEFAULT NULL,
  `building_id` bigint NULL DEFAULT NULL,
  `dormitory_number` int NULL DEFAULT NULL,
  `capacity` tinyint NULL DEFAULT NULL,
  `electricity` double NULL DEFAULT NULL,
  `water` double NULL DEFAULT NULL,
  `e_status` tinyint NULL DEFAULT NULL,
  `w_status` tinyint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_dormitory
-- ----------------------------
INSERT INTO `tb_dormitory` VALUES (1, 1, 101, 8, 37.71, 67.13, 0, 0);
INSERT INTO `tb_dormitory` VALUES (2, 1, 102, 8, -10, 61.67, 1, 0);
INSERT INTO `tb_dormitory` VALUES (3, 1, 103, 8, 78.27, -10.2, 0, 1);
INSERT INTO `tb_dormitory` VALUES (4, 1, 104, 8, 3.8, 13.51, 0, 0);
INSERT INTO `tb_dormitory` VALUES (5, 1, 105, 8, 96.43, 64.78, 0, 0);
INSERT INTO `tb_dormitory` VALUES (6, 1, 106, 8, 74.11, 14.81, 0, 0);
INSERT INTO `tb_dormitory` VALUES (7, 1, 107, 8, 92.14, 12.24, 0, 0);
INSERT INTO `tb_dormitory` VALUES (8, 1, 108, 8, 105.34, 16.75, 0, 0);
INSERT INTO `tb_dormitory` VALUES (9, 1, 109, 8, 3.15, 25.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (10, 1, 110, 8, 110.3, 77.56, 0, 0);
INSERT INTO `tb_dormitory` VALUES (11, 1, 111, 8, 80.9, 28.66, 0, 0);
INSERT INTO `tb_dormitory` VALUES (12, 1, 112, 8, 4.97, 34.08, 0, 0);
INSERT INTO `tb_dormitory` VALUES (13, 1, 113, 8, 6.23, 64.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (14, 1, 201, 8, 50.44, 33.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (15, 1, 202, 8, 70.92, 66.81, 0, 0);
INSERT INTO `tb_dormitory` VALUES (16, 1, 203, 8, 104.93, 8.38, 0, 0);
INSERT INTO `tb_dormitory` VALUES (17, 1, 204, 8, 65.9, 90.71, 0, 0);
INSERT INTO `tb_dormitory` VALUES (18, 1, 205, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (19, 1, 206, 8, 37.14, 46.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (20, 1, 207, 8, 80.17, 81.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (21, 1, 208, 8, 39.27, 36.01, 0, 0);
INSERT INTO `tb_dormitory` VALUES (22, 1, 209, 8, 11.08, 56.67, 0, 0);
INSERT INTO `tb_dormitory` VALUES (23, 1, 210, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (24, 1, 211, 8, 64.69, 64.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (25, 1, 212, 8, 9.79, 80.19, 0, 0);
INSERT INTO `tb_dormitory` VALUES (26, 1, 213, 8, 26.46, 92.48, 0, 0);
INSERT INTO `tb_dormitory` VALUES (27, 1, 301, 8, 50.44, 33.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (28, 1, 302, 8, 70.92, 66.81, 0, 0);
INSERT INTO `tb_dormitory` VALUES (29, 1, 303, 8, 104.93, 8.38, 0, 0);
INSERT INTO `tb_dormitory` VALUES (30, 1, 304, 8, 65.9, 90.71, 0, 0);
INSERT INTO `tb_dormitory` VALUES (31, 1, 305, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (32, 1, 306, 8, 37.14, 46.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (33, 1, 307, 8, 80.17, 81.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (34, 1, 308, 8, 39.27, 36.01, 0, 0);
INSERT INTO `tb_dormitory` VALUES (35, 1, 309, 8, 11.08, 56.67, 0, 0);
INSERT INTO `tb_dormitory` VALUES (36, 1, 310, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (37, 1, 311, 8, 64.69, 64.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (38, 1, 312, 8, 9.79, 80.19, 0, 0);
INSERT INTO `tb_dormitory` VALUES (39, 1, 313, 8, 26.46, 92.48, 0, 0);
INSERT INTO `tb_dormitory` VALUES (40, 1, 401, 8, 50.44, 33.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (41, 1, 402, 8, 70.92, 66.81, 0, 0);
INSERT INTO `tb_dormitory` VALUES (42, 1, 403, 8, 104.93, 8.38, 0, 0);
INSERT INTO `tb_dormitory` VALUES (43, 1, 404, 8, 65.9, 90.71, 0, 0);
INSERT INTO `tb_dormitory` VALUES (44, 1, 405, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (45, 1, 406, 8, 37.14, 46.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (46, 1, 407, 8, 80.17, 81.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (47, 1, 408, 8, 39.27, 36.01, 0, 0);
INSERT INTO `tb_dormitory` VALUES (48, 1, 409, 8, 11.08, 56.67, 0, 0);
INSERT INTO `tb_dormitory` VALUES (49, 1, 410, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (50, 1, 411, 8, 64.69, 64.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (51, 1, 412, 8, 9.79, 80.19, 0, 0);
INSERT INTO `tb_dormitory` VALUES (52, 1, 413, 8, 26.46, 92.48, 0, 0);
INSERT INTO `tb_dormitory` VALUES (53, 1, 501, 8, 50.44, 33.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (54, 1, 502, 8, 70.92, 66.81, 0, 0);
INSERT INTO `tb_dormitory` VALUES (55, 1, 503, 8, 104.93, 8.38, 0, 0);
INSERT INTO `tb_dormitory` VALUES (56, 1, 504, 8, 65.9, 90.71, 0, 0);
INSERT INTO `tb_dormitory` VALUES (57, 1, 505, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (58, 1, 506, 8, 37.14, 46.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (59, 1, 507, 8, 80.17, 81.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (60, 1, 508, 8, 39.27, 36.01, 0, 0);
INSERT INTO `tb_dormitory` VALUES (61, 1, 509, 8, 11.08, 56.67, 0, 0);
INSERT INTO `tb_dormitory` VALUES (62, 1, 510, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (63, 1, 511, 8, 64.69, 64.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (64, 1, 512, 8, 9.79, 80.19, 0, 0);
INSERT INTO `tb_dormitory` VALUES (65, 1, 513, 8, 26.46, 92.48, 0, 0);
INSERT INTO `tb_dormitory` VALUES (66, 1, 601, 8, 50.44, 33.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (67, 1, 602, 8, 70.92, 66.81, 0, 0);
INSERT INTO `tb_dormitory` VALUES (68, 1, 603, 8, 104.93, 8.38, 0, 0);
INSERT INTO `tb_dormitory` VALUES (69, 1, 604, 8, 65.9, 90.71, 0, 0);
INSERT INTO `tb_dormitory` VALUES (70, 1, 605, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (71, 1, 606, 8, 37.14, 46.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (72, 1, 607, 8, 80.17, 81.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (73, 1, 608, 8, 39.27, 36.01, 0, 0);
INSERT INTO `tb_dormitory` VALUES (74, 1, 609, 8, 11.08, 56.67, 0, 0);
INSERT INTO `tb_dormitory` VALUES (75, 1, 610, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (76, 1, 611, 8, 64.69, 64.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (77, 1, 612, 8, 9.79, 80.19, 0, 0);
INSERT INTO `tb_dormitory` VALUES (78, 1, 613, 8, 26.46, 92.48, 0, 0);
INSERT INTO `tb_dormitory` VALUES (79, 1, 701, 8, 50.44, 33.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (80, 1, 702, 8, 70.92, 66.81, 0, 0);
INSERT INTO `tb_dormitory` VALUES (81, 1, 703, 8, 104.93, 8.38, 0, 0);
INSERT INTO `tb_dormitory` VALUES (82, 1, 704, 8, 65.9, 90.71, 0, 0);
INSERT INTO `tb_dormitory` VALUES (83, 1, 705, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (84, 1, 706, 8, 37.14, 46.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (85, 1, 707, 8, 80.17, 81.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (86, 1, 708, 8, 39.27, 36.01, 0, 0);
INSERT INTO `tb_dormitory` VALUES (87, 1, 709, 8, 11.08, 56.67, 0, 0);
INSERT INTO `tb_dormitory` VALUES (88, 1, 710, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (89, 1, 711, 8, 64.69, 64.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (90, 1, 712, 8, 9.79, 80.19, 0, 0);
INSERT INTO `tb_dormitory` VALUES (91, 1, 713, 8, 26.46, 92.48, 0, 0);
INSERT INTO `tb_dormitory` VALUES (92, 2, 101, 8, 65.54, 42.03, 0, 0);
INSERT INTO `tb_dormitory` VALUES (93, 2, 102, 8, 7.33, 76.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (94, 2, 103, 8, 11.9, 87.24, 0, 0);
INSERT INTO `tb_dormitory` VALUES (95, 2, 104, 8, 68.44, 73.98, 0, 0);
INSERT INTO `tb_dormitory` VALUES (96, 2, 105, 8, 108.85, 77.78, 0, 0);
INSERT INTO `tb_dormitory` VALUES (97, 2, 106, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (98, 2, 107, 8, 26.21, 30.95, 0, 0);
INSERT INTO `tb_dormitory` VALUES (99, 2, 108, 8, 29.71, 32.79, 0, 0);
INSERT INTO `tb_dormitory` VALUES (100, 2, 109, 8, 84.56, 71.6, 0, 0);
INSERT INTO `tb_dormitory` VALUES (101, 2, 110, 8, 1.89, 69.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (102, 2, 111, 8, 68, 42.5, 0, 0);
INSERT INTO `tb_dormitory` VALUES (103, 2, 112, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (104, 2, 201, 8, 65.54, 42.03, 0, 0);
INSERT INTO `tb_dormitory` VALUES (105, 2, 202, 8, 7.33, 76.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (106, 2, 203, 8, 11.9, 87.24, 0, 0);
INSERT INTO `tb_dormitory` VALUES (107, 2, 204, 8, 68.44, 73.98, 0, 0);
INSERT INTO `tb_dormitory` VALUES (108, 2, 205, 8, 108.85, 77.78, 0, 0);
INSERT INTO `tb_dormitory` VALUES (109, 2, 206, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (110, 2, 207, 8, 26.21, 30.95, 0, 0);
INSERT INTO `tb_dormitory` VALUES (111, 2, 208, 8, 29.71, 32.79, 0, 0);
INSERT INTO `tb_dormitory` VALUES (112, 2, 209, 8, 84.56, 71.6, 0, 0);
INSERT INTO `tb_dormitory` VALUES (113, 2, 210, 8, 1.89, 69.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (114, 2, 211, 8, 68, 42.5, 0, 0);
INSERT INTO `tb_dormitory` VALUES (115, 2, 212, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (116, 2, 301, 8, 65.54, 42.03, 0, 0);
INSERT INTO `tb_dormitory` VALUES (117, 2, 302, 8, 7.33, 76.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (118, 2, 303, 8, 11.9, 87.24, 0, 0);
INSERT INTO `tb_dormitory` VALUES (119, 2, 304, 8, 68.44, 73.98, 0, 0);
INSERT INTO `tb_dormitory` VALUES (120, 2, 305, 8, 108.85, 77.78, 0, 0);
INSERT INTO `tb_dormitory` VALUES (121, 2, 306, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (122, 2, 307, 8, 26.21, 30.95, 0, 0);
INSERT INTO `tb_dormitory` VALUES (123, 2, 308, 8, 29.71, 32.79, 0, 0);
INSERT INTO `tb_dormitory` VALUES (124, 2, 309, 8, 84.56, 71.6, 0, 0);
INSERT INTO `tb_dormitory` VALUES (125, 2, 310, 8, 1.89, 69.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (126, 2, 311, 8, 68, 42.5, 0, 0);
INSERT INTO `tb_dormitory` VALUES (127, 2, 312, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (128, 2, 401, 8, 65.54, 42.03, 0, 0);
INSERT INTO `tb_dormitory` VALUES (129, 2, 402, 8, 7.33, 76.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (130, 2, 403, 8, 11.9, 87.24, 0, 0);
INSERT INTO `tb_dormitory` VALUES (131, 2, 404, 8, 68.44, 73.98, 0, 0);
INSERT INTO `tb_dormitory` VALUES (132, 2, 405, 8, 108.85, 77.78, 0, 0);
INSERT INTO `tb_dormitory` VALUES (133, 2, 406, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (134, 2, 407, 8, 26.21, 30.95, 0, 0);
INSERT INTO `tb_dormitory` VALUES (135, 2, 408, 8, 29.71, 32.79, 0, 0);
INSERT INTO `tb_dormitory` VALUES (136, 2, 409, 8, 84.56, 71.6, 0, 0);
INSERT INTO `tb_dormitory` VALUES (137, 2, 410, 8, 1.89, 69.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (138, 2, 411, 8, 68, 42.5, 0, 0);
INSERT INTO `tb_dormitory` VALUES (139, 2, 412, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (140, 2, 501, 8, 65.54, 42.03, 0, 0);
INSERT INTO `tb_dormitory` VALUES (141, 2, 502, 8, 7.33, 76.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (142, 2, 503, 8, 11.9, 87.24, 0, 0);
INSERT INTO `tb_dormitory` VALUES (143, 2, 504, 8, 68.44, 73.98, 0, 0);
INSERT INTO `tb_dormitory` VALUES (144, 2, 505, 8, 108.85, 77.78, 0, 0);
INSERT INTO `tb_dormitory` VALUES (145, 2, 506, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (146, 2, 507, 8, 26.21, 30.95, 0, 0);
INSERT INTO `tb_dormitory` VALUES (147, 2, 508, 8, 29.71, 32.79, 0, 0);
INSERT INTO `tb_dormitory` VALUES (148, 2, 509, 8, 84.56, 71.6, 0, 0);
INSERT INTO `tb_dormitory` VALUES (149, 2, 510, 8, 1.89, 69.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (150, 2, 511, 8, 68, 42.5, 0, 0);
INSERT INTO `tb_dormitory` VALUES (151, 2, 512, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (152, 2, 601, 8, 65.54, 42.03, 0, 0);
INSERT INTO `tb_dormitory` VALUES (153, 2, 602, 8, 7.33, 76.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (154, 2, 603, 8, 11.9, 87.24, 0, 0);
INSERT INTO `tb_dormitory` VALUES (155, 2, 604, 8, 68.44, 73.98, 0, 0);
INSERT INTO `tb_dormitory` VALUES (156, 2, 605, 8, 108.85, 77.78, 0, 0);
INSERT INTO `tb_dormitory` VALUES (157, 2, 606, 8, 119.97, 68.97, 0, 0);
INSERT INTO `tb_dormitory` VALUES (158, 2, 607, 8, 26.21, 30.95, 0, 0);
INSERT INTO `tb_dormitory` VALUES (159, 2, 608, 8, 29.71, 32.79, 0, 0);
INSERT INTO `tb_dormitory` VALUES (160, 2, 609, 8, 84.56, 71.6, 0, 0);
INSERT INTO `tb_dormitory` VALUES (161, 2, 610, 8, 1.89, 69.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (162, 2, 611, 8, 68, 42.5, 0, 0);
INSERT INTO `tb_dormitory` VALUES (163, 2, 612, 8, 70.47, 3.21, 0, 0);
INSERT INTO `tb_dormitory` VALUES (178, 3, 101, 6, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (179, 3, 102, 6, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (180, 3, 103, 6, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (181, 3, 104, 6, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (182, 3, 105, 6, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (183, 3, 106, 6, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (184, 3, 107, 6, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (185, 3, 108, 6, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (186, 3, 109, 6, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (187, 3, 110, 6, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (188, 3, 111, 6, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (189, 3, 112, 6, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (190, 3, 113, 6, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (191, 3, 114, 6, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (192, 3, 115, 6, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (193, 3, 116, 6, 71.79, 40.4, 0, 0);
INSERT INTO `tb_dormitory` VALUES (194, 3, 117, 6, 17.55, 36.05, 0, 0);
INSERT INTO `tb_dormitory` VALUES (195, 3, 118, 6, 104.79, 58.94, 0, 0);
INSERT INTO `tb_dormitory` VALUES (196, 3, 119, 6, 76.67, 31.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (197, 3, 120, 6, 11.04, 30.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (198, 3, 201, 6, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (199, 3, 202, 6, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (200, 3, 203, 6, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (201, 3, 204, 6, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (202, 3, 205, 6, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (203, 3, 206, 6, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (204, 3, 207, 6, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (205, 3, 208, 6, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (206, 3, 209, 6, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (207, 3, 210, 6, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (208, 3, 211, 6, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (209, 3, 212, 6, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (210, 3, 213, 6, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (211, 3, 214, 6, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (212, 3, 215, 6, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (213, 3, 216, 6, 71.79, 40.4, 0, 0);
INSERT INTO `tb_dormitory` VALUES (214, 3, 217, 6, 17.55, 36.05, 0, 0);
INSERT INTO `tb_dormitory` VALUES (215, 3, 218, 6, 104.79, 58.94, 0, 0);
INSERT INTO `tb_dormitory` VALUES (216, 3, 219, 6, 76.67, 31.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (217, 3, 220, 6, 11.04, 30.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (218, 3, 301, 6, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (219, 3, 302, 6, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (220, 3, 303, 6, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (221, 3, 304, 6, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (222, 3, 305, 6, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (223, 3, 306, 6, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (224, 3, 307, 6, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (225, 3, 308, 6, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (226, 3, 309, 6, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (227, 3, 310, 6, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (228, 3, 311, 6, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (229, 3, 312, 6, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (230, 3, 313, 6, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (231, 3, 314, 6, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (232, 3, 315, 6, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (233, 3, 316, 6, 71.79, 40.4, 0, 0);
INSERT INTO `tb_dormitory` VALUES (234, 3, 317, 6, 17.55, 36.05, 0, 0);
INSERT INTO `tb_dormitory` VALUES (235, 3, 318, 6, 104.79, 58.94, 0, 0);
INSERT INTO `tb_dormitory` VALUES (236, 3, 319, 6, 76.67, 31.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (237, 3, 320, 6, 11.04, 30.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (238, 3, 401, 6, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (239, 3, 402, 6, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (240, 3, 403, 6, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (241, 3, 404, 6, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (242, 3, 405, 6, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (243, 3, 406, 6, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (244, 3, 407, 6, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (245, 3, 408, 6, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (246, 3, 409, 6, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (247, 3, 410, 6, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (248, 3, 411, 6, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (249, 3, 412, 6, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (250, 3, 413, 6, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (251, 3, 414, 6, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (252, 3, 415, 6, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (253, 3, 416, 6, 71.79, 40.4, 0, 0);
INSERT INTO `tb_dormitory` VALUES (254, 3, 417, 6, 17.55, 36.05, 0, 0);
INSERT INTO `tb_dormitory` VALUES (255, 3, 418, 6, 104.79, 58.94, 0, 0);
INSERT INTO `tb_dormitory` VALUES (256, 3, 419, 6, 76.67, 31.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (257, 3, 420, 6, 11.04, 30.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (258, 3, 501, 6, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (259, 3, 502, 6, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (260, 3, 503, 6, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (261, 3, 504, 6, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (262, 3, 505, 6, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (263, 3, 506, 6, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (264, 3, 507, 6, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (265, 3, 508, 6, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (266, 3, 509, 6, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (267, 3, 510, 6, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (268, 3, 511, 6, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (269, 3, 512, 6, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (270, 3, 513, 6, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (271, 3, 514, 6, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (272, 3, 515, 6, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (273, 3, 516, 6, 71.79, 40.4, 0, 0);
INSERT INTO `tb_dormitory` VALUES (274, 3, 517, 6, 17.55, 36.05, 0, 0);
INSERT INTO `tb_dormitory` VALUES (275, 3, 518, 6, 104.79, 58.94, 0, 0);
INSERT INTO `tb_dormitory` VALUES (276, 3, 519, 6, 76.67, 31.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (277, 3, 520, 6, 11.04, 30.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (278, 3, 601, 6, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (279, 3, 602, 6, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (280, 3, 603, 6, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (281, 3, 604, 6, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (282, 3, 605, 6, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (283, 3, 606, 6, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (284, 3, 607, 6, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (285, 3, 608, 6, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (286, 3, 609, 6, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (287, 3, 610, 6, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (288, 3, 611, 6, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (289, 3, 612, 6, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (290, 3, 613, 6, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (291, 3, 614, 6, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (292, 3, 615, 6, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (293, 3, 616, 6, 71.79, 40.4, 0, 0);
INSERT INTO `tb_dormitory` VALUES (294, 3, 617, 6, 17.55, 36.05, 0, 0);
INSERT INTO `tb_dormitory` VALUES (295, 3, 618, 6, 104.79, 58.94, 0, 0);
INSERT INTO `tb_dormitory` VALUES (296, 3, 619, 6, 76.67, 31.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (297, 3, 620, 6, 11.04, 30.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (298, 3, 701, 6, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (299, 3, 702, 6, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (300, 3, 703, 6, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (301, 3, 704, 6, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (302, 3, 705, 6, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (303, 3, 706, 6, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (304, 3, 707, 6, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (305, 3, 708, 6, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (306, 3, 709, 6, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (307, 3, 710, 6, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (308, 3, 711, 6, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (309, 3, 712, 6, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (310, 3, 713, 6, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (311, 3, 714, 6, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (312, 3, 715, 6, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (313, 3, 716, 6, 71.79, 40.4, 0, 0);
INSERT INTO `tb_dormitory` VALUES (314, 3, 717, 6, 17.55, 36.05, 0, 0);
INSERT INTO `tb_dormitory` VALUES (315, 3, 718, 6, 104.79, 58.94, 0, 0);
INSERT INTO `tb_dormitory` VALUES (316, 3, 719, 6, 76.67, 31.77, 0, 0);
INSERT INTO `tb_dormitory` VALUES (317, 3, 720, 6, 11.04, 30.26, 0, 0);
INSERT INTO `tb_dormitory` VALUES (318, 4, 101, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (319, 4, 102, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (320, 4, 103, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (321, 4, 104, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (322, 4, 105, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (323, 4, 106, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (324, 4, 107, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (325, 4, 108, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (326, 4, 109, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (327, 4, 110, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (328, 4, 111, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (329, 4, 112, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (330, 4, 113, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (331, 4, 114, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (332, 4, 115, 4, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (333, 4, 201, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (334, 4, 202, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (335, 4, 203, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (336, 4, 204, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (337, 4, 205, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (338, 4, 206, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (339, 4, 207, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (340, 4, 208, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (341, 4, 209, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (342, 4, 210, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (343, 4, 211, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (344, 4, 212, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (345, 4, 213, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (346, 4, 214, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (347, 4, 215, 4, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (348, 4, 301, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (349, 4, 302, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (350, 4, 303, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (351, 4, 304, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (352, 4, 305, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (353, 4, 306, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (354, 4, 307, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (355, 4, 308, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (356, 4, 309, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (357, 4, 310, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (358, 4, 311, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (359, 4, 312, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (360, 4, 313, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (361, 4, 314, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (362, 4, 315, 4, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (363, 4, 401, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (364, 4, 402, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (365, 4, 403, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (366, 4, 404, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (367, 4, 405, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (368, 4, 406, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (369, 4, 407, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (370, 4, 408, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (371, 4, 409, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (372, 4, 410, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (373, 4, 411, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (374, 4, 412, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (375, 4, 413, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (376, 4, 414, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (377, 4, 415, 4, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (378, 4, 501, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (379, 4, 502, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (380, 4, 503, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (381, 4, 504, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (382, 4, 505, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (383, 4, 506, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (384, 4, 507, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (385, 4, 508, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (386, 4, 509, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (387, 4, 510, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (388, 4, 511, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (389, 4, 512, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (390, 4, 513, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (391, 4, 514, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (392, 4, 515, 4, 56.1, 93.41, 0, 0);
INSERT INTO `tb_dormitory` VALUES (393, 5, 101, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (394, 5, 102, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (395, 5, 103, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (396, 5, 104, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (397, 5, 105, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (398, 5, 106, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (399, 5, 107, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (400, 5, 108, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (401, 5, 109, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (402, 5, 110, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (403, 5, 111, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (404, 5, 112, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (405, 5, 113, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (406, 5, 114, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (407, 5, 201, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (408, 5, 202, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (409, 5, 203, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (410, 5, 204, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (411, 5, 205, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (412, 5, 206, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (413, 5, 207, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (414, 5, 208, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (415, 5, 209, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (416, 5, 210, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (417, 5, 211, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (418, 5, 212, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (419, 5, 213, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (420, 5, 214, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (421, 5, 301, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (422, 5, 302, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (423, 5, 303, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (424, 5, 304, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (425, 5, 305, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (426, 5, 306, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (427, 5, 307, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (428, 5, 308, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (429, 5, 309, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (430, 5, 310, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (431, 5, 311, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (432, 5, 312, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (433, 5, 313, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (434, 5, 314, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (435, 5, 401, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (436, 5, 402, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (437, 5, 403, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (438, 5, 404, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (439, 5, 405, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (440, 5, 406, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (441, 5, 407, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (442, 5, 408, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (443, 5, 409, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (444, 5, 410, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (445, 5, 411, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (446, 5, 412, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (447, 5, 413, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (448, 5, 414, 4, 47.86, 6.49, 0, 0);
INSERT INTO `tb_dormitory` VALUES (449, 5, 501, 4, 37.14, 17.43, 0, 0);
INSERT INTO `tb_dormitory` VALUES (450, 5, 502, 4, 73.25, 82.52, 0, 0);
INSERT INTO `tb_dormitory` VALUES (451, 5, 503, 4, 43.24, 78.96, 0, 0);
INSERT INTO `tb_dormitory` VALUES (452, 5, 504, 4, 103.47, 76.14, 0, 0);
INSERT INTO `tb_dormitory` VALUES (453, 5, 505, 4, 40.1, 78.1, 0, 0);
INSERT INTO `tb_dormitory` VALUES (454, 5, 506, 4, 62.34, 37.8, 0, 0);
INSERT INTO `tb_dormitory` VALUES (455, 5, 507, 4, 53.28, 42.88, 0, 0);
INSERT INTO `tb_dormitory` VALUES (456, 5, 508, 4, 11.39, 55.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (457, 5, 509, 4, 106.66, 2.46, 0, 0);
INSERT INTO `tb_dormitory` VALUES (458, 5, 510, 4, 87.94, 86.91, 0, 0);
INSERT INTO `tb_dormitory` VALUES (459, 5, 511, 4, 80.29, 25.15, 0, 0);
INSERT INTO `tb_dormitory` VALUES (460, 5, 512, 4, 49.08, 37.55, 0, 0);
INSERT INTO `tb_dormitory` VALUES (461, 5, 513, 4, 42.17, 98.72, 0, 0);
INSERT INTO `tb_dormitory` VALUES (462, 5, 514, 4, 47.86, 6.49, 0, 0);

-- ----------------------------
-- Table structure for tb_user_dormitory
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_dormitory`;
CREATE TABLE `tb_user_dormitory`  (
  `userid` bigint NOT NULL,
  `dormitoryId` bigint NOT NULL COMMENT '宿舍id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '人员的宿舍' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_dormitory
-- ----------------------------

-- ----------------------------
-- Table structure for work_log
-- ----------------------------
DROP TABLE IF EXISTS `work_log`;
CREATE TABLE `work_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userid` bigint NOT NULL COMMENT '用户id',
  `time` int NOT NULL DEFAULT 0 COMMENT '工作时间（分钟时间）',
  `day_time` date NOT NULL COMMENT '当天',
  `type` tinyint NOT NULL DEFAULT 0 COMMENT '类型,0正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工作时间记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_log
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
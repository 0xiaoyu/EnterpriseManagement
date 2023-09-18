package com.yu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yu.model.entity.SysUserRole;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户角色持久层
 *
 * @author yu
 * @since 2023/9/16
 */
@Mapper
public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {

}

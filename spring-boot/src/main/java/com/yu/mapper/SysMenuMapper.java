package com.yu.mapper;

/**
 * 菜单持久接口层
 *
 * @author yu
 * @since 2023/9/16
 */

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yu.model.entity.SysMenu;
import com.yu.model.bo.RouteBO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Set;

@Mapper
public interface SysMenuMapper extends BaseMapper<SysMenu> {

    List<RouteBO> listRoutes();

    /**
     * 获取角色权限集合
     *
     * @param roles
     * @return
     */
    Set<String> listRolePerms(Set<String> roles);
}

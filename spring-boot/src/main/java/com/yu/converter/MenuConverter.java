package com.yu.converter;

import com.yu.model.entity.SysMenu;
import com.yu.model.form.MenuForm;
import com.yu.model.vo.MenuVO;
import org.mapstruct.Mapper;

/**
 * 菜单对象转换器
 *
 * @author yu
 * @since 2023/9/16
 */
@Mapper(componentModel = "spring")
public interface MenuConverter {

    MenuVO entity2Vo(SysMenu entity);


    MenuForm entity2Form(SysMenu entity);

    SysMenu form2Entity(MenuForm menuForm);

}
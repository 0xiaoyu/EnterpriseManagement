package com.yu.converter;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.model.bo.UserBO;
import com.yu.model.entity.SysUser;
import com.yu.model.form.UserForm;
import com.yu.model.bo.UserFormBO;
import com.yu.model.vo.UserImportVO;
import com.yu.model.vo.UserInfoVO;
import com.yu.model.vo.UserPageVO;
import org.mapstruct.InheritInverseConfiguration;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

/**
 * 用户对象转换器
 *
 * @author yu
 * @since 2023/9/16
 */
@Mapper(componentModel = "spring")
public interface UserConverter {

    @Mappings({
            @Mapping(target = "genderLabel", expression = "java(com.yu.common.base.IBaseEnum.getLabelByValue(bo.getGender(), com.yu.common.enums.GenderEnum.class))")
    })
    UserPageVO bo2Vo(UserBO bo);

    Page<UserPageVO> bo2Vo(Page<UserBO> bo);

    UserForm bo2Form(UserFormBO bo);

    UserForm entity2Form(SysUser entity);

    @InheritInverseConfiguration(name = "entity2Form")
    SysUser form2Entity(UserForm entity);

    @Mappings({
            @Mapping(target = "userId", source = "id")
    })
    UserInfoVO toUserInfoVo(SysUser entity);

    SysUser importVo2Entity(UserImportVO vo);

}

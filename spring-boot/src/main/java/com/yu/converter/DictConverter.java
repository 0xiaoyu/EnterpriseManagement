package com.yu.converter;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.model.entity.SysDict;
import com.yu.model.form.DictForm;
import com.yu.model.vo.DictPageVO;
import org.mapstruct.InheritInverseConfiguration;
import org.mapstruct.Mapper;

/**
 * 字典数据项对象转换器
 *
 * @author yu
 * @since 2023/9/16
 */
@Mapper(componentModel = "spring")
public interface DictConverter {

    Page<DictPageVO> entity2Page(Page<SysDict> page);

    DictForm entity2Form(SysDict entity);

    @InheritInverseConfiguration(name="entity2Form")
    SysDict form2Entity(DictForm entity);
}

package com.yu.converter;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.model.entity.SysDictType;
import com.yu.model.form.DictTypeForm;
import com.yu.model.vo.DictTypePageVO;
import org.mapstruct.Mapper;

/**
 * 字典类型对象转换器
 *
 * @author yu
 * @since 2023/9/16
 */
@Mapper(componentModel = "spring")
public interface DictTypeConverter {

    Page<DictTypePageVO> entity2Page(Page<SysDictType> page);

    DictTypeForm entity2Form(SysDictType entity);

    SysDictType form2Entity(DictTypeForm entity);
}

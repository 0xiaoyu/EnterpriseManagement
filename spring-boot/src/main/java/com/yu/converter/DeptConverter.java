package com.yu.converter;

import com.yu.model.entity.SysDept;
import com.yu.model.form.DeptForm;
import com.yu.model.vo.DeptVO;
import org.mapstruct.Mapper;

/**
 * 部门对象转换器
 *
 * @author yu
 * @since 2023/9/16
 */
@Mapper(componentModel = "spring")
public interface DeptConverter {

    DeptForm entity2Form(SysDept entity);
    DeptVO entity2Vo(SysDept entity);

    SysDept form2Entity(DeptForm deptForm);

}
package com.yu.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.model.dto.SalaryDTO;
import com.yu.model.entity.Salary;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yu.model.query.SalaryPageQuery;

/**
 * <p>
 * 薪资 Mapper 接口
 * </p>
 *
 * @author zay
 * @since 2023-09-26
 */
public interface SalaryMapper extends BaseMapper<Salary> {

    IPage<SalaryDTO> getPage(Page<Object> page, Long deptId,String time);
}

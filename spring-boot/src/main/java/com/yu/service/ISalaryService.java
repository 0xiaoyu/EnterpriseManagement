package com.yu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.yu.common.result.PageResult;
import com.yu.model.dto.SalaryDTO;
import com.yu.model.entity.Salary;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yu.model.query.SalaryPageQuery;

/**
 * <p>
 * 薪资 服务类
 * </p>
 *
 * @author zay
 * @since 2023-09-26
 */
public interface ISalaryService extends IService<Salary> {

    IPage<SalaryDTO> getPage(SalaryPageQuery query);
}

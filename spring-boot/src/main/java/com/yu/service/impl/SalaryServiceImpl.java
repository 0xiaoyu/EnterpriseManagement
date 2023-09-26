package com.yu.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yu.mapper.SalaryMapper;
import com.yu.model.dto.SalaryDTO;
import com.yu.model.entity.Salary;
import com.yu.model.query.SalaryPageQuery;
import com.yu.service.ISalaryService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * <p>
 * 薪资 服务实现类
 * </p>
 *
 * @author zay
 * @since 2023-09-26
 */
@Service
public class SalaryServiceImpl extends ServiceImpl<SalaryMapper, Salary> implements ISalaryService {

    @Override
    public IPage<SalaryDTO> getPage(SalaryPageQuery query) {
        LocalDate month = query.getMonth();
        if (month == null)
            month = LocalDate.now();
        return baseMapper.getPage(query.getPage(), query.getDeptId(), month.format(DateTimeFormatter.ofPattern("yyyy-MM")));
    }
}

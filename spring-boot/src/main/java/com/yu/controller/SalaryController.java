package com.yu.controller;


import cn.hutool.core.util.StrUtil;
import com.yu.common.result.PageResult;
import com.yu.common.result.Result;
import com.yu.model.entity.Salary;
import com.yu.model.query.SalaryPageQuery;
import com.yu.service.ISalaryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 薪资 前端控制器
 * </p>
 *
 * @author zay
 * @since 2023-09-26
 */
@RestController
@RequestMapping("/salary")
@RequiredArgsConstructor
public class SalaryController {
    private final ISalaryService service;

    @GetMapping
    public PageResult getPage(SalaryPageQuery query) {
        if (StrUtil.isNotBlank(query.getUserId()))
            return PageResult.success(service.lambdaQuery().eq(Salary::getUserid, query.getUserId()).page(query.getPage()));
        else
            return PageResult.success(service.getPage(query));
    }

    @PatchMapping
    public Result<Boolean> modify(Salary salary){
        return Result.judge(service.updateById(salary));
    }


}

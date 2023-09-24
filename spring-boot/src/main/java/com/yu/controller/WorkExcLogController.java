package com.yu.controller;


import com.yu.common.result.PageResult;
import com.yu.common.result.Result;
import com.yu.model.entity.WorkExcLog;
import com.yu.model.query.WorkExcPageQuery;
import com.yu.service.IWorkExcLogService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 工作异常记录 前端控制器
 * </p>
 *
 * @author zay
 * @since 2023-09-24
 */
@RestController
@RequestMapping("/work-exc")
@RequiredArgsConstructor
@Tag(name = "工作异常记录")
public class WorkExcLogController {

    private final IWorkExcLogService service;

    @GetMapping
    @Operation(summary = "分页查询异常类型")
    public PageResult<WorkExcLog> page(WorkExcPageQuery query){
        return PageResult.success(service.getPageQuery(query));
    }

    @PostMapping
    @Operation(summary = "新增异常类型")
    public Result<Boolean> add(@RequestBody WorkExcLog workExcLog){
        return Result.judge(service.save(workExcLog));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "删除异常类型")
    public Result<Boolean> delete( @PathVariable Long id){
        return Result.judge(service.removeById(id));
    }

    @PatchMapping
    @Operation(summary = "修改异常类型")
    public Result<Boolean> update(@RequestBody WorkExcLog workExcLog){
        return Result.judge(service.updateById(workExcLog));
    }

}

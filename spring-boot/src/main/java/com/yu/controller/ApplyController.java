package com.yu.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.toolkit.Db;
import com.yu.common.base.BasePageQuery;
import com.yu.common.enums.ApplyTypeEnum;
import com.yu.common.result.PageResult;
import com.yu.common.result.Result;
import com.yu.common.util.SecurityUtils;
import com.yu.model.entity.Apply;
import com.yu.model.entity.SysUser;
import com.yu.model.query.ApplyQuery;
import com.yu.service.IApplyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 申请表 前端控制器
 *
 * @author zay
 * @since 2023-09-24
 */
@RestController
@RequestMapping("/api/v1/apply")
@RequiredArgsConstructor
@Tag(name = "申请表")
public class ApplyController {

    private final IApplyService service;

    @GetMapping
    @Operation(summary = "条件查询申请表")
    public PageResult<Apply> page(Apply query, BasePageQuery page) {
        return PageResult.success(service.lambdaQuery(query).page(page.getPage()));
    }

    @PostMapping
    @Operation(summary = "新增申请表")
    public Result<Boolean> add(Apply apply) {
        apply.setUserId(SecurityUtils.getUserId());
        // todo 向审批人发送消息
        return Result.judge(service.save(apply));
    }

    @GetMapping("type")
    @Operation(summary = "获取所有申请的类型")
    public Result<ApplyTypeEnum[]> getAllType() {
        return Result.success(ApplyTypeEnum.values());
    }

    @GetMapping("/me")
    @Operation(summary = "根据userid获取申请表")
    public PageResult<Apply> getById(ApplyQuery page) {
        Long userId = SecurityUtils.getUserId();
        SysUser one = Db.lambdaQuery(SysUser.class)
                .eq(StrUtil.isNotBlank(page.getApprovedUser()), SysUser::getNickname, page.getApprovedUser())
                .select(SysUser::getId)
                .one();
        return PageResult.success(service.lambdaQuery()
                .eq(Apply::getUserId, userId)
                .eq(page.getStatus() != null, Apply::getStatus, page.getStatus())
                .eq(one != null, Apply::getApprovedUserId, one.getId())
                .page(page.getPage())
        );
    }

    @DeleteMapping("{id}")
    @Operation(summary = "删除申请表")
    public Result<Boolean> delete(@PathVariable Long id) {
        return Result.judge(service.removeById(id));
    }
}

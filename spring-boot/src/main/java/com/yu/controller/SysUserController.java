package com.yu.controller;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.yu.common.constant.ExcelConstants;
import com.yu.common.enums.EmailType;
import com.yu.common.result.PageResult;
import com.yu.common.result.Result;
import com.yu.common.util.EmailUtils;
import com.yu.common.util.ExcelUtils;
import com.yu.common.annotation.PreventDuplicateSubmit;
import com.yu.listener.easyexcel.UserImportListener;
import com.yu.model.vo.UserImportVO;
import com.yu.model.form.UserForm;
import com.yu.model.entity.SysUser;
import com.yu.model.query.UserPageQuery;
import com.yu.model.vo.UserExportVO;
import com.yu.model.vo.UserInfoVO;
import com.yu.model.vo.UserPageVO;
import com.yu.service.SysUserService;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Objects;

/**
 * 用户控制器
 *
 * @author yu
 * @since 2023/9/16
 */
@Tag(name = "02.用户接口")
@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class SysUserController {

    private final SysUserService userService;
    private final PasswordEncoder passwordEncoder;
    private final EmailUtils emailUtils;


    @PatchMapping("resetPassword")
    @Operation(description = "重置密码")
    public Result<String> resetPassword(@Parameter(description = "email", example = "1647@qq.com")@RequestParam String email,
                                        @Parameter(description = "邮箱验证码", example = "123asd")@RequestParam String verifyCode,
                                        @Parameter(description = "新密码", example = "123456")@RequestParam String password,
                                        @Parameter(description = "用户名", example = "zhou")@RequestParam String username
    ) {
        Result<String> s = switch (emailUtils.verify(email, verifyCode, EmailType.RESET_PASSWORD)) {
            case FAIL -> Result.failed("邮箱验证码错误");
            case OVERDUE -> Result.failed("邮箱验证码已过期");
            default -> null;
        };
        if (s != null)
            return s;

        SysUser user = userService.lambdaQuery().eq(SysUser::getUsername,username).eq(SysUser::getEmail, email).one();
        if (Objects.isNull(user)) return Result.failed("用户不存在");
        String encode = passwordEncoder.encode(password);
        user.setPassword(encode);
        boolean b = userService.updateById(user);
        return b ? Result.success() : Result.failed("重置密码失败");
    }

    @Operation(description = "获取邮箱验证码验证")
    @GetMapping("getEmailVerifyCode")
    public Result<String> getEmailVerifyCode(@Parameter(description = "注册的邮箱", example = "164702@qq.com") String email,
                                             @Parameter(description = "发送邮箱的类型", example = "REGISTER") @RequestParam("type") EmailType type) {
        try {
            emailUtils.sendMailCode(email, type);
            return Result.success();
        } catch (Exception e) {
            return Result.failed("发送验证码失败");
        }
    }

    @Operation(summary = "用户分页列表", security = {@SecurityRequirement(name = "Authorization")})
    @GetMapping("/page")
    public PageResult<UserPageVO> getUserPage(
            @ParameterObject UserPageQuery queryParams
    ) {
        IPage<UserPageVO> result = userService.getUserPage(queryParams);
        return PageResult.success(result);
    }

    @Operation(summary = "新增用户", security = {@SecurityRequirement(name = "Authorization")})
    @PostMapping
    @PreAuthorize("@security.hasPerm('sys:user:add')")
    @PreventDuplicateSubmit
    public Result saveUser(
            @RequestBody @Valid UserForm userForm
    ) {
        boolean result = userService.saveUser(userForm);
        return Result.judge(result);
    }

    @Operation(summary = "用户表单数据", security = {@SecurityRequirement(name = "Authorization")})
    @GetMapping("/{userId}/form")
    public Result<UserForm> getUserForm(
            @Parameter(description = "用户ID") @PathVariable Long userId
    ) {
        UserForm formData = userService.getUserFormData(userId);
        return Result.success(formData);
    }

    @Operation(summary = "修改用户", security = {@SecurityRequirement(name = "Authorization")})
    @PutMapping(value = "/{userId}")
    @PreAuthorize("@security.hasPerm('sys:user:edit')")
    public Result updateUser(
            @Parameter(description = "用户ID") @PathVariable Long userId,
            @RequestBody @Validated UserForm userForm) {
        boolean result = userService.updateUser(userId, userForm);
        return Result.judge(result);
    }

    @Operation(summary = "删除用户", security = {@SecurityRequirement(name = "Authorization")})
    @DeleteMapping("/{ids}")
    @PreAuthorize("@security.hasPerm('sys:user:delete')")
    public Result deleteUsers(
            @Parameter(description = "用户ID，多个以英文逗号(,)分割") @PathVariable String ids
    ) {
        boolean result = userService.deleteUsers(ids);
        return Result.judge(result);
    }

    @Operation(summary = "修改用户密码", security = {@SecurityRequirement(name = "Authorization")})
    @PatchMapping(value = "/{userId}/password")
    @PreAuthorize("@security.hasPerm('sys:user:reset_pwd')")
    public Result updatePassword(
            @Parameter(description = "用户ID") @PathVariable Long userId,
            @RequestParam String password
    ) {
        boolean result = userService.updatePassword(userId, password);
        return Result.judge(result);
    }

    @Operation(summary = "修改用户状态", security = {@SecurityRequirement(name = "Authorization")})
    @PatchMapping(value = "/{userId}/status")
    public Result updateUserStatus(
            @Parameter(description = "用户ID") @PathVariable Long userId,
            @Parameter(description = "用户状态(1:启用;0:禁用)") @RequestParam Integer status
    ) {
        boolean result = userService.update(new LambdaUpdateWrapper<SysUser>()
                .eq(SysUser::getId, userId)
                .set(SysUser::getStatus, status)
        );
        return Result.judge(result);
    }

    @Operation(summary = "获取当前登录用户信息", security = {@SecurityRequirement(name = "Authorization")})
    @GetMapping("/me")
    public Result<UserInfoVO> getCurrentUserInfo() {
        // todo 刷新token过期时间
        UserInfoVO userInfoVO = userService.getCurrentUserInfo();
        return Result.success(userInfoVO);
    }

    @Operation(summary = "用户导入模板下载", security = {@SecurityRequirement(name = "Authorization")})
    @GetMapping("/template")
    public void downloadTemplate(HttpServletResponse response) throws IOException {
        String fileName = "用户导入模板.xlsx";
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));

        String fileClassPath = ExcelConstants.EXCEL_TEMPLATE_DIR + File.separator + fileName;
        InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream(fileClassPath);

        ServletOutputStream outputStream = response.getOutputStream();
        ExcelWriter excelWriter = EasyExcel.write(outputStream).withTemplate(inputStream).build();

        excelWriter.finish();
    }

    @Operation(summary = "导入用户", security = {@SecurityRequirement(name = "Authorization")})
    @PostMapping("/_import")
    public Result importUsers(@Parameter(description = "部门ID") Long deptId, MultipartFile file) throws IOException {
        UserImportListener listener = new UserImportListener(deptId);
        String msg = ExcelUtils.importExcel(file.getInputStream(), UserImportVO.class, listener);
        return Result.success(msg);
    }

    @Operation(summary = "导出用户", security = {@SecurityRequirement(name = "Authorization")})
    @GetMapping("/_export")
    public void exportUsers(UserPageQuery queryParams, HttpServletResponse response) throws IOException {
        String fileName = "用户列表.xlsx";
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));

        List<UserExportVO> exportUserList = userService.listExportUsers(queryParams);
        EasyExcel.write(response.getOutputStream(), UserExportVO.class).sheet("用户列表")
                .doWrite(exportUserList);
    }
}

package com.yu.controller;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import com.yu.common.constant.SecurityConstants;
import com.yu.common.result.Result;
import com.yu.config.WorkTimeConfig;
import com.yu.model.entity.ClockLog;
import com.yu.security.jwt.JwtTokenProvider;
import com.yu.security.model.SysUserDetails;
import com.yu.service.IClockLogService;
import com.yu.service.IDayWorkService;
import com.yu.service.SysUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalTime;
import java.util.List;
import java.util.Objects;

/**
 * 进入记录 控制层。
 *
 * @author yu
 * @since 1.0
 */
@RestController
@RequestMapping("api/v1/accessLog")
@RequiredArgsConstructor
@Validated
@Tag(name = "进入记录控制层")
public class AccessController {

    private final JwtTokenProvider jwtTokenManager;
    private final SysUserService userService;
    private final IClockLogService clockLogService;
    private final IDayWorkService dayWorkService;


    @Operation(summary = "获取工作设置")
    @GetMapping("accessTime")
    public Result<List<LocalTime>> getTime() {
        return Result.success(List.of(WorkTimeConfig.startTime, WorkTimeConfig.endTime));
    }

    @Operation(summary = "修改工作时间")
    @PutMapping("modifyTime")
    public Result<Boolean> modifyTime(@NotNull LocalTime startTime, @NotNull LocalTime endTime) {
        Assert.isTrue(startTime.isBefore(endTime), "开始时间必须小于结束时间");
        WorkTimeConfig.startTime = startTime;
        WorkTimeConfig.endTime = endTime;
        return Result.success();
    }

    @PostMapping("authentication")
    @Operation(summary = "二维码验证")
    public Result<String> authentication(@Parameter(description = "通行token") @RequestBody String token) {
        token = token.replaceAll("\"", "");
        if (StrUtil.isBlank(token) || !token.startsWith(SecurityConstants.TOKEN_PREFIX)) {
            return Result.failed("验证失败");
        }
        String jwt = token.substring(SecurityConstants.TOKEN_PREFIX.length());
        Authentication authentication = jwtTokenManager.getAuthentication(jwt);
        if (Objects.isNull(authentication)) {
            return Result.failed("验证失败");
        }
        LocalTime now = LocalTime.now();
        SysUserDetails userDetails = (SysUserDetails) authentication.getPrincipal();
        ClockLog time = clockLogService.lambdaQuery().eq(ClockLog::getUserid, userDetails.getUserId()).one();
        LocalTime startTime = time.getStartTime();
        if (startTime == null) {
            long s = Duration.between(now, WorkTimeConfig.endTime).toMinutes();
            time.setStartTime(now);
            clockLogService.updateById(time);
            if (s < 0) {
                return Result.success("迟到打时间%d秒:%sw".formatted(s, now.toString()));
            } else {
                return Result.success("打卡成功:" + now);
            }
        } else {
            long s = Duration.between(now, WorkTimeConfig.endTime).toMinutes();
            time.setEndTime(now);
            clockLogService.updateById(time);
            if (s < 0) {
                return Result.success("打卡成功:" + now);
            } else {
                return Result.success("早退%d分钟:%s".formatted(s, now.toString()));
            }
        }
    }

}
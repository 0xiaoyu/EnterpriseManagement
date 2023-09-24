package com.yu.controller;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.toolkit.Db;
import com.yu.common.constant.SecurityConstants;
import com.yu.common.enums.WorkExcEnum;
import com.yu.common.result.Result;
import com.yu.common.util.SecurityUtils;
import com.yu.config.WorkTimeConfig;
import com.yu.model.dto.ClockCountDayDTO;
import com.yu.model.entity.ClockLog;
import com.yu.model.entity.WorkExcLog;
import com.yu.security.jwt.JwtTokenProvider;
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
import java.time.LocalDate;
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
        Long userId = SecurityUtils.getUserId();
        ClockLog time = clockLogService.lambdaQuery().eq(ClockLog::getUserid, userId).one();
        LocalTime startTime = time.getStartTime();
        if (startTime == null) {
            long s = Duration.between(now, WorkTimeConfig.endTime).toMinutes();
            time.setStartTime(now);
            clockLogService.updateById(time);
            if (s < 0) {
                Db.save(WorkExcLog.builder().dayTime(LocalDate.now())
                        .type(WorkExcEnum.LATE)
                        .userid(userId).time((int) s).build());
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
                Db.save(WorkExcLog.builder().dayTime(LocalDate.now()).type(WorkExcEnum.EARLY)
                        .userid(userId).time((int) s).build());
                return Result.success("早退%d分钟:%s".formatted(s, now.toString()));
            }
        }
    }


    @PostMapping("count/late")
    @Operation(summary = "统计某天迟到人数")
    public Result<Long> countLate(LocalDate date){
        if (date == null)
            date = LocalDate.now();
        return Result.success(clockLogService.lambdaQuery().eq(ClockLog::getDayTime,date)
                .gt(ClockLog::getStartTime,WorkTimeConfig.startTime).count());
    }

    @GetMapping("count/day/late")
    @Operation(summary = "统计每天迟到人数")
    public Result<List<ClockCountDayDTO>> countLateDayDTOResult(LocalDate start,LocalDate end){
        if(!start.isBefore(end))
            return Result.failed("开始时间必须小于结束时间");

        return Result.success(clockLogService.countLateDay(start,end));
    }
}
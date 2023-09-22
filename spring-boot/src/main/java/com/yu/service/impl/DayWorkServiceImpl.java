package com.yu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.toolkit.Db;
import com.yu.config.WorkTimeConfig;
import com.yu.mapper.DayWorkMapper;
import com.yu.model.entity.ClockLog;
import com.yu.model.entity.DayWork;
import com.yu.service.IDayWorkService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 * 每日工时记录 服务实现类
 * </p>
 *
 * @author zay
 * @since 2023-09-22
 */
@Service
public class DayWorkServiceImpl extends ServiceImpl<DayWorkMapper, DayWork> implements IDayWorkService {


    /**
     * 每天23:59:58执行，计算每天的工作时间
     */
    @Scheduled(cron = "58 59 23 * * ?")
    @Transactional
    public void test() {
        LocalDate now = LocalDate.now();
        List<ClockLog> list = Db.lambdaQuery(ClockLog.class).eq(ClockLog::getDayTime, now).list();
        List<DayWork> dayWorkList = list.stream().map(item -> {
            DayWork dayWork = new DayWork();
            dayWork.setUserId(item.getUserid());
            dayWork.setDayTime(now);
            StringBuilder detail = new StringBuilder();
            if (item.getStartTime().isAfter(WorkTimeConfig.startTime)) {
                detail.append("迟到!!").append(Duration.between(WorkTimeConfig.startTime, item.getStartTime()).toMinutes()).append("分钟");
            }
            if (item.getEndTime().isBefore(WorkTimeConfig.endTime)) {
                detail.append("早退!!").append(Duration.between(item.getEndTime(), WorkTimeConfig.endTime).toMinutes()).append("分钟");
            }
            if (item.getEndTime().isBefore(WorkTimeConfig.overTime)) {
                // 工作时间超过加班规定时间
                dayWork.setWorkTime((int) Duration.between(item.getStartTime(), item.getEndTime()).toMinutes());
                dayWork.setOverTime((int) Duration.between(WorkTimeConfig.overTime, item.getEndTime()).toMinutes());
            } else {
                dayWork.setWorkTime((int) Duration.between(item.getStartTime(), WorkTimeConfig.overTime).toMinutes());
            }
            return dayWork;
        }).toList();
        saveBatch(dayWorkList);
    }
}

package com.yu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.yu.model.dto.ClockCountDayDTO;
import com.yu.model.entity.ClockLog;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yu.model.query.PassLogPageQuery;
import com.yu.model.vo.PassPageVo;

import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 * 打卡记录表 服务类
 * </p>
 *
 * @author zay
 * @since 2023-09-22
 */
public interface IClockLogService extends IService<ClockLog> {

    /**
     * 统计迟到天数
     * @param start 开始时间
     * @param end 结束时间
     * @return
     */
    List<ClockCountDayDTO> countLateDay(LocalDate start, LocalDate end);


    IPage<PassPageVo> getPageQuery(PassLogPageQuery query);
}

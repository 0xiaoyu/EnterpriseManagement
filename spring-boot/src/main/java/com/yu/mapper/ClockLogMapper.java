package com.yu.mapper;

import com.yu.model.dto.ClockCountDayDTO;
import com.yu.model.entity.ClockLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 * 打卡记录表 Mapper 接口
 * </p>
 *
 * @author zay
 * @since 2023-09-22
 */
public interface ClockLogMapper extends BaseMapper<ClockLog> {

    List<ClockCountDayDTO> countLateDay(LocalDate start, LocalDate end);
}

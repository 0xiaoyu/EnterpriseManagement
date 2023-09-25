package com.yu.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.model.dto.ClockCountDayDTO;
import com.yu.model.entity.ClockLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yu.model.query.PassLogPageQuery;
import com.yu.model.vo.PassPageVo;

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

    Page<PassPageVo> getPageQuery(Page<PassPageVo> page, PassLogPageQuery q);

}

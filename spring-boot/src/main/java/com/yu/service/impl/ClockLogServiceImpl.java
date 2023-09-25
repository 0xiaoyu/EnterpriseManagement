package com.yu.service.impl;

import cn.hutool.core.lang.Assert;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yu.mapper.ClockLogMapper;
import com.yu.model.dto.ClockCountDayDTO;
import com.yu.model.entity.ClockLog;
import com.yu.model.query.PassLogPageQuery;
import com.yu.model.vo.PassPageVo;
import com.yu.service.IClockLogService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 * 打卡记录表 服务实现类
 * </p>
 *
 * @author zay
 * @since 2023-09-22
 */
@Service
public class ClockLogServiceImpl extends ServiceImpl<ClockLogMapper, ClockLog> implements IClockLogService {

    @Override
    public List<ClockCountDayDTO> countLateDay(LocalDate start, LocalDate end) {
        return baseMapper.countLateDay(start, end);
    }

    @Override
    public Page<PassPageVo> getPageQuery(PassLogPageQuery query) {
        Page<PassPageVo> page = query.getPage();
        return baseMapper.getPageQuery(page,query);
    }
}

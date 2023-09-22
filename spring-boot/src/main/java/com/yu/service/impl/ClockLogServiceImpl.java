package com.yu.service.impl;

import com.yu.model.entity.ClockLog;
import com.yu.mapper.ClockLogMapper;
import com.yu.service.IClockLogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

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

}

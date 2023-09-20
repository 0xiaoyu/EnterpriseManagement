package com.yu.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yu.mapper.PayLogMapper;
import com.yu.model.entity.PayLogEntity;
import com.yu.service.PayLogService;
import org.springframework.stereotype.Service;

/**
 * 电费日志 服务层实现。
 *
 * @author yu
 * @since 1.0
 */
@Service
public class PayLogServiceImpl extends ServiceImpl<PayLogMapper, PayLogEntity> implements PayLogService {

}
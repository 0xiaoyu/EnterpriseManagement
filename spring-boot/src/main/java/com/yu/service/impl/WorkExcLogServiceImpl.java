package com.yu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yu.mapper.WorkExcLogMapper;
import com.yu.model.entity.WorkExcLog;
import com.yu.model.query.WorkExcPageQuery;
import com.yu.service.IWorkExcLogService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 工作异常记录 服务实现类
 * </p>
 *
 * @author zay
 * @since 2023-09-24
 */
@Service
public class WorkExcLogServiceImpl extends ServiceImpl<WorkExcLogMapper, WorkExcLog> implements IWorkExcLogService {

    @Override
    public IPage<WorkExcLog> getPageQuery(WorkExcPageQuery query) {
        QueryWrapper<Object> qw = Wrappers.query()
                .eq(query.getType() != null, "type", query.getType().getValue())
                .between("day_time", query.getStartTime(), query.getEndTime());
        return baseMapper.getPageQuery(query.getPage(),qw,query.getName(),query.getDept());
    }
}

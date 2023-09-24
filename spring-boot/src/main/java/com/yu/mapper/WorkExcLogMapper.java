package com.yu.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.model.entity.WorkExcLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 工作异常记录 Mapper 接口
 * </p>
 *
 * @author zay
 * @since 2023-09-24
 */
public interface WorkExcLogMapper extends BaseMapper<WorkExcLog> {

    IPage<WorkExcLog> getPageQuery(Page<Object> page, @Param("ew") QueryWrapper<Object> qw,String name ,Long dept);
}

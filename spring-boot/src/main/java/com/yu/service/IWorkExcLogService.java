package com.yu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yu.model.dto.WorkExcLogDTO;
import com.yu.model.entity.WorkExcLog;
import com.yu.model.query.WorkExcPageQuery;

/**
 * <p>
 * 工作异常记录 服务类
 * </p>
 *
 * @author zay
 * @since 2023-09-24
 */
public interface IWorkExcLogService extends IService<WorkExcLog> {

    IPage<WorkExcLogDTO> getPageQuery(WorkExcPageQuery query);
}

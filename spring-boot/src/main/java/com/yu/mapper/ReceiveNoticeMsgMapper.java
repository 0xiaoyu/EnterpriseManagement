package com.yu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.common.enums.NoticeEnum;
import com.yu.model.entity.ReceiveNoticeMsgEntity;
import com.yu.model.vo.NoticeVo;
import org.apache.ibatis.annotations.Mapper;

/**
 * 接收通知 映射层。
 *
 * @author yu
 * @since 1.0
 */
@Mapper
public interface ReceiveNoticeMsgMapper extends BaseMapper<ReceiveNoticeMsgEntity> {


    Page<NoticeVo> getNoticeList(Page<NoticeVo> page, Long userId,Long deptId, NoticeEnum type);

//    Long getNoReadCount(Long id);

    Long getNoReadCount(Long userId, Long deptId);
}

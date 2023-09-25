package com.yu.service.impl;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yu.common.enums.NoticeEnum;
import com.yu.common.util.SecurityUtils;
import com.yu.mapper.ReceiveNoticeMsgMapper;
import com.yu.model.entity.ReceiveNoticeMsgEntity;
import com.yu.model.vo.NoticeVo;
import com.yu.service.ReceiveNoticeMsgService;
import org.springframework.stereotype.Service;

/**
 * 接收通知 服务层实现。
 *
 * @author yu
 * @since 1.0
 */
@Service
public class ReceiveNoticeMsgServiceImpl extends ServiceImpl<ReceiveNoticeMsgMapper, ReceiveNoticeMsgEntity> implements ReceiveNoticeMsgService {

    @Override
    public Page<NoticeVo> getNoticeList(Page<NoticeVo> page, NoticeEnum type) {
        Long userId = SecurityUtils.getUserId();
        Long deptId = SecurityUtils.getDeptId();
        return baseMapper.getNoticeList(page, userId,-deptId,type);
    }

    @Override
    public Long getNoReadCount(Long id, Long deptId) {
        return baseMapper.getNoReadCount(id,-Math.abs(deptId));
    }

    @Override
    public Long getNoReadCount() {
        return baseMapper.getNoReadCount(SecurityUtils.getUserId(),-SecurityUtils.getDeptId());
    }
}
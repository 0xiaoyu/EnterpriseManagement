package com.yu.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.yu.model.entity.SenderNoticeMsgEntity;

/**
 * 通知消息 服务层。
 *
 * @author yu
 * @since 1.0
 */
public interface SenderNoticeMsgService extends IService<SenderNoticeMsgEntity> {

    Boolean sysNotice(String msg,Long id);
}
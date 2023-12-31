package com.yu.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.common.base.BasePageQuery;
import com.yu.common.enums.NoticeEnum;
import com.yu.common.result.PageResult;
import com.yu.common.result.Result;
import com.yu.common.util.SecurityUtils;
import com.yu.model.entity.NoticeRead;
import com.yu.model.entity.ReceiveNoticeMsgEntity;
import com.yu.model.entity.SenderNoticeMsgEntity;
import com.yu.model.vo.NoticeVo;
import com.yu.service.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

/**
 * 接收通知 控制层。
 *
 * @author yu
 * @since 1.0
 */
@RestController
@RequestMapping("/api/v1/notice")
@RequiredArgsConstructor
@Tag(name = "接收通知控制层")
public class NoticeController {

    private final SenderNoticeMsgService senderService;
    private final SimpMessagingTemplate messagingTemplate;
    private final ReceiveNoticeMsgService receiveService;
    private final INoticeReadService noticeReadService;


    public record NoticeSend(String receiveId,String dept, String content, NoticeEnum type,String title
    ) {
    }

    /**
     * 发送通知给人员
     * 1.记录发送内容和发送者
     * 2，记录接收者
     * 3. webSocket发送
     *
     * @param notice 发送通知给学生
     * @return {@code true} 添加成功，{@code false} 添加失败
     */
    @PostMapping("/student")
    @Operation(summary = "发送通知给人员")
    @Parameters(value = {
            @Parameter(name = "sendId", description = "发送者id，在tb_user表内的id", required = true),
            @Parameter(name = "receiveId", description = "接收者id，多个用逗号隔开"),
            @Parameter(name = "dept", description = "部门id，多个用逗号隔开"),
            @Parameter(name = "content", description = "通知内容", required = true),
            @Parameter(name = "type", description = "通知类型", required = true)
    })
    @PreAuthorize("@security.hasPerm('notice:send:student')")
    public Result<Boolean> sendToStudent(@RequestBody NoticeSend notice) {
        SenderNoticeMsgEntity msg = SenderNoticeMsgEntity.builder()
                .senderId(SecurityUtils.getUserId()).msg(notice.content).build();
        // 1.记录发送内容和发送者
        if (StrUtil.isNotBlank(notice.receiveId)) {
            msg.setType(NoticeEnum.PRIVATE_NOTICE);
            senderService.save(msg);
            List<ReceiveNoticeMsgEntity> receive = Arrays.stream(notice.receiveId.split(",")).map(id -> {
                messagingTemplate.convertAndSendToUser(String.valueOf(id), "/notice/user", notice.content);
                return ReceiveNoticeMsgEntity.builder()
                        .receiveId(Long.valueOf(id)).noticeId(msg.getId()).build();
            }).toList();
            receiveService.saveBatch(receive);
        } else if (StrUtil.isNotBlank(notice.dept)) {
            if (notice.dept.equals("all")) {
                messagingTemplate.convertAndSend("/notice/all", notice.content);
                msg.setType(NoticeEnum.GROUP_NOTICE);
                senderService.save(msg);
                receiveService.save(ReceiveNoticeMsgEntity.builder()
                        .receiveId(0L).noticeId(msg.getId()).build());
            } else {
                msg.setType(NoticeEnum.DORMITORY_NOTICE);
                senderService.save(msg);
                List<ReceiveNoticeMsgEntity> list = Arrays.stream(notice.dept.split(",")).map(id -> {
                    messagingTemplate.convertAndSend("/notice/dept"+id, notice.content);
                    return ReceiveNoticeMsgEntity.builder()
                            .receiveId(-Long.parseLong(id)).noticeId(msg.getId()).build();
                }).toList();
                receiveService.saveBatch(list);
            }
        } else {
            return Result.failed("接收者不能为空");
        }
        return Result.success(true);
    }

    @Operation(summary = "获取通知类型", security = {@SecurityRequirement(name = "Authorization")})
    @GetMapping("/noticeType")
    public Result<NoticeEnum[]> getNoticeType() {
        return Result.success(NoticeEnum.values());
    }


    @GetMapping("/list")
    @Operation(summary = "根据用户id获取接收通知", security = {@SecurityRequirement(name = "Authorization")})
    public PageResult<NoticeVo> getByUserId(BasePageQuery query,NoticeEnum type) {
        Page<NoticeVo> page = receiveService.getNoticeList(query.getPage(),type);
        return PageResult.success(page);
    }

    /**
     * 已读所有
     * @return
     */
    @GetMapping("/readAll")
    @Operation(summary = "已读所有", security = {@SecurityRequirement(name = "Authorization")})
    public Result<Boolean> readAll(){
        Long userId = SecurityUtils.getUserId();
        boolean b = noticeReadService.lambdaUpdate().eq(NoticeRead::getId, userId).set(NoticeRead::getUpdateTime, LocalDateTime.now()).update();
        return Result.judge(b);
    }

    @GetMapping("count/noRead/{id}")
    @Operation(summary = "根据用户id获取未读通知数量", security = {@SecurityRequirement(name = "Authorization")})
    @Parameters(value = {
            @Parameter(name = "id", description = "用户id", required = true)
    })
    public Result<Long> getNoReadCount(@PathVariable Long id,Long deptId) {
        return Result.success(receiveService.getNoReadCount(id, deptId));
    }

    @GetMapping("count/noRead")
    @Operation(summary = "根据该用户未读通知数量", security = {@SecurityRequirement(name = "Authorization")})
    public Result<Long> getNoReadCount() {
        return Result.success(receiveService.getNoReadCount());
    }

}
package com.yu.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import com.yu.common.base.IBaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum NoticeEnum  implements IBaseEnum<Integer> {
    SYSTEM_NOTICE(0, "系统通知"),
    GROUP_NOTICE(1, "全体通知"),
    DORMITORY_NOTICE(2, "宿舍通知"),
    PRIVATE_NOTICE(3, "私信"),
    ;
    @EnumValue
    private final Integer value;
    @JsonValue
    private final String label;
}

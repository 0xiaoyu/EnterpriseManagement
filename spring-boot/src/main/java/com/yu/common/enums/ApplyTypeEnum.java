package com.yu.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import com.yu.common.base.IBaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ApplyTypeEnum implements IBaseEnum {
    LEAVE(1, "请假"),
    OUT(2, "外出"),

    ;
    @EnumValue
    private final Integer value;
    @JsonValue
    private final String label;
}

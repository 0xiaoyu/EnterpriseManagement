package com.yu.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import com.yu.common.base.IBaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum PassTypeEnum implements IBaseEnum<Integer> {
    STUDENT_IN(0,"学生进入"),

    STUDENT_OUT(1,"学生离开"),

    OTHER_IN(2,"其他人员进入"),

    OTHER_OUT(3,"其他人员离开");

    @EnumValue
    final Integer value;

    @JsonValue
    final String label;
}

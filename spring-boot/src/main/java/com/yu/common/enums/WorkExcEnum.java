package com.yu.common.enums;


import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import com.yu.common.base.IBaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum WorkExcEnum implements IBaseEnum {
    LATE(1, "迟到"),
    EARLY(2, "早退"),
    ABSENTEEISM(3, "旷工"),
    LEAVE(4, "请假"),
    ;
    @EnumValue
    private final Integer value;
    @JsonValue
    private final String label;

}

package com.yu.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum DormitoryEnum {
    MAN(0,"男生宿舍"),
    WOMAN(1,"女生宿舍"),
    BUILDING(2,"在建楼"),
    DEMOLITION(3,"待拆楼"),
    REPAIR(4,"维修楼"),
    ;

    @EnumValue
    final Integer code;

    @JsonValue
    final String desc;
}

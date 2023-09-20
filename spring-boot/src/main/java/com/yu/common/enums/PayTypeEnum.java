package com.yu.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import com.yu.common.base.IBaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum PayTypeEnum implements IBaseEnum<Integer> {
    ELECTRICITY(1, "电费"),
    WATER(2, "水费"),
    Repair(3, "维修费")
    ;


    @EnumValue
    private final Integer value;

    @JsonValue
    private final String label;
}

package com.yu.common.enums;

import com.yu.common.base.IBaseEnum;
import lombok.Getter;

/**
 * 状态枚举
 *
 * @author yu
 * @since 2023/9/16
 */
@Getter
public enum StatusEnum implements IBaseEnum<Integer> {

    ENABLE(1, "启用"),
    DISABLE (0, "禁用");

    private final Integer value;

    private final String label;

    StatusEnum(Integer value, String label) {
        this.value = value;
        this.label = label;
    }
}

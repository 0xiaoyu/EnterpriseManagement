package com.yu.model.dto;

import lombok.Data;

@Data
public class ClockCountDayDTO {

    /**
     * 数量
     */
    private Long count;
    /**
     * 哪一天
     */
    private String day;
}

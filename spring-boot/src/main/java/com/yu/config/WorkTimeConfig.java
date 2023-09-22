package com.yu.config;

import java.time.LocalTime;

public class WorkTimeConfig {

    /**
     * 上班打卡时间
     */
    public static LocalTime startTime = LocalTime.of(9,0,0);
    /**
     * 下班打卡时间
     */
    public static LocalTime endTime = LocalTime.of(18,0,0);
    /**
     * 开始计算的加班时间
     */
    public static LocalTime overTime = LocalTime.of(18,30,0);
}

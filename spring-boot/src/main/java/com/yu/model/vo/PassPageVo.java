package com.yu.model.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDate;

@Schema(name = "进入记录")
@Data
public class PassPageVo {

    @Schema(description = "日志id")
    private Long id;

    @Schema(description = "进出时间")
    private LocalDate dayTime;
    @Schema(description = "进出人员名字")
    private String name;

    @Schema(description = "上班时间")
    private String startTime;
    @Schema(description = "下班时间")
    private String endTime;

    @Schema(description = "电话")
    private String phone;
}

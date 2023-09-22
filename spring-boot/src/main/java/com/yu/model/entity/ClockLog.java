package com.yu.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;

/**
 * <p>
 * 打卡记录表
 * </p>
 *
 * @author zay
 * @since 2023-09-22
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("clock_log")
@Schema(title="ClockLog对象", description="打卡记录表")
public class ClockLog implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @Schema(description = "用户id")
    private Long userid;

    @Schema(description = "上班时间")
    private LocalTime startTime;

    @Schema(description = "下班时间")
    private LocalTime endTime;

    @Schema(description = "创建时间,记录哪一天打的卡")
    private LocalDate dayTime;


}

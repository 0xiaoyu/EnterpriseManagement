package com.yu.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * <p>
 * 每日工时记录
 * </p>
 *
 * @author zay
 * @since 2023-09-22
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("day_work")
@Schema(title="DayWork对象", description="每日工时记录")
public class DayWork implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @Schema(description = "用户id")
    @TableField("user_id")
    private Long userId;

    @Schema(description = "工作时间(分钟)")
    @TableField("work_time")
    private Integer workTime;

    @Schema(description = "加班时间")
    @TableField("over_time")
    private Integer overTime;

    @Schema(description = "描述")
    @TableField("detail")
    private String detail;

    @Schema(description = "哪一天")
    @TableField("day_time")
    private LocalDate dayTime;


}

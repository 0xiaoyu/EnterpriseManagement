package com.yu.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.yu.common.enums.WorkExcEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * <p>
 * 工作异常记录
 * </p>
 *
 * @author zay
 * @since 2023-09-24
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("work_exc_log")
@Schema(title="WorkExcLog对象", description="工作异常记录")
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WorkExcLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @Schema(description = "用户id")
    private Long userid;

    @Schema(description = "时间")
    private Integer time;

    @Schema(description = "当天")
    private LocalDate dayTime;

    @Schema(description = "异常类型")
    private WorkExcEnum type;


}

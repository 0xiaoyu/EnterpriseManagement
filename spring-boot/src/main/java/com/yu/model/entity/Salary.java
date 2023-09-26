package com.yu.model.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.time.LocalDate;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 薪资
 * </p>
 *
 * @author zay
 * @since 2023-09-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("salary")
public class Salary implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 人员id
     */
    private Long userid;

    /**
     * 时间
     */
    private LocalDate time;

    /**
     * 薪资
     */
    private Integer salary;

    /**
     * 状态,0未发，1统计中，2发送
     */
    private Integer status;


}

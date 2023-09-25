package com.yu.model.dto;

import com.yu.model.entity.WorkExcLog;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class WorkExcLogDTO extends WorkExcLog {
    /**
     * 违规人员名字
     */
    private String name;
    /**
     * 人员手机号
     */
    private String mobile;
    /**
     * 人员部门
     */
    private String deptName;
}

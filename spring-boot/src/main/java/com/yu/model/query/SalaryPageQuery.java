package com.yu.model.query;

import com.yu.common.base.BasePageQuery;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Data
public class SalaryPageQuery extends BasePageQuery {
    private String userId;
    private Long deptId;
    private LocalDate month;
}

package com.yu.model.dto;

import com.yu.model.entity.Salary;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class SalaryDTO extends Salary {
    private String name;
    private String mobile;
}

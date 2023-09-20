package com.yu.model.vo;

import com.yu.common.enums.DormitoryEnum;
import com.yu.model.entity.SysUser;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class UserDormitoryVo extends SysUser {
    private String dormitoryNumber;
    private String buildingName;
    private DormitoryEnum type;
}

package com.yu.model.query;

import com.yu.common.base.BasePageQuery;
import com.yu.common.enums.ApplyTypeEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class ApplyQuery extends BasePageQuery {
    @Schema(description = "申请状态")
    private Integer status;
    @Schema(description = "审批人")
    private String approvedUser;
    @Schema(description = "申请类型")
    private ApplyTypeEnum type;
}

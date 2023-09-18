package com.yu.model.query;

import com.yu.common.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 权限分页查询对象
 *
 * @author yu
 * @since 2023/9/16
 */
@Data
@Schema 
public class PermPageQuery extends BasePageQuery {

    @Schema(description="权限名称")
    private String name;

    @Schema(description="菜单ID")
    private Long menuId;

}

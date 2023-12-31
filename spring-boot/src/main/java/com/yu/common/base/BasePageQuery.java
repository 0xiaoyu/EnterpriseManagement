package com.yu.common.base;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 基础分页请求对象
 *
 * @author yu
 * @since 2023/9/16
 */
@Data
@Schema
public class BasePageQuery {

    @Schema(description = "页码", example = "1")
    private int pageNum = 1;

    @Schema(description = "每页记录数", example = "10")
    private int pageSize = 10;


    public <T> Page<T> getPage(){
        return Page.of(pageNum, pageSize);
    }
}

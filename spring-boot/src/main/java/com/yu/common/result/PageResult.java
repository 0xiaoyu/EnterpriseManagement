package com.yu.common.result;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * 分页响应结构体
 *
 * @author yu
 * @since 2023/9/16
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageResult<T> implements Serializable {

    private String code;

    private Data<T> data;

    private String msg;

    public static <T> PageResult<T> success(IPage<T> page) {
        Data<T> data = new Data<T>(page.getRecords(), page.getTotal());
        return new PageResult<T>(ResultCode.SUCCESS.getCode(),
                data, ResultCode.SUCCESS.getMsg()
        );
    }

    @lombok.Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Data<T> {

        private List<T> list;

        private long total;

    }

}

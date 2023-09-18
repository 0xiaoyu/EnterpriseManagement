package com.yu.common.base;

import lombok.Data;
import lombok.ToString;

import java.io.Serializable;

/**
 * 视图对象基类
 *
 * @author yu
 * @since 2023/9/16
 */
@Data
@ToString
public class BaseVO implements Serializable {

    private static final long serialVersionUID = 1L;
}

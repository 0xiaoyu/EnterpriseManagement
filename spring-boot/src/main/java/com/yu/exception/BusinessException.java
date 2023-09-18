package com.yu.exception;

import com.yu.common.result.IResultCode;
import lombok.Getter;

/**
 * 自定义业务异常
 *
 * @author yu
 * @since 2023/9/16
 */
@Getter
public class BusinessException extends RuntimeException {

    public IResultCode resultCode;

    public BusinessException(IResultCode errorCode) {
        super(errorCode.getMsg());
        this.resultCode = errorCode;
    }

    public BusinessException(String message){
        super(message);
    }

    public BusinessException(String message, Throwable cause){
        super(message, cause);
    }

    public BusinessException(Throwable cause){
        super(cause);
    }


}

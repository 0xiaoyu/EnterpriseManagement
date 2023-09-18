package com.yu.common.util;

import com.alibaba.excel.EasyExcel;
import com.yu.listener.easyexcel.MyAnalysisEventListener;

import java.io.InputStream;

/**
 * Excel 工具类
 *
 * @author yu
 * @since 2023/9/16
 */
public class ExcelUtils {

    public static <T> String importExcel(InputStream is, Class clazz, MyAnalysisEventListener<T> listener) {
        EasyExcel.read(is, clazz, listener).sheet().doRead();
        return listener.getMsg();
    }
}

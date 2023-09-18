package com.yu.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yu.model.entity.SysDict;
import com.yu.model.form.DictForm;
import com.yu.model.query.DictPageQuery;
import com.yu.model.vo.DictPageVO;
import com.yu.common.model.Option;

import java.util.List;

/**
 * 字典接口
 *
 * @author yu
 * @since 2023/9/16
 */
public interface SysDictService extends IService<SysDict> {
    /**
     * 字典数据项分页列表
     *
     * @param queryParams
     * @return
     */
    Page<DictPageVO> getDictPage(DictPageQuery queryParams);

    /**
     * 字典数据项表单
     *
     * @param id 字典数据项ID
     * @return
     */
    DictForm getDictForm(Long id);

    /**
     * 新增字典数据项
     *
     * @param dictForm 字典数据项表单
     * @return
     */
    boolean saveDict(DictForm dictForm);

    /**
     * 修改字典数据项
     *
     * @param id       字典数据项ID
     * @param dictForm 字典数据项表单
     * @return
     */
    boolean updateDict(Long id, DictForm dictForm);

    /**
     * 删除字典数据项
     *
     * @param idsStr 字典数据项ID，多个以英文逗号(,)分割
     * @return
     */
    boolean deleteDict(String idsStr);

    /**
     * 获取字典下拉列表
     *
     * @param typeCode
     * @return
     */
    List<Option> listDictOptions(String typeCode);

}

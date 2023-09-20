package com.yu.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yu.model.entity.Dormitory;
import com.yu.model.entity.SysUser;
import com.yu.model.query.DormitoryPageQuery;
import com.yu.model.vo.UserDormitoryVo;
import org.apache.ibatis.annotations.Param;

/**
* @author za'y
* @description 针对表【tb_dormitory】的数据库操作Mapper
* @createDate 2023-08-27 21:57:58
* @Entity com.yu.model.entity.Dormitory
*/
public interface DormitoryMapper extends BaseMapper<Dormitory> {

    IPage<Dormitory> floorPage(Page<Dormitory> page, DormitoryPageQuery q);


    SysUser getUserByDormitoryId(Long id);

    IPage<UserDormitoryVo> getUserPage(@Param("page") Page<Object> page,
                                       @Param("ew") LambdaQueryWrapper<Dormitory> eq,
                                       @Param("floor") Integer floor);
}





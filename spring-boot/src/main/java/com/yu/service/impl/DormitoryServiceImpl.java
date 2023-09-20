package com.yu.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yu.mapper.DormitoryMapper;
import com.yu.model.entity.Dormitory;
import com.yu.model.entity.SysUser;
import com.yu.model.query.DormitoryPageQuery;
import com.yu.model.vo.UserDormitoryVo;
import com.yu.service.DormitoryService;
import org.springframework.stereotype.Service;

/**
 * @author za'y
 * @description 针对表【tb_dormitory】的数据库操作Service实现
 * @createDate 2023-08-27 21:57:58
 */
@Service
public class DormitoryServiceImpl extends ServiceImpl<DormitoryMapper, Dormitory>
        implements DormitoryService {

    @Override
    public IPage<Dormitory> getPage(DormitoryPageQuery queryParams) {
        Page<Dormitory> page = queryParams.getPage();
        return this.baseMapper.floorPage(page, queryParams);
    }


    @Override
    public SysUser getUserByDormitoryId(Long id) {
        return baseMapper.getUserByDormitoryId(id);
    }

    @Override
    public IPage<UserDormitoryVo> getUserPage(DormitoryPageQuery q) {
        LambdaQueryWrapper<Dormitory> eq = Wrappers.lambdaQuery(Dormitory.class)
                .eq(ObjectUtil.isNotNull(q.getBuildingId()), Dormitory::getBuildingId, q.getBuildingId())
                .eq(ObjectUtil.isNotNull(q.getWStatus()), Dormitory::getWStatus, q.getWStatus())
                .eq(ObjectUtil.isNotNull(q.getEStatus()), Dormitory::getEStatus, q.getEStatus());
        Integer floor = null;
        if (ObjectUtil.isNotNull(q.getFloor()) && ObjectUtil.isNotNull(q.getBuildingId())) {
            floor = q.getFloor();
        }
        return baseMapper.getUserPage(q.getPage(),eq,floor);
    }

}





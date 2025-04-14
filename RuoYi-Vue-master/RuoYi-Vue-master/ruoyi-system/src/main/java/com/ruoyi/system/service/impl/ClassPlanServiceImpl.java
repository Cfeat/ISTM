package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.ClassPlanMapper;
import com.ruoyi.system.domain.ClassPlan;
import com.ruoyi.system.service.IClassPlanService;

/**
 * 教案管理Service业务层处理
 * 
 * @author lkh
 * @date 2025-02-13
 */
@Service
public class ClassPlanServiceImpl implements IClassPlanService 
{
    @Autowired
    private ClassPlanMapper classPlanMapper;

    /**
     * 查询教案管理
     * 
     * @param planId 教案管理主键
     * @return 教案管理
     */
    @Override
    public ClassPlan selectClassPlanByPlanId(Long planId)
    {
        return classPlanMapper.selectClassPlanByPlanId(planId);
    }

    /**
     * 查询教案管理列表
     * 
     * @param classPlan 教案管理
     * @return 教案管理
     */
    @Override
    public List<ClassPlan> selectClassPlanList(ClassPlan classPlan)
    {
        return classPlanMapper.selectClassPlanList(classPlan);
    }

    /**
     * 新增教案管理
     * 
     * @param classPlan 教案管理
     * @return 结果
     */
    @Override
    public int insertClassPlan(ClassPlan classPlan)
    {
        classPlan.setCreateTime(DateUtils.getNowDate());
        return classPlanMapper.insertClassPlan(classPlan);
    }

    /**
     * 修改教案管理
     * 
     * @param classPlan 教案管理
     * @return 结果
     */
    @Override
    public int updateClassPlan(ClassPlan classPlan)
    {
        classPlan.setUpdateTime(DateUtils.getNowDate());
        return classPlanMapper.updateClassPlan(classPlan);
    }

    /**
     * 批量删除教案管理
     * 
     * @param planIds 需要删除的教案管理主键
     * @return 结果
     */
    @Override
    public int deleteClassPlanByPlanIds(Long[] planIds)
    {
        return classPlanMapper.deleteClassPlanByPlanIds(planIds);
    }

    /**
     * 删除教案管理信息
     * 
     * @param planId 教案管理主键
     * @return 结果
     */
    @Override
    public int deleteClassPlanByPlanId(Long planId)
    {
        return classPlanMapper.deleteClassPlanByPlanId(planId);
    }
}

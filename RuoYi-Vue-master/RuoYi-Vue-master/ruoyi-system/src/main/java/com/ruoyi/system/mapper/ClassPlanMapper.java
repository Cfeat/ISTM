package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ClassPlan;

/**
 * 教案管理Mapper接口
 * 
 * @author lkh
 * @date 2025-02-13
 */
public interface ClassPlanMapper 
{
    /**
     * 查询教案管理
     * 
     * @param planId 教案管理主键
     * @return 教案管理
     */
    public ClassPlan selectClassPlanByPlanId(Long planId);

    /**
     * 查询教案管理列表
     * 
     * @param classPlan 教案管理
     * @return 教案管理集合
     */
    public List<ClassPlan> selectClassPlanList(ClassPlan classPlan);

    /**
     * 新增教案管理
     * 
     * @param classPlan 教案管理
     * @return 结果
     */
    public int insertClassPlan(ClassPlan classPlan);

    /**
     * 修改教案管理
     * 
     * @param classPlan 教案管理
     * @return 结果
     */
    public int updateClassPlan(ClassPlan classPlan);

    /**
     * 删除教案管理
     * 
     * @param planId 教案管理主键
     * @return 结果
     */
    public int deleteClassPlanByPlanId(Long planId);

    /**
     * 批量删除教案管理
     * 
     * @param planIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteClassPlanByPlanIds(Long[] planIds);
}

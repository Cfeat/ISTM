package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ruoyi.system.domain.ClassPlanRating;
import com.ruoyi.system.mapper.ClassPlanRatingMapper;
import com.ruoyi.system.service.IClassPlanRatingService;

/**
 * 教案评分记录Service业务层处理
 * 
 * @author lkh
 */
@Service
public class ClassPlanRatingServiceImpl implements IClassPlanRatingService 
{
    @Autowired
    private ClassPlanRatingMapper classPlanRatingMapper;

    /**
     * 查询教案评分记录
     * 
     * @param id 教案评分记录主键
     * @return 教案评分记录
     */
    @Override
    public ClassPlanRating selectRatingById(Long id)
    {
        return classPlanRatingMapper.selectRatingById(id);
    }

    /**
     * 查询用户对特定教案的评分
     * 
     * @param userId 用户ID
     * @param planId 教案ID
     * @return 教案评分记录
     */
    @Override
    public ClassPlanRating selectRatingByUserAndPlan(Long userId, Long planId)
    {
        // 实际调用Mapper查询
        ClassPlanRating rating = new ClassPlanRating();
        rating.setUserId(userId);
        rating.setPlanId(planId);
        List<ClassPlanRating> ratings = classPlanRatingMapper.selectRatingList(rating);
        return ratings != null && !ratings.isEmpty() ? ratings.get(0) : null;
    }

    /**
     * 获取教案的平均评分和评分人数
     * 
     * @param planId 教案ID
     * @return 包含averageRating和rateCount的Map
     */
    @Override
    public Map<String, Object> getAverageRating(Long planId)
    {
        // 临时返回模拟数据
        Map<String, Object> result = new HashMap<>();
        result.put("averageRating", 4.5);
        result.put("rateCount", 10);
        return result;
    }

    /**
     * 查询教案所有评分记录
     * 
     * @param planId 教案ID
     * @return 教案评分记录列表
     */
    @Override
    public List<ClassPlanRating> selectRatingsByPlanId(Long planId)
    {
        ClassPlanRating rating = new ClassPlanRating();
        rating.setPlanId(planId);
        return classPlanRatingMapper.selectRatingList(rating);
    }

    /**
     * 新增教案评分记录
     * 
     * @param classPlanRating 教案评分记录
     * @return 结果
     */
    @Override
    public int insertRating(ClassPlanRating classPlanRating)
    {
        // 实际调用Mapper插入
        return classPlanRatingMapper.insertRating(classPlanRating);
    }

    /**
     * 修改教案评分记录
     * 
     * @param classPlanRating 教案评分记录
     * @return 结果
     */
    @Override
    public int updateRating(ClassPlanRating classPlanRating)
    {
        // 实际调用Mapper更新
        return classPlanRatingMapper.updateRating(classPlanRating);
    }

    /**
     * 删除教案评分记录主键
     * 
     * @param id 教案评分记录主键
     * @return 结果
     */
    @Override
    public int deleteRatingById(Long id)
    {
        return classPlanRatingMapper.deleteRatingById(id);
    }

    /**
     * 批量删除教案评分记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    @Override
    public int deleteRatingByIds(Long[] ids)
    {
        return classPlanRatingMapper.deleteRatingByIds(ids);
    }
}
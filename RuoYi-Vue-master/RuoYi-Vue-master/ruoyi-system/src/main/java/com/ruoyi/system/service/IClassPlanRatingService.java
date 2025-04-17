package com.ruoyi.system.service;

import java.util.Map;

import com.ruoyi.system.domain.ClassPlanRating;

/**
 * 教案评分记录Service接口
 * 
 * @author lkh
 */
public interface IClassPlanRatingService 
{
    /**
     * 查询教案评分记录
     * 
     * @param id 教案评分记录主键
     * @return 教案评分记录
     */
    public ClassPlanRating selectRatingById(Long id);

    /**
     * 查询用户对特定教案的评分
     * 
     * @param userId 用户ID
     * @param planId 教案ID
     * @return 教案评分记录
     */
    public ClassPlanRating selectRatingByUserAndPlan(Long userId, Long planId);

    /**
     * 获取教案的平均评分和评分人数
     * 
     * @param planId 教案ID
     * @return 包含averageRating和rateCount的Map
     */
    public Map<String, Object> getAverageRating(Long planId);

    /**
     * 新增教案评分记录
     * 
     * @param classPlanRating 教案评分记录
     * @return 结果
     */
    public int insertRating(ClassPlanRating classPlanRating);

    /**
     * 修改教案评分记录
     * 
     * @param classPlanRating 教案评分记录
     * @return 结果
     */
    public int updateRating(ClassPlanRating classPlanRating);

    /**
     * 删除教案评分记录
     * 
     * @param id 教案评分记录主键
     * @return 结果
     */
    public int deleteRatingById(Long id);

    /**
     * 批量删除教案评分记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRatingByIds(Long[] ids);
} 
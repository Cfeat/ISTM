package com.ruoyi.system.mapper;

import java.util.List;

import com.ruoyi.system.domain.ClassPlanRating;

/**
 * 教案评分记录Mapper接口
 * 
 * @author lkh
 */
public interface ClassPlanRatingMapper
{
    /**
     * 查询教案评分记录
     * 
     * @param id 教案评分记录主键
     * @return 教案评分记录
     */
    public ClassPlanRating selectRatingById(Long id);

    /**
     * 查询教案评分记录列表
     * 
     * @param classPlanRating 教案评分记录
     * @return 教案评分记录集合
     */
    public List<ClassPlanRating> selectRatingList(ClassPlanRating classPlanRating);

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
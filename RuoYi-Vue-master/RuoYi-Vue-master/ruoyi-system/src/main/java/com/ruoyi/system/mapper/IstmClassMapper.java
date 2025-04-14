package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.IstmClass;

/**
 * 课程管理Mapper接口
 * 
 * @author lkh
 * @date 2025-02-13
 */
public interface IstmClassMapper 
{
    /**
     * 查询课程管理
     * 
     * @param classId 课程管理主键
     * @return 课程管理
     */
    public IstmClass selectIstmClassByClassId(Long classId);

    /**
     * 查询课程管理列表
     * 
     * @param istmClass 课程管理
     * @return 课程管理集合
     */
    public List<IstmClass> selectIstmClassList(IstmClass istmClass);

    /**
     * 新增课程管理
     * 
     * @param istmClass 课程管理
     * @return 结果
     */
    public int insertIstmClass(IstmClass istmClass);

    /**
     * 修改课程管理
     * 
     * @param istmClass 课程管理
     * @return 结果
     */
    public int updateIstmClass(IstmClass istmClass);

    /**
     * 删除课程管理
     * 
     * @param classId 课程管理主键
     * @return 结果
     */
    public int deleteIstmClassByClassId(Long classId);

    /**
     * 批量删除课程管理
     * 
     * @param classIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteIstmClassByClassIds(Long[] classIds);
}

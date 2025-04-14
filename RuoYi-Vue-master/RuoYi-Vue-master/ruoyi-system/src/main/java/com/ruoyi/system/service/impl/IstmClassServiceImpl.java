package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.IstmClassMapper;
import com.ruoyi.system.domain.IstmClass;
import com.ruoyi.system.service.IIstmClassService;

/**
 * 课程管理Service业务层处理
 * 
 * @author lkh
 * @date 2025-02-13
 */
@Service
public class IstmClassServiceImpl implements IIstmClassService 
{
    @Autowired
    private IstmClassMapper istmClassMapper;

    /**
     * 查询课程管理
     * 
     * @param classId 课程管理主键
     * @return 课程管理
     */
    @Override
    public IstmClass selectIstmClassByClassId(Long classId)
    {
        return istmClassMapper.selectIstmClassByClassId(classId);
    }

    /**
     * 查询课程管理列表
     * 
     * @param istmClass 课程管理
     * @return 课程管理
     */
    @Override
    public List<IstmClass> selectIstmClassList(IstmClass istmClass)
    {
        return istmClassMapper.selectIstmClassList(istmClass);
    }

    /**
     * 新增课程管理
     * 
     * @param istmClass 课程管理
     * @return 结果
     */
    @Override
    public int insertIstmClass(IstmClass istmClass)
    {
        istmClass.setCreateTime(DateUtils.getNowDate());
        return istmClassMapper.insertIstmClass(istmClass);
    }

    /**
     * 修改课程管理
     * 
     * @param istmClass 课程管理
     * @return 结果
     */
    @Override
    public int updateIstmClass(IstmClass istmClass)
    {
        istmClass.setUpdateTime(DateUtils.getNowDate());
        return istmClassMapper.updateIstmClass(istmClass);
    }

    /**
     * 批量删除课程管理
     * 
     * @param classIds 需要删除的课程管理主键
     * @return 结果
     */
    @Override
    public int deleteIstmClassByClassIds(Long[] classIds)
    {
        return istmClassMapper.deleteIstmClassByClassIds(classIds);
    }

    /**
     * 删除课程管理信息
     * 
     * @param classId 课程管理主键
     * @return 结果
     */
    @Override
    public int deleteIstmClassByClassId(Long classId)
    {
        return istmClassMapper.deleteIstmClassByClassId(classId);
    }
}

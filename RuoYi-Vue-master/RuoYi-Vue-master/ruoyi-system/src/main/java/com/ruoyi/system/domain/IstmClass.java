package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 课程管理对象 istm_class
 * 
 * @author lkh
 * @date 2025-02-13
 */
public class IstmClass extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教案ID */
    private Long classId;

    /** 课程标题 */
    @Excel(name = "课程标题")
    private String className;

    /** 课程类型 */
    @Excel(name = "课程类型")
    private String classType;

    /** 教学过程 */
    @Excel(name = "教学过程")
    private String classProcess;

    /** 教学目标 */
    @Excel(name = "教学目标")
    private String classPurpose;

    /** 教案序号 */
    @Excel(name = "教案序号")
    private Long planId;

    /** 学生人数 */
    @Excel(name = "学生人数")
    private Long studentCount;

    /** 用户序号 */
    @Excel(name = "用户序号")
    private Long userId;

    /** 持续时间 */
    @Excel(name = "持续时间")
    private Long duration;

    /** 冗余1 */
    private String note1;

    /** 冗余2 */
    private String note2;

    /** 冗余3 */
    private String note3;

    public void setClassId(Long classId) 
    {
        this.classId = classId;
    }

    public Long getClassId() 
    {
        return classId;
    }
    public void setClassName(String className) 
    {
        this.className = className;
    }

    public String getClassName() 
    {
        return className;
    }
    public void setClassType(String classType) 
    {
        this.classType = classType;
    }

    public String getClassType() 
    {
        return classType;
    }
    public void setClassProcess(String classProcess) 
    {
        this.classProcess = classProcess;
    }

    public String getClassProcess() 
    {
        return classProcess;
    }
    public void setClassPurpose(String classPurpose) 
    {
        this.classPurpose = classPurpose;
    }

    public String getClassPurpose() 
    {
        return classPurpose;
    }
    public void setPlanId(Long planId) 
    {
        this.planId = planId;
    }

    public Long getPlanId() 
    {
        return planId;
    }
    public void setStudentCount(Long studentCount) 
    {
        this.studentCount = studentCount;
    }

    public Long getStudentCount() 
    {
        return studentCount;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setDuration(Long duration) 
    {
        this.duration = duration;
    }

    public Long getDuration() 
    {
        return duration;
    }
    public void setNote1(String note1) 
    {
        this.note1 = note1;
    }

    public String getNote1() 
    {
        return note1;
    }
    public void setNote2(String note2) 
    {
        this.note2 = note2;
    }

    public String getNote2() 
    {
        return note2;
    }
    public void setNote3(String note3) 
    {
        this.note3 = note3;
    }

    public String getNote3() 
    {
        return note3;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("classId", getClassId())
            .append("className", getClassName())
            .append("classType", getClassType())
            .append("classProcess", getClassProcess())
            .append("classPurpose", getClassPurpose())
            .append("planId", getPlanId())
            .append("studentCount", getStudentCount())
            .append("userId", getUserId())
            .append("duration", getDuration())
            .append("note1", getNote1())
            .append("note2", getNote2())
            .append("note3", getNote3())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}

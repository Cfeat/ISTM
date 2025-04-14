package com.ruoyi.system.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教案管理对象 class_plan
 * 
 * @author lkh
 * @date 2025-02-13
 */
@ApiModel(value = "ClassPlan", description = "教案实体")
public class ClassPlan extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教案ID */
    @ApiModelProperty("教案ID")
    private Long planId;

    /** 教案标题 */
    @ApiModelProperty("教案标题")
    @Excel(name = "教案标题")
    private String title;

    /** 教案类型 */
    @Excel(name = "教案类型")
    private String planType;

    /** 适用年级 */
    @Excel(name = "适用年级")
    private String grade;

    /** 头像地址 */
    private String avatar;

    /** 内容 */
    @Excel(name = "内容")
    private String content;

    /** 点击人数 */
    @Excel(name = "点击人数")
    private Long peopleCount;

    /** 冗余1 */
    private String note1;

    /** 冗余2 */
    private String note2;

    /** 冗余3 */
    private String note3;

    public void setPlanId(Long planId) 
    {
        this.planId = planId;
    }

    public Long getPlanId() 
    {
        return planId;
    }
    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }
    public void setPlanType(String planType) 
    {
        this.planType = planType;
    }

    public String getPlanType() 
    {
        return planType;
    }
    public void setGrade(String grade) 
    {
        this.grade = grade;
    }

    public String getGrade() 
    {
        return grade;
    }
    public void setAvatar(String avatar) 
    {
        this.avatar = avatar;
    }

    public String getAvatar() 
    {
        return avatar;
    }
    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }
    public void setPeopleCount(Long peopleCount) 
    {
        this.peopleCount = peopleCount;
    }

    public Long getPeopleCount() 
    {
        return peopleCount;
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
            .append("planId", getPlanId())
            .append("title", getTitle())
            .append("planType", getPlanType())
            .append("grade", getGrade())
            .append("avatar", getAvatar())
            .append("content", getContent())
            .append("peopleCount", getPeopleCount())
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

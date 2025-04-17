package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

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

    private String title;
    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    /** 教案ID */
    @ApiModelProperty("教案ID")
    private Long planId;

    /** 教案标题 */
    @ApiModelProperty("教案标题")
    @Excel(name = "教案标题")
    private String planName;

    /** 教案类型 */
    @Excel(name = "教案类型")
    private String planType;

    /** 适用年级 */
    @Excel(name = "适用年级")
    private String grade;

    /** 头像地址 */
    private String coverImg;

    /** 内容 */
    @Excel(name = "内容")
    private String planDesc;

    /** 点击人数 */
    @Excel(name = "点击人数")
    private Integer views;

    /** 冗余1 */
    private String planPurpose;

    /** 冗余2 */
    private String planProcess;

    /** 冗余3 */
    private String note3;

    /** 下载次数 */
    private Integer downloads;

    /** 评分 */
    private Double rating;

    /** 评分人数 */
    private Integer rateCount;

    /** 教学目标 */
    private String note1;

    /** 教学过程 */
    private String note2;

    /** 封面图片 */
    private String avatar;

    public void setPlanId(Long planId) 
    {
        this.planId = planId;
    }

    public Long getPlanId() 
    {
        return planId;
    }
    public void setPlanName(String planName) 
    {
        this.planName = planName;
    }

    public String getPlanName() 
    {
        return planName;
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
    public void setCoverImg(String coverImg) 
    {
        this.coverImg = coverImg;
    }

    public String getCoverImg() 
    {
        return this.avatar != null ? this.avatar : this.coverImg;
    }
    public void setPlanDesc(String planDesc) 
    {
        this.planDesc = planDesc;
    }

    public String getPlanDesc() 
    {
        return planDesc;
    }
    public void setViews(Integer views) 
    {
        this.views = views;
    }

    public Integer getViews() 
    {
        return views;
    }
    public void setPlanPurpose(String planPurpose) 
    {
        this.planPurpose = planPurpose;
    }

    public String getPlanPurpose() 
    {
        return planPurpose;
    }
    public void setPlanProcess(String planProcess) 
    {
        this.planProcess = planProcess;
    }

    public String getPlanProcess() 
    {
        return planProcess;
    }
    public void setNote3(String note3) 
    {
        this.note3 = note3;
    }

    public String getNote3() 
    {
        return note3;
    }

    public void setDownloads(Integer downloads) {
        this.downloads = downloads;
    }

    public Integer getDownloads() {
        return downloads;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public Integer getRateCount() {
        return rateCount;
    }

    public void setRateCount(Integer rateCount) {
        this.rateCount = rateCount;
    }

    public String getNote1() {
        return note1;
    }

    public void setNote1(String note1) {
        this.note1 = note1;
    }

    public String getNote2() {
        return note2;
    }

    public void setNote2(String note2) {
        this.note2 = note2;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    /**
     * 获取教案内容（兼容前端content字段）
     */
    public String getContent() 
    {
        return this.planDesc;
    }

    /**
     * 设置教案内容（兼容前端content字段）
     */
    public void setContent(String content) 
    {
        this.planDesc = content;
    }

    /**
     * 获取教学目标（兼容前端teachingGoals字段）
     */
    public String getTeachingGoals() 
    {
        return this.note1 != null ? this.note1 : this.planPurpose;
    }

    /**
     * 获取教学过程（兼容前端teachingProcess字段）
     */
    public String getTeachingProcess() 
    {
        return this.note2 != null ? this.note2 : this.planProcess;
    }

    /**
     * 获取点击人数（兼容前端peopleCount字段）
     */
    public Integer getPeopleCount() 
    {
        return this.views;
    }

    /**
     * 设置点击人数（兼容前端peopleCount字段）
     */
    public void setPeopleCount(Integer peopleCount) 
    {
        this.views = peopleCount;
    }

    /**
     * 获取运动类型（兼容前端sport字段）
     */
    public String getSport() 
    {
        return this.planType;
    }

    /**
     * 设置运动类型（兼容前端sport字段）
     */
    public void setSport(String sport) 
    {
        this.planType = sport;
    }

    /**
     * 获取教案标题（兼容）
     */
    public String getDescription() 
    {
        return this.planDesc;
    }

    /**
     * 获取教案封面图片（完全兼容）
     */
    public String getImageUrl() 
    {
        return this.avatar != null ? this.avatar : this.coverImg;
    }

    /**
     * 获取评分人数（兼容rate_count字段）
     */
    public Integer getRate_count() 
    {
        return this.rateCount;
    }

    /**
     * 设置评分人数（兼容rate_count字段）
     */
    public void setRate_count(Integer rate_count) 
    {
        this.rateCount = rate_count;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("planId", getPlanId())
            .append("planName", getPlanName())
            .append("planType", getPlanType())
            .append("grade", getGrade())
            .append("coverImg", getCoverImg())
            .append("planDesc", getPlanDesc())
            .append("views", getViews())
            .append("planPurpose", getPlanPurpose())
            .append("planProcess", getPlanProcess())
            .append("note3", getNote3())
            .append("downloads", getDownloads())
            .append("rating", getRating())
            .append("rateCount", getRateCount())
            .append("note1", getNote1())
            .append("note2", getNote2())
            .append("avatar", getAvatar())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}

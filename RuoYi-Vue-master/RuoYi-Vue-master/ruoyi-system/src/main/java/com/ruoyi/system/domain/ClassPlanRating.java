package com.ruoyi.system.domain;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 教案评分记录对象 class_plan_rating
 * 
 * @author lkh
 */
@ApiModel(value = "ClassPlanRating", description = "教案评分实体")
public class ClassPlanRating extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评分ID */
    @ApiModelProperty("评分ID")
    private Long id;

    /** 教案ID */
    @ApiModelProperty("教案ID")
    @Excel(name = "教案ID")
    private Long planId;

    /** 用户ID */
    @ApiModelProperty("用户ID")
    @Excel(name = "用户ID")
    private Long userId;

    /** 评分 */
    @ApiModelProperty("评分")
    @Excel(name = "评分")
    private Integer score;

    /** 评分时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("评分时间")
    @Excel(name = "评分时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    
    public void setPlanId(Long planId) 
    {
        this.planId = planId;
    }

    public Long getPlanId() 
    {
        return planId;
    }
    
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    
    public void setScore(Integer score) 
    {
        this.score = score;
    }

    public Integer getScore() 
    {
        return score;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("planId", getPlanId())
            .append("userId", getUserId())
            .append("score", getScore())
            .append("createTime", getCreateTime())
            .toString();
    }
} 
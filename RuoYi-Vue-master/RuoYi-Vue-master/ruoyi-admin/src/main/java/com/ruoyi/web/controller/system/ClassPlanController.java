package com.ruoyi.web.controller.system;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.http.HttpServletResponse;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.ClassPlan;
import com.ruoyi.system.domain.ClassPlanRating;
import com.ruoyi.system.service.IClassPlanService;
import com.ruoyi.system.service.IClassPlanRatingService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教案管理Controller
 * 
 * @author lkh
 */
@Api(tags = "教案管理")
@RestController
@RequestMapping("/system/plan")
public class ClassPlanController extends BaseController
{
    @Autowired
    private IClassPlanService classPlanService;
    
    @Autowired
    private IClassPlanRatingService classPlanRatingService;

    /**
     * 查询教案管理列表
     */
    @ApiOperation(value = "获取教案列表", notes = "根据条件查询教案列表")
    @PreAuthorize("@ss.hasPermi('system:plan:list')")
    @GetMapping("/list")
    public TableDataInfo list(ClassPlan classPlan)
    {
        startPage();
        List<ClassPlan> list = classPlanService.selectClassPlanList(classPlan);
        return getDataTable(list);
    }

    /**
     * 导出教案管理列表
     */
    @ApiOperation(value = "导出教案列表", notes = "将符合条件的教案列表导出为Excel文件")
    @PreAuthorize("@ss.hasPermi('system:plan:export')")
    @Log(title = "教案管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ClassPlan classPlan)
    {
        List<ClassPlan> list = classPlanService.selectClassPlanList(classPlan);
        ExcelUtil<ClassPlan> util = new ExcelUtil<ClassPlan>(ClassPlan.class);
        util.exportExcel(response, list, "教案管理数据");
    }

    /**
     * 获取教案管理详细信息
     */
    @ApiOperation(value="获取教案详情",notes = "根据教案ID查询详细信息")
    @ApiImplicitParam(name = "planId", value = "教案id", required = true, dataType = "Long", paramType = "path", dataTypeClass = Long.class)
    @PreAuthorize("@ss.hasPermi('system:plan:query')")
    @GetMapping(value = "/{planId}")
    public AjaxResult getInfo(@PathVariable("planId") Long planId)
    {
        return success(classPlanService.selectClassPlanByPlanId(planId));
    }

    /**
     * 新增教案管理
     */
    @ApiOperation(value = "新增教案", notes = "新增一条教案记录")
    @ApiImplicitParam(name = "classPlan", value = "教案对象", required = true, dataType = "ClassPlan", paramType = "body")
    @PreAuthorize("@ss.hasPermi('system:plan:add')")
    @Log(title = "教案管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ClassPlan classPlan)
    {
        return toAjax(classPlanService.insertClassPlan(classPlan));
    }

    /**
     * 修改教案管理
     */
    @ApiOperation(value = "修改教案", notes = "根据ID修改教案信息")
    @ApiImplicitParam(name = "classPlan", value = "教案对象", required = true, dataType = "ClassPlan", paramType = "body")
    @PreAuthorize("@ss.hasPermi('system:plan:edit')")
    @Log(title = "教案管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ClassPlan classPlan)
    {
        return toAjax(classPlanService.updateClassPlan(classPlan));
    }

    /**
     * 删除教案管理
     */
    @ApiOperation(value = "删除教案", notes = "根据ID批量删除教案")
    @ApiImplicitParam(name = "planIds", value = "教案ID数组", required = true, dataType = "Long[]", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:plan:remove')")
    @Log(title = "教案管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{planIds}")
    public AjaxResult remove(@PathVariable Long[] planIds)
    {
        return toAjax(classPlanService.deleteClassPlanByPlanIds(planIds));
    }
    
    /**
     * 下载教案
     */
    @ApiOperation(value = "下载教案", notes = "根据ID和文件类型下载教案")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "planId", value = "教案ID", required = true, dataType = "Long", paramType = "query"),
        @ApiImplicitParam(name = "fileType", value = "文件类型(docx/pdf/txt)", required = true, dataType = "String", paramType = "query")
    })
    @GetMapping("/download")
    public void download(HttpServletResponse response, @RequestParam("planId") Long planId, @RequestParam("fileType") String fileType)
    {
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
        if (classPlan != null) {
            // 处理教案下载逻辑，根据不同的文件类型生成对应的文件
            // TODO: 实现下载逻辑
        }
    }
    
    /**
     * 记录教案查看次数
     */
    @ApiOperation(value = "记录查看次数", notes = "增加教案的观看计数")
    @ApiImplicitParam(name = "planId", value = "教案ID", required = true, dataType = "Long", paramType = "path")
    @PutMapping("/view/{planId}")
    public AjaxResult recordView(@PathVariable("planId") Long planId)
    {
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
        if (classPlan != null) {
            if (classPlan.getViews() == null) {
                classPlan.setViews(1);
            } else {
                classPlan.setViews(classPlan.getViews() + 1);
            }
            classPlanService.updateClassPlan(classPlan);
            
            Map<String, Object> data = new HashMap<>();
            data.put("views", classPlan.getViews());
            return AjaxResult.success(data);
        }
        return AjaxResult.error("教案不存在");
    }
    
    /**
     * 提交教案评分
     */
    @ApiOperation(value = "评分教案", notes = "给教案提交评分(1-5分)")
    @PostMapping("/rate")
    public AjaxResult rate(@RequestBody ClassPlanRating rating)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        SysUser user = loginUser.getUser();
        
        // 设置用户ID
        rating.setUserId(user.getUserId());
        
        // 保存评分
        ClassPlanRating existingRating = classPlanRatingService.selectRatingByUserAndPlan(user.getUserId(), rating.getPlanId());
        
        if (existingRating != null) {
            existingRating.setScore(rating.getScore());
            classPlanRatingService.updateRating(existingRating);
        } else {
            classPlanRatingService.insertRating(rating);
        }
        
        // 更新教案的平均评分
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(rating.getPlanId());
        if (classPlan != null) {
            // 获取最新的平均评分和评分人数
            Map<String, Object> ratingData = classPlanRatingService.getAverageRating(rating.getPlanId());
            
            Map<String, Object> data = new HashMap<>();
            data.put("rating", ratingData.get("averageRating"));
            data.put("rateCount", ratingData.get("rateCount"));
            
            return AjaxResult.success(data);
        }
        
        return AjaxResult.error("评分失败");
    }
    
    /**
     * 记录教案下载次数
     */
    @ApiOperation(value = "记录下载次数", notes = "增加教案的下载计数")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "planId", value = "教案ID", required = true, dataType = "Long", paramType = "query"),
        @ApiImplicitParam(name = "fileType", value = "文件类型", required = true, dataType = "String", paramType = "query")
    })
    @PutMapping("/download/record")
    public AjaxResult recordDownload(@RequestParam("planId") Long planId, @RequestParam("fileType") String fileType)
    {
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
        if (classPlan != null) {
            // 增加下载次数
            Integer downloads = classPlan.getDownloads();
            if (downloads == null) {
                classPlan.setDownloads(1);
            } else {
                classPlan.setDownloads(downloads + 1);
            }
            classPlanService.updateClassPlan(classPlan);
            
            Map<String, Object> data = new HashMap<>();
            data.put("downloads", classPlan.getDownloads());
            return AjaxResult.success(data);
        }
        return AjaxResult.error("教案不存在");
    }
    
    /**
     * 应用教案到课堂
     */
    @ApiOperation(value = "应用教案到课堂", notes = "将教案应用到课堂教学中")
    @ApiImplicitParam(name = "planId", value = "教案ID", required = true, dataType = "Long", paramType = "path")
    @GetMapping("/apply/{planId}")
    public AjaxResult applyToClass(@PathVariable("planId") Long planId)
    {
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
        if (classPlan != null) {
            return AjaxResult.success(classPlan);
        }
        return AjaxResult.error("教案不存在");
    }
} 
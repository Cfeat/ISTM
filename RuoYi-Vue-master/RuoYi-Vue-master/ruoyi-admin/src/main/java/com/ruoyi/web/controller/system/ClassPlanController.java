package com.ruoyi.web.controller.system;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
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
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.ClassPlan;
import com.ruoyi.system.service.IClassPlanService;
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
}

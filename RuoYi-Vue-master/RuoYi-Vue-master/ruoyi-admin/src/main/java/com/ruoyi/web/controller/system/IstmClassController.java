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
import com.ruoyi.system.domain.IstmClass;
import com.ruoyi.system.service.IIstmClassService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程管理Controller
 * 
 * @author lkh
 * @date 2025-02-13
 */
@Api("课程管理")
@RestController
@RequestMapping("/system/class")
public class IstmClassController extends BaseController
{
    @Autowired
    private IIstmClassService istmClassService;

    /**
     * 查询课程管理列表
     */
    @ApiOperation(value = "获取课程列表", notes = "根据条件查询课程列表")
    @PreAuthorize("@ss.hasPermi('system:class:list')")
    @GetMapping("/list")
    public TableDataInfo list(IstmClass istmClass)
    {
        startPage();
        List<IstmClass> list = istmClassService.selectIstmClassList(istmClass);
        return getDataTable(list);
    }

    /**
     * 导出课程管理列表
     */
    @ApiOperation(value = "导出课程列表", notes = "将符合条件的课程列表导出为Excel文件")
    @PreAuthorize("@ss.hasPermi('system:class:export')")
    @Log(title = "课程管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, IstmClass istmClass)
    {
        List<IstmClass> list = istmClassService.selectIstmClassList(istmClass);
        ExcelUtil<IstmClass> util = new ExcelUtil<IstmClass>(IstmClass.class);
        util.exportExcel(response, list, "课程管理数据");
    }

    /**
     * 获取课程管理详细信息
     */
    @ApiOperation(value="获取课程详情",notes = "根据课程ID查询详细信息")
    @ApiImplicitParam(name = "classId", value = "课程id", required = true, dataType = "Long", paramType = "path", dataTypeClass = Long.class)
    @PreAuthorize("@ss.hasPermi('system:class:query')")
    @GetMapping(value = "/{classId}")
    public AjaxResult getInfo(@PathVariable("classId") Long classId)
    {
        return success(istmClassService.selectIstmClassByClassId(classId));
    }

    /**
     * 新增课程管理
     */
    @ApiOperation(value = "新增课程", notes = "新增一条课程记录")
    @ApiImplicitParam(name = "istmClass", value = "课程对象", required = true, dataType = "IstmClass", paramType = "body")
    @PreAuthorize("@ss.hasPermi('system:class:add')")
    @Log(title = "课程管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IstmClass istmClass)
    {
        return toAjax(istmClassService.insertIstmClass(istmClass));
    }

    /**
     * 修改课程管理
     */
    @ApiOperation(value = "修改课程", notes = "根据ID修改课程信息")
    @ApiImplicitParam(name = "istmClass", value = "课程对象", required = true, dataType = "IstmClass", paramType = "body")
    @PreAuthorize("@ss.hasPermi('system:class:edit')")
    @Log(title = "课程管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IstmClass istmClass)
    {
        return toAjax(istmClassService.updateIstmClass(istmClass));
    }

    /**
     * 删除课程管理
     */
    @ApiOperation(value = "删除课程", notes = "根据ID批量删除课程")
    @ApiImplicitParam(name = "classIds", value = "课程ID数组", required = true, dataType = "Long[]", paramType = "path")
    @PreAuthorize("@ss.hasPermi('system:class:remove')")
    @Log(title = "课程管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{classIds}")
    public AjaxResult remove(@PathVariable Long[] classIds)
    {
        return toAjax(istmClassService.deleteIstmClassByClassIds(classIds));
    }
}

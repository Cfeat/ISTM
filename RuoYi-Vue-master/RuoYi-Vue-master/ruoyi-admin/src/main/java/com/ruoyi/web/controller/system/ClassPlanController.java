package com.ruoyi.web.controller.system;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.io.OutputStream;
import javax.servlet.ServletOutputStream;

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

// 可选：如果使用Word文档生成功能，需要添加
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;

// 可选：如果使用PDF生成功能，需要添加
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

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
    @GetMapping("/download")
    public void download(HttpServletResponse response, @RequestParam("planId") Long planId, @RequestParam("fileType") String fileType) throws IOException
    {
        try {
            ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
            if (classPlan == null) {
                response.setContentType("application/json;charset=utf-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"教案不存在\"}");
                return;
            }
            
            // 根据不同的文件类型生成对应内容
            String fileName = classPlan.getTitle() + "." + fileType;
            
            // 设置下载响应头
            response.reset();
            response.addHeader("Access-Control-Allow-Origin", "*");
            response.addHeader("Access-Control-Expose-Headers", "Content-Disposition");
            
            // 设置文件名编码
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename=" + encodedFileName);
            
            // 根据文件类型设置内容类型并生成文件
            if ("docx".equals(fileType)) {
                response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
                generateWordDocument(classPlan, response.getOutputStream());
            } else if ("pdf".equals(fileType)) {
                response.setContentType("application/pdf");
                generatePdfDocument(classPlan, response.getOutputStream());
            } else {
                // 默认为文本文件
                response.setContentType("text/plain;charset=utf-8");
                String content = generateContent(classPlan, fileType);
                response.getWriter().write(content);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"code\":500,\"msg\":\"下载失败：" + e.getMessage() + "\"}");
        }
    }
    
    /**
     * 记录教案查看次数
     */
    @ApiOperation(value = "记录查看次数", notes = "增加教案的观看计数")
    @PutMapping("/view/{planId}")
    public AjaxResult recordView(@PathVariable("planId") Long planId)
    {
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
        if (classPlan != null) {
            // 获取当前登录用户
            LoginUser loginUser = SecurityUtils.getLoginUser();
            Long userId = loginUser.getUserId();
            
            // 增加查看次数
            Integer views = classPlan.getViews();
            classPlan.setViews(views == null ? 1 : views + 1);
            classPlanService.updateClassPlan(classPlan);
            
            Map<String, Object> data = new HashMap<>();
            data.put("views", classPlan.getViews());
            return AjaxResult.success(data);
        }
        return AjaxResult.error("教案不存在");
    }
    
    /**
     * 记录教案下载次数
     */
    @ApiOperation(value = "记录下载次数", notes = "增加教案的下载计数")
    @PutMapping("/download/record")
    public AjaxResult recordDownload(@RequestParam("planId") Long planId, @RequestParam("fileType") String fileType)
    {
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
        if (classPlan != null) {
            // 获取当前登录用户信息
            LoginUser loginUser = SecurityUtils.getLoginUser();
            Long userId = loginUser.getUserId();
            
            // 增加下载次数
            Integer downloads = classPlan.getDownloads();
            classPlan.setDownloads(downloads == null ? 1 : downloads + 1);
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

    /**
     * 提交教案评分
     */
    @ApiOperation(value = "评分教案", notes = "给教案提交评分(1-5分)")
    @PostMapping("/rate")
    public AjaxResult rate(@RequestBody Map<String, Object> rateData)
    {
        Long planId = Long.valueOf(rateData.get("planId").toString());
        Integer score = Integer.valueOf(rateData.get("score").toString());
        
        // 验证评分范围
        if (score < 1 || score > 5) {
            return AjaxResult.error("评分必须在1-5之间");
        }
        
        ClassPlan classPlan = classPlanService.selectClassPlanByPlanId(planId);
        if (classPlan != null) {
            // 获取当前登录用户
            LoginUser loginUser = SecurityUtils.getLoginUser();
            Long userId = loginUser.getUserId();
            
            // 检查用户是否已经评过分
            ClassPlanRating existingRating = classPlanRatingService.selectRatingByUserAndPlan(userId, planId);
            boolean isNewRating = (existingRating == null);
            
            ClassPlanRating rating = new ClassPlanRating();
            rating.setPlanId(planId);
            rating.setUserId(userId);
            rating.setScore(score);
            
            // 如果是新评分，新增记录，否则更新已有记录
            if (isNewRating) {
                classPlanRatingService.insertRating(rating);
            } else {
                // 已经评过分，更新评分
                rating.setId(existingRating.getId());
                classPlanRatingService.updateRating(rating);
            }
            
            // 重新计算平均分
            List<ClassPlanRating> allRatings = classPlanRatingService.selectRatingsByPlanId(planId);
            if (allRatings != null && !allRatings.isEmpty()) {
                // 计算平均分
                double sum = 0;
                for (ClassPlanRating r : allRatings) {
                    sum += r.getScore();
                }
                double avgRating = sum / allRatings.size();
                
                // 四舍五入保留一位小数
                avgRating = Math.round(avgRating * 10) / 10.0;
                
                // 更新教案评分信息
                classPlan.setRating(avgRating);
                classPlan.setRateCount(allRatings.size());
                classPlanService.updateClassPlan(classPlan);
            }
            
            Map<String, Object> data = new HashMap<>();
            data.put("rating", classPlan.getRating());
            data.put("rateCount", classPlan.getRateCount());
            
            return AjaxResult.success(data);
        }
        
        return AjaxResult.error("评分失败");
    }

    // 生成文本内容
    private String generateContent(ClassPlan classPlan, String fileType) {
        StringBuilder content = new StringBuilder();
        content.append("标题：").append(classPlan.getTitle()).append("\r\n\r\n");
        content.append("教案类型：").append(classPlan.getPlanType()).append("\r\n");
        content.append("适用年级：").append(classPlan.getGrade()).append("\r\n\r\n");
        
        content.append("【教案内容】\r\n");
        content.append(classPlan.getPlanDesc()).append("\r\n\r\n");
        
        content.append("【教学目标】\r\n");
        content.append(classPlan.getPlanPurpose()).append("\r\n\r\n");
        
        content.append("【教学过程】\r\n");
        content.append(classPlan.getPlanProcess()).append("\r\n\r\n");
        
        return content.toString();
    }

    // 生成Word文档 - 简化版
    private void generateWordDocument(ClassPlan classPlan, OutputStream os) throws IOException {
        // 如果没有POI库，可以简单输出文本内容
        String content = generateContent(classPlan, "docx");
        os.write(content.getBytes("UTF-8"));
        os.flush();
    }

    // 生成PDF文档 - 简化版
    private void generatePdfDocument(ClassPlan classPlan, OutputStream os) {
        // 如果没有iText库，可以简单输出文本内容
        try {
            String content = generateContent(classPlan, "pdf");
            os.write(content.getBytes("UTF-8"));
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
} 
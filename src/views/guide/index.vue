<template>
  <div class="guide-container">
    <h2 class="guide-title" style="color: #95d475;">使用建议</h2>
    
    <el-card class="guide-section">
      <template #header>
        <div class="section-header">
          <el-icon><School /></el-icon>
          <span>AI课堂使用建议</span>
        </div>
      </template>
      <div class="section-content">
        <h4>1. 创建课堂</h4>
        <ul>
          <li>建议填写详细的教学目标和教学过程，这将帮助AI更好地理解您的教学意图</li>
          <li>合理设置学生数量，建议在20-40人之间</li>
          <li>根据实际教学需求调整男女比例</li>
          <li>错误案例概率建议设置在30%-70%之间，以模拟真实课堂情况</li>
          <li>可以通过拖拽上传教案文件，系统将自动识别并填充相关信息</li>
        </ul>

        <h4>2. 课堂互动</h4>
        <ul>
          <li>虚拟学生响应时间可根据课程难度调整，建议在0.5-2秒之间</li>
          <li>选择合适的天气背景可以增加课堂的真实感和代入感</li>
          <li>注意观察学生的反馈，及时调整教学节奏</li>
        </ul>

        <h4>3. 最佳实践</h4>
        <ul>
          <li>首次使用时建议从小班级开始，熟悉系统后再尝试大班教学</li>
          <li>可以利用系统的智能分析功能优化教学方案</li>
          <li>定期查看历史课堂记录，总结教学经验</li>
        </ul>
      </div>
    </el-card>

    <el-card class="guide-section">
      <template #header>
        <div class="section-header">
          <el-icon><Warning /></el-icon>
          <span>注意事项</span>
        </div>
      </template>
      <div class="section-content">
        <ul>
          <li>请确保网络连接稳定，以保证AI课堂的流畅运行</li>
          <li>建议使用最新版本的浏览器访问系统</li>
          <li>如遇到问题，可查看系统设置中的帮助文档</li>
          <li>重要的教学数据建议及时保存</li>
        </ul>
      </div>
    </el-card>

    <el-card class="guide-section">
      <template #header>
        <div class="section-header">
          <el-icon><Service /></el-icon>
          <span>技术支持</span>
        </div>
      </template>
      <div class="section-content">
        <p>如果您在使用过程中遇到任何问题，可以通过以下方式获取帮助：</p>
        <ul>
          <li>系统设置 → 帮助中心</li>
          <li>发送邮件至：support@istm.com</li>
          <li>工作时间：周一至周五 9:00-18:00</li>
        </ul>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { School, Warning, Service } from '@element-plus/icons-vue'
</script>

<style lang="scss" scoped>
.guide-container {
  padding: 20px;

  .guide-title {
    margin-bottom: 24px;
    font-size: 24px;
  }

  .guide-section {
    margin-bottom: 24px;

    .section-header {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 16px;
      font-weight: 500;

      .el-icon {
        font-size: 20px;
        color: #95d475;
      }
    }

    .section-content {
      h4 {
        color: #95d475;
        margin: 16px 0 12px;
      }

      ul {
        padding-left: 20px;
        
        li {
          margin-bottom: 8px;
          line-height: 1.6;
          color: #606266;

          &:last-child {
            margin-bottom: 0;
          }
        }
      }

      p {
        margin-bottom: 12px;
        color: #606266;
      }
    }
  }
}
</style> 
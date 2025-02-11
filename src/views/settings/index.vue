<template>
  <div class="settings-container">
    <h2 class="settings-title" style="color: #95d475;">系统设置</h2>

    <el-tabs v-model="activeTab" class="settings-tabs">
      <!-- 基础设置 -->
      <el-tab-pane label="基础设置" name="basic">
        <el-form :model="basicSettings" label-width="120px">
          <el-card class="settings-card">
            <template #header>
              <div class="card-header">
                <el-icon><Setting /></el-icon>
                <span>基础配置</span>
              </div>
            </template>
            
            <el-form-item label="系统语言">
              <el-select v-model="basicSettings.language">
                <el-option label="简体中文" value="zh-CN" />
                <el-option label="English" value="en-US" />
              </el-select>
            </el-form-item>

            <el-form-item label="默认课堂人数">
              <el-input-number 
                v-model="basicSettings.defaultStudentCount" 
                :min="1" 
                :max="100"
              />
            </el-form-item>

            <el-form-item label="自动保存">
              <el-switch 
                v-model="basicSettings.autoSave"
                active-color="#95d475"
              />
            </el-form-item>
          </el-card>
        </el-form>
      </el-tab-pane>

      <!-- AI设置 -->
      <el-tab-pane label="AI设置" name="ai">
        <el-form :model="aiSettings" label-width="120px">
          <el-card class="settings-card">
            <template #header>
              <div class="card-header">
                <el-icon><Monitor /></el-icon>
                <span>AI配置</span>
              </div>
            </template>

            <el-form-item label="AI响应速度">
              <el-slider 
                v-model="aiSettings.responseSpeed"
                :min="1"
                :max="10"
                :marks="{1: '慢', 5: '中', 10: '快'}"
              />
            </el-form-item>

            <el-form-item label="语音识别">
              <el-switch 
                v-model="aiSettings.voiceRecognition"
                active-color="#95d475"
              />
            </el-form-item>

            <el-form-item label="AI助手">
              <el-switch 
                v-model="aiSettings.aiAssistant"
                active-color="#95d475"
              />
            </el-form-item>
          </el-card>
        </el-form>
      </el-tab-pane>

      <!-- 通知设置 -->
      <el-tab-pane label="通知设置" name="notification">
        <el-form :model="notificationSettings" label-width="120px">
          <el-card class="settings-card">
            <template #header>
              <div class="card-header">
                <el-icon><Bell /></el-icon>
                <span>通知配置</span>
              </div>
            </template>

            <el-form-item label="系统通知">
              <el-switch 
                v-model="notificationSettings.systemNotification"
                active-color="#95d475"
              />
            </el-form-item>

            <el-form-item label="邮件通知">
              <el-switch 
                v-model="notificationSettings.emailNotification"
                active-color="#95d475"
              />
            </el-form-item>

            <el-form-item label="通知邮箱" v-if="notificationSettings.emailNotification">
              <el-input v-model="notificationSettings.email" placeholder="请输入邮箱" />
            </el-form-item>
          </el-card>
        </el-form>
      </el-tab-pane>
    </el-tabs>

    <!-- 保存按钮 -->
    <div class="settings-footer">
      <el-button @click="resetSettings">重置</el-button>
      <el-button 
        type="primary" 
        style="background-color: #95d475; border-color: #95d475;"
        @click="saveSettings"
        :loading="saving"
      >
        保存设置
      </el-button>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { Setting, Monitor, Bell } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const activeTab = ref('basic')
const saving = ref(false)

// 基础设置
const basicSettings = reactive({
  language: 'zh-CN',
  defaultStudentCount: 30,
  autoSave: true
})

// AI设置
const aiSettings = reactive({
  responseSpeed: 5,
  voiceRecognition: true,
  aiAssistant: true
})

// 通知设置
const notificationSettings = reactive({
  systemNotification: true,
  emailNotification: false,
  email: ''
})

// 保存设置
const saveSettings = async () => {
  try {
    saving.value = true
    // TODO: 调用API保存设置
    await new Promise(resolve => setTimeout(resolve, 1000)) // 模拟API调用
    ElMessage.success('设置保存成功')
  } catch (error) {
    ElMessage.error('设置保存失败')
  } finally {
    saving.value = false
  }
}

// 重置设置
const resetSettings = () => {
  // TODO: 重置为默认设置
  ElMessage.success('设置已重置')
}
</script>

<style lang="scss" scoped>
.settings-container {
  padding: 20px;

  .settings-title {
    margin-bottom: 24px;
    font-size: 24px;
  }

  .settings-tabs {
    margin-bottom: 24px;

    .settings-card {
      margin-bottom: 20px;

      .card-header {
        display: flex;
        align-items: center;
        gap: 8px;

        .el-icon {
          color: #95d475;
        }
      }

      :deep(.el-form-item) {
        margin-bottom: 20px;

        &:last-child {
          margin-bottom: 0;
        }
      }
    }
  }

  .settings-footer {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 40px;
  }
}
</style> 
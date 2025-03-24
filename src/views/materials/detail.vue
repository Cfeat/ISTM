<template>
  <div class="material-detail">
    <div class="detail-header">
      <h2 style="color: #95d475;">教案详情</h2>
      <el-button @click="goBack">返回</el-button>
    </div>

    <el-card class="detail-content" v-loading="loading">
      <!-- 基本信息 -->
      <div class="section">
        <div class="title-section">
          <h1>{{ detail.title }}</h1>
          <el-dropdown @command="handleDownload">
            <el-button type="primary">
              <el-icon><Download /></el-icon>下载教案
              <el-icon class="el-icon--right"><ArrowDown /></el-icon>
            </el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="docx">Word文档 (.docx)</el-dropdown-item>
                <el-dropdown-item command="pdf">PDF文档 (.pdf)</el-dropdown-item>
                <el-dropdown-item command="txt">文本文件 (.txt)</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
        <div class="meta-info">
          <el-tag>{{ detail.sport }}</el-tag>
          <!-- <el-tag type="success">{{ detail.grade }}</el-tag> -->
          <span><el-icon><View /></el-icon>{{ detail.views }}</span>
          <span><el-icon><Star /></el-icon>{{ detail.rating }}</span>
          <span><el-icon><Download /></el-icon>{{ detail.downloads }}</span>
        </div>
      </div>

      <!-- 教案内容 -->
      <div class="section">
        <h3>教案简介</h3>
        <p>{{ detail.description }}</p>
      </div>

      <div class="section">
        <h3>教学目标</h3>
        <div class="content-box">{{ detail.teachingGoals }}</div>
      </div>

      <div class="section">
        <h3>教学过程</h3>
        <div class="content-box">{{ detail.teachingProcess }}</div>
      </div>

      <!-- <div class="section">
        <h3>注意事项</h3>
        <div class="content-box">{{ detail.notes }}</div>
      </div> -->
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { View, Star, Download, ArrowDown } from '@element-plus/icons-vue'
import { getMaterialDetail, downloadMaterial } from '@/api/materials'

const router = useRouter()
const route = useRoute()
const loading = ref(false)
const detail = ref({})

// 获取教案详情
const fetchDetail = async () => {
  try {
    loading.value = true
    const res = await getMaterialDetail(route.params.id)
    if (res.code === 200) {
      detail.value = res.data
    } else {
      throw new Error(res.message || '获取教案详情失败')
    }
  } catch (error) {
    console.error('获取教案详情失败:', error)
    ElMessage.error(error.message || '获取教案详情失败')
    router.push('/materials')
  } finally {
    loading.value = false
  }
}

// 下载教案
const handleDownload = async (fileType) => {
  try {
    loading.value = true
    const res = await downloadMaterial(route.params.id, fileType)
    
    // 创建 Blob 对象
    const blob = new Blob([new Uint8Array(res.data)], { type: res.type || 'text/plain' })
    
    // 创建下载链接
    const url = window.URL.createObjectURL(blob)
    const link = document.createElement('a')
    link.href = url
    link.download = `${detail.value.title}.${fileType}`
    
    // 触发下载
    document.body.appendChild(link)
    link.click()
    
    // 清理
    document.body.removeChild(link)
    window.URL.revokeObjectURL(url)
    
    ElMessage.success('下载成功')
  } catch (error) {
    console.error('下载失败:', error)
    ElMessage.error('下载失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

// 返回列表
const goBack = () => {
  router.back()
}

onMounted(() => {
  if (route.params.id) {
    fetchDetail()
  }
})
</script>

<style lang="scss" scoped>
.material-detail {
  padding: 20px;

  .detail-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;

    h2 {
      margin: 0;
    }
  }

  .detail-content {
    .section {
      margin-bottom: 30px;

      .title-section {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;

        h1 {
          margin: 0;
          font-size: 24px;
          color: #333;
        }

        .el-dropdown {
          margin-left: 16px;
        }
      }

      .meta-info {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 20px;

        span {
          display: flex;
          align-items: center;
          gap: 4px;
          color: #666;
        }
      }

      h3 {
        margin: 0 0 15px;
        padding-left: 10px;
        border-left: 4px solid #95d475;
        color: #333;
      }

      .content-box {
        padding: 15px;
        background: #f8f9fa;
        border-radius: 4px;
        line-height: 1.6;
        color: #666;
        white-space: pre-line;
      }

      p {
        line-height: 1.6;
        color: #666;
      }
    }
  }
}
</style> 
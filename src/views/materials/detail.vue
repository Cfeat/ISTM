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
          <div class="action-buttons">
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
            <el-button type="success" @click="applyToClass">
              <el-icon><Document /></el-icon>应用到课堂
            </el-button>
          </div>
        </div>
        <div class="meta-info">
          <el-tag>{{ detail.planType }}</el-tag>
          <span class="stat-item"><el-icon><View /></el-icon>{{ detail.views || 0 }}</span>
          <span class="stat-item"><el-icon><Star /></el-icon>{{ detail.rating || '0.0' }} {{ detail.rateCount ? `(${detail.rateCount}人评价)` : '' }}</span>
          <span class="stat-item"><el-icon><Download /></el-icon>{{ detail.downloads || 0 }}</span>
        </div>
      </div>

      <!-- 在meta-info下方添加评分组件 -->
      <div class="rating-section">
        <h3>教案评分</h3>
        <div class="rating-content">
          <div class="current-rating">
            <div class="rating-score">{{ detail.rating || '暂无评分' }}</div>
            <el-rate
              v-model="detail.rating"
              disabled
              show-score
              text-color="#ff9900"
            />
            <div class="rating-count" v-if="detail.rateCount">{{ detail.rateCount }}人评价</div>
          </div>
          <div class="rate-form">
            <span>我的评分：</span>
            <el-rate
              v-model="userRating"
              :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
              :show-text="true"
              :texts="['很差', '较差', '一般', '不错', '很好']"
              @change="handleRate"
            />
          </div>
        </div>
      </div>

      <!-- 教案内容 -->
      <div class="section">
        <h3>教案简介</h3>
        <p>{{ detail.content || '暂无简介' }}</p>
      </div>

      <div class="section">
        <h3>教学目标</h3>
        <div class="content-box">{{ detail.note1 || '暂无教学目标' }}</div>
      </div>

      <div class="section">
        <h3>教学过程</h3>
        <div class="content-box">{{ detail.note2 || '暂无教学过程' }}</div>
      </div>

      <!-- 添加评分历史 -->
      <!-- <div class="section">
        <h3>评分详情</h3>
        <div class="rating-stats">
          <div class="current-rating">
            <div class="rating-number">{{ detail.rating || '0.0' }}</div>
            <el-rate v-model="detail.rating" disabled show-score text-color="#ff9900"></el-rate>
            <div class="rating-text">{{ detail.rateCount || 0 }}人评价</div>
          </div>
          
          <div class="rating-distribution">
            <div v-for="n in 5" :key="n" class="rating-bar">
              <span class="star-level">{{ n }}星</span>
              <el-progress 
                :percentage="getRatingPercentage(n)" 
                :stroke-width="14"
                :color="n > 3 ? '#67c23a' : n > 1 ? '#e6a23c' : '#f56c6c'">
              </el-progress>
            </div>
          </div>
        </div>
      </div> -->

      <!-- 添加交互计数器 -->
      <div class="meta-stats">
        <div class="stat-item">
          <el-icon><View /></el-icon>
          <span class="count">{{ detail.views || 0 }}</span>
          <span class="label">浏览量</span>
        </div>
        <div class="stat-item">
          <el-icon><Download /></el-icon>
          <span class="count">{{ detail.downloads || 0 }}</span>
          <span class="label">下载量</span>
        </div>
        <div class="stat-item">
          <el-icon><Star /></el-icon>
          <span class="count">{{ detail.rating || '0.0' }}</span>
          <span class="label">评分</span>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { View, Star, Download, ArrowDown, Document } from '@element-plus/icons-vue'
import { 
  getMaterialDetail, 
  downloadMaterial, 
  applyPlanToClass,
  recordPlanView,
  recordPlanDownload,
  ratePlan
} from '@/api/materials'

const router = useRouter()
const route = useRoute()
const loading = ref(false)
const detail = ref({})
const userRating = ref(0)
const ratingStats = ref({})

// 获取教案详情并记录查看次数
const fetchDetail = async () => {
  try {
    loading.value = true
    const res = await getMaterialDetail(route.params.id)
    console.log('教案详情响应:', res)
    
    if (res.code === 200) {
      detail.value = res.data
      
      // 记录查看次数
      try {
        const viewRes = await recordPlanView(route.params.id)
        console.log('记录查看响应:', viewRes)
        
        // 如果后端返回了更新后的观看数，则更新本地数据
        if (viewRes.code === 200 && viewRes.data && viewRes.data.views !== undefined) {
          detail.value.views = viewRes.data.views
        }
      } catch (viewError) {
        console.error('记录查看失败:', viewError)
        // 即使记录失败，也增加本地计数
        detail.value.views = (detail.value.views || 0) + 1
      }
    } else {
      throw new Error(res.msg || '获取教案详情失败')
    }
  } catch (error) {
    console.error('获取教案详情失败:', error)
    ElMessage.error(error.message || '获取教案详情失败')
    router.push('/materials')
  } finally {
    loading.value = false
  }
}

// 处理评分
const handleRate = async (score) => {
  try {
    loading.value = true
    console.log(`提交评分: ${score}分, 教案ID: ${route.params.id}`)
    const res = await ratePlan(route.params.id, score)
    
    if (res.code === 200) {
      ElMessage.success('评分成功')
      // 更新本地详情数据
      if (res.data) {
        // 直接使用后端返回的最新评分数据
        if (res.data.rating !== undefined) {
          detail.value.rating = res.data.rating
        }
        if (res.data.rateCount !== undefined) {
          detail.value.rateCount = res.data.rateCount
        }
        // 获取评分分布数据
        fetchRatingDistribution()
      }
    } else {
      throw new Error(res.msg || '评分失败')
    }
  } catch (error) {
    console.error('评分失败:', error)
    ElMessage.error(error.message || '评分失败')
    // 评分失败时重置评分
    userRating.value = 0
  } finally {
    loading.value = false
  }
}

// 获取评分分布数据
const fetchRatingDistribution = async () => {
  try {
    // 可以添加新的API方法来获取评分分布数据
    // const res = await getRatingDistribution(route.params.id)
    // if (res.code === 200 && res.data) {
    //   ratingStats.value = res.data
    // }
    
    // 此处仅做模拟数据展示
    ratingStats.value = {
      '5': Math.floor(Math.random() * 100),
      '4': Math.floor(Math.random() * 80),
      '3': Math.floor(Math.random() * 50),
      '2': Math.floor(Math.random() * 20),
      '1': Math.floor(Math.random() * 10)
    }
  } catch (error) {
    console.error('获取评分分布失败:', error)
  }
}

// 计算各星级评分百分比
const getRatingPercentage = (star) => {
  if (!detail.value.rateCount || detail.value.rateCount === 0) {
    return 0
  }
  
  const count = ratingStats.value[star] || 0
  return Math.round((count / detail.value.rateCount) * 100)
}

// 下载教案
const handleDownload = async (fileType) => {
  try {
    loading.value = true;
    
    // 使用完整URL，确保包含协议和主机
    const baseUrl = import.meta.env.VITE_APP_BASE_API;
    const url = `${baseUrl}/system/plan/download?planId=${route.params.id}&fileType=${fileType}`;
    
    // 创建临时链接并触发下载
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', `${detail.value.title || '教案'}.${fileType}`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    
    // 记录下载次数
    try {
      const recordRes = await recordPlanDownload(route.params.id, fileType);
      if (recordRes.code === 200 && recordRes.data) {
        if (recordRes.data.downloads) {
          detail.value.downloads = recordRes.data.downloads;
        } else {
          detail.value.downloads = (detail.value.downloads || 0) + 1;
        }
      }
    } catch (error) {
      console.error('记录下载失败:', error);
      detail.value.downloads = (detail.value.downloads || 0) + 1;
    }
    
    ElMessage.success('下载成功');
  } catch (error) {
    console.error('下载失败:', error);
    ElMessage.error('下载失败，请稍后重试');
  } finally {
    loading.value = false;
  }
}

// 应用到创建课堂
const applyToClass = async () => {
  try {
    loading.value = true
    
    const res = await applyPlanToClass(route.params.id)
    
    if (res.code === 200) {
      ElMessage.success('已应用教案内容')
      // 带着教案数据跳转到创建课堂页面
      router.push({
        path: '/classroom/create',
        query: { planId: route.params.id }
      })
    } else {
      throw new Error(res.msg || '应用教案失败')
    }
  } catch (error) {
    console.error('应用教案失败:', error)
    ElMessage.error(error.message || '应用教案失败')
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

        .action-buttons {
          display: flex;
          gap: 10px;
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

  .rating-section {
    margin-top: 20px;
    
    h3 {
      margin: 0 0 15px;
      padding-left: 10px;
      border-left: 4px solid #95d475;
      color: #333;
    }
    
    .rating-content {
      padding: 15px;
      background: #f8f9fa;
      border-radius: 4px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      
      .current-rating {
        .rating-score {
          font-size: 24px;
          color: #ff9900;
          font-weight: bold;
        }
        
        .rating-count {
          font-size: 14px;
          color: #999;
          margin-left: 5px;
        }
      }
      
      .rate-form {
        display: flex;
        align-items: center;
        gap: 10px;
        
        span {
          font-size: 14px;
          color: #666;
        }
      }
    }
  }

  .rating-stats {
    display: flex;
    align-items: center;
    justify-content: space-between;
    
    .current-rating {
      .rating-number {
        font-size: 24px;
        color: #ff9900;
        font-weight: bold;
      }
      
      .rating-text {
        font-size: 14px;
        color: #999;
        margin-left: 5px;
      }
    }
    
    .rating-distribution {
      display: flex;
      gap: 10px;
      
      .rating-bar {
        .star-level {
          font-size: 14px;
          color: #666;
        }
        
        .el-progress {
          width: 100px;
        }
      }
    }
  }

  .meta-stats {
    display: flex;
    align-items: center;
    justify-content: space-between;
    
    .stat-item {
      display: flex;
      flex-direction: column;
      align-items: center;
      
      .count {
        font-size: 24px;
        color: #333;
        font-weight: bold;
      }
      
      .label {
        font-size: 14px;
        color: #999;
      }
    }
  }
}
</style> 
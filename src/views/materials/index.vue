<template>
  <div class="materials-container">
    <div class="page-header">
      <h2 style="color: #95d475;">精选教案</h2>
      <div class="action-buttons">
        <el-button type="primary" @click="$router.push('/materials/upload')">
          <el-icon><Plus /></el-icon>上传教案
        </el-button>
        <!-- <el-button type="info" @click="$router.push('/materials/statistics')">
          <el-icon><TrendCharts /></el-icon>数据统计
        </el-button> -->
      </div>
    </div>

    <!-- 分类筛选 -->
    <el-card class="filter-card">
      <div class="filter-item">
        <span class="label">运动项目：</span>
        <el-radio-group v-model="filter.sport" @change="handleFilterChange">
          <el-radio-button label="all">全部</el-radio-button>
          <el-radio-button label="篮球">篮球</el-radio-button>
          <el-radio-button label="足球">足球</el-radio-button>
          <el-radio-button label="排球">排球</el-radio-button>
          <el-radio-button label="田径">田径</el-radio-button>
          <el-radio-button label="体操">体操</el-radio-button>
        </el-radio-group>
      </div>
      <!-- <div class="filter-item">
        <span class="label">适用年级：</span>
        <el-radio-group v-model="filter.grade">
          <el-radio-button label="all">全部</el-radio-button>
          <el-radio-button label="primary">大一</el-radio-button>
          <el-radio-button label="junior">大二</el-radio-button>
          <el-radio-button label="senior">大三</el-radio-button>
        </el-radio-group>
      </div> -->
    </el-card>

    <!-- 教案列表 -->
    <div class="materials-grid">
      <el-card 
        v-for="item in materialsList" 
        :key="item.id" 
        class="material-card"
      >
        <div class="material-cover">
          <img :src="item.cover" :alt="item.title">
          <div class="material-tags">
            <el-tag size="small">{{ item.sport }}</el-tag>
            <!-- <el-tag size="small" type="success">{{ item.grade }}</el-tag> -->
          </div>
        </div>
        <div class="material-info">
          <h3>{{ item.title }}</h3>
          <p>{{ item.description }}</p>
          <div class="material-meta">
            <!-- <span><el-icon><View /></el-icon>{{ item.views }}</span>
            <span><el-icon><Star /></el-icon>{{ item.rating }} {{ item.rateCount > 0 ? `(${item.rateCount})` : '' }}</span>
            <span><el-icon><Download /></el-icon>{{ item.downloads }}</span> -->
          </div>
          <div class="material-actions">
            <el-button type="primary" @click="viewMaterial(item)">查看详情</el-button>
            <el-dropdown @command="(type) => handleDownload(type, item.id)">
              <el-button>
                <el-icon><Download /></el-icon>下载
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
        </div>
      </el-card>
    </div>

    <!-- 分页 -->
    <div class="pagination">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :total="total"
        :page-sizes="[12, 24, 36, 48]"
        layout="total, sizes, prev, pager, next"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { View, Star, Download, ArrowDown, Plus, TrendCharts } from '@element-plus/icons-vue'
import { getMaterialsList, downloadMaterial, recordPlanDownload } from '@/api/materials'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

const currentPage = ref(1)
const pageSize = ref(12)
const total = ref(0)
const materialsList = ref([])

const filter = reactive({
  sport: 'all',
  // grade: 'all'
})

const router = useRouter()

// 获取教案列表
const fetchMaterialsList = async () => {
  try {
    const params = {
      pageNum: currentPage.value,
      pageSize: pageSize.value,
      planType: filter.sport !== 'all' ? filter.sport : undefined
    }
    const res = await getMaterialsList(params)
    console.log('教案列表响应:', res)
    if (res.code === 200) {
      // 适配后端返回的数据格式
      if (res.rows) {
        materialsList.value = res.rows.map(item => formatPlanItem(item))
        total.value = res.total || 0
      } else if (res.data && res.data.list) {
        materialsList.value = res.data.list.map(item => formatPlanItem(item))
        total.value = res.data.total || 0
      } else if (res.data) {
        materialsList.value = Array.isArray(res.data) ? res.data.map(item => formatPlanItem(item)) : []
        total.value = res.data.length || 0
      } else {
        materialsList.value = []
        total.value = 0
      }
    } else {
      throw new Error(res.msg || '获取教案列表失败')
    }
  } catch (error) {
    console.error('获取教案列表失败:', error)
    ElMessage.error(error.message || '获取教案列表失败')
  }
}

// 格式化教案数据
const formatPlanItem = (item) => {
  const sportType = item.planType || item.sport || 'default';
  
  let defaultCover = '/src/assets/sports/default.jpg';
  if (sportType === '篮球') {
    defaultCover = '/src/assets/sports/basketball.jpg';
  } else if (sportType === '足球') {
    defaultCover = '/src/assets/sports/football.jpg';
  } else if (sportType === '排球') {
    defaultCover = '/src/assets/sports/volleyball.jpg';
  } else if (sportType === '田径') {
    defaultCover = '/src/assets/sports/track.jpg';
  } else if (sportType === '体操') {
    defaultCover = '/src/assets/sports/gymnastics.jpg';
  }
  
  // 确保数值字段有合适的默认值和类型转换
  const views = item.views !== undefined ? Number(item.views) : (item.peopleCount !== undefined ? Number(item.peopleCount) : 0);
  const downloads = item.downloads !== undefined ? Number(item.downloads) : 0;
  const rating = item.rating !== undefined ? (typeof item.rating === 'number' ? item.rating.toFixed(1) : item.rating) : '0.0';
  const rateCount = item.rateCount !== undefined ? Number(item.rateCount) : 0;
  
  return {
    id: item.planId || item.id || 0,
    title: item.title || item.planName || '',
    description: item.content || item.planDesc || '暂无描述',
    sport: item.planType || 'default',
    cover: item.avatar || item.coverImg || defaultCover, 
    views: views,
    rating: rating,
    rateCount: rateCount,
    downloads: downloads,
    rawData: item
  }
}

// 查看教案详情
const viewMaterial = (material) => {
  const planId = material.id || material.planId;
  console.log('查看教案ID:', planId);
  router.push(`/materials/detail/${planId}`)
}

// 下载教案
const handleDownload = async (fileType, materialId) => {
  try {
    // 使用完整URL
    const baseUrl = import.meta.env.VITE_APP_BASE_API;
    const url = `${baseUrl}/system/plan/download?planId=${materialId}&fileType=${fileType}`;
    
    // 创建临时链接并触发下载
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', `教案.${fileType}`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    
    // 记录下载次数
    try {
      const downloadRes = await recordPlanDownload(materialId, fileType);
      console.log('记录下载结果:', downloadRes);
      
      // 更新本地数据，增加下载计数
      if (downloadRes.code === 200 && downloadRes.data) {
        const updatedMaterial = materialsList.value.find(item => item.id === materialId);
        if (updatedMaterial) {
          updatedMaterial.downloads = downloadRes.data.downloads || (updatedMaterial.downloads + 1);
        }
      }
    } catch (err) {
      console.error('记录下载失败:', err);
    }
    
    ElMessage.success('下载成功');
  } catch (error) {
    console.error('下载失败:', error);
    ElMessage.error('下载失败，请稍后重试');
  }
}

// 分页处理
const handleSizeChange = (val) => {
  pageSize.value = val
  fetchMaterialsList()
}

const handleCurrentChange = (val) => {
  currentPage.value = val
  fetchMaterialsList()
}

// 处理筛选变化
const handleFilterChange = () => {
  currentPage.value = 1  // 重置页码
  fetchMaterialsList()
}

onMounted(() => {
  fetchMaterialsList()
})
</script>

<style lang="scss" scoped>
.materials-container {
  padding: 20px;

  .filter-card {
    margin: 20px 0;

    .filter-item {
      margin-bottom: 15px;

      &:last-child {
        margin-bottom: 0;
      }

      .label {
        margin-right: 10px;
        font-weight: 500;
      }
    }
  }

  .materials-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
    margin: 20px 0;

    .material-card {
      cursor: pointer;
      transition: all 0.3s;

      &:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      }

      .material-cover {
        position: relative;
        height: 160px;
        overflow: hidden;

        img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .material-tags {
          position: absolute;
          top: 10px;
          right: 10px;
          display: flex;
          gap: 5px;
        }
      }

      .material-info {
        padding: 15px;

        h3 {
          margin: 0 0 10px;
          font-size: 16px;
        }

        p {
          margin: 0 0 10px;
          color: #666;
          font-size: 14px;
          display: -webkit-box;
          -webkit-line-clamp: 2;
          line-clamp: 2;
          -webkit-box-orient: vertical;
          overflow: hidden;
        }

        .material-meta {
          display: flex;
          gap: 15px;
          color: #999;
          font-size: 13px;

          span {
            display: flex;
            align-items: center;
            gap: 4px;
          }
        }

        .material-actions {
          display: flex;
          justify-content: space-between;
          margin-top: 15px;
          padding-top: 15px;
          border-top: 1px solid #eee;
        }
      }
    }
  }

  .pagination {
    display: flex;
    justify-content: center;
    margin-top: 30px;
  }

  .page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .action-buttons {
    display: flex;
    gap: 10px;
  }
}
</style> 
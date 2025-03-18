<template>
  <div class="materials-container">
    <h2 style="color: #95d475;">精选教案</h2>

    <!-- 分类筛选 -->
    <el-card class="filter-card">
      <div class="filter-item">
        <span class="label">运动项目：</span>
        <el-radio-group v-model="filter.sport">
          <el-radio-button label="all">全部</el-radio-button>
          <el-radio-button label="basketball">篮球</el-radio-button>
          <el-radio-button label="football">足球</el-radio-button>
          <el-radio-button label="volleyball">排球</el-radio-button>
          <el-radio-button label="athletics">田径</el-radio-button>
        </el-radio-group>
      </div>
      <div class="filter-item">
        <span class="label">适用年级：</span>
        <el-radio-group v-model="filter.grade">
          <el-radio-button label="all">全部</el-radio-button>
          <el-radio-button label="primary">大一</el-radio-button>
          <el-radio-button label="junior">大二</el-radio-button>
          <el-radio-button label="senior">大三</el-radio-button>
        </el-radio-group>
      </div>
    </el-card>

    <!-- 教案列表 -->
    <div class="materials-grid">
      <el-card 
        v-for="item in materialsList" 
        :key="item.id" 
        class="material-card"
        @click="viewMaterial(item)"
      >
        <div class="material-cover">
          <img :src="item.cover" :alt="item.title">
          <div class="material-tags">
            <el-tag size="small">{{ item.sport }}</el-tag>
            <el-tag size="small" type="success">{{ item.grade }}</el-tag>
          </div>
        </div>
        <div class="material-info">
          <h3>{{ item.title }}</h3>
          <p>{{ item.description }}</p>
          <div class="material-meta">
            <span><el-icon><View /></el-icon>{{ item.views }}</span>
            <span><el-icon><Star /></el-icon>{{ item.rating }}</span>
            <span><el-icon><Download /></el-icon>{{ item.downloads }}</span>
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
import { View, Star, Download } from '@element-plus/icons-vue'
import { getMaterialsList } from '@/api/materials'

const currentPage = ref(1)
const pageSize = ref(12)
const total = ref(0)
const materialsList = ref([])

const filter = reactive({
  sport: 'all',
  grade: 'all'
})

// 获取教案列表
const fetchMaterialsList = async () => {
  try {
    const params = {
      page: currentPage.value,
      pageSize: pageSize.value,
      ...filter
    }
    const res = await getMaterialsList(params)
    materialsList.value = res.data.list
    total.value = res.data.total
  } catch (error) {
    ElMessage.error('获取教案列表失败')
  }
}

// 查看教案详情
const viewMaterial = (material) => {
  // TODO: 实现查看详情逻辑
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
      }
    }
  }

  .pagination {
    display: flex;
    justify-content: center;
    margin-top: 30px;
  }
}
</style> 
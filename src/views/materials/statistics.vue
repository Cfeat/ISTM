<template>
    <div class="statistics-container">
      <el-card>
        <h2>教案统计信息</h2>
        
        <!-- 总览数据 -->
        <div class="overview-stats">
          <el-row :gutter="20">
            <el-col :span="6">
              <el-card shadow="hover" class="stat-card">
                <div class="stat-title">总教案数</div>
                <div class="stat-value">{{ totalStats.count }}</div>
                <div class="stat-chart">
                  <el-progress :percentage="100" :show-text="false" stroke-width="8"></el-progress>
                </div>
              </el-card>
            </el-col>
            <el-col :span="6">
              <el-card shadow="hover" class="stat-card">
                <div class="stat-title">总浏览量</div>
                <div class="stat-value">{{ totalStats.views }}</div>
                <div class="stat-chart">
                  <el-progress :percentage="getPercentage(totalStats.views, 10000)" :show-text="false" stroke-width="8" color="#67c23a"></el-progress>
                </div>
              </el-card>
            </el-col>
            <el-col :span="6">
              <el-card shadow="hover" class="stat-card">
                <div class="stat-title">总下载量</div>
                <div class="stat-value">{{ totalStats.downloads }}</div>
                <div class="stat-chart">
                  <el-progress :percentage="getPercentage(totalStats.downloads, 5000)" :show-text="false" stroke-width="8" color="#e6a23c"></el-progress>
                </div>
              </el-card>
            </el-col>
            <el-col :span="6">
              <el-card shadow="hover" class="stat-card">
                <div class="stat-title">平均评分</div>
                <div class="stat-value">{{ totalStats.avgRating.toFixed(1) }}</div>
                <div class="stat-chart">
                  <el-rate v-model="totalStats.avgRating" disabled show-score text-color="#ff9900"></el-rate>
                </div>
              </el-card>
            </el-col>
          </el-row>
        </div>
        
        <!-- 分类统计 -->
        <el-divider content-position="left">按类型统计</el-divider>
        
        <div class="chart-container">
          <div class="chart" ref="typeChartRef"></div>
        </div>
        
        <!-- 热门教案 -->
        <el-divider content-position="left">热门教案Top 5</el-divider>
        
        <el-table :data="hotPlans" style="width: 100%">
          <el-table-column prop="title" label="教案名称" width="250"></el-table-column>
          <el-table-column prop="planType" label="类型" width="100"></el-table-column>
          <el-table-column prop="views" label="浏览量" width="100"></el-table-column>
          <el-table-column prop="downloads" label="下载量" width="100"></el-table-column>
          <el-table-column prop="rating" label="评分" width="180">
            <template #default="scope">
              <el-rate v-model="scope.row.rating" disabled show-score text-color="#ff9900"></el-rate>
            </template>
          </el-table-column>
          <el-table-column label="操作">
            <template #default="scope">
              <el-button link type="primary" size="small" @click="viewPlan(scope.row)">查看</el-button>
            </template>
          </el-table-column>
        </el-table>
        
        <!-- Top Materials By Views -->
        <el-col :span="8">
          <el-card class="stat-card">
            <template #header>
              <div class="card-header">
                <h3><el-icon><View /></el-icon> 最受欢迎教案 (浏览量)</h3>
              </div>
            </template>
            <div class="rank-list">
              <div v-for="(item, index) in topByViews" :key="item.id" class="rank-item">
                <span class="rank" :class="{ 'top-rank': index < 3 }">{{ index + 1 }}</span>
                <span class="name">{{ item.title }}</span>
                <span class="value">{{ item.views }} 次</span>
              </div>
            </div>
          </el-card>
        </el-col>
        
        <!-- Top Materials By Downloads -->
        <el-col :span="8">
          <el-card class="stat-card">
            <template #header>
              <div class="card-header">
                <h3><el-icon><Download /></el-icon> 下载量排行榜</h3>
              </div>
            </template>
            <div class="rank-list">
              <div v-for="(item, index) in topByDownloads" :key="item.id" class="rank-item">
                <span class="rank" :class="{ 'top-rank': index < 3 }">{{ index + 1 }}</span>
                <span class="name">{{ item.title }}</span>
                <span class="value">{{ item.downloads }} 次</span>
              </div>
            </div>
          </el-card>
        </el-col>
        
        <!-- Top Materials By Rating -->
        <el-col :span="8">
          <el-card class="stat-card">
            <template #header>
              <div class="card-header">
                <h3><el-icon><Star /></el-icon> 评分排行榜</h3>
              </div>
            </template>
            <div class="rank-list">
              <div v-for="(item, index) in topByRating" :key="item.id" class="rank-item">
                <span class="rank" :class="{ 'top-rank': index < 3 }">{{ index + 1 }}</span>
                <span class="name">{{ item.title }}</span>
                <span class="value">
                  {{ item.rating }} <span class="sub-text">({{ item.rateCount }}人评)</span>
                </span>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-card>
    </div>
  </template>
  
  <script setup>
  import { ref, reactive, onMounted } from 'vue';
  import { useRouter } from 'vue-router';
  import * as echarts from 'echarts';
  import { getMaterialsList } from '@/api/materials';
  import { ElMessage } from 'element-plus';
  import { View, Download, Star } from '@element-plus/icons-vue';
  
  const router = useRouter();
  const typeChartRef = ref(null);
  let typeChart = null;
  
  // 总体统计数据
  const totalStats = reactive({
    count: 0,
    views: 0,
    downloads: 0,
    avgRating: 0
  });
  
  // 热门教案列表
  const hotPlans = ref([]);
  const loading = ref(false);
  const topByViews = ref([]);
  const topByDownloads = ref([]);
  const topByRating = ref([]);
  const summaryStats = ref({
    totalMaterials: 0,
    totalViews: 0,
    totalDownloads: 0,
    ratedCount: 0,
    avgViewsPerMaterial: 0,
    avgDownloadsPerMaterial: 0
  });
  const typeDistribution = ref({});
  
  // 获取教案数据和统计信息
  const fetchStatistics = async () => {
    try {
      loading.value = true
      const params = { pageSize: 100 } // 获取更多数据用于统计
      const res = await getMaterialsList(params)
      
      if (res.code === 200) {
        let materials = []
        
        // 适配不同的后端响应格式
        if (res.rows) {
          materials = res.rows
        } else if (res.data && res.data.list) {
          materials = res.data.list
        } else if (res.data && Array.isArray(res.data)) {
          materials = res.data
        }
        
        // 格式化数据
        materials = materials.map(item => ({
          id: item.planId || item.id,
          title: item.title || '',
          views: item.views || item.peopleCount || 0,
          downloads: item.downloads || 0,
          rating: item.rating || 0,
          rateCount: item.rateCount || 0,
          planType: item.planType || ''
        }))
        
        // 排序数据
        topByViews.value = [...materials].sort((a, b) => b.views - a.views).slice(0, 10)
        topByDownloads.value = [...materials].sort((a, b) => b.downloads - a.downloads).slice(0, 10)
        topByRating.value = [...materials]
          .filter(item => item.rateCount > 0) // 只包括有评分的教案
          .sort((a, b) => b.rating - a.rating)
          .slice(0, 10)
        
        // 计算各类型教案数量
        typeDistribution.value = materials.reduce((acc, item) => {
          const type = item.planType || '其他'
          acc[type] = (acc[type] || 0) + 1
          return acc
        }, {})
        
        // 计算总浏览、下载、评分统计
        const totalViews = materials.reduce((sum, item) => sum + (item.views || 0), 0)
        const totalDownloads = materials.reduce((sum, item) => sum + (item.downloads || 0), 0)
        const ratedCount = materials.filter(item => item.rateCount > 0).length
        
        summaryStats.value = {
          totalMaterials: materials.length,
          totalViews,
          totalDownloads,
          ratedCount,
          avgViewsPerMaterial: materials.length ? (totalViews / materials.length).toFixed(1) : 0,
          avgDownloadsPerMaterial: materials.length ? (totalDownloads / materials.length).toFixed(1) : 0
        }
        
      } else {
        throw new Error(res.msg || '获取数据失败')
      }
    } catch (error) {
      console.error('获取统计数据失败:', error)
      ElMessage.error(error.message || '获取统计数据失败')
    } finally {
      loading.value = false
    }
  }
  
  // 计算百分比，用于进度条
  const getPercentage = (value, maxValue) => {
    return Math.min(Math.round((value / maxValue) * 100), 100);
  };
  
  // 初始化所有图表
  const initCharts = () => {
    if (typeChartRef.value) {
      // 初始化类型分布图表
      typeChart = echarts.init(typeChartRef.value);
      const defaultData = [
        { name: '篮球', value: 10 },
        { name: '足球', value: 8 },
        { name: '排球', value: 6 },
        { name: '田径', value: 4 },
        { name: '体操', value: 3 }
      ];
      
      const option = {
        title: {
          text: '各类型教案统计',
          left: 'center'
        },
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}: {c} ({d}%)'
        },
        legend: {
          orient: 'horizontal',
          bottom: 10,
          data: defaultData.map(item => item.name)
        },
        series: [
          {
            name: '教案类型',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: '#fff',
              borderWidth: 2
            },
            label: {
              show: false,
              position: 'center'
            },
            emphasis: {
              label: {
                show: true,
                fontSize: '18',
                fontWeight: 'bold'
              }
            },
            labelLine: {
              show: false
            },
            data: defaultData
          }
        ]
      };
      
      typeChart.setOption(option);
      
      // 响应式调整
      window.addEventListener('resize', () => {
        typeChart && typeChart.resize();
      });
    }
  }
  
  // 获取教案列表并统计
  const fetchMaterialsData = async () => {
    try {
      const res = await getMaterialsList({ pageSize: 100 }); // 获取足够多的数据进行统计
      
      if (res.code === 200 && res.rows) {
        const data = res.rows;
        
        // 计算总体统计
        totalStats.count = data.length;
        totalStats.views = data.reduce((sum, item) => sum + (item.views || 0), 0);
        totalStats.downloads = data.reduce((sum, item) => sum + (item.downloads || 0), 0);
        
        const totalRating = data.reduce((sum, item) => {
          return sum + (item.rating || 0) * (item.rateCount || 1);
        }, 0);
        const totalRateCount = data.reduce((sum, item) => sum + (item.rateCount || 1), 0);
        totalStats.avgRating = totalRating / (totalRateCount || 1);
        
        // 统计各类型数量
        const typeStats = {};
        data.forEach(item => {
          const type = item.planType || '未分类';
          if (!typeStats[type]) {
            typeStats[type] = 0;
          }
          typeStats[type]++;
        });
        
        // 转换为图表数据格式
        const chartData = Object.keys(typeStats).map(key => ({
          name: key,
          value: typeStats[key]
        }));
        
        // 初始化图表
        initTypeChart(chartData);
        
        // 热门教案Top 5（按浏览量排序）
        hotPlans.value = [...data]
          .sort((a, b) => (b.views || 0) - (a.views || 0))
          .slice(0, 5);
      }
    } catch (error) {
      console.error('获取教案统计数据失败:', error);
    }
  };
  
  // 查看教案详情
  const viewPlan = (plan) => {
    router.push(`/materials/detail/${plan.planId}`);
  };
  
  onMounted(() => {
    fetchStatistics();
    initCharts();
  });
  </script>
  
  <style scoped>
  .statistics-container {
    padding: 20px;
  }
  
  .overview-stats {
    margin: 30px 0;
  }
  
  .stat-card {
    text-align: center;
    padding: 10px;
    height: 160px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }
  
  .stat-title {
    font-size: 16px;
    color: #606266;
  }
  
  .stat-value {
    font-size: 30px;
    font-weight: bold;
    color: #303133;
    margin: 15px 0;
  }
  
  .chart-container {
    margin: 30px 0;
  }
  
  .chart {
    height: 400px;
    width: 100%;
  }
  </style>
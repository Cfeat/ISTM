<template>
  <div class="history-container">
    <!-- 导航选项 -->
    <div class="nav-tabs">
      <div 
        v-for="tab in tabs" 
        :key="tab.key"
        :class="['tab-item', { active: activeTab === tab.key }]"
        @click="handleTabClick(tab.key)"
      >
        {{ tab.label }}
      </div>
    </div>

    <!-- 根据activeTab显示不同内容 -->
    <div v-if="activeTab === 'statistics'" class="statistics-content">
      <!-- 统计数据卡片 -->
      <div class="statistics-cards">
        <div class="stat-card">
          <h3>总计创建教案数</h3>
          <div class="number">7</div>
          <div class="icon-wrapper green">
            <el-icon><Document /></el-icon>
          </div>
        </div>
        <div class="stat-card">
          <h3>总计创建AI课堂数</h3>
          <div class="number">5</div>
          <div class="icon-wrapper blue">
            <el-icon><Monitor /></el-icon>
          </div>
        </div>
        <div class="stat-card">
          <h3>总计学生数</h3>
          <div class="number">230</div>
          <div class="icon-wrapper orange">
            <el-icon><User /></el-icon>
          </div>
        </div>
        <div class="stat-card">
          <h3>总计教学时长</h3>
          <div class="number">~5h</div>
          <div class="icon-wrapper purple">
            <el-icon><Timer /></el-icon>
          </div>
        </div>
      </div>

      <!-- 错误类型分析 -->
      <div class="analysis-section">
        <div class="chart-container">
          <h3>易错类型占比</h3>
          <div class="time-filter">
            <el-radio-group v-model="timeRange" size="small">
              <el-radio-button label="day">近三天</el-radio-button>
              <el-radio-button label="month">近一月</el-radio-button>
              <el-radio-button label="year">近一年</el-radio-button>
            </el-radio-group>
          </div>
          <div class="pie-chart">
            <!-- 这里需要引入echarts实现饼图 -->
          </div>
          <div class="legend">
            <div class="legend-item">
              <span class="dot blue"></span>
              <span>技术性错误 40%</span>
            </div>
            <div class="legend-item">
              <span class="dot green"></span>
              <span>规则性错误 35%</span>
            </div>
            <div class="legend-item">
              <span class="dot purple"></span>
              <span>心理性错误 25%</span>
            </div>
          </div>
        </div>

        <!-- 趋势图表 -->
        <div class="chart-container">
          <h3>成功解决问题比例</h3>
          <div class="line-chart">
            <!-- 这里需要引入echarts实现折线图 -->
          </div>
        </div>
      </div>
    </div>

    <!-- 教案管理内容 -->
    <teaching-management v-if="activeTab === 'plans'" />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Document, Monitor, User, Timer } from '@element-plus/icons-vue'
import TeachingManagement from '../teaching/management.vue'

const tabs = [
  { key: 'statistics', label: '课堂统计可视化' },
  { key: 'plans', label: '全部教案' },
  { key: 'created', label: '已创建AI课堂' },
  { key: 'types', label: '课程类型筛选' }
]

const activeTab = ref('statistics')
const timeRange = ref('month')

const handleTabClick = (tabKey) => {
  activeTab.value = tabKey
}
</script>

<style lang="scss" scoped>
.history-container {
  min-height: calc(100vh - 50px); // 减去导航栏高度
  margin-top: -10px;
  padding: 20px;
  background-color: #f0f2f5; // 设置背景色

  .nav-tabs {
    display: flex;
    margin-bottom: 24px;
    background: #fff;
    border-radius: 8px;
    padding: 4px;

    .tab-item {
      flex: 1;
      text-align: center;
      padding: 12px;
      cursor: pointer;
      border-radius: 4px;
      transition: all 0.3s;

      &.active {
        background: #95d475;
        color: white;
      }

      &:hover:not(.active) {
        background: #f0f9eb;
      }
    }
  }

  .statistics-cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    margin-bottom: 24px;

    .stat-card {
      background: white;
      padding: 20px;
      border-radius: 8px;
      position: relative;
      overflow: hidden;

      h3 {
        color: #666;
        font-size: 14px;
        margin: 0 0 12px 0;
      }

      .number {
        font-size: 28px;
        font-weight: bold;
        color: #333;
      }

      .icon-wrapper {
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        width: 48px;
        height: 48px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0.2;

        &.green { background: #95d475; }
        &.blue { background: #409eff; }
        &.orange { background: #e6a23c; }
        &.purple { background: #909399; }

        .el-icon {
          font-size: 24px;
          color: white;
        }
      }
    }
  }

  .analysis-section {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 20px;

    .chart-container {
      background: white;
      padding: 20px;
      border-radius: 8px;

      h3 {
        margin: 0 0 20px 0;
        color: #333;
      }

      .time-filter {
        margin-bottom: 20px;
      }

      .legend {
        margin-top: 20px;

        .legend-item {
          display: flex;
          align-items: center;
          margin-bottom: 8px;

          .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            margin-right: 8px;

            &.blue { background: #409eff; }
            &.green { background: #95d475; }
            &.purple { background: #909399; }
          }
        }
      }
    }
  }

  .statistics-content {
    // 为统计内容添加样式
  }

  // 确保教案管理内容正确显示
  :deep(.teaching-container) {
    background: transparent;
    margin: 0;
    
    .teaching-card {
      background: #fff;
    }
  }

  // 确保统计卡片和图表有白色背景
  .statistics-cards .stat-card,
  .analysis-section .chart-container {
    background: #fff;
  }
}
</style> 
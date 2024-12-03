<template>
  <div class="dashboard-container">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card shadow="hover" class="dashboard-card">
          <template #header>
            <div class="card-header">
              <span>教学课程</span>
              <el-tag type="success">进行中</el-tag>
            </div>
          </template>
          <div class="card-content">
            <h2>12</h2>
            <p>当前进行中的课程数量</p>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="6">
        <el-card shadow="hover" class="dashboard-card">
          <template #header>
            <div class="card-header">
              <span>学生人数</span>
              <el-tag type="primary">总计</el-tag>
            </div>
          </template>
          <div class="card-content">
            <h2>256</h2>
            <p>注册学生总人数</p>
          </div>
        </el-card>
      </el-col>

      <el-col :span="6">
        <el-card shadow="hover" class="dashboard-card">
          <template #header>
            <div class="card-header">
              <span>教师人数</span>
              <el-tag type="warning">总计</el-tag>
            </div>
          </template>
          <div class="card-content">
            <h2>18</h2>
            <p>注册教师总人数</p>
          </div>
        </el-card>
      </el-col>

      <el-col :span="6">
        <el-card shadow="hover" class="dashboard-card">
          <template #header>
            <div class="card-header">
              <span>课程完成率</span>
              <el-tag type="info">统计</el-tag>
            </div>
          </template>
          <div class="card-content">
            <h2>85%</h2>
            <p>课程平均完成率</p>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="mt-4">
      <el-col :span="12">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>最近课程</span>
            </div>
          </template>
          <el-table :data="recentCourses" stripe>
            <el-table-column prop="name" label="课程名称" />
            <el-table-column prop="teacher" label="教师" />
            <el-table-column prop="time" label="时间" />
            <el-table-column prop="status" label="状态">
              <template #default="scope">
                <el-tag :type="scope.row.status === '进行中' ? 'success' : 'info'">
                  {{ scope.row.status }}
                </el-tag>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
      
      <el-col :span="12">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>系统公告</span>
            </div>
          </template>
          <el-timeline>
            <el-timeline-item
              v-for="(notice, index) in notices"
              :key="index"
              :timestamp="notice.time"
              :type="notice.type"
            >
              {{ notice.content }}
            </el-timeline-item>
          </el-timeline>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const recentCourses = ref([
  {
    name: '体育教学基础',
    teacher: '张老师',
    time: '2024-03-20 14:00',
    status: '进行中'
  },
  {
    name: '篮球训练课程',
    teacher: '李老师',
    time: '2024-03-21 09:00',
    status: '未开始'
  },
  {
    name: '游泳基础教学',
    teacher: '王老师',
    time: '2024-03-19 16:00',
    status: '已结束'
  }
])

const notices = ref([
  {
    content: '系统更新维护通知：将于本周六凌晨2点进行系统升级',
    time: '2024-03-19 10:00',
    type: 'warning'
  },
  {
    content: '新功能上线：教学评估模块已正式启用',
    time: '2024-03-18 14:30',
    type: 'success'
  },
  {
    content: '关于开展2024年春季教学工作的通知',
    time: '2024-03-17 09:00',
    type: 'info'
  }
])
</script>

<style lang="scss" scoped>
.dashboard-container {
  padding: 20px;
  
  .dashboard-card {
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      
      span {
        font-size: 16px;
        font-weight: 500;
      }
    }
    
    .card-content {
      text-align: center;
      padding: 20px 0;
      
      h2 {
        font-size: 28px;
        margin: 10px 0;
        color: var(--el-color-primary);
      }
      
      p {
        color: #666;
        font-size: 14px;
        margin: 0;
      }
    }
  }
  
  .mt-4 {
    margin-top: 20px;
  }

  .el-card {
    margin-bottom: 20px;
  }

  .el-timeline {
    padding: 20px;
  }
}
</style>

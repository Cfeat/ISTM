<template>
  <div class="classroom-detail">
    <div class="detail-header">
      <h2 style="color: #95d475;">AI课堂详情</h2>
      <el-button @click="goBack">返回列表</el-button>
    </div>

    <el-card class="detail-content" v-loading="loading">
      <!-- 基本信息 -->
      <div class="section">
        <h3>基本信息</h3>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="课程名称">{{ detail.name }}</el-descriptions-item>
          <el-descriptions-item label="课程类型">{{ getCourseTypeLabel(detail.type) }}</el-descriptions-item>
          <el-descriptions-item label="学生数量">{{ detail.studentCount }}人</el-descriptions-item>
          <el-descriptions-item label="教学时长">{{ detail.duration }}分钟</el-descriptions-item>
        </el-descriptions>
      </div>

      <!-- 教学设置 -->
      <div class="section">
        <h3>教学设置</h3>
        <el-descriptions :column="3" border>
          <el-descriptions-item label="男女比例">{{ detail.genderRatio }}%</el-descriptions-item>
          <el-descriptions-item label="错误率">{{ detail.errorRate }}%</el-descriptions-item>
          <el-descriptions-item label="响应时间">{{ detail.responseTime }}秒</el-descriptions-item>
        </el-descriptions>
      </div>

      <!-- 教学目标 -->
      <div class="section">
        <h3>教学目标</h3>
        <div class="content-box">{{ detail.description || '暂无教学目标' }}</div>
      </div>

      <!-- 教学过程 -->
      <div class="section">
        <h3>教学过程</h3>
        <div class="content-box">{{ detail.plan || '暂无教学过程' }}</div>
      </div>

      <!-- 操作按钮 -->
      <div class="action-buttons">
        <el-button type="primary" style="background-color: #95d475; border-color: #95d475;" @click="startClass">
          开始上课
        </el-button>
        <el-button type="primary" plain @click="editClass">编辑课堂</el-button>
        <el-button type="danger" plain @click="deleteClass">删除课堂</el-button>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getClassroom, delClassroom, startClassroom } from '@/api/system/classroom'

const router = useRouter()
const route = useRoute()
const loading = ref(false)
const detail = ref({})

const courseTypeMap = {
  '0': '普通课程',
  '1': '足球课程',
  '2': '武术课程',
  '3': '体操课程',
  '4': '康复课程',
  '5': '篮球课程',
  '6': '田径课程',
  '7': '排球课程'
}

const getCourseTypeLabel = (type) => {
  return courseTypeMap[type] || type
}

// 获取课堂详情
const fetchDetail = async () => {
  try {
    loading.value = true
    console.log('获取课堂详情，ID:', route.params.id)
    const res = await getClassroom(route.params.id)
    console.log('课堂详情响应:', res)
    
    if (res.code === 200 && res.data) {
      // 适配RuoYi返回的数据格式
      const data = res.data;
      detail.value = {
        id: data.classId,
        name: data.className,
        type: data.classType,
        // 从后端正确的字段读取数据，并提供多重备选
        description: data.classPurpose || data.remark || '',
        plan: data.classProcess || '',
        createTime: data.createTime,
        teacherName: data.teacherName || '未设置',
        studentCount: data.studentCount || 0,
        status: data.status || 0,
        duration: data.duration || 45,
        genderRatio: data.genderRatio || 50,
        errorRate: data.errorRate || 20,
        responseTime: data.responseTime || 3
      }
      console.log('处理后的详情数据:', detail.value)
    } else {
      throw new Error(res.msg || '获取数据失败')
    }
  } catch (error) {
    console.error('获取课堂详情失败:', error)
    ElMessage.error(error.message || '获取课堂详情失败')
    router.push('/classroom/list')
  } finally {
    loading.value = false
  }
}

// 返回列表
const goBack = () => {
  router.push('/classroom/list')
}

// 开始上课
const startClass = async () => {
  try {
    const res = await startClassroom(route.params.id)
    if (res.code === 200) {
      ElMessage.success('课堂开始')
      router.push(`/classroom/room/${route.params.id}`)
    } else {
      throw new Error(res.message)
    }
  } catch (error) {
    ElMessage.error(error.message || '开始上课失败')
  }
}

// 编辑课堂
const editClass = () => {
  router.push(`/classroom/edit/${route.params.id}`)
}

// 删除课堂
const deleteClass = async () => {
  try {
    await ElMessageBox.confirm('确定要删除该课堂吗？删除后将无法恢复', '警告', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await delClassroom(route.params.id)
    ElMessage.success('删除成功')
    router.push('/classroom/list')
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

onMounted(() => {
  fetchDetail()
})
</script>

<style lang="scss" scoped>
.classroom-detail {
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
      }
    }

    .action-buttons {
      display: flex;
      justify-content: center;
      gap: 20px;
      margin-top: 40px;
    }
  }

  :deep(.el-descriptions) {
    margin-bottom: 20px;

    .el-descriptions__label {
      width: 120px;
      justify-content: flex-end;
      padding-right: 15px;
    }
  }
}
</style> 
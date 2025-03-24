<template>
  <div class="classroom-edit">
    <div class="edit-header">
      <h2 style="color: #95d475;">编辑课堂</h2>
      <el-button @click="goBack">返回</el-button>
    </div>

    <el-card class="edit-content" v-loading="loading">
      <el-form 
        ref="formRef"
        :model="formData"
        :rules="rules"
        label-width="120px"
      >
        <!-- 基本信息 -->
        <div class="section">
          <h3>基本信息</h3>
          <el-form-item label="课程名称" prop="courseName">
            <el-input v-model="formData.courseName" placeholder="请输入课程名称" />
          </el-form-item>
          <el-form-item label="课程类型" prop="courseType">
            <el-select v-model="formData.courseType" placeholder="请选择课程类型">
              <el-option 
                v-for="type in courseTypes" 
                :key="type.value"
                :label="type.label"
                :value="type.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="学生数量" prop="studentCount">
            <el-input-number v-model="formData.studentCount" :min="1" :max="100" />
          </el-form-item>
          <el-form-item label="教学时长" prop="duration">
            <el-input-number v-model="formData.duration" :min="1" :max="120" />
            <span class="unit">分钟</span>
          </el-form-item>
        </div>

        <!-- 教学设置 -->
        <div class="section">
          <h3>教学设置</h3>
          <el-form-item label="男女比例" prop="genderRatio">
            <el-input-number v-model="formData.genderRatio" :min="0" :max="100" />
            <span class="unit">%</span>
          </el-form-item>
          <el-form-item label="错误率" prop="errorRate">
            <el-input-number v-model="formData.errorRate" :min="0" :max="100" />
            <span class="unit">%</span>
          </el-form-item>
          <el-form-item label="响应时间" prop="responseTime">
            <el-input-number v-model="formData.responseTime" :min="1" :max="10" />
            <span class="unit">秒</span>
          </el-form-item>
        </div>

        <!-- 教学目标 -->
        <div class="section">
          <h3>教学目标</h3>
          <el-form-item prop="teachingGoals">
            <el-input 
              v-model="formData.teachingGoals"
              type="textarea"
              :rows="4"
              placeholder="请输入教学目标"
            />
          </el-form-item>
        </div>

        <!-- 教学过程 -->
        <div class="section">
          <h3>教学过程</h3>
          <el-form-item prop="teachingProcess">
            <el-input
              v-model="formData.teachingProcess"
              type="textarea"
              :rows="6"
              placeholder="请输入教学过程"
            />
          </el-form-item>
        </div>

        <!-- 操作按钮 -->
        <div class="action-buttons">
          <el-button type="primary" @click="handleSubmit">保存</el-button>
          <el-button @click="goBack">取消</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getClassroomDetail, updateClassroom } from '@/api/classroom'

const router = useRouter()
const route = useRoute()
const formRef = ref(null)
const loading = ref(false)

// 课程类型选项
const courseTypes = [
  { value: 'basketball', label: '篮球课程' },
  { value: 'football', label: '足球课程' },
  { value: 'volleyball', label: '排球课程' },
  { value: 'athletics', label: '田径课程' },
  { value: 'gymnastics', label: '体操课程' }
]

// 表单数据
const formData = reactive({
  courseName: '',
  courseType: '',
  studentCount: 30,
  duration: 45,
  genderRatio: 50,
  errorRate: 20,
  responseTime: 3,
  teachingGoals: '',
  teachingProcess: ''
})

// 表单验证规则
const rules = {
  courseName: [{ required: true, message: '请输入课程名称', trigger: 'blur' }],
  courseType: [{ required: true, message: '请选择课程类型', trigger: 'change' }],
  studentCount: [{ required: true, message: '请输入学生数量', trigger: 'blur' }],
  duration: [{ required: true, message: '请输入教学时长', trigger: 'blur' }],
  teachingGoals: [{ required: true, message: '请输入教学目标', trigger: 'blur' }],
  teachingProcess: [{ required: true, message: '请输入教学过程', trigger: 'blur' }]
}

// 获取课堂详情
const fetchDetail = async () => {
  try {
    loading.value = true
    const res = await getClassroomDetail(route.params.id)
    if (res.code === 200 && res.data) {
      // 将获取到的数据填充到表单中
      Object.assign(formData, res.data)
    } else {
      throw new Error(res.message || '获取课堂详情失败')
    }
  } catch (error) {
    console.error('获取详情失败:', error)
    ElMessage.error(error.message || '获取课堂详情失败')
    router.push('/classroom/list')
  } finally {
    loading.value = false
  }
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    loading.value = true
    
    const submitData = {
      id: route.params.id,
      courseName: formData.courseName,
      courseType: formData.courseType,
      studentCount: Number(formData.studentCount),
      duration: Number(formData.duration),
      genderRatio: Number(formData.genderRatio),
      errorRate: Number(formData.errorRate),
      responseTime: Number(formData.responseTime),
      teachingGoals: formData.teachingGoals,
      teachingProcess: formData.teachingProcess
    }

    const res = await updateClassroom(route.params.id, submitData)
    if (res.code === 200) {
      ElMessage.success('保存成功')
      router.push('/classroom/list')
    } else {
      throw new Error(res.message || '保存失败')
    }
  } catch (error) {
    console.error('保存失败:', error)
    ElMessage.error(error.message || '保存失败')
  } finally {
    loading.value = false
  }
}

// 返回
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
.classroom-edit {
  padding: 20px;

  .edit-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;

    h2 {
      margin: 0;
    }
  }

  .edit-content {
    .section {
      margin-bottom: 30px;

      h3 {
        margin: 0 0 15px;
        padding-left: 10px;
        border-left: 4px solid #95d475;
        color: #333;
      }
    }

    .unit {
      margin-left: 8px;
      color: #666;
    }

    .action-buttons {
      display: flex;
      justify-content: center;
      gap: 20px;
      margin-top: 40px;
    }
  }

  :deep(.el-form-item) {
    margin-bottom: 22px;
  }
}
</style>
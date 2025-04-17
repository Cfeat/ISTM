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
          <el-form-item label="课程名称" prop="className">
            <el-input v-model="formData.className" placeholder="请输入课程名称" />
          </el-form-item>
          <el-form-item label="课程类型" prop="classType">
            <el-select v-model="formData.classType" placeholder="请选择课程类型">
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
          <el-form-item prop="classDesc">
            <el-input 
              v-model="formData.classDesc"
              type="textarea"
              :rows="4"
              placeholder="请输入教学目标"
            />
          </el-form-item>
        </div>

        <!-- 教学过程 -->
        <div class="section">
          <h3>教学过程</h3>
          <el-form-item prop="planInfo">
            <el-input
              v-model="formData.planInfo"
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
import { getClassroom, updateClassroom, getCourseTypes } from '@/api/system/classroom'

const router = useRouter()
const route = useRoute()
const formRef = ref(null)
const loading = ref(false)
const courseTypes = ref([])

// 表单数据
const formData = reactive({
  classId: '',
  className: '',
  classType: '',
  studentCount: 30,
  duration: 45,
  genderRatio: 50,
  errorRate: 20,
  responseTime: 3,
  classDesc: '',
  planInfo: ''
})

// 表单验证规则
const rules = {
  className: [{ required: true, message: '请输入课程名称', trigger: 'blur' }],
  classType: [{ required: true, message: '请选择课程类型', trigger: 'change' }],
  studentCount: [{ required: true, message: '请输入学生数量', trigger: 'blur' }],
  duration: [{ required: true, message: '请输入教学时长', trigger: 'blur' }],
  classDesc: [{ required: true, message: '请输入教学目标', trigger: 'blur' }],
  planInfo: [{ required: true, message: '请输入教学过程', trigger: 'blur' }]
}

// 获取课程类型列表
const fetchCourseTypes = async () => {
  try {
    const res = await getCourseTypes()
    console.log('课程类型响应:', res)
    if (res.code === 200 && res.data) {
      // 将RuoYi数据字典格式转换为前端需要的格式
      courseTypes.value = res.data.map(item => ({
        value: item.dictValue,
        label: item.dictLabel
      }))
    } else {
      throw new Error(res.msg || '获取数据失败')
    }
  } catch (error) {
    console.error('获取课程类型失败:', error)
    ElMessage.error('获取课程类型失败')
  }
}

// 获取课堂详情
const fetchDetail = async () => {
  try {
    loading.value = true
    const res = await getClassroom(route.params.id)
    console.log('课堂详情响应:', res)
    
    if (res.code === 200 && res.data) {
      // 适配RuoYi后端数据格式
      const data = res.data;
      formData.classId = data.classId || route.params.id;
      formData.className = data.className || '';
      formData.classType = data.classType || '';
      formData.studentCount = data.studentCount || 30;
      formData.duration = data.duration || 45;
      // 从正确的后端字段读取数据
      formData.classDesc = data.classPurpose || data.remark || '';  // 教学目标
      formData.planInfo = data.classProcess || '';                  // 教学过程
      formData.genderRatio = data.genderRatio || 50;
      formData.errorRate = data.errorRate || 20;
      formData.responseTime = data.responseTime || 3;
      console.log('编辑表单数据:', formData);
    } else {
      throw new Error(res.msg || '获取课堂详情失败')
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
      classId: formData.classId || route.params.id,
      className: formData.className,
      classType: formData.classType,
      studentCount: Number(formData.studentCount),
      duration: Number(formData.duration),
      genderRatio: Number(formData.genderRatio),
      errorRate: Number(formData.errorRate),
      responseTime: Number(formData.responseTime),
      classDesc: formData.classDesc,   // 教学目标
      planInfo: formData.planInfo      // 教学过程
    }

    console.log('提交数据:', submitData);
    const res = await updateClassroom(submitData)
    console.log('更新响应:', res);
    
    if (res.code === 200) {
      ElMessage.success('保存成功')
      router.push('/classroom/list')
    } else {
      throw new Error(res.msg || '保存失败')
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
  fetchCourseTypes()
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
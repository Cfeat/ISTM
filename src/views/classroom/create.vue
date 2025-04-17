<template>
  <div class="classroom-create">
    <!-- <div class="create-header">
      <h2>创建AI课堂</h2>
      <p class="tip">请先填写必填项目</p>
    </div> -->

    <el-form 
      ref="formRef"
      :model="formData"
      :rules="rules"
      label-width="120px"
      class="create-form"
    >
      <!-- 左侧表单部分 -->
      <div class="form-left">
        <h3>创建AI课堂<span class="required-tip">红点为必填项目</span></h3>
        
        <el-form-item label="课程名称" prop="className">
          <el-input v-model="formData.className" placeholder="请输入课程名称" />
        </el-form-item>

        <el-form-item label="课程类型" prop="classType">
          <el-select 
            v-model="formData.classType" 
            placeholder="请选择课程类型"
            @change="handleCourseTypeChange"
          >
            <el-option
              v-for="type in courseTypes"
              :key="type.value"
              :label="type.label"
              :value="type.value"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="学生数目" prop="studentCount">
          <el-input 
            v-model.number="formData.studentCount" 
            type="number"
            placeholder="请输入学生数目" 
          />
        </el-form-item>

        <el-form-item label="教学时长" prop="duration">
          <el-input v-model="formData.duration" placeholder="请输入教学时长" />
        </el-form-item>

        <el-form-item label="教学目标" prop="classDesc">
          <el-input
            v-model="formData.classDesc"
            type="textarea"
            :rows="4"
            placeholder="请输入教学目标"
          />
        </el-form-item>

        <el-form-item label="教学过程" prop="planInfo">
          <el-input
            v-model="formData.planInfo"
            type="textarea"
            :rows="6"
            placeholder="请输入教学过程"
          />
        </el-form-item>
      </div>

      <!-- 右侧设置部分 -->
      <div class="form-right">
        <div class="settings-section">
          <h3>学生详细信息设置</h3>
          
          <div class="setting-item">
            <span class="setting-label">男/女</span>
            <div class="setting-control">
              <el-button 
                class="control-btn minus-btn" 
                @click="adjustGenderRatio('minus')"
                round
              >
                <el-icon><Minus /></el-icon>
              </el-button>
              <span class="ratio-value">{{ formData.genderRatio }}%</span>
              <el-button 
                class="control-btn plus-btn" 
                @click="adjustGenderRatio('plus')"
                round
              >
                <el-icon><Plus /></el-icon>
              </el-button>
            </div>
          </div>

          <div class="setting-item">
            <span class="setting-label">
              随机错误案例概率设置
              <el-tooltip content="表达多少比例的学生易出现错误" placement="top">
                <small>表达多少比例的学生易出现错误</small>
              </el-tooltip>
            </span>
            <div class="setting-control">
              <el-button 
                class="control-btn minus-btn" 
                @click="adjustErrorRate('minus')"
                round
              >
                <el-icon><Minus /></el-icon>
              </el-button>
              <span class="ratio-value">{{ formData.errorRate }}%</span>
              <el-button 
                class="control-btn plus-btn" 
                @click="adjustErrorRate('plus')"
                round
              >
                <el-icon><Plus /></el-icon>
              </el-button>
            </div>
          </div>

          <div class="setting-item">
            <span class="setting-label">
              虚拟学生响应时间 (秒)
              <el-tooltip content="表达虚拟学生将在多久后做出响应" placement="top">
                <small>表达虚拟学生将在多久后做出响应</small>
              </el-tooltip>
            </span>
            <div class="setting-control">
              <el-button 
                class="control-btn minus-btn" 
                @click="adjustResponseTime('minus')"
                round
              >
                <el-icon><Minus /></el-icon>
              </el-button>
              <span class="ratio-value">{{ formData.responseTime }}s</span>
              <el-button 
                class="control-btn plus-btn" 
                @click="adjustResponseTime('plus')"
                round
              >
                <el-icon><Plus /></el-icon>
              </el-button>
            </div>
          </div>
        </div>

        <div class="weather-section">
          <h3>天气选择</h3>
          <div class="weather-options">
            <div 
              v-for="weather in weatherOptions" 
              :key="weather.value"
              :class="['weather-item', { active: formData.weather === weather.value }]"
              @click="selectWeather(weather.value)"
            >
              <img :src="weather.icon" :alt="weather.label">
              <span>{{ weather.label }}</span>
            </div>
          </div>
        </div>

        <div class="ai-upload">
          <div 
            class="upload-area" 
            :class="{ dragging: isDragging }"
            @drop="handleDrop"
            @dragover="handleDragOver"
            @dragenter="isDragging = true"
            @dragleave="isDragging = false"
            @click="triggerFileUpload"
          >
            <el-icon><Upload /></el-icon>
            <p>将教案文件拖到此处或点击上传</p>
            <input 
              type="file" 
              ref="fileInput" 
              style="display: none;" 
              accept=".docx,.pdf,.txt" 
              @change="handleFileChange"
            />
          </div>
          <div class="upload-tip" v-if="uploadedFileName">
            <el-icon><Document /></el-icon>
            <span>{{ uploadedFileName }}</span>
            <el-icon class="delete-icon" @click="clearUploadedFile"><Delete /></el-icon>
          </div>
        </div>
      </div>
    </el-form>

    <div class="form-footer">
      <el-button @click="handleCancel">取消</el-button>
      <el-button type="primary" style="background-color: #95d475; border-color: #95d475;" @click="handleSubmit" :loading="submitting">
        创建课堂
      </el-button>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { Plus, Minus, Upload, Document, Delete } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { addClassroom, uploadTeachingPlan, getCourseTypes } from '@/api/system/classroom'
import { applyPlanToClass } from '@/api/materials'

const router = useRouter()
const route = useRoute()
const formRef = ref(null)
const fileInput = ref(null)
const submitting = ref(false)
const courseTypes = ref([])
const isDragging = ref(false)
const uploadedFileName = ref('')
const uploadedFile = ref(null)

// 获取query参数中的planId
const planId = computed(() => route.query.planId)

// 表单数据
const formData = reactive({
  className: '',
  classType: '',
  studentCount: 30,
  duration: 45,
  classDesc: '',
  planInfo: '',
  genderRatio: 50,
  errorRate: 30,
  responseTime: 1,
  weather: 'sunny'
})

const weatherOptions = [
  { label: '晴天', value: 'sunny', icon: '/src/assets/weather/sunny.png' },
  { label: '多云', value: 'cloudy', icon: '/src/assets/weather/cloudy.png' },
  { label: '微雨', value: 'rainy', icon: '/src/assets/weather/rainy.png' },
  { label: '小雪', value: 'snowy', icon: '/src/assets/weather/snowy.png' }
]

// 表单验证规则
const rules = {
  className: [{ required: true, message: '请输入课程名称', trigger: 'blur' }],
  classType: [{ required: true, message: '请选择课程类型', trigger: 'change' }],
  studentCount: [{ required: true, message: '请输入学生数目', trigger: 'blur' }],
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

// 监听课程类型变化，自动填充相关内容
const handleCourseTypeChange = (type) => {
  if (type && courseData[type]) {
    const courseInfo = courseData[type]
    formData.className = courseInfo.name
    formData.classDesc = courseInfo.goals
    formData.planInfo = courseInfo.process
  }
}

// 调整性别比例
const adjustGenderRatio = (type) => {
  if (type === 'plus' && formData.genderRatio < 100) {
    formData.genderRatio += 10
  } else if (type === 'minus' && formData.genderRatio > 0) {
    formData.genderRatio -= 10
  }
}

// 调整错误率
const adjustErrorRate = (type) => {
  if (type === 'plus' && formData.errorRate < 100) {
    formData.errorRate += 10
  } else if (type === 'minus' && formData.errorRate > 0) {
    formData.errorRate -= 10
  }
}

// 调整响应时间
const adjustResponseTime = (type) => {
  if (type === 'plus' && formData.responseTime < 10) {
    formData.responseTime += 0.5
  } else if (type === 'minus' && formData.responseTime > 0) {
    formData.responseTime -= 0.5
  }
}

// 选择天气
const selectWeather = (weather) => {
  formData.weather = weather
}

// 触发文件上传
const triggerFileUpload = () => {
  fileInput.value.click()
}

// 处理文件选择
const handleFileChange = (event) => {
  const file = event.target.files[0]
  if (file) {
    uploadedFileName.value = file.name
    uploadedFile.value = file
    handleFileUpload(file)
  }
}

// 清除上传的文件
const clearUploadedFile = () => {
  uploadedFileName.value = ''
  uploadedFile.value = null
  fileInput.value.value = ''
}

// 处理文件上传
const handleFileUpload = async (file) => {
  try {
    const formDataObj = new FormData()
    formDataObj.append('file', file)
    
    ElMessage.info('正在解析教案文件...')
    const res = await uploadTeachingPlan(formDataObj)
    console.log('上传教案响应:', res)
    
    if (res.code === 200 && res.data) {
      // 自动填充表单
      updateFormWithPlanData(res.data)
      ElMessage.success('教案解析成功')
    } else {
      throw new Error(res.msg || '教案解析失败')
    }
  } catch (error) {
    console.error('教案解析失败:', error)
    ElMessage.error(error.message || '教案解析失败')
  }
}

// 根据教案数据更新表单
const updateFormWithPlanData = (data) => {
  console.log('更新表单数据:', data)
  
  // 根据后端字段名进行适配
  if (data.planName) formData.className = data.planName
  if (data.sportType) formData.classType = data.sportType
  if (data.planPurpose) formData.classDesc = data.planPurpose
  if (data.planProcess) formData.planInfo = data.planProcess
  
  // 可能的备选字段名
  if (!formData.className && data.className) formData.className = data.className
  if (!formData.classType && data.classType) formData.classType = data.classType
  if (!formData.classDesc && (data.classPurpose || data.teachingGoals)) {
    formData.classDesc = data.classPurpose || data.teachingGoals
  }
  if (!formData.planInfo && (data.classProcess || data.teachingProcess)) {
    formData.planInfo = data.classProcess || data.teachingProcess
  }
}

// 应用教案到表单
const applyPlanToForm = async () => {
  if (!planId.value) return
  
  try {
    ElMessage.info('正在应用教案...')
    const res = await applyPlanToClass(planId.value)
    console.log('应用教案响应:', res)
    
    if (res.code === 200 && res.data) {
      updateFormWithPlanData(res.data)
      ElMessage.success('已应用教案内容')
    } else {
      throw new Error(res.msg || '应用教案失败')
    }
  } catch (error) {
    console.error('应用教案失败:', error)
    ElMessage.error(error.message || '应用教案失败')
  }
}

// 拖拽上传相关
const handleDrop = (e) => {
  e.preventDefault()
  isDragging.value = false
  const file = e.dataTransfer.files[0]
  if (file) {
    uploadedFileName.value = file.name
    uploadedFile.value = file
    handleFileUpload(file)
  }
}

const handleDragOver = (e) => {
  e.preventDefault()
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    submitting.value = true
    
    // 确保提交的数据中没有classId字段
    const submitData = { 
      className: formData.className,
      classType: formData.classType,
      studentCount: Number(formData.studentCount),
      duration: Number(formData.duration),
      genderRatio: Number(formData.genderRatio),
      errorRate: Number(formData.errorRate),
      responseTime: Number(formData.responseTime),
      classDesc: formData.classDesc,   // 教学目标
      planInfo: formData.planInfo,     // 教学过程
      weather: formData.weather
    };
    
    console.log('提交表单数据:', submitData)
    const res = await addClassroom(submitData)
    console.log('创建课堂响应:', res)
    
    if (res.code === 200) {
      ElMessage.success('创建成功')
      
      // 处理返回的id格式，从多个可能的位置获取ID
      let classId = null
      
      // 检查各种可能的返回格式
      if (typeof res.data === 'number' || typeof res.data === 'string') {
        // 直接返回ID作为data
        classId = res.data
      } else if (res.data && typeof res.data === 'object') {
        // 返回对象中包含classId
        classId = res.data.classId
      } else if (res.classId) {
        // 直接在res对象上
        classId = res.classId
      }
      
      console.log('提取的课堂ID:', classId)
      
      if (classId) {
        // 跳转到课堂详情页
        console.log('跳转到详情页:', `/classroom/detail/${classId}`)
        router.push(`/classroom/detail/${classId}`)
      } else {
        console.log('未能获取课堂ID，跳转到列表页')
        router.push('/classroom/list')
      }
    } else {
      throw new Error(res.msg || '创建失败')
    }
  } catch (error) {
    console.error('创建失败:', error)
    ElMessage.error(error.message || '创建失败')
  } finally {
    submitting.value = false
  }
}

// 取消创建
const handleCancel = () => {
  router.back()
}

// 初始化
onMounted(() => {
  fetchCourseTypes()
  
  // 如果有planId参数，自动应用教案
  if (planId.value) {
    applyPlanToForm()
  }
})
</script>

<style lang="scss" scoped>
.classroom-create {
  padding: 20px;

  .create-header {
    margin-bottom: 30px;
    
    h2 {
      font-size: 24px;
      margin-bottom: 10px;
    }

    .tip {
      color: #666;
      font-size: 14px;
    }
  }

  .create-form {
    display: flex;
    gap: 40px;

    .form-left {
      flex: 1;

      h3 {
        margin-bottom: 20px;
        color: #7fd753;
        
        .required-tip {
          font-size: 12px;
          color: #f56c6c;
          margin-left: 10px;
        }
      }
    }

    .form-right {
      width: 400px;

      .settings-section {
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;

        .setting-item {
          margin-bottom: 20px;

          .setting-label {
            display: block;
            margin-bottom: 10px;
            
            small {
              color: #999;
              font-size: 12px;
              margin-left: 5px;
            }
          }

          .setting-control {
            display: flex;
            align-items: center;
            gap: 10px;

            .control-btn {
              background-color: #95d475;
              border-color: #95d475;
              color: white;
              padding: 8px;
              display: flex;
              align-items: center;
              justify-content: center;
              
              &:hover {
                background-color: #85c665;
                border-color: #85c665;
              }
              
              &:active {
                background-color: #75b855;
                border-color: #75b855;
              }
            }

            .ratio-value {
              min-width: 60px;
              text-align: center;
            }
          }
        }
      }

      .weather-section {
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;

        .weather-options {
          display: grid;
          grid-template-columns: repeat(4, 1fr);
          gap: 10px;

          .weather-item {
            text-align: center;
            cursor: pointer;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s;

            &:hover {
              background: #f5f7fa;
            }

            &.active {
              background: #ecf5ff;
            }

            img {
              width: 40px;
              height: 40px;
              margin-bottom: 5px;
            }

            span {
              display: block;
              font-size: 12px;
            }
          }
        }
      }

      .ai-upload {
        background: #fff;
        padding: 20px;
        border-radius: 8px;

        .upload-area {
          border: 2px dashed #dcdfe6;
          border-radius: 8px;
          padding: 40px;
          text-align: center;
          cursor: pointer;
          transition: all 0.3s;

          &:hover {
            border-color: #409eff;
          }

          &.dragging {
            border-color: #409eff;
            background-color: #ecf5ff;
          }

          .el-icon {
            font-size: 48px;
            color: #909399;
            margin-bottom: 10px;
          }

          p {
            color: #909399;
            font-size: 14px;
          }
        }

        .upload-tip {
          margin-top: 10px;
          padding: 8px 12px;
          background: #f0f9eb;
          border-radius: 4px;
          color: #67c23a;
          display: flex;
          align-items: center;
          gap: 8px;
          font-size: 14px;

          span {
            flex: 1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
          }

          .delete-icon {
            cursor: pointer;
            color: #f56c6c;
            font-size: 16px;
          }
        }
      }
    }
  }

  .form-footer {
    display: flex;
    justify-content: center;
    gap: 20px;
  }

  .el-select {
    width: 100%;
  }
}
</style> 
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
        
        <el-form-item label="课程名称" prop="courseName">
          <el-input v-model="formData.courseName" placeholder="请输入课程名称" />
        </el-form-item>

        <el-form-item label="课程类型" prop="courseType">
          <el-input v-model="formData.courseType" placeholder="请选择课程类型" />
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

        <el-form-item label="教学目标" prop="teachingGoals">
          <el-input
            v-model="formData.teachingGoals"
            type="textarea"
            :rows="4"
            placeholder="请输入教学目标"
          />
        </el-form-item>

        <el-form-item label="教学过程" prop="teachingProcess">
          <el-input
            v-model="formData.teachingProcess"
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
          <div class="upload-area">
            <el-icon><Upload /></el-icon>
            <p>将教案文件拖到此处自动识别</p>
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
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Plus, Minus, Upload } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { createClassroom, uploadTeachingPlan, getCourseTypes } from '@/api/classroom'

const router = useRouter()
const formRef = ref(null)
const submitting = ref(false)
const formData = reactive({
  courseName: '',
  courseType: '',
  studentCount: '',
  duration: '',
  teachingGoals: '',
  teachingProcess: '',
  genderRatio: 50,
  errorRate: 50,
  responseTime: 0.5,
  weather: 'sunny'
})

const weatherOptions = [
  { label: '晴天', value: 'sunny', icon: '/src/assets/weather/sunny.png' },
  { label: '多云', value: 'cloudy', icon: '/src/assets/weather/cloudy.png' },
  { label: '微雨', value: 'rainy', icon: '/src/assets/weather/rainy.png' },
  { label: '小雪', value: 'snowy', icon: '/src/assets/weather/snowy.png' }
]

const rules = {
  courseName: [
    { required: true, message: '请输入课程名称', trigger: 'blur' }
  ],
  courseType: [
    { required: true, message: '请选择课程类型', trigger: 'blur' }
  ],
  studentCount: [
    { required: true, message: '请输入学生数目', trigger: 'blur' },
    { type: 'number', message: '学生数目必须为数字' },
    { type: 'number', min: 1, message: '学生数目必须大于0', trigger: 'blur' }
  ]
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

// 获取课程类型列表
const courseTypes = ref([])
const fetchCourseTypes = async () => {
  try {
    const res = await getCourseTypes()
    courseTypes.value = res.data
  } catch (error) {
    ElMessage.error('获取课程类型失败')
  }
}

// 处理文件上传
const handleFileUpload = async (file) => {
  try {
    const formData = new FormData()
    formData.append('file', file)
    
    const res = await uploadTeachingPlan(formData)
    if (res.data) {
      // 自动填充表单
      Object.assign(formData, res.data)
      ElMessage.success('教案解析成功')
    }
  } catch (error) {
    ElMessage.error('教案解析失败')
  }
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    submitting.value = true
    
    const res = await createClassroom(formData)
    ElMessage.success('创建成功')
    
    // 跳转到课堂列表页
    router.push({
      name: 'ClassroomList',
      query: {
        id: res.data.id // 可选：带上新创建的课堂ID
      }
    })
  } catch (error) {
    ElMessage.error(error.message || '创建失败')
  } finally {
    submitting.value = false
  }
}

// 取消创建
const handleCancel = () => {
  router.back()
}

// 拖拽上传相关
const handleDrop = (e) => {
  e.preventDefault()
  const file = e.dataTransfer.files[0]
  if (file) {
    handleFileUpload(file)
  }
}

const handleDragOver = (e) => {
  e.preventDefault()
}

// 初始化
onMounted(() => {
  fetchCourseTypes()
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

          &:hover {
            border-color: #409eff;
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
      }
    }
  }

  .form-footer {
    display: flex;
    justify-content: center;
    gap: 20px;
  }

  .upload-area {
    &.dragging {
      border-color: #409eff;
      background-color: #ecf5ff;
    }
  }
}
</style> 
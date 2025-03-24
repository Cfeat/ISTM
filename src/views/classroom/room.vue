<template>
  <div class="classroom-room">
    <!-- 顶部信息栏 -->
    <div class="room-header">
      <div class="course-info">
        <h2>{{ classroom.courseName }}</h2>
        <el-tag type="success">{{ getCourseTypeLabel(classroom.courseType) }}</el-tag>
        <span class="student-count">学生数：{{ classroom.studentCount }}人</span>
      </div>
      <div class="timer">
        <el-icon><Timer /></el-icon>
        已上课时间：{{ formatTime(elapsedTime) }}
      </div>
      <el-button type="danger" @click="handleExit">
        <el-icon><CircleClose /></el-icon>
        结束上课
      </el-button>
    </div>

    <!-- 主要内容区 -->
    <div class="room-content">
      <!-- 左侧教学区 -->
      <div class="teaching-area">
        <div class="teaching-content">
          <div class="section-title">
            <el-icon><Document /></el-icon>
            <h3>教学进度</h3>
          </div>
          <div class="process-steps">
            <div 
              v-for="(step, index) in teachingSteps" 
              :key="index"
              :class="['step', { active: currentStep === index }]"
              @click="selectStep(index)"
            >
              <span class="step-number">{{ index + 1 }}</span>
              <span class="step-text">{{ step }}</span>
            </div>
          </div>
        </div>
        <div class="command-input">
          <el-input
            v-model="teacherCommand"
            type="textarea"
            :rows="3"
            placeholder="输入教学指令，例如：'请同学们原地运球'"
            @keyup.enter="sendCommand"
          />
          <div class="button-group">
            <el-button type="primary" @click="sendCommand">
              <el-icon><Position /></el-icon>
              发送指令
            </el-button>
            <el-button type="warning" @click="generateError">
              <el-icon><Warning /></el-icon>
              生成错误示范
            </el-button>
          </div>
        </div>
      </div>

      <!-- 右侧学生反馈区 -->
      <div class="student-feedback">
        <div class="section-title">
          <el-icon><ChatLineRound /></el-icon>
          <h3>课堂互动</h3>
        </div>
        <div class="chat-messages" ref="chatBox">
          <div 
            v-for="(message, index) in messages" 
            :key="index"
            :class="['message', message.type]"
          >
            <div class="message-header">
              <span class="name">{{ message.name }}</span>
              <span class="time">{{ message.time }}</span>
            </div>
            <div class="message-content">{{ message.content }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Timer, Position, Warning, Document, ChatLineRound, CircleClose } from '@element-plus/icons-vue'
import { getClassroomDetail, sendTeacherCommand, getVirtualStudents } from '@/api/classroom'
import { generateErrorCase, generateStudentResponse } from '@/utils/ai'
import { Random } from 'mockjs'

const route = useRoute()
const router = useRouter()
const classroom = ref({})
const teacherCommand = ref('')
const messages = ref([])
const elapsedTime = ref(0)
const currentStep = ref(0)
const showErrorCase = ref(false)
const chatBox = ref(null)
let timer = null

// 课程类型映射
const courseTypeMap = {
  basketball: '篮球课程',
  football: '足球课程',
  volleyball: '排球课程',
  athletics: '田径课程',
  gymnastics: '体操课程'
}

const getCourseTypeLabel = (type) => {
  return courseTypeMap[type] || type
}

// 格式化时间
const formatTime = (seconds) => {
  const minutes = Math.floor(seconds / 60)
  const remainingSeconds = seconds % 60
  return `${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`
}

// 从教学过程中提取步骤
const teachingSteps = computed(() => {
  if (!classroom.value.teachingProcess) return []
  return classroom.value.teachingProcess.split('\n').map(step => step.trim())
})

// 获取课堂信息
const fetchClassroomDetail = async () => {
  try {
    const res = await getClassroomDetail(route.params.id)
    classroom.value = res.data
    // 初始化虚拟学生
    await initializeVirtualStudents()
  } catch (error) {
    ElMessage.error('获取课堂信息失败')
  }
}

// 初始化虚拟学生
const initializeVirtualStudents = async () => {
  try {
    const res = await getVirtualStudents(route.params.id)
    // 添加系统欢迎消息
    addMessage({
      type: 'system',
      name: '系统',
      content: `课堂开始，共有 ${classroom.value.studentCount} 名学生加入`
    })
  } catch (error) {
    ElMessage.error('初始化学生失败')
  }
}

// 添加消息到聊天框
const addMessage = (message) => {
  messages.value.push({
    ...message,
    time: new Date().toLocaleTimeString()
  })
  // 滚动到底部
  setTimeout(() => {
    if (chatBox.value) {
      chatBox.value.scrollTop = chatBox.value.scrollHeight
    }
  }, 100)
}

// 发送教师指令
const sendCommand = async () => {
  if (!teacherCommand.value.trim()) {
    ElMessage.warning('请输入教学指令')
    return
  }

  // 添加教师指令到消息列表
  addMessage({
    type: 'teacher',
    name: '教师',
    content: teacherCommand.value
  })

  try {
    // 生成学生的改正反馈
    const response = await generateStudentResponse(
      classroom.value.courseType,
      classroom.value.courseName,
      teacherCommand.value,
      true
    )
    
    // 添加学生反馈到消息列表
    addMessage({
      type: 'student',
      name: Random.cname(),
      content: response
    })

    // 清空输入框
    teacherCommand.value = ''
  } catch (error) {
    ElMessage.error(error.message || '发送指令失败')
  }
}

// 生成错误案例
const generateError = async () => {
  try {
    const errorCase = await generateErrorCase(
      classroom.value.courseType,
      classroom.value.courseName,
      teachingSteps.value[currentStep.value]
    )
    
    addMessage({
      type: 'student',
      name: Random.cname(),
      content: errorCase
    })
  } catch (error) {
    ElMessage.error('生成错误案例失败')
  }
}

// 选择教学步骤
const selectStep = (index) => {
  currentStep.value = index
  addMessage({
    type: 'system',
    name: '系统',
    content: `当前进入教学步骤：${teachingSteps.value[index]}`
  })
}

// 退出课堂
const handleExit = async () => {
  try {
    await ElMessageBox.confirm('确定要结束本次课堂吗？', '提示', {
      type: 'warning'
    })
    router.push('/classroom/list')
  } catch (error) {
    // 用户取消操作
  }
}

// 开始计时
const startTimer = () => {
  timer = setInterval(() => {
    elapsedTime.value++
  }, 1000)
}

onMounted(() => {
  fetchClassroomDetail()
  startTimer()
})

onUnmounted(() => {
  if (timer) {
    clearInterval(timer)
  }
})
</script>

<style lang="scss" scoped>
.classroom-room {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: #f5f7fa;

  .room-header {
    background: white;
    padding: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #eee;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);

    .course-info {
      display: flex;
      align-items: center;
      gap: 15px;

      h2 {
        margin: 0;
        color: #409eff;
        font-size: 24px;
      }

      .student-count {
        color: #666;
        font-size: 16px;
      }
    }

    .timer {
      font-size: 18px;
      font-weight: bold;
      color: #409eff;
      display: flex;
      align-items: center;
      gap: 8px;
    }
  }

  .room-content {
    flex: 1;
    display: flex;
    gap: 20px;
    padding: 20px;
    overflow: hidden;

    .section-title {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 20px;
      
      h3 {
        margin: 0;
        color: #409eff;
      }
    }

    .teaching-area {
      flex: 1;
      background: white;
      border-radius: 12px;
      padding: 20px;
      display: flex;
      flex-direction: column;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);

      .teaching-content {
        flex: 1;
        margin-bottom: 20px;

        .process-steps {
          .step {
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 10px;
            background: #f5f7fa;

            .step-number {
              width: 24px;
              height: 24px;
              border-radius: 50%;
              background: #409eff;
              color: white;
              display: flex;
              align-items: center;
              justify-content: center;
              font-size: 14px;
            }

            &:hover {
              background: #ecf5ff;
            }

            &.active {
              background: #409eff;
              color: white;

              .step-number {
                background: white;
                color: #409eff;
              }
            }
          }
        }
      }

      .command-input {
        display: flex;
        flex-direction: column;
        gap: 10px;

        .button-group {
          display: flex;
          gap: 10px;
          justify-content: flex-end;
        }
      }
    }

    .student-feedback {
      width: 400px;
      background: white;
      border-radius: 12px;
      padding: 20px;
      display: flex;
      flex-direction: column;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);

      .chat-messages {
        flex: 1;
        overflow-y: auto;
        padding-right: 10px;

        .message {
          margin-bottom: 15px;
          padding: 12px;
          border-radius: 8px;

          &.teacher {
            background: #ecf5ff;
          }

          &.student {
            background: #f0f9eb;
          }

          &.system {
            background: #f4f4f5;
            text-align: center;
          }

          .message-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 13px;
            color: #666;

            .name {
              font-weight: bold;
            }
          }

          .message-content {
            line-height: 1.5;
          }
        }
      }
    }
  }
}
</style>
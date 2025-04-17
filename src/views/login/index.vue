<template>
  <div class="login-container">
    <!-- 背景 -->
    <div class="background">
      <img src="@/assets/images/background.svg" alt="background">
    </div>

    <!-- 顶部导航栏 -->
    <div class="header">
      <div class="logo-container">
        <img src="@/assets/images/logo.png" alt="ISTM Logo">
      </div>
      <div class="title">
        <h1>ISTM</h1>
        <p>Interactive Sports Teaching Mentor</p>
      </div>
      <div class="subtitle">
        ——AI助力体育师范生教学能力提升新范式
      </div>
    </div>

    <!-- 左侧装饰图 -->
    <div class="decorations">
      <img src="@/assets/images/login/wave.svg" alt="teacher" class="teacher-image">
    </div>

    <!-- 登录表单 -->
    <div class="login-form">
      <div class="form-header">
        <div class="title-row">
          <h1>ISTM</h1>
          <img src="@/assets/images/logo.png" alt="ISTM Logo" class="form-logo"
        </div>
        <p>Interactive Sports Teaching Mentor</p>
      </div>

      <el-form ref="loginFormRef" :model="loginForm" :rules="loginRules">
        <el-form-item prop="username">
          <el-input
            v-model="loginForm.username"
            placeholder="账号"
            :prefix-icon="User"
          />
        </el-form-item>

        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            :type="passwordVisible ? 'text' : 'password'"
            placeholder="密码"
            :prefix-icon="Lock"
          >
            <template #suffix>
              <el-icon 
                class="cursor-pointer" 
                @click="passwordVisible = !passwordVisible"
              >
                <component :is="passwordVisible ? View : Hide" />
              </el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item prop="code" class="code-item">
          <el-input
            v-model="loginForm.code"
            placeholder="验证码"
            style="width: 200px"
          />
          <div class="code-image" @click="getCode">
            <img :src="codeUrl" alt="验证码">
          </div>
        </el-form-item>

        <el-form-item>
          <el-button
            :loading="loading"
            type="primary"
            class="login-button"
            @click.prevent="handleLogin"
          >
            登录
          </el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="watermark">ISTM</div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store/modules/user'
import { getCodeImg } from '@/api/login'
import { User, Lock, View, Hide } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()

const loginForm = reactive({
  username: '',
  password: '',
  code: '',
  uuid: ''
})

const loginRules = {
  username: [{ required: true, trigger: 'blur', message: '请输入账号' }],
  password: [{ required: true, trigger: 'blur', message: '请输入密码' }],
  code: [
    { required: true, trigger: 'blur', message: '请输入验证码' },
    // { min: 4, max: 4, message: '验证码长度必须为4位', trigger: 'blur' }
  ]
}

const loading = ref(false)
const codeUrl = ref('')
const loginFormRef = ref()
const passwordVisible = ref(false)

// 获取验证码
const getCode = async () => {
  try {
    const res = await getCodeImg()
    console.log('验证码响应:', res)
    // RuoYi后端返回格式适配
    if (res.code === 200) {
      // 确保img字段存在
      if (res.img) {
        codeUrl.value = 'data:image/gif;base64,' + res.img
        loginForm.uuid = res.uuid
      } else if (res.captchaImg) {
        codeUrl.value = 'data:image/gif;base64,' + res.captchaImg
        loginForm.uuid = res.uuid
      } else {
        console.error('验证码图片数据格式不匹配:', res)
        ElMessage.error('验证码图片数据格式不匹配')
      }
    } else {
      ElMessage.error(res.msg || '获取验证码失败')
    }
  } catch (error) {
    console.error('获取验证码失败:', error)
    ElMessage.error(error.message || '获取验证码失败')
  }
}

// 登录方法
const handleLogin = async () => {
  if (!loginFormRef.value) return
  
  await loginFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        console.log('正在提交登录请求...', loginForm)
        const res = await userStore.login(loginForm)
        console.log('登录响应:', res)
        if (res.code === 200) {
          // 等待短暂时间，确保token被正确设置
          setTimeout(() => {
            router.push({ path: '/dashboard' })
            ElMessage.success('登录成功')
          }, 300)
        } else {
          // 登录失败，重新获取验证码
          getCode()
          ElMessage.error(res.msg || '登录失败')
        }
      } catch (error) {
        console.error('登录失败:', error)
        getCode()
        ElMessage.error(error.message || '登录失败')
      } finally {
        loading.value = false
      }
    }
  })
}

// 初始化验证码
getCode()
</script>

<style lang="scss">
@use '@/assets/styles/variables' as *;
@use '@/assets/styles/login';
</style>

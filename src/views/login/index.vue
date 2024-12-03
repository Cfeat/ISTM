<template>
  <div class="login-container">
    <div class="login-box">
      <div class="login-logo">
        <img src="@/assets/logo/istm-logo.png" alt="ISTM Logo">
        <h1>Interactive Sports Teaching Mentor</h1>
      </div>
      
      <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
        <el-form-item prop="username">
          <el-input 
            v-model="loginForm.username" 
            placeholder="账号/手机号"
            size="large"
            :prefix-icon="User"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            placeholder="密码"
            type="password"
            size="large"
            :prefix-icon="Lock"
            show-password
            @keyup.enter="handleLogin"
          />
        </el-form-item>
        <el-form-item>
          <el-button 
            :loading="loading"
            type="primary" 
            size="large" 
            class="login-button"
            @click="handleLogin"
          >
            {{ loading ? '登录中...' : '登录' }}
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store/modules/user'
import { ElMessage } from 'element-plus'
import { User, Lock } from '@element-plus/icons-vue'

const router = useRouter()
const userStore = useUserStore()
const loginRef = ref()
const loading = ref(false)

const loginForm = reactive({
  username: '',
  password: ''
})

const loginRules = {
  username: [
    { required: true, message: '请输入账号/手机号', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' }
  ]
}

const handleLogin = () => {
  loginRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      try {
        await userStore.login(loginForm)
        router.push({ path: '/' })
      } catch (error) {
        console.error('Login error:', error)
      } finally {
        loading.value = false
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.login-container {
  height: 100vh;
  background: #f0f2f5;
  display: flex;
  align-items: center;
  justify-content: center;

  .login-box {
    width: 400px;
    padding: 40px;
    background: #fff;
    border-radius: 4px;
    box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
  }

  .login-logo {
    text-align: center;
    margin-bottom: 40px;
    
    img {
      height: 44px;
      margin-bottom: 16px;
    }

    h1 {
      font-size: 18px;
      color: #666;
    }
  }

  .login-button {
    width: 100%;
  }
}
</style>

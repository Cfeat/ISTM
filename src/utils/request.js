import axios from 'axios'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getToken } from '@/utils/auth'

// 创建axios实例
const service = axios.create({
  // 使用Vite环境变量
  baseURL: import.meta.env.VITE_APP_BASE_API || '/api',
  timeout: Number(import.meta.env.VITE_APP_TIMEOUT || 10000)
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    const token = getToken()
    if (token) {
      // 根据RuoYi后端要求设置令牌
      config.headers['Authorization'] = token
    }
    return config
  },
  error => {
    console.error('Request Error:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    const res = response.data
    console.log('API响应数据:', response.config.url, res)
    
    // 验证码和登录接口特殊处理
    if (response.config.url.includes('/captchaImage') || response.config.url.includes('/login')) {
      return res
    }
    
    // 判断后端返回的状态码
    if (res.code === 200 || res.code === 0) {
      return res
    } else {
      // 显示错误消息
      ElMessage({
        message: res.msg || '系统错误',
        type: 'error',
        duration: 5 * 1000
      })
      
      // 401: 未登录或Token已过期; 50008: 非法的token; 50012: 其他客户端登录; 50014: Token过期
      if (res.code === 401 || res.code === 50008 || res.code === 50012 || res.code === 50014) {
        // 只有在非登录页面触发过期时才显示重新登录确认框
        if (!window.location.href.includes('/login')) {
          ElMessageBox.confirm('您的登录状态已过期，可以取消继续留在该页面，或者重新登录', '系统提示', {
            confirmButtonText: '重新登录',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            // 调用登出方法，清除用户信息
            // store.dispatch('user/resetToken').then(() => {
            //   location.reload()
            // })
          })
        }
      }
      return Promise.reject(new Error(res.msg || '系统错误'))
    }
  },
  error => {
    console.error('Response Error:', error.response || error)
    // 显示错误信息
    ElMessage({
      message: error.message || '系统错误',
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)

export default service

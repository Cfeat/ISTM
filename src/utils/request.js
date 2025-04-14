import axios from 'axios'
import { ElMessage } from 'element-plus'
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
      // 设置令牌，按照RuoYi后端的要求配置
      config.headers['Authorization'] = 'Bearer ' + token
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
    
    // 验证码接口特殊处理
    if (response.config.url.includes('/auth/captcha')) {
      return res
    }
    
    // 判断后端返回的状态码
    if (res.code === 200) {
      return res
    } else {
      ElMessage({
        message: res.msg || '系统错误',
        type: 'error',
        duration: 5 * 1000
      })
      
      // 50008: 非法的token; 50012: 其他客户端登录了; 50014: Token过期了;
      if (res.code === 401 || res.code === 50008 || res.code === 50012 || res.code === 50014) {
        // 重新登录
        ElMessage.confirm('您已登出，可以取消继续留在该页面，或者重新登录', '确认登出', {
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
      return Promise.reject(new Error(res.msg || '系统错误'))
    }
  },
  error => {
    console.error('Response Error:', error.response || error)
    ElMessage({
      message: error.message || '系统错误',
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)

export default service

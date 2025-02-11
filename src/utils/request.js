import axios from 'axios'
import { ElMessage } from 'element-plus'
import { getToken } from '@/utils/auth'

// 模拟数据
const mockData = {
  '/login': {
    success: {
      code: 200,
      data: {
        token: 'mock-token'
      },
      message: '登录成功'
    }
  },
  '/getInfo': {
    success: {
      code: 200,
      data: {
        name: '测试用户',
        avatar: '/src/assets/images/user.jpg',
        roles: ['admin']
      },
      message: '获取用户信息成功'
    }
  },
  '/logout': {
    success: {
      code: 200,
      data: null
    }
  },
  '/teaching/list': {
    success: {
      code: 200,
      data: [
        {
          id: 1,
          title: '基础体能训练',
          type: '普通',
          tags: ['普通', '小班'],
          duration: '20',
          score: '31.89'
        },
        {
          id: 2,
          title: '足球精英课程',
          type: '足球',
          tags: ['足球', '小班'],
          duration: '30',
          score: '31.10'
        },
        {
          id: 3,
          title: '武术与自卫',
          type: '武术',
          tags: ['武术', '大班'],
          duration: '22',
          score: '41.77'
        },
        {
          id: 4,
          title: '健康与营养学',
          type: '营养',
          tags: ['营养', '小班', '室内'],
          duration: '35',
          score: '31.89'
        },
        {
          id: 5,
          title: '体能与康复训练',
          type: '康复',
          tags: ['康复', '小班', '室内'],
          duration: '40',
          score: '22.25'
        }
      ],
      message: '获取教案列表成功'
    }
  }
}

// 创建axios实例
const service = axios.create({
  baseURL: '/api',
  timeout: 10000
})

// 模拟请求适配器
const mockAdapter = (config) => {
  return new Promise((resolve) => {
    const { url, scenario = 'success' } = config
    const mockEndpoint = mockData[url]
    const response = mockEndpoint[scenario]
    
    setTimeout(() => {
      resolve({
        status: 200,
        statusText: 'OK',
        data: response,
        headers: {},
        config,
        request: {}
      })
    }, 100)
  })
}

// 请求拦截器
service.interceptors.request.use(
  config => {
    const token = getToken()
    if (token) {
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
    
    // 直接返回数据，让业务层处理具体的状态码
    return res
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

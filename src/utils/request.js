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
  baseURL: import.meta.env.VITE_APP_BASE_API || '',
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
    // 确保基本配置存在
    config.headers = config.headers || {}
    
    // 确保 method 存在且为字符串
    if (!config.method) {
      config.method = 'get'
    } else {
      config.method = config.method.toLowerCase()
    }
    
    // 如果是模拟请求，使用模拟适配器
    if (config.mock) {
      config.adapter = mockAdapter
    }
    
    // 添加 token
    const token = getToken()
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    
    return config
  },
  error => Promise.reject(error)
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    const { code, data, message } = response.data
    
    if (code === 200) {
      message && ElMessage.success(message)
      return data
    }
    
    ElMessage.error(message || '错误')
    return Promise.reject(new Error(message || '错误'))
  },
  error => {
    ElMessage.error(error.message || '请求失败')
    return Promise.reject(error)
  }
)

export default service

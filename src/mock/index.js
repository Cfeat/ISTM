import Mock from 'mockjs'
import user from './modules/user'

// 设置响应延时
Mock.setup({
  timeout: '100-300'
})

// 用户相关接口
// 验证码
Mock.mock(/\/api\/auth\/captcha/, 'get', user.getCodeImg)
// 登录
Mock.mock(/\/api\/auth\/login/, 'post', user.login)
// 退出登录
Mock.mock(/\/api\/auth\/logout/, 'post', user.logout)
// 获取用户信息
Mock.mock(/\/api\/users\/info/, 'get', user.getInfo)

// 课程列表
Mock.mock(/\/api\/courses/, 'get', {
  code: 200,
  data: {
    'list|10': [{
      'id|+1': 1,
      'name': '@ctitle(5, 10)',
      'type|1': ['体育', '健康'],
      'createTime': '@datetime',
      'status|1': ['active', 'draft']
    }],
    'total': 100
  }
})

// 教案列表
Mock.mock(/\/api\/materials/, 'get', {
  code: 200,
  data: {
    'list|12': [{
      'id|+1': 1,
      'title': '@ctitle(5, 15)',
      'description': '@cparagraph(1, 2)',
      'cover': '@image("300x200")',
      'sport|1': ['篮球', '足球', '排球', '田径'],
      'grade|1': ['小学', '初中', '高中'],
      'views|100-1000': 800,
      'rating|1-5.1': 4.5,
      'downloads|10-100': 50
    }],
    'total': 100
  }
})

// 资源分类
Mock.mock(/\/api\/resources\/categories/, 'get', {
  code: 200,
  data: [
    {
      id: 1,
      name: '教学文档',
      icon: 'Document',
      description: '教案、课件、教学大纲等文档资源',
      count: 156
    },
    {
      id: 2,
      name: '教学视频',
      icon: 'Video',
      description: '示范动作、教学实录等视频资源',
      count: 89
    },
    {
      id: 3,
      name: '教学图片',
      icon: 'Picture',
      description: '动作分解图、场地示意图等图片资源',
      count: 234
    },
    {
      id: 4,
      name: '其他资料',
      icon: 'Collection',
      description: '教学参考资料、评分标准等其他资源',
      count: 67
    }
  ]
})

// 资源列表
Mock.mock(/\/api\/resources\/list/, 'get', {
  code: 200,
  data: {
    'list|10': [{
      'id|+1': 1,
      'name': '@ctitle(5, 15)',
      'type|1': ['doc', 'docx', 'pdf', 'mp4', 'jpg', 'png'],
      'category|1': ['教学文档', '教学视频', '教学图片', '其他资料'],
      'size': '@integer(1, 100)MB',
      'downloads|0-1000': 500,
      'views|0-2000': 1000,
      'updateTime': '@datetime',
      'description': '@cparagraph(1, 2)'
    }],
    'total': 100
  }
})

// 资源详情
Mock.mock(/\/api\/resources\/detail\/\d+/, 'get', {
  code: 200,
  data: {
    id: '@id',
    name: '@ctitle(5, 15)',
    type: '@pick(["doc", "docx", "pdf", "mp4", "jpg", "png"])',
    category: '@pick(["教学文档", "教学视频", "教学图片", "其他资料"])',
    size: '@integer(1, 100)MB',
    downloads: '@integer(0, 1000)',
    views: '@integer(0, 2000)',
    updateTime: '@datetime',
    description: '@cparagraph(2, 4)',
    url: '@url',
    thumbnail: '@image("200x200")',
    tags: ['@ctitle(2, 4)', '@ctitle(2, 4)', '@ctitle(2, 4)']
  }
})

// 下载资源
Mock.mock(/\/api\/resources\/download\/\d+/, 'get', {
  code: 200,
  message: '下载成功'
})

// 系统设置
Mock.mock(/\/api\/settings/, 'get', {
  code: 200,
  data: {
    language: 'zh-CN',
    defaultStudentCount: 30,
    autoSave: true,
    responseSpeed: 5,
    voiceRecognition: true,
    aiAssistant: true,
    systemNotification: true,
    emailNotification: false,
    email: ''
  }
})

// AI课堂 - 课程类型
Mock.mock(/\/api\/classroom\/types/, 'get', {
  code: 200,
  data: [
    { value: 'basketball', label: '篮球' },
    { value: 'football', label: '足球' },
    { value: 'volleyball', label: '排球' },
    { value: 'athletics', label: '田径' },
    { value: 'gymnastics', label: '体操' }
  ]
})

// AI课堂 - 创建课堂
Mock.mock(/\/api\/classroom\/create/, 'post', {
  code: 200,
  message: '创建成功',
  data: {
    id: '@id',
    createTime: '@datetime'
  }
})

// AI课堂 - 获取课堂详情
Mock.mock(/\/api\/classroom\/detail/, 'get', {
  code: 200,
  data: {
    courseName: '@ctitle(5, 10)',
    courseType: '@pick(["basketball", "football", "volleyball", "athletics", "gymnastics"])',
    studentCount: '@integer(20, 40)',
    duration: '@integer(30, 120)',
    teachingGoals: '@cparagraph(1, 2)',
    teachingProcess: '@cparagraph(2, 4)',
    genderRatio: 50,
    errorRate: 30,
    responseTime: 1.5
  }
})

// 更新用户信息
Mock.mock(/\/api\/user\/update/, 'post', {
  code: 200,
  message: '更新成功',
  data: {
    name: '@cname',
    email: '@email',
    bio: '@cparagraph(1, 3)'
  }
})

// 更新密码
Mock.mock(/\/api\/user\/password/, 'post', {
  code: 200,
  message: '密码修改成功'
})

// 更新头像
Mock.mock(/\/api\/user\/avatar/, 'post', {
  code: 200,
  message: '头像更新成功',
  data: '@image("200x200")'
})

// 获取用户信息
Mock.mock(/\/api\/user\/info/, 'get', {
  code: 200,
  data: {
    id: '@id',
    name: '@cname',
    email: '@email',
    avatar: '@image("200x200")',
    role: '@pick(["admin", "user"])',
    createTime: '@datetime',
    bio: '@cparagraph(1, 3)'
  }
})

export default Mock

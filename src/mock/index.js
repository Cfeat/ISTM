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

// 定义课程基础数据，确保数据一致性
const courseData = {
  basketball: {
    name: '篮球运球基础训练',
    label: '篮球课程',
    goals: '掌握篮球运球的基本姿势和技巧，能够完成原地运球、行进间运球等基本动作，培养学生对篮球运动的兴趣。',
    process: '1. 热身准备活动（5分钟）\n2. 讲解运球基本要领（10分钟）\n3. 原地运球练习（10分钟）\n4. 行进间运球练习（10分钟）\n5. 综合运球游戏（8分钟）\n6. 总结与放松（2分钟）'
  },
  football: {
    name: '足球传球基础训练',
    label: '足球课程',
    goals: '学习足球传球的基本方法，掌握脚内侧传球技术要领，能够进行简单的传接配合。',
    process: '1. 热身与基本活动（5分钟）\n2. 讲解脚内侧传球要领（10分钟）\n3. 原地传球练习（10分钟）\n4. 移动中传接球练习（10分钟）\n5. 分组传球比赛（8分钟）\n6. 课程总结（2分钟）'
  },
  volleyball: {
    name: '排球垫球基础训练',
    label: '排球课程',
    goals: '了解排球垫球的基本要领，掌握正确的手型和身体姿势，能够完成基本的垫球动作。',
    process: '1. 准备活动（5分钟）\n2. 讲解垫球基本要领（10分钟）\n3. 原地垫球练习（10分钟）\n4. 移动垫球练习（10分钟）\n5. 简单垫球游戏（8分钟）\n6. 总结课程（2分钟）'
  },
  athletics: {
    name: '短跑起跑技术训练',
    label: '田径课程',
    goals: '掌握短跑起跑的基本姿势，学会使用起跑器，提高起跑反应速度和加速能力。',
    process: '1. 专项热身（5分钟）\n2. 起跑器使用讲解（10分钟）\n3. 起跑姿势练习（10分钟）\n4. 起跑加速练习（10分钟）\n5. 起跑竞赛（8分钟）\n6. 放松整理（2分钟）'
  },
  gymnastics: {
    name: '体操基本体式训练',
    label: '体操课程',
    goals: '学习体操基本体式，掌握基本站立、行进等动作要领，培养良好的身体姿态。',
    process: '1. 身体基本热身（5分钟）\n2. 基本体式讲解（10分钟）\n3. 基本站立练习（10分钟）\n4. 行进动作练习（10分钟）\n5. 组合动作练习（8分钟）\n6. 课程小结（2分钟）'
  }
}

// 存储创建的课堂数据
const classrooms = []

// 格式化日期时间
function formatDateTime(date) {
  const pad = (num) => String(num).padStart(2, '0')
  
  const year = date.getFullYear()
  const month = pad(date.getMonth() + 1)
  const day = pad(date.getDate())
  const hours = pad(date.getHours())
  const minutes = pad(date.getMinutes())
  const seconds = pad(date.getSeconds())
  
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
}

// AI课堂 - 创建课堂
Mock.mock(/\/api\/classroom\/create/, 'post', function(options) {
  const data = JSON.parse(options.body)
  const id = Mock.Random.guid()
  const classroom = {
    id,
    ...data,
    createTime: formatDateTime(new Date()), // 使用当前真实时间
    status: 'active'
  }
  classrooms.unshift(classroom)
  
  return {
    code: 200,
    message: '创建成功',
    data: { id }
  }
})

// AI课堂 - 课堂列表
Mock.mock(/\/api\/classroom\/list/, 'get', function(options) {
  const list = [...classrooms]
  
  // 补充随机生成的课堂数据
  const remainingCount = 10 - list.length
  if (remainingCount > 0) {
    // 生成最近30天内的随机时间
    const getRecentDate = () => {
      const date = new Date()
      date.setDate(date.getDate() - Mock.Random.integer(0, 30))
      date.setHours(Mock.Random.integer(0, 23)) 
      date.setMinutes(Mock.Random.integer(0, 59))
      date.setSeconds(Mock.Random.integer(0, 59))
      return formatDateTime(date)
    }

    for (let i = 0; i < remainingCount; i++) {
      const courseType = Mock.Random.pick(Object.keys(courseData))
      list.push({
        id: Mock.Random.guid(),
        courseType,
        courseName: courseData[courseType].name,
        studentCount: Mock.Random.integer(20, 40),
        duration: 45,
        createTime: getRecentDate(),
        status: Mock.Random.pick(['active', 'draft'])
      })
    }
  }
  
  // 按创建时间降序排序
  list.sort((a, b) => new Date(b.createTime) - new Date(a.createTime))
  
  return {
    code: 200,
    data: {
      list,
      total: 100
    }
  }
})

// AI课堂 - 课堂详情
Mock.mock(/\/api\/classroom\/detail/, 'get', function(options) {
  const id = options.url.split('?id=')[1]
  // 查找已创建的课堂
  let classroom = classrooms.find(item => item.id === id)
  
  if (!classroom) {
    // 如果找不到，返回一个默认的课堂数据
    const courseType = 'basketball'
    classroom = {
      id,
      courseType,
      courseName: courseData[courseType].name,
      studentCount: 30,
      duration: 45,
      genderRatio: 50,
      errorRate: 20,
      responseTime: 3,
      teachingGoals: courseData[courseType].goals,
      teachingProcess: courseData[courseType].process,
      createTime: formatDateTime(new Date()),
      status: 'active'
    }
  }
  
  return {
    code: 200,
    data: classroom
  }
})

// 教案数据
const materials = [
  {
    id: '1',
    title: '篮球运球基础训练教案',
    description: '本教案针对篮球运球技术进行系统训练，包括原地运球、行进间运球、变向运球等基本技术动作的教学方法和练习方案。',
    sport: '篮球',
    cover: 'https://images.freeimages.com/images/large-previews/43a/basketball-ball-on-court-1339617.jpg',
    views: 1580,
    rating: 4.8,
    downloads: 426,
    teachingGoals: '1. 掌握篮球运球的基本姿势\n2. 能够完成原地运球和行进间运球\n3. 掌握简单的变向运球技术\n4. 培养对篮球运动的兴趣',
    teachingProcess: '1. 热身准备活动（10分钟）\n2. 讲解运球基本要领（15分钟）\n3. 原地运球练习（20分钟）\n4. 行进间运球练习（20分钟）\n5. 变向运球练习（15分钟）\n6. 综合运球游戏（15分钟）\n7. 总结与放松（5分钟）',
    // fileType: 'docx'
  },
  {
    id: '2',
    title: '足球传球技术教案',
    description: '系统讲解足球传球技术要领，包括脚内侧传球、脚背传球等多种传球方式的训练方法。',
    sport: '足球',
    cover: 'https://images.alphacoders.com/482/482000.jpg',
    views: 1245,
    rating: 4.7,
    downloads: 385,
    teachingGoals: '1. 掌握脚内侧传球技术\n2. 掌握脚背传球技术\n3. 提高传球准确性\n4. 培养团队配合意识',
    teachingProcess: '1. 热身活动（10分钟）\n2. 传球技术讲解（15分钟）\n3. 定点传球练习（20分钟）\n4. 移动中传接球练习（20分钟）\n5. 分组对抗练习（15分钟）\n6. 实战演练（15分钟）\n7. 总结（5分钟）',
    // fileType: 'pdf'
  },
  {
    id: '3',
    title: '排球垫球技术教学',
    description: '详细介绍排球垫球的基本技术要领，包括准备姿势、手型要求、移动步伐等内容。',
    sport: '排球',
    cover: 'https://images.nbcolympics.com/sites/default/files/2021-03/Oly-16x9-Indoor-Volleyball.png',
    views: 980,
    rating: 4.6,
    downloads: 298,
    teachingGoals: '1. 掌握垫球的基本姿势\n2. 学会正确的手型和击球点\n3. 能够进行简单的移动垫球\n4. 提高对球的控制能力',
    teachingProcess: '1. 准备活动（10分钟）\n2. 垫球要领讲解（15分钟）\n3. 原地垫球练习（20分钟）\n4. 移动垫球练习（20分钟）\n5. 分组练习（15分钟）\n6. 综合训练（15分钟）\n7. 课程总结（5分钟）',
    // fileType: 'doc'
  },
  {
    id: '4',
    title: '田径短跑起跑技术教案',
    description: '专业的短跑起跑技术训练方案，包括起跑器使用、起跑姿势调整、加速跑等环节的详细指导。',
    sport: '田径',
    cover: 'https://thumbs.dreamstime.com/b/ground-field-race-track-road-stadium-fitness-running-track-sports-nobody-pattern-texture-background-261041210.jpg',
    views: 856,
    rating: 4.9,
    downloads: 267,
    teachingGoals: '1. 掌握短跑起跑的基本姿势\n2. 熟练使用起跑器\n3. 提高起跑反应速度\n4. 掌握加速跑技术',
    teachingProcess: '1. 热身活动（15分钟）\n2. 起跑器调整讲解（10分钟）\n3. 起跑姿势练习（20分钟）\n4. 起跑加速练习（20分钟）\n5. 完整起跑训练（15分钟）\n6. 放松整理（10分钟）',
    // fileType: 'txt'
  },
  // ... 继续添加更多教案数据
]

// 获取教案列表的 mock
Mock.mock(/\/api\/materials\/list/, 'get', function(options) {
  const params = parseQuery(options.url)
  const { sport, page = 1, pageSize = 12 } = params
  
  // 根据运动项目筛选
  let filteredList = [...materials]
  if (sport && sport !== 'all') {
    filteredList = materials.filter(item => item.sport === sport)
  }
  
  // 分页处理
  const start = (page - 1) * pageSize
  const end = start + pageSize
  const list = filteredList.slice(start, end)
  
  return {
    code: 200,
    data: {
      list,
      total: filteredList.length
    }
  }
})

// 获取教案详情
Mock.mock(/\/api\/materials\/detail/, 'get', function(options) {
  const { id } = parseQuery(options.url)
  const material = materials.find(item => item.id === id)
  
  return {
    code: 200,
    data: material
  }
})

// 下载教案的 mock
Mock.mock(/\/api\/materials\/download/, 'get', function(options) {
  const { id, fileType } = parseQuery(options.url)
  const material = materials.find(item => item.id === id)
  
  if (!material) {
    return {
      code: 404,
      message: '教案不存在'
    }
  }

  // 生成文档内容
  const content = `${material.title}
运动项目：${material.sport}

教学目标：
${material.teachingGoals}

教学过程：
${material.teachingProcess}

教案说明：
${material.description}
`

  // 根据文件类型生成相应格式的文件
  let blob
  let type

  switch (fileType) {
    case 'docx':
      // 生成简单的 Word 文档
      const docxContent = `
        <html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word'>
        <head>
          <meta charset="utf-8">
          <title>${material.title}</title>
        </head>
        <body>
          <div style="white-space: pre-wrap;">${content}</div>
        </body>
        </html>
      `
      type = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      blob = new Blob([docxContent], { type })
      break

    case 'pdf':
      // 生成简单的 PDF 文档
      const pdfContent = `
        %PDF-1.4
        1 0 obj
        <<
        /Type /Catalog
        /Pages 2 0 R
        >>
        endobj
        2 0 obj
        <<
        /Type /Pages
        /Kids [3 0 R]
        /Count 1
        >>
        endobj
        3 0 obj
        <<
        /Type /Page
        /Parent 2 0 R
        /Resources <<
        /Font <<
        /F1 4 0 R
        >>
        >>
        /MediaBox [0 0 612 792]
        /Contents 5 0 R
        >>
        endobj
        4 0 obj
        <<
        /Type /Font
        /Subtype /Type1
        /BaseFont /Helvetica
        >>
        endobj
        5 0 obj
        <<
        /Length 68
        >>
        stream
        BT
        /F1 12 Tf
        72 720 Td
        (${content.replace(/\n/g, '\r\n')}) Tj
        ET
        endstream
        endobj
        xref
        0 6
        0000000000 65535 f
        0000000009 00000 n
        0000000058 00000 n
        0000000115 00000 n
        0000000254 00000 n
        0000000332 00000 n
        trailer
        <<
        /Size 6
        /Root 1 0 R
        >>
        startxref
        406
        %%EOF
      `
      type = 'application/pdf'
      blob = new Blob([pdfContent], { type })
      break

    case 'txt':
    default:
      type = 'text/plain;charset=utf-8'
      blob = new Blob([content], { type })
      break
  }

  return {
    code: 200,
    data: blob,
    type: type,
    filename: `${material.title}.${fileType}`
  }
})

// 辅助函数：解析 URL 查询参数
function parseQuery(url) {
  const query = {}
  const search = url.split('?')[1]
  if (search) {
    const pairs = search.split('&')
    pairs.forEach(pair => {
      const [key, value] = pair.split('=')
      query[key] = decodeURIComponent(value)
    })
  }
  return query
}

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
  data: Object.entries(courseData).map(([value, { label }]) => ({
    value,
    label
  }))
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

// AI课堂 - 删除课堂
Mock.mock(/\/api\/classroom\/\d+/, 'delete', {
  code: 200,
  message: '删除成功'
})

// AI课堂 - 开始课堂
Mock.mock(/\/api\/classroom\/start/, 'post', function(options) {
  const data = JSON.parse(options.body)
  const id = data.id
  
  // 查找课堂是否存在
  const classroom = classrooms.find(c => c.id === id)
  if (!classroom) {
    return {
      code: 500,
      message: '课堂不存在'
    }
  }

  return {
    code: 200,
    message: '课堂已开始',
    data: {
      roomId: id,
      status: 'active'
    }
  }
})

// AI课堂 - 进入教室
Mock.mock(/\/api\/classroom\/room\/\d+/, 'get', function(options) {
  const id = options.url.match(/\/api\/classroom\/room\/(\d+)/)[1]
  return {
    code: 200,
    data: {
      // 返回课堂相关数据
      id,
      // ... 其他课堂数据
    }
  }
})

// 获取虚拟学生列表
Mock.mock(/\/api\/classroom\/students/, 'get', function(options) {
  const classroomId = options.url.split('?')[1].split('=')[1]
  const classroom = classrooms.find(c => c.id === classroomId)
  const studentCount = classroom?.studentCount || 30
  
  return {
    code: 200,
    data: Array(studentCount).fill(null).map((_, index) => ({
      id: Mock.Random.guid(),
      name: Mock.Random.cname(),
      gender: Mock.Random.pick(['male', 'female']),
      avatar: Mock.Random.image('100x100'),
      personality: Mock.Random.pick(['active', 'passive', 'normal'])
    }))
  }
})

// 发送教师指令并获取学生反馈
Mock.mock(/\/api\/classroom\/command/, 'post', function(options) {
  const { command, step, errorCase } = JSON.parse(options.body)
  
  // 根据指令生成学生反馈
  const generateResponse = () => {
    const responses = []
    const responseTypes = errorCase ? 
      ['positive', 'negative', 'confused'] : 
      ['positive', 'positive', 'confused']
    
    const responseTemplates = {
      positive: [
        '好的，老师！',
        '明白了！',
        '我已经完成了！',
        '这个动作我掌握得不错！'
      ],
      negative: [
        '老师，我有点做不到...',
        '这个动作好难啊',
        '我需要帮助',
        '我觉得很吃力'
      ],
      confused: [
        '老师，能再说一遍吗？',
        '这个要领是什么？',
        '我不太明白',
        '可以示范一下吗？'
      ]
    }
    
    // 随机生成2-4个学生的反馈
    const responseCount = Mock.Random.integer(2, 4)
    for (let i = 0; i < responseCount; i++) {
      const type = Mock.Random.pick(responseTypes)
      responses.push({
        name: Mock.Random.cname(),
        content: Mock.Random.pick(responseTemplates[type])
      })
    }
    
    return responses
  }
  
  return {
    code: 200,
    data: {
      responses: generateResponse()
    }
  }
})

// 更新学生数量
Mock.mock(/\/api\/classroom\/\d+\/student-count/, 'patch', function(options) {
  const classroomId = options.url.match(/\/api\/classroom\/(\d+)\/student-count/)[1]
  const { student_count } = JSON.parse(options.body)
  
  const classroom = classrooms.find(c => c.id === classroomId)
  if (classroom) {
    classroom.studentCount = student_count
  }
  
  return {
    code: 200,
    message: '更新成功'
  }
})

// 添加更新课堂的 mock
Mock.mock(/\/api\/classroom\/update/, 'post', function(options) {
  const data = JSON.parse(options.body)
  const id = data.id
  
  // 查找并更新课堂数据
  const index = classrooms.findIndex(c => c.id === id)
  if (index !== -1) {
    classrooms[index] = {
      ...classrooms[index],
      ...data
    }
  }
  
  return {
    code: 200,
    message: '更新成功'
  }
})

// 添加删除课堂的 mock
Mock.mock(/\/api\/classroom\/delete/, 'post', function(options) {
  const { id } = JSON.parse(options.body)
  
  // 查找并删除课堂
  const index = classrooms.findIndex(c => c.id === id)
  if (index !== -1) {
    classrooms.splice(index, 1)
  }
  
  return {
    code: 200,
    message: '删除成功'
  }
})

export default Mock

import axios from 'axios'
import Mock from 'mockjs'
import { Random } from 'mockjs'

const AI_API_URL = import.meta.env.VITE_DEEPSEEK_API_URL
const API_KEY = import.meta.env.VITE_DEEPSEEK_API_KEY

// 判断是否使用模拟模式
const USE_MOCK = !AI_API_URL || !API_KEY

// 创建AI聊天实例
const aiClient = axios.create({
  baseURL: AI_API_URL,
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  },
  timeout: 30000 // 设置超时时间为30秒
})

// 添加请求拦截器，用于调试
aiClient.interceptors.request.use(
  config => {
    console.log('AI API Request:', config)
    return config
  },
  error => {
    console.error('AI API Request Error:', error)
    return Promise.reject(error)
  }
)

// 添加响应拦截器，用于调试
aiClient.interceptors.response.use(
  response => {
    console.log('AI API Response:', response)
    return response
  },
  error => {
    console.error('AI API Response Error:', error)
    return Promise.reject(error)
  }
)

// 模拟错误案例生成
const mockErrorCase = (courseType, currentStep) => {
  const errorTemplates = {
    basketball: {
      '运球': [
        '老师，我运球的时候球总是弹得很高，控制不好',
        '我感觉手掌拍打篮球，但是球经常跑偏',
        '运球时我的眼睛一直盯着球看',
        '我运球时手臂太僵硬了，不够放松'
      ],
      '投篮': [
        '投篮时我手腕没有很好地完成跟投动作',
        '出手时球总是偏离目标',
        '我投篮时重心不太稳',
        '手肘没有对准篮筐'
      ]
    },
    football: {
      '传球': [
        '老师，我用脚内侧传球时球总是传歪了',
        '我踢球时站立脚的位置不太对',
        '传球时力量掌握不好，球要么太轻要么太重',
        '我感觉踢到球的部位不太准确'
      ]
    },
    volleyball: {
      '垫球': [
        '老师，我垫球时手臂总是不够平',
        '球打到手臂时感觉很疼',
        '我的手肘弯曲了，不知道对不对',
        '垫球时总是没有击中手臂中间位置'
      ]
    }
  }

  const stepType = Object.keys(errorTemplates[courseType] || {})
    .find(type => currentStep.includes(type)) || '基础动作'
  
  const errors = errorTemplates[courseType]?.[stepType] || [
    '老师，我觉得这个动作有点难，不知道是不是做对了',
    '我按照要求做了，但是感觉不太标准',
    '这个动作的要领我还没有完全理解'
  ]

  return Random.pick(errors)
}

// 模拟学生反馈生成
const mockStudentResponse = (courseType, teacherCommand, isCorrection) => {
  const positiveResponses = [
    '明白了，老师！我这就按照您说的来改正。',
    '原来是这样，谢谢老师的指导！',
    '好的，我知道错在哪里了，我会注意改正的。',
    '老师说得对，我感觉现在动作顺多了！',
    '这样做确实感觉更准确，谢谢老师！'
  ]

  const normalResponses = [
    '好的，老师，我会继续练习的！',
    '明白了，这个动作确实需要多加练习。',
    '老师，我觉得我已经进步了一些。',
    '我会按照老师说的继续努力的！',
    '这个动作我大概理解了，需要多练习。'
  ]

  return Random.pick(isCorrection ? positiveResponses : normalResponses)
}

// 生成错误动作描述
export async function generateErrorCase(courseType, courseName, currentStep) {
  try {
    console.log('Generating error case with:', { courseType, courseName, currentStep })
    
    const prompt = `作为一个体育课${courseName}的学生，在学习"${currentStep}"这个动作时，
请模拟一个学生做错动作的场景。要求：
1. 详细描述做错的动作要领
2. 说明这样做的具体表现
3. 表达对这个动作的困惑
4. 用学生的口吻请教老师

例如：
"老师，我按照要求做了运球动作，但是球总是弹得很高，而且手掌好像拍打到球的位置不对，应该怎么改正呢？"
`

    if (USE_MOCK) {
      return mockErrorCase(courseType, currentStep)
    }

    const response = await aiClient.post('', {
      model: 'deepseek-chat',
      messages: [
        {
          role: 'system',
          content: '你是一个正在学习体育动作的学生，会遇到一些典型的动作错误。请用自然的语气描述你的困惑。'
        },
        {
          role: 'user',
          content: prompt
        }
      ],
      temperature: 0.7,
      max_tokens: 150
    })

    if (response.data?.choices?.[0]?.message?.content) {
      return response.data.choices[0].message.content.trim()
    } else {
      throw new Error('Invalid API response format')
    }
  } catch (error) {
    console.error('Error generating error case:', error)
    return mockErrorCase(courseType, currentStep)
  }
}

// 生成学生改正反馈
export async function generateStudentResponse(courseType, courseName, teacherCommand, isCorrection = false) {
  try {
    console.log('Generating student response with:', { courseType, courseName, teacherCommand, isCorrection })
    
    const prompt = `作为一个体育课${courseName}的学生，老师刚刚针对你的错误动作进行了以下指导：
"${teacherCommand}"

请表达：
1. 对老师指导的理解
2. 具体说明你会如何改正动作
3. 描述改正后的正确动作要领
4. 表达感谢和继续练习的决心

例如：
"明白了老师！原来手腕要放松，手指张开，我试着改正一下...这样控球确实稳多了，谢谢老师指导！"`

    if (USE_MOCK) {
      return mockStudentResponse(courseType, teacherCommand, isCorrection)
    }

    const response = await aiClient.post('', {
      model: 'deepseek-chat',
      messages: [
        {
          role: 'system',
          content: '你是一个认真学习的体育课学生，会积极接受老师的指导并努力改正错误。'
        },
        {
          role: 'user',
          content: prompt
        }
      ],
      temperature: 0.7,
      max_tokens: 150
    })

    if (response.data?.choices?.[0]?.message?.content) {
      return response.data.choices[0].message.content.trim()
    } else {
      throw new Error('Invalid API response format')
    }
  } catch (error) {
    console.error('Error generating student response:', error)
    return mockStudentResponse(courseType, teacherCommand, true)
  }
}

// 生成系统提示词
const generateSystemPrompt = (courseType, courseName) => {
  return `你现在是一个体育课${courseName}的虚拟学生。你需要：
1. 根据教师的指令，模拟学生在学习体育动作时可能出现的常见错误
2. 当教师纠正错误后，表现出理解和改正的态度
3. 使用自然的语气，像真实的学生一样交流`
} 
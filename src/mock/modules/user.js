import Mock from 'mockjs'

// 存储验证码和uuid的映射关系
const captchaMap = new Map()

// 生成验证码图片的base64编码
const generateCaptcha = () => {
  const captcha = Mock.Random.string('0123456789', 4)
  const uuid = Mock.Random.uuid()
  // 存储验证码
  captchaMap.set(uuid, captcha)
  
  return {
    code: 200,
    msg: '操作成功',
    img: Mock.Random.dataImage('120x40', captcha),
    uuid: uuid
  }
}

export default {
  // 获取验证码
  getCodeImg: () => {
    return generateCaptcha()
  },

  // 登录
  login: (config) => {
    const body = JSON.parse(config.body)
    const { username, password, code, uuid } = body
    
    // 验证码校验
    const validCode = captchaMap.get(uuid)
    if (!validCode) {
      return {
        code: 500,
        msg: '验证码已过期'
      }
    }
    
    if (code.toLowerCase() !== validCode.toLowerCase()) {
      return {
        code: 500,
        msg: '验证码错误'
      }
    }
    
    // 验证码使用后删除
    captchaMap.delete(uuid)

    // 用户名密码校验
    if (username === 'admin' && password === '123456') {
      return {
        code: 200,
        msg: '登录成功',
        data: {
          token: Mock.Random.uuid(),
          userInfo: {
            userId: '1',
            username: 'admin',
            nickname: '管理员',
            avatar: Mock.Random.image('100x100', '#50B347', '#FFF', 'ISTM')
          }
        }
      }
    }
    
    return {
      code: 500,
      msg: '用户名或密码错误'
    }
  },

  // 获取用户信息
  getInfo: () => {
    return {
      code: 200,
      msg: '操作成功',
      data: {
        user: {
          userId: '1',
          username: 'admin',
          nickname: '管理员',
          avatar: Mock.Random.image('100x100', '#50B347', '#FFF', 'ISTM'),
          roles: ['admin'],
          permissions: ['*:*:*']
        }
      }
    }
  },

  // 退出登录
  logout: () => {
    return {
      code: 200,
      msg: '退出成功'
    }
  }
} 
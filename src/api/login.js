import request from '@/utils/request'

// 登录方法
export function login(data) {
  return request({
    url: '/auth/login',
    method: 'post',
    data
  })
}

// 获取验证码
export function getCodeImg() {
  return request({
    url: '/auth/captcha',
    method: 'get',
    timeout: 20000
  })
}

// 获取用户信息
export function getInfo() {
  return request({
    url: '/users/info',
    method: 'get'
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/auth/logout',
    method: 'post'
  })
}

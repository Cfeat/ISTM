import request from '@/utils/request'

// 登录方法
export function login(userInfo) {
  return request({
    url: '/login',
    method: 'post',
    data: userInfo,
    mock: true
  })
}

// 获取用户信息
export function getInfo() {
  return request({
    url: '/getInfo',
    method: 'get',
    mock: true
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/logout',
    method: 'post',
    mock: true
  })
}

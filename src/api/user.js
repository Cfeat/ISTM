import request from '@/utils/request'

// 更新用户信息
export function updateUserInfo(data) {
  return request({
    url: '/api/user/update',
    method: 'post',
    data
  })
}

// 更新密码
export function updatePassword(data) {
  return request({
    url: '/api/user/password',
    method: 'post',
    data
  })
}

// 更新头像
export function updateAvatar(data) {
  return request({
    url: '/api/user/avatar',
    method: 'post',
    data
  })
}

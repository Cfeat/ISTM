import request from '@/utils/request'

// 获取系统设置
export function getSettings() {
  return request({
    url: '/api/settings',
    method: 'get'
  })
}

// 保存系统设置
export function saveSettings(data) {
  return request({
    url: '/api/settings',
    method: 'post',
    data
  })
}

// 重置系统设置
export function resetSettings() {
  return request({
    url: '/api/settings/reset',
    method: 'post'
  })
} 
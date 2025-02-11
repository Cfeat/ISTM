import request from '@/utils/request'

// 获取教案列表
export function getMaterialsList(params) {
  return request({
    url: '/api/materials',
    method: 'get',
    params
  })
} 
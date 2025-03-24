import request from '@/utils/request'

// 获取教案列表
export function getMaterialsList(params) {
  return request({
    url: '/api/materials/list',
    method: 'get',
    params
  })
}

// 获取教案详情
export function getMaterialDetail(id) {
  return request({
    url: '/api/materials/detail',
    method: 'get',
    params: { id }
  })
}

// 下载教案
export function downloadMaterial(id, fileType) {
  return request({
    url: '/api/materials/download',
    method: 'get',
    params: { id, fileType },
    responseType: 'blob'
  })
} 
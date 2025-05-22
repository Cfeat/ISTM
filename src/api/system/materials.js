import request from '@/utils/request'

// 获取教案列表
export function getMaterialsList(params) {
  return request({
    url: '/system/plan/list',
    method: 'get',
    params
  })
}

// 获取教案详情
export function getMaterialDetail(id) {
  return request({
    url: '/system/plan/' + id,
    method: 'get'
  })
}

// 下载教案
export function downloadMaterial(id, fileType) {
  return request({
    url: '/system/plan/download',
    method: 'get',
    params: { planId: id, fileType },
    responseType: 'blob'
  })
}

// 上传教案 (共享上传接口)
export function uploadTeachingPlan(data) {
  return request({
    url: '/system/plan/upload',
    method: 'post',
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    data
  })
}

// 应用教案到创建课堂
export function applyPlanToClass(planId) {
  return request({
    url: '/system/plan/apply/' + planId,
    method: 'get'
  })
}

// 记录教案查看次数
export function recordPlanView(planId) {
  return request({
    url: '/system/plan/view/' + planId,
    method: 'put'
  })
}

// 提交教案评分
export function ratePlan(planId, score) {
  return request({
    url: '/system/plan/rate',
    method: 'post',
    data: {
      planId,
      score
    }
  })
}

// 记录教案下载
export function recordPlanDownload(planId, fileType) {
  return request({
    url: '/system/plan/download/record',
    method: 'put',
    params: {
      planId,
      fileType
    }
  })
} 
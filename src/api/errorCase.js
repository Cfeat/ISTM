import request from '@/utils/request'

// 添加错误案例
export function addErrorCase(data) {
  return request({
    url: '/api/error-cases',
    method: 'post',
    data
  })
}

// // 获取教案相关的错误案例
// export function getErrorCases(planId) {
//   return request({
//     url: `/api/lesson-plans/${planId}/error-cases`,
//     method: 'get'
//   })
// }

// 获取错误案例列表
export function getErrorCaseList(params) {
  return request({
    url: '/api/error-cases',
    method: 'get',
    params
  })
}

// 获取错误案例详情
export function getErrorCaseDetail(id) {
  return request({
    url: `/api/error-cases/${id}`,
    method: 'get'
  })
}

// 更新错误案例
export function updateErrorCase(id, data) {
  return request({
    url: `/api/error-cases/${id}`,
    method: 'put',
    data
  })
}

// 删除错误案例
export function deleteErrorCase(id) {
  return request({
    url: `/api/error-cases/${id}`,
    method: 'delete'
  })
} 
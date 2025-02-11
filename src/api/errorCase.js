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
import request from '@/utils/request'

// 获取教案列表
export function getTeachingList(params) {
  return request({
    url: '/api/lesson-plans',
    method: 'get',
    params
  })
}

// 删除教案
export function deleteTeaching(id) {
  return request({
    url: `/api/lesson-plans/${id}`,
    method: 'delete'
  })
}

// 编辑教案
export function updateTeaching(data) {
  return request({
    url: `/api/lesson-plans/${data.plan_id}`,
    method: 'put',
    data
  })
}

// 新增教案
export function addTeaching(data) {
  return request({
    url: '/api/lesson-plans',
    method: 'post',
    data
  })
}

// // 获取教案相关的错误案例
// export function getTeachingErrors(planId) {
//   return request({
//     url: `/api/lesson-plans/${planId}/error-cases`,
//     method: 'get'
//   })
// } 
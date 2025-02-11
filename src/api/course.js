import request from '@/utils/request'

// 获取课程列表
export function getCourseList(params) {
  return request({
    url: '/api/courses',
    method: 'get',
    params
  })
}

// 获取课程详情
export function getCourseDetail(id) {
  return request({
    url: `/api/courses/${id}`,
    method: 'get'
  })
} 
import request from '@/utils/request'

// 获取虚拟课堂列表
export function getClassroomList(params) {
  return request({
    url: '/api/virtual-classrooms',
    method: 'get',
    params
  })
}

// 创建虚拟课堂
export function createClassroom(data) {
  return request({
    url: '/api/classroom/create',
    method: 'post',
    data
  })
}

// 更新学生数量
export function updateStudentCount(classroomId, count) {
  return request({
    url: `/api/classroom/${classroomId}/student-count`,
    method: 'patch',
    data: { student_count: count }
  })
}

// 上传教案文件
export function uploadTeachingPlan(data) {
  return request({
    url: '/api/classroom/upload',
    method: 'post',
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    data
  })
}

// 获取课程类型列表
export function getCourseTypes() {
  return request({
    url: '/api/classroom/types',
    method: 'get'
  })
}

// 获取课堂详情
export function getClassroomDetail(id) {
  return request({
    url: '/api/classroom/detail',
    method: 'get',
    params: { id }
  })
} 
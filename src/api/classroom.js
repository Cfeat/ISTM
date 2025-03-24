import request from '@/utils/request'

// 获取课堂列表
export function getClassroomList(params) {
  return request({
    url: '/api/classroom/list',
    method: 'get',
    params
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

// 更新课堂信息
export function updateClassroom(id, data) {
  return request({
    url: '/api/classroom/update',
    method: 'post',
    data: {
      id,
      ...data
    }
  })
}

// 删除课堂
export function deleteClassroom(id) {
  return request({
    url: '/api/classroom/delete',
    method: 'post',
    data: { id }
  })
}

// 创建课堂
export function createClassroom(data) {
  return request({
    url: '/api/classroom/create',
    method: 'post',
    data
  })
}

// 开始上课
export function startClassroom(id) {
  return request({
    url: '/api/classroom/start',
    method: 'post',
    data: { id }
  })
}

// 获取虚拟学生列表
export function getVirtualStudents(classroomId) {
  return request({
    url: '/api/classroom/students',
    method: 'get',
    params: { classroomId }
  })
}

// 发送教师指令
export function sendTeacherCommand(classroomId, data) {
  return request({
    url: '/api/classroom/command',
    method: 'post',
    data: {
      ...data,
      classroomId
    }
  })
}

// 获取错误案例列表
export function getErrorCases(classroomId) {
  return request({
    url: `/api/classroom/${classroomId}/error-cases`,
    method: 'get'
  })
}

// 更新学生数量
export function updateStudentCount(classroomId, count) {
  return request({
    url: `/api/classroom/${classroomId}/student-count`,
    method: 'patch',
    data: { count }
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
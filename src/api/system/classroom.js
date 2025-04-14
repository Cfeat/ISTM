import request from '@/utils/request'

// 查询课堂列表
export function listClassroom(query) {
  return request({
    url: '/system/classroom/list',
    method: 'get',
    params: query
  })
}

// 查询课堂详细
export function getClassroom(classroomId) {
  return request({
    url: '/system/classroom/' + classroomId,
    method: 'get'
  })
}

// 新增课堂
export function addClassroom(data) {
  return request({
    url: '/system/classroom',
    method: 'post',
    data: data
  })
}

// 修改课堂
export function updateClassroom(data) {
  return request({
    url: '/system/classroom',
    method: 'put',
    data: data
  })
}

// 删除课堂
export function delClassroom(classroomId) {
  return request({
    url: '/system/classroom/' + classroomId,
    method: 'delete'
  })
}

// 开始上课
export function startClassroom(classroomId) {
  return request({
    url: '/system/classroom/start/' + classroomId,
    method: 'put'
  })
}

// 获取虚拟学生列表
export function getVirtualStudents(classroomId) {
  return request({
    url: '/system/classroom/students/' + classroomId,
    method: 'get'
  })
}

// 发送教师指令
export function sendTeacherCommand(data) {
  return request({
    url: '/system/classroom/command',
    method: 'post',
    data: data
  })
}

// 获取错误案例列表
export function getErrorCases(classroomId) {
  return request({
    url: '/system/classroom/error-cases/' + classroomId,
    method: 'get'
  })
}

// 更新学生数量
export function updateStudentCount(data) {
  return request({
    url: '/system/classroom/student-count',
    method: 'put',
    data: data
  })
}

// 上传教案文件
export function uploadTeachingPlan(data) {
  return request({
    url: '/system/classroom/upload',
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
    url: '/system/classroom/types',
    method: 'get'
  })
} 
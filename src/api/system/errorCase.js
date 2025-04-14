import request from '@/utils/request'

// 查询错误案例列表
export function listErrorCase(query) {
  return request({
    url: '/system/errorCase/list',
    method: 'get',
    params: query
  })
}

// 查询错误案例详细
export function getErrorCase(caseId) {
  return request({
    url: '/system/errorCase/' + caseId,
    method: 'get'
  })
}

// 新增错误案例
export function addErrorCase(data) {
  return request({
    url: '/system/errorCase',
    method: 'post',
    data: data
  })
}

// 修改错误案例
export function updateErrorCase(data) {
  return request({
    url: '/system/errorCase',
    method: 'put',
    data: data
  })
}

// 删除错误案例
export function delErrorCase(caseId) {
  return request({
    url: '/system/errorCase/' + caseId,
    method: 'delete'
  })
}

// 获取课堂的错误案例列表
export function getClassroomErrorCases(classroomId) {
  return request({
    url: '/system/errorCase/classroom/' + classroomId,
    method: 'get'
  })
} 
import request from '@/utils/request'

// 获取教案列表
export function getTeachingList() {
  return request({
    url: '/teaching/list',
    method: 'get',
    mock: true
  })
}

// 删除教案
export function deleteTeaching(id) {
  return request({
    url: `/teaching/${id}`,
    method: 'delete',
    mock: true
  })
}

// 编辑教案
export function updateTeaching(data) {
  return request({
    url: '/teaching/update',
    method: 'put',
    data,
    mock: true
  })
}

// 新增教案
export function addTeaching(data) {
  return request({
    url: '/teaching/add',
    method: 'post',
    data,
    mock: true
  })
} 
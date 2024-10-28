import request from '@/utils/request'

// 查询用户详情列表
export function listInfo(query) {
  return request({
    url: '/user/info/list',
    method: 'get',
    params: query
  })
}

// 查询用户详情详细
export function getInfo(id) {
  return request({
    url: '/user/info/' + id,
    method: 'get'
  })
}

// 新增用户详情
export function addInfo(data) {
  return request({
    url: '/user/info',
    method: 'post',
    data: data
  })
}

// 修改用户详情
export function updateInfo(data) {
  return request({
    url: '/user/info',
    method: 'put',
    data: data
  })
}

// 删除用户详情
export function delInfo(id) {
  return request({
    url: '/user/info/' + id,
    method: 'delete'
  })
}

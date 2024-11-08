import request from '@/utils/request'

// 查询标签（分类）列表
export function listTag(query) {
  return request({
    url: '/post/tag/list',
    method: 'get',
    params: query
  })
}

// 查询标签（分类）详细
export function getTag(id) {
  return request({
    url: '/post/tag/' + id,
    method: 'get'
  })
}

// 新增标签（分类）
export function addTag(data) {
  return request({
    url: '/post/tag',
    method: 'post',
    data: data
  })
}

// 修改标签（分类）
export function updateTag(data) {
  return request({
    url: '/post/tag',
    method: 'put',
    data: data
  })
}

// 删除标签（分类）
export function delTag(id) {
  return request({
    url: '/post/tag/' + id,
    method: 'delete'
  })
}

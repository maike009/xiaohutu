import { http } from '@/utils/http'
/**
 * 获取帖子数据
 */
export function getPostListAPI(query) {
  const { pageNum, pageSize } = query
  return http({
    url: '/post/post/frontList',
    method: 'GET',
    data: query
  })
}
/**
 * 获取帖子详情
 */
export function getPostDetailAPI(id) {
  return http({
    url: `/post/post/${id}`,
    method: 'GET'
  })
}

/**
 * 发布帖子
 */
export function publishPostAPI(data) {
  return http({
    url: '/post/post',
    method: 'POST',
    data
  })
}

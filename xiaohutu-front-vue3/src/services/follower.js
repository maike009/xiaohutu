import { http } from '@/utils/http'
/**
 * 新增关注记录
 */
export function addFollowerAPI(data) {
  return http({
    url: '/post/follower',
    method: 'POST',
    data
  })
}

/**
 * 修改历史记录
 */
export function updateFollowerAPI(data) {
  return http({
    url: '/post/follower',
    method: 'PUT',
    data
  })
}

/**
 * 删除历史记录
 */
export function delFollowerAPI(ids) {
  return http({
    url: `/post/follower/${ids}`,
    method: 'delete'
  })
}

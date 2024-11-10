import { http } from '@/utils/http'

// 新增点赞
export function addLikeAPI(data) {
  return http({
    url: '/post/like',
    method: 'post',
    data: data
  })
}

// 删除点赞
export function delLikeAPI(data) {
  return http({
    url: '/post/like/delete',
    method: 'delete',
    data: data
  })
}

import { http } from '@/utils/http'

// 新增收藏
export function addFavoriteAPI(data) {
  return http({
    url: '/post/collection',
    method: 'post',
    data: data
  })
}

// 删除收藏
export function delFavoriteAPI(data) {
  return http({
    url: '/post/collection/delete',
    method: 'delete',
    data: data
  })
}

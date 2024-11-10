// 草稿相关 API
import { http } from '@/utils/http'

export function getDraftListAPI(params) {
  return http({
    url: '/draft/list',
    method: 'GET',
    params
  })
}

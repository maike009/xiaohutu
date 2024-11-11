import { http } from '@/utils/http'
/**
 * 新增历史记录
 */
export function addHistoryAPI(data) {
  return http({
    url: '/post/history',
    method: 'POST',
    data
  })
}

/**
 * 修改历史记录
 */
export function updateHistoryAPI(data) {
  return http({
    url: '/post/history',
    method: 'PUT',
    data
  })
}

/**
 * 删除历史记录
 */
export function delHistoryAPI(ids) {
  return http({
    url: `/post/history/${ids}`,
    method: 'delete'
  })
}

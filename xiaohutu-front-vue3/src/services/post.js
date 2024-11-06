import { http } from '@/utils/http'
/**
 * 获取帖子数据
 */
export function getPostListAPI(query) {
  const { pageNum, pageSize } = query
  return http({
    url: '/post/post/frontList',
    method: 'get',
    params: {
      pageNum,
      pageSize
    }
  })
}

import { http } from '@/utils/http'

// 获取标签数据
export function getTagListAPI() {
  return http({
    url: '/post/tag/list',
    method: 'GET',
    data: {
      pageSize: 1000
    }
  })
}

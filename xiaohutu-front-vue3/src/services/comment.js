import { http } from '@/utils/http'

/**
 * 获取评论列表
 * @param postId
 * @param pageNum
 * @param pageSize
 * @returns {Promise<T>}
 */
export function getCommentListAPI(postId, pageNum, pageSize, parentCommentId) {
  return http({
    url: `/post/comment/list`,
    method: 'GET',
    data: {
      postId,
      pageNum,
      pageSize,
      parentCommentId
    }
  })
}

/**
 * 新增评论
 */
export function addCommentAPI(data) {
  return http({
    url: '/post/comment',
    method: 'POST',
    data
  })
}

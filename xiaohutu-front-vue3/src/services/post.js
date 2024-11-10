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
 * 获取我的帖子列表
 */
export function getMyPostListAPI(query) {
  const { pageNum, pageSize } = query
  return http({
    url: '/post/post/myList',
    method: 'GET',
    data: query
  })
}

/**
 * 获取我点赞的帖子列表
 */
export function getMyLikePostListAPI(query) {
  const { pageNum, pageSize } = query
  return http({
    url: '/post/post/myLikeList',
    method: 'GET',
    data: query
  })
}

/**
 * 获取我收藏的帖子列表
 */
export function getMyFavoritePostListAPI(query) {
  const { pageNum, pageSize } = query
  return http({
    url: '/post/post/myFavoriteList',
    method: 'GET',
    data: query
  })
}

/**
 * 获取我的草稿箱
 */
export function getMyDraftPostListAPI(query) {
  const { pageNum, pageSize } = query
  return http({
    url: '/post/post/draftList',
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
 * 修改帖子
 */
export function updatePostAPI(data) {
  return http({
    url: '/post/post',
    method: 'PUT',
    data
  })
}

/**
 * 获取我草稿箱的帖子详情
 */
export function getMyDraftPostDetailAPI(id) {
  return http({
    url: `/post/post/draft/${id}`,
    method: 'GET'
  })
}

/**
 * 删除帖子
 */
export function delPostAPI(ids) {
  return http({
    url: `/post/post/${ids}`,
    method: 'delete'
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

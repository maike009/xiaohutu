import { http } from '@/utils/http'

// 获取自己信息
export function getUserDetailAPI() {
  return http({
    url: '/system/user/myInfo',
    method: 'GET'
  })
}
// 获取个人信息
export function getUserInfoAPI(id) {
  return http({
    url: '/system/user/userInfo/' + id,
    method: 'GET'
  })
}
// 修改个人信息
export function updateUserDetailAPI(data) {
  return http({
    url: '/system/user/editMyInfo',
    method: 'POST',
    data
  })
}
// 获取粉丝列表
export function getFollowingUserListAPI(query) {
  return http({
    url: '/system/user/followingUsers',
    method: 'GET',
    data: query
  })
}
// 获取关注列表
export function getFollowerUserListAPI(query) {
  return http({
    url: '/system/user/followers',
    method: 'GET',
    data: query
  })
}

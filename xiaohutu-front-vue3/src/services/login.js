import { http } from '@/utils/http'

export function loginAPI(loginUser) {
  return http({
    url: '/login',
    method: 'POST',
    data: loginUser
  })
}
// 退出登录
export function logoutAPI() {
  return http({
    url: '/logout',
    method: 'POST'
  })
}

// 注册方法
export function registerAPI(data) {
  return http({
    url: '/register',
    headers: {
      isToken: false
    },
    method: 'POST',
    data: data
  })
}

// 获取验证码
export function getCodeImgAPI() {
  return http({
    url: '/captchaImage',
    header: {
      isToken: false
    },
    method: 'GET',
    timeout: 20000
  })
}

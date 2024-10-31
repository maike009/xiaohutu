import { http } from '@/utils/http'

export function loginAPI(loginUser) {
  return http({
    url: '/frontLogin',
    method: 'POST',
    data: {
      userName: loginUser.userName,
      password: loginUser.password,
      code: loginUser.code,
      uuid: loginUser.uuid
    }
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

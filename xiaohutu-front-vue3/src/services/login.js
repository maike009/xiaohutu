import { http } from '@/utils/http'

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

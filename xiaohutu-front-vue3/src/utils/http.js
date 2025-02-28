// src/utils/http.ts

// 请求基地址
import { useUserStore } from '@/stores'

const baseURL = 'http://localhost:8080'
// const baseURL = 'http://192.168.0.185:8080'

// 拦截器配置
const httpInterceptor = {
  // 拦截前触发
  invoke(options) {
    // 1. 非 http 开头需拼接地址
    if (!options.url.startsWith('http')) {
      options.url = baseURL + options.url
    }
    // 2. 请求超时
    options.timeout = 10000
    // 3. 添加小程序端请求头标识
    options.header = {
      'source-client': 'h5',
      ...options.header
    }

    // 4. 添加 token 请求头标识
    const userStore = useUserStore()
    const token = userStore.token
    if (token) {
      options.header.Authorization = token
    }
  }
}

// 拦截 request 请求
uni.addInterceptor('request', httpInterceptor)
// 拦截 uploadFile 文件上传
uni.addInterceptor('uploadFile', httpInterceptor)

/**
 * 请求函数
 * @param  UniApp.RequestOptions
 * @returns Promise
 *  1. 返回 Promise 对象，用于处理返回值类型
 *  2. 获取数据成功
 *    2.1 提取核心数据 res.data
 *    2.2 添加类型，支持泛型
 *  3. 获取数据失败
 *    3.1 401错误  -> 清理用户信息，跳转到登录页
 *    3.2 其他错误 -> 根据后端错误信息轻提示
 *    3.3 网络错误 -> 提示用户换网络
 */
export const http = (options) => {
  // 1. 返回 Promise 对象
  return new Promise((resolve, reject) => {
    uni.request({
      ...options,
      // 响应成功
      success(res) {
        // 状态码 2xx，参考 axios 的设计
        if (res.statusCode >= 200 && res.statusCode < 300) {
          // console.log(res.data)
          // 提取核心数据 res.data
          if (res.data?.code >= 200 && res.data?.code < 300) {
            resolve(res.data)
          } else if (res.data?.code === 401) {
            // 401错误  -> 清理用户信息，跳转到登录页
            uni.showToast({
              icon: 'none',
              title: '登录过期，请重新登录'
            })
            const userStore = useUserStore() // 假设你已经引入了 useMemberStore
            userStore.clearProfile()
            userStore.clearToken()
            uni.redirectTo({ url: '/pages/login/login' })
            reject(res)
          } else {
            // 其他错误 -> 根据后端错误信息轻提示
            uni.showToast({
              icon: 'none',
              title: res.data?.msg || '请求错误'
            })
            reject(res)
          }
        } else if (res.statusCode === 401) {
          // 注意：这里重复处理了401的情况，可以考虑合并到上面的逻辑中
          // 401错误  -> 清理用户信息，跳转到登录页
          const userStore = useUserStore()
          userStore.clearProfile()
          uni.navigateTo({ url: '/pages/login/login' })
          reject(res)
        } else {
          // 其他错误 -> 根据后端错误信息轻提示
          uni.showToast({
            icon: 'none',
            title: res.data?.msg || '请求错误'
          })
          reject(res)
        }
      },
      // 响应失败
      fail(err) {
        uni.showToast({
          icon: 'none',
          title: '网络错误，换个网络试试'
        })
        reject(err)
      }
    })
  })
}

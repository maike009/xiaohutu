import { defineStore } from 'pinia'
import { ref } from 'vue'

// 定义 Store
export const useUserStore = defineStore(
  'userFront',
  () => {
    // 前台用户信息
    const profile = ref()

    // 保存用户信息，登录时使用
    const setProfile = (val) => {
      profile.value = val
    }

    // 清理用户信息，退出时使用
    const clearProfile = () => {
      profile.value = undefined
    }
    // 请求时获取的token
    const token = ref()
    // 设置token
    function setToken(val) {
      token.value = val
    }
    // 清理token
    function clearToken() {
      token.value = undefined
    }

    // 记得 return
    return {
      token,
      setToken,
      clearToken,
      profile,
      setProfile,
      clearProfile,
    }
  },
  // TODO: 持久化
  {
    persist: {
      storage: {
        setItem(key, value) {
          uni.setStorageSync(key, value)
        },
        getItem(key) {
          return uni.getStorageSync(key)
        },
      },
    },
  },
)

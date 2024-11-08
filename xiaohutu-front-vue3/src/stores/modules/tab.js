import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useTabStore = defineStore('lastTab', () => {
  const lastTab = ref(0)
  const setTaBList = (val) => {
    lastTab.value = val
  }

  return {
    lastTab,
    setTaBList
  }
})

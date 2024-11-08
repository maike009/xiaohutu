<template>
  <!-- 页面内容 -->
  <view></view>
</template>

<script setup>
// 在某个tab页面的`onShow`生命周期中
import { onMounted } from 'vue'
import { useTabStore } from '@/stores'

onMounted(() => {
  const tabStore = useTabStore()
  console.log('ADD上一次的tab路径', tabStore.lastTab)
  console.log('ja  ddd')
  uni.redirectTo({
    url: '/pages/addPost/addPost?lastPath=' + tabStore.lastTab
  })
})
</script>

<style lang="scss" scoped>
/* 样式代码 */
</style>

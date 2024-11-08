<template>
  <view> 个人中心 </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { useTabStore } from '@/stores'
const userInfo = ref({})
onShow(() => {
  const tabStore = useTabStore()
  console.log('上一次的tab路径', tabStore.lastTab)
  tabStore.setTaBList('user')
})
onMounted(() => {})
</script>

<style lang="scss">
.example {
  padding: 15px;
  background-color: #fff;
}

.segmented-control {
  margin-bottom: 15px;
}

.button-group {
  margin-top: 15px;
  display: flex;
  justify-content: space-around;
}

.form-item {
  display: flex;
  align-items: center;
}

.button {
  display: flex;
  align-items: center;
  height: 35px;
  margin-left: 10px;
}
</style>

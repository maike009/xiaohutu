<template>
  <search-bar @get-post-list="handleGetPostList"></search-bar>
  <TagScroll />
  <post-component :searchValue="searchValue"></post-component>
</template>

<script setup>
import SearchBar from '@/components/serach/SearchBar.vue'
import PostComponent from '@/components/postcontent/postComponent.vue'
import { ref } from 'vue'
import TagScroll from '@/components/TagScroll.vue'
import { onShow } from '@dcloudio/uni-app'
import { useTabStore } from '@/stores'

const searchValue = ref('')
function handleGetPostList(value) {
  console.log(value, 'from child')
  searchValue.value = value
}
onShow(() => {
  const tabStore = useTabStore()
  console.log('上一次的tab路径', tabStore.lastTab)
  tabStore.setTaBList('index')
})
</script>

<style scoped></style>

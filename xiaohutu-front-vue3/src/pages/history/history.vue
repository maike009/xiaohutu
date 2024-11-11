<template>
  <view>
    <post-component
      :postList="postList"
      :status="status"
      :contentText="contentText"
      :loadMorePosts="loadMorePosts"
      :isHistory="isHistory"
    ></post-component>
  </view>
</template>

<script setup lang="ts">
import PostComponent from '@/components/postcontent/postComponent.vue'
import { ref } from 'vue'
import { baseUrl } from '@/utils/base'
import { getHistoryPostListAPI } from '@/services/post'
import { onLoad } from '@dcloudio/uni-app'
import { useUserStore } from '@/stores'
// 帖子列表数据
const postList = ref([])
const status = ref('more')
const contentText = ref({
  contentdown: '查看更多',
  contentrefresh: '加载中',
  contentnomore: '没有更多'
})
const isHistory = ref(true)
const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  userId: null
})
onLoad(() => {
  getHistoryPostList()
})

// 获取我的帖子列表
async function getHistoryPostList() {
  try {
    queryParams.value.userId = useUserStore().profile.userId
    const res = await getHistoryPostListAPI(queryParams.value)
    const rs = res.rows.map((item) => {
      const imgUrlArr = (item.contentImage ?? '').split(',')
      item.contentImage = baseUrl + imgUrlArr[0]
      return item
    })
    postList.value = rs
  } catch (error) {
    console.error('加载帖子数据失败', error)
  }
}
// 帖子数据封装结果
const loadMorePosts = async () => {
  if (status.value === 'loading' || status.value === 'no-more') return

  status.value = 'loading'
  queryParams.value.pageNum++
  try {
    const res = await getHistoryPostListAPI(queryParams.value)

    if (res.rows.length > 0) {
      const newPosts = res.rows.map((item) => {
        const imgUrlArr = (item.contentImage ?? '').split(',')
        item.contentImage = baseUrl + imgUrlArr[0]
        return item
      })
      postList.value = [...postList.value, ...newPosts]
      status.value = 'more'
    } else {
      status.value = 'no-more'
    }
  } catch (error) {
    console.error('加载更多帖子失败', error)
    status.value = 'more'
  }
}
</script>

<style scoped lang="scss"></style>

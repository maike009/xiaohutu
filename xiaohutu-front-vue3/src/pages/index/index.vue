<template>
  <search-bar @get-search-value="handleSearchValue"></search-bar>
  <TagScroll @get-post-list-tag="getPostListByTag" />
  <post-component
    :postList="postList"
    :status="status"
    :contentText="contentText"
    :loadMorePosts="loadMorePosts"
  ></post-component>
</template>

<script setup>
import SearchBar from '@/components/serach/SearchBar.vue'
import PostComponent from '@/components/postcontent/postComponent.vue'
import { ref, onMounted, watch } from 'vue'
import TagScroll from '@/components/TagScroll.vue'
import { onShow } from '@dcloudio/uni-app'
import { useTabStore, useUserStore } from '@/stores'
import { getUserDetailAPI } from '@/services/user'
import { getPostListAPI } from '@/services/post'
import { baseUrl } from '@/utils/base'

const searchValue = ref('')
function handleSearchValue(value) {
  console.log(value, 'from child')
  searchValue.value = value
  queryParams.value.pageNum = 1
  queryParams.value.pageSize = 10
  queryParams.value.searchValue = value
}
// 根据标签获取帖子
function getPostListByTag(tagId) {
  console.log('tagiddd', tagId)
  queryParams.value.pageNum = 1
  queryParams.value.pageSize = 10
  queryParams.value.tagId = ''
  if (tagId !== 0) {
    queryParams.value.tagId = tagId
  }
  loadPosts()
}
onShow(() => {
  const tabStore = useTabStore()
  console.log('上一次的tab路径', tabStore.lastTab)
  tabStore.setTaBList('index')
})
async function getUserInfo() {
  const res = await getUserDetailAPI()
  useUserStore().setProfile(res.data)
}
onMounted(() => {
  getUserInfo()
  loadPosts()
})
// 帖子列表数据
const postList = ref([])
const status = ref('more')
const contentText = ref({
  contentdown: '查看更多',
  contentrefresh: '加载中',
  contentnomore: '没有更多'
})

const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  searchValue: '',
  tagId: ''
})
watch(
  () => queryParams.value.searchValue,
  (newValue) => {
    loadPosts()
  }
)

const loadPosts = async () => {
  try {
    const res = await getPostListAPI(queryParams.value)
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

const loadMorePosts = async () => {
  if (status.value === 'loading' || status.value === 'no-more') return

  status.value = 'loading'
  queryParams.value.pageNum++

  try {
    const res = await getPostListAPI(queryParams.value)
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

<style scoped></style>

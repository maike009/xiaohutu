<!--<template>-->
<!--  <view class="container">-->
<!--    <view class="grid">-->
<!--      <view class="item" v-for="(item, index) in postList" :key="index">-->
<!--        <image-->
<!--          class="item-image"-->
<!--          :src="item.contentImage"-->
<!--          alt=""-->
<!--          @load="onImageLoad(item)"-->
<!--          :style="{ aspectRatio: item.aspectRatio ? item.aspectRatio : 1 }"-->
<!--        />-->
<!--        <view class="item-text">{{ item.contentText }}</view>-->
<!--      </view>-->
<!--    </view>-->
<!--    <uni-load-more :status="status" :content-text="contentText" />-->
<!--  </view>-->
<!--</template>-->
<!--<script setup>-->
<!--import { ref, defineProps, watch } from 'vue'-->
<!--import { onLoad, onReachBottom } from '@dcloudio/uni-app'-->
<!--import { getPostListAPI } from '@/services/post'-->

<!--const status = ref('more')-->

<!--const queryParams = ref({-->
<!--  pageNum: 1,-->
<!--  pageSize: 20,-->
<!--  nickName: null,-->
<!--  contentText: null-->
<!--})-->
<!--const contentText = ref({-->
<!--  contentdown: '查看更多',-->
<!--  contentrefresh: '加载中',-->
<!--  contentnomore: '没有更多'-->
<!--})-->
<!--const postList = ref([])-->
<!--onLoad(async () => {-->
<!--  const res = await getPostListAPI(queryParams.value)-->
<!--  const rs = res.rows.map((item) => {-->
<!--    const imgUrlArr = (item.contentImage ?? '').split(',')-->
<!--    item.contentImage = 'http://localhost:8080' + imgUrlArr[0]-->
<!--    return item-->
<!--  })-->
<!--  postList.value = res.rows-->
<!--  console.log('页面加载帖子数据', res, rs)-->
<!--})-->
<!--onReachBottom(() => {-->
<!--  status.value = 'loading'-->
<!--  setTimeout(() => {-->
<!--    status.value = 'no-more'-->
<!--  }, 3000)-->
<!--})-->
<!--// 图片加载事件：动态计算 aspect-ratio-->
<!--const onImageLoad = (item) => {-->
<!--  const image = new Image()-->
<!--  image.src = item.contentImage-->
<!--  image.onload = () => {-->
<!--    // 获取图片的宽高比-->
<!--    const aspectRatio = image.width / image.height-->
<!--    // 根据宽高比动态设置 item 的 aspect-ratio-->
<!--    item.aspectRatio = aspectRatio-->
<!--  }-->
<!--}-->
<!--</script>-->
<!--<style lang="scss" scoped>-->
<!--.uni-list-item {-->
<!--  border-bottom-style: solid;-->
<!--  border-bottom-width: 1px;-->
<!--  border-bottom-color: #eee;-->
<!--  font-size: 14px;-->
<!--}-->

<!--.uni-list-item__container {-->
<!--  /* #ifndef APP-NVUE */-->
<!--  display: flex;-->
<!--  width: 100%;-->
<!--  box-sizing: border-box;-->
<!--  /* #endif */-->
<!--  padding: 12px 15px;-->
<!--  flex: 1;-->
<!--  position: relative;-->
<!--  flex-direction: row;-->
<!--  justify-content: space-between;-->
<!--  align-items: center;-->
<!--}-->

<!--.uni-list-item__content-title {-->
<!--  font-size: 14px;-->
<!--  color: #666;-->
<!--}-->
<!--.grid {-->
<!--  display: grid;-->
<!--  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); /* 自动填充列数 */-->
<!--  gap: 5px; /* 设置列间距 */-->
<!--  margin: 5px;-->
<!--}-->

<!--.item {-->
<!--  border-radius: 8px;-->
<!--  overflow: hidden;-->
<!--  display: flex;-->
<!--  flex-direction: column;-->
<!--  background-color: #fff;-->
<!--}-->

<!--.item-image {-->
<!--  width: 100%;-->
<!--  height: auto;-->
<!--  //aspect-ratio: 1 / 1; /* 默认方形比例，可以随需要调整 */-->
<!--  object-fit: cover; /* 图片填充满格子 */-->
<!--}-->

<!--.item-text {-->
<!--  padding: 8px;-->
<!--  font-size: 14px;-->
<!--  color: #333;-->
<!--}-->
<!--</style>-->
<template>
  <view class="container">
    <view class="waterfall-container">
      <view v-for="(column, columnIndex) in columns" :key="columnIndex" class="waterfall-column">
        <view v-for="item in column" :key="item.id" class="waterfall-item">
          <image
            class="item-image"
            :src="item.contentImage"
            :mode="'widthFix'"
            @load="onImageLoad(item)"
          />
          <view class="item-text">{{ item.contentText }}</view>
        </view>
      </view>
    </view>
    <uni-load-more :status="status" :content-text="contentText" />
  </view>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { onReachBottom } from '@dcloudio/uni-app'
import { getPostListAPI } from '@/services/post'

const status = ref('more')
const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  nickName: null,
  contentText: null
})
const contentText = ref({
  contentdown: '查看更多',
  contentrefresh: '加载中',
  contentnomore: '没有更多'
})
const postList = ref([])
const columnCount = 2 // 瀑布流布局的列数

const columns = computed(() => {
  const cols = Array.from({ length: columnCount }, () => [])
  postList.value.forEach((item, index) => {
    cols[index % columnCount].push(item)
  })
  return cols
})

const loadPosts = async () => {
  try {
    const res = await getPostListAPI(queryParams.value)
    const rs = res.rows.map((item) => {
      const imgUrlArr = (item.contentImage ?? '').split(',')
      item.contentImage = 'http://localhost:8080' + imgUrlArr[0]
      return item
    })
    postList.value = rs
    queryParams.value.pageNum = res.pageNum
    console.log('页面加载帖子数据', res, rs)
  } catch (error) {
    console.error('加载帖子数据失败', error)
    uni.showToast({
      title: '加载失败，请重试',
      icon: 'none'
    })
  }
}

const loadMorePosts = async () => {
  if (status.value === 'loading' || status.value === 'no-more') return

  status.value = 'loading'
  queryParams.value.pageNum = queryParams.value.pageNum + 1
  try {
    const res = await getPostListAPI(queryParams.value)
    if (res.rows.length > 0) {
      const newPosts = res.rows.map((item) => {
        const imgUrlArr = (item.contentImage ?? '').split(',')
        item.contentImage = 'http://localhost:8080' + imgUrlArr[0]
        return item
      })
      postList.value = [...postList.value, ...newPosts]
      queryParams.value.pageNum = res.pageNum
      status.value = 'more'
    } else {
      status.value = 'no-more'
    }
  } catch (error) {
    console.error('加载更多帖子失败', error)
    status.value = 'more'
    uni.showToast({
      title: '加载失败，请重试',
      icon: 'none'
    })
  }
}

const onImageLoad = (item) => {
  // 在 uniapp 中，我们可以使用 uni.getImageInfo 来获取图片信息
  uni.getImageInfo({
    src: item.contentImage,
    success: (res) => {
      item.width = res.width
      item.height = res.height
    },
    fail: (err) => {
      console.error('获取图片信息失败', err)
    }
  })
}

onMounted(() => {
  loadPosts()
})

onReachBottom(() => {
  if (status.value !== 'no-more') {
    loadMorePosts()
  }
})
</script>

<style lang="scss">
.container {
  padding: 10rpx;
}

.waterfall-container {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.waterfall-column {
  width: 48%; // 根据需要和间隙大小调整
}

.waterfall-item {
  margin-bottom: 20rpx;
  background-color: #fff;
  border-radius: 16rpx;
  overflow: hidden;
}

.item-image {
  width: 100%;
  height: auto;
  display: block;
}

.item-text {
  padding: 16rpx;
  font-size: 28rpx;
  color: #333;
}
</style>

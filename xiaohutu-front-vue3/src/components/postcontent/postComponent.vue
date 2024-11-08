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
        <view
          v-for="item in column"
          :key="item.id"
          class="waterfall-item"
          @click="goPostDetail(item)"
        >
          <image
            class="item-image"
            :src="item.contentImage"
            :mode="'widthFix'"
            @load="onImageLoad(item)"
          />
          <view class="item-text">{{ item.contentText }}</view>

          <!-- 用户信息 -->
          <view class="user-info">
            <image class="avatar" :src="item.avatar || baseAvatarUrl" mode="aspectFill"></image>
            <view class="user-text">
              <text class="nickname">{{ item.nickName }}</text>
              <text class="time">{{ formatTime(item.updateTime) }}</text>
            </view>
          </view>

          <!-- 地址和标签 -->
          <view class="post-meta" v-if="item.addr">
            <view class="location" v-if="item.addr">
              <uni-icons type="location" size="16"></uni-icons>
              <text>{{ item.addr }}</text>
            </view>
            <view class="tag" v-if="item.tagContent">
              <uni-icons type="tag" size="16"></uni-icons>
              <text>{{ item.tagContent }}</text>
            </view>
          </view>
        </view>
      </view>
    </view>
    <uni-load-more :status="status" :content-text="contentText" />
  </view>
</template>

<script setup>
import { ref, computed, onMounted, defineProps, watch } from 'vue'
import { onReachBottom } from '@dcloudio/uni-app'
import { getPostListAPI } from '@/services/post'
import { baseUrl, baseAvatarUrl } from '@/utils/base'
import { formatTime } from '@/utils/xiaohutu'

// 父传的数据
const props = defineProps({
  searchValue: String
})
// 加载状态
const status = ref('more')

// 加载文本显示
const contentText = ref({
  contentdown: '查看更多',
  contentrefresh: '加载中',
  contentnomore: '没有更多'
})

// 请求参数
const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  nickName: null,
  contentText: null,
  searchValue: props.searchValue
})
// 帖子数据
const postList = ref([])
const columnCount = 2 // 瀑布流布局的列数

// 处理后适应瀑布流的数据
const columns = computed(() => {
  const cols = Array.from({ length: columnCount }, () => [])
  postList.value.forEach((item, index) => {
    cols[index % columnCount].push(item)
  })
  return cols
})
// 页面加载时加载帖子数据
const loadPosts = async () => {
  try {
    const res = await getPostListAPI(queryParams.value)
    const rs = res.rows.map((item) => {
      const imgUrlArr = (item.contentImage ?? '').split(',')
      item.contentImage = baseUrl + imgUrlArr[0]
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
// 跳转到帖子详情
function goPostDetail(item) {
  uni.navigateTo({
    url: '/pages/postDetail/postDetail?id=' + item.id
  })
}
// 上拉加载
const loadMorePosts = async () => {
  if (status.value === 'loading' || status.value === 'no-more') return

  status.value = 'loading'
  queryParams.value.pageNum++
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
// 加载图片后获取宽高
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
watch(props, (newValue) => {
  if (props.searchValue === '') {
    queryParams.value.pageNum = 1
    queryParams.value.pageSize = 10
    queryParams.value.searchValue = null
    status.value = 'more'
    loadPosts()
    return
  }
  if (props.searchValue !== null && props.searchValue !== undefined) {
    queryParams.value.pageNum = 1
    queryParams.value.pageSize = 10
    queryParams.value.searchValue = newValue.searchValue
    status.value = 'more'

    loadPosts()
  }
})
onMounted(() => {
  loadPosts()
})

onReachBottom(() => {
  if (status.value !== 'no-more') {
    loadMorePosts()
  }
})
</script>

<style lang="scss" scoped>
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
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.2);
  transition: box-shadow 0.3s ease;

  &:hover {
    box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.15);
  }
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

.user-info {
  display: flex;
  align-items: center;
  margin-bottom: 20rpx;

  .avatar {
    width: 80rpx;
    height: 80rpx;
    border-radius: 50%;
    margin-right: 20rpx;
  }

  .user-text {
    display: flex;
    flex-direction: column;

    .nickname {
      font-size: 32rpx;
      font-weight: bold;
      color: #333;
    }

    .time {
      font-size: 24rpx;
      color: #999;
    }
  }
}
.post-meta {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20rpx;

  .location,
  .tag {
    display: flex;
    align-items: center;
    font-size: 24rpx;
    color: #666;

    uni-icons {
      margin-right: 6rpx;
    }
  }
}
</style>

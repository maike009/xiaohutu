<script setup lang="ts">
import { ref, computed, onMounted, defineProps } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getPostDetailAPI, delPostAPI } from '@/services/post'
import { baseUrl, baseAvatarUrl } from '@/utils/base'
import { formatTime } from '@/utils/xiaohutu'
import { addLikeAPI, delLikeAPI } from '@/services/like'
import { useUserStore } from '@/stores'
import { addFavoriteAPI, delFavoriteAPI } from '@/services/collection'
import Comment from '@/components/Comment.vue'
import { addHistoryAPI } from '@/services/history'
// 帖子详情数据
const postData = ref()
const defaultAvatar = baseAvatarUrl // 默认头像路径

const props = defineProps({
  id: {
    type: [Number, String],
    required: true
  }
})
// 页面加载数据
onLoad(async (options) => {
  console.log(options.id, 'postid', props.id)
  await getPostData(props.id)
  await addHistoryAPI({ postId: props.id })
})

// 获取帖子详情数据
async function getPostData(postId) {
  try {
    const res = await getPostDetailAPI(postId)
    console.log(res, '详情')
    postData.value = res.data
    likeCount.value = postData.value.likeCount
    favoriteCount.value = postData.value.favoriteCount
    isLike.value = res.isLike || false
    isFavorite.value = res.isFavorite || false
  } catch (error) {
    console.error('Failed to fetch post data:', error)
    // 可以在这里添加错误处理逻辑，比如显示错误消息
  }
}
const userStore = useUserStore()
// 处理点赞逻辑
const likeCount = ref(0)
const isLike = ref(false)
const like_type = computed(() => {
  if (!isLike.value) {
    return 'heart'
  } else {
    return 'heart-filled'
  }
})
async function handlerLike(postId) {
  isLike.value = !isLike.value
  if (isLike.value) {
    // 处理点赞逻辑
    likeCount.value = likeCount.value + 1
    const res = await addLikeAPI({ userId: userStore.profile.userId, postId: postData.value.id })
  }
  if (!isLike.value) {
    // 处理取消点赞逻辑
    likeCount.value = likeCount.value - 1
    const res = await delLikeAPI({ userId: userStore.profile.userId, postId: postData.value.id })
  }
  console.log('点赞', likeCount.value, 'postlike', postData.value.likeCount)
}

// 处理收藏逻辑
const favoriteCount = ref(0)
const isFavorite = ref(false)
const favorite_type = computed(() => {
  if (!isFavorite.value) {
    return 'star'
  } else {
    return 'star-filled'
  }
})
async function handlerFavorite(postId) {
  isFavorite.value = !isFavorite.value
  if (isFavorite.value) {
    // 处理收藏逻辑
    favoriteCount.value = favoriteCount.value + 1
    const res = await addFavoriteAPI({
      userId: userStore.profile.userId,
      postId: postData.value.id
    })
  }
  if (!isFavorite.value) {
    // 处理取消收藏逻辑
    favoriteCount.value = favoriteCount.value - 1
    const res = await delFavoriteAPI({
      userId: userStore.profile.userId,
      postId: postData.value.id
    })
  }
}

// 图片预览
const postImages = computed(() => {
  if (postData.value && postData.value.contentImage) {
    return postData.value.contentImage.split(',').map((item) => baseUrl + item)
  }
  return []
})

// 图片预览
const previewImage = (index) => {
  uni.previewImage({
    urls: postImages.value,
    current: index
  })
}

function goToUserDetail() {
  uni.navigateTo({
    url: '/pages/userDetail/userDetail?userId=' + postData.value.userId
  })
}
const replyTo = ref(false)
function changeReplyTO() {
  replyTo.value = !replyTo.value
}
// 删除帖子
const goToAddPost = (postId) => {
  uni.navigateTo({
    url: `/pages/addPost/addPost?id=${postId}&edit=true`
  })
}
// 评论完成后刷新页面
const refreshPostData = () => {
  getPostData(props.id)
}
</script>

<template>
  <view class="post-detail" v-if="postData">
    <!-- 标题 -->
    <view class="post-title" v-if="postData.postTitle">
      <text>{{ postData.postTitle }}</text>
    </view>

    <!-- 分割线 -->
    <view class="divider"></view>

    <!-- 用户信息 -->
    <view class="user-info" @tap="goToUserDetail">
      <image
        class="avatar"
        :src="postData.avatar ? baseUrl + postData.avatar : defaultAvatar"
        mode="aspectFill"
      ></image>
      <view class="user-text">
        <text class="nickname">{{ postData.nickName }}</text>
        <text class="time">{{ formatTime(postData.updateTime) }}</text>
      </view>
    </view>

    <!-- 帖子内容 -->
    <view class="post-content">
      <text class="content-text">{{ postData.contentText }}</text>
      <view class="image-grid">
        <image
          v-for="(img, index) in postImages"
          :key="index"
          :src="img"
          mode="aspectFit"
          @tap="previewImage(index)"
        ></image>
      </view>
    </view>

    <!-- 地址和标签 -->
    <view class="post-meta">
      <view class="location" v-if="postData.addr">
        <uni-icons type="location" size="16"></uni-icons>
        <text>{{ postData.addr }}</text>
      </view>
      <view class="tag" v-if="postData.tagContent">
        <uni-icons type="tag" size="16"></uni-icons>
        <text>{{ postData.tagContent }}</text>
      </view>
    </view>

    <!-- 互动信息 -->
    <view class="interaction-bar">
      <view class="interaction-item" @tap="handlerLike(postData.id)">
        <uni-icons :type="like_type" size="20"></uni-icons>
        <text>{{ likeCount || 0 }}</text>
      </view>
      <view class="interaction-item" @tap="changeReplyTO">
        <uni-icons type="chat" size="20"></uni-icons>
        <text>{{ postData.commentCount || 0 }}</text>
      </view>
      <view class="interaction-item" @tap="handlerFavorite(postData.id)">
        <uni-icons :type="favorite_type" size="20"></uni-icons>
        <text>{{ favoriteCount || 0 }}</text>
      </view>
      <!-- 新增：删除图标 -->
      <view
        class="interaction-item"
        v-if="postData.userId === userStore.profile.userId"
        @tap.stop="goToAddPost(postData.id)"
      >
        <uni-icons type="settings" size="20"></uni-icons>
      </view>
    </view>
  </view>

  <view v-else class="loading">
    <text>加载中...</text>
  </view>
  <comment :refreshPostData="refreshPostData" :postId="postData.id" :replyTo="replyTo" />
</template>

<style lang="scss" scoped>
.post-detail {
  padding: 20rpx;
  background-color: #f8f8f8;
}
.menu-icon {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 10;
}
.post-title {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
  margin-bottom: 20rpx;
  padding: 0 20rpx;
}

.divider {
  height: 1rpx;
  background-color: #e0e0e0;
  margin: 20rpx 0;
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

.post-content {
  margin-bottom: 20rpx;

  .content-text {
    font-size: 28rpx;
    color: #333;
    line-height: 1.6;
    margin-bottom: 20rpx;
  }

  .image-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10rpx;

    image {
      width: 100%;
      height: 200rpx;
      border-radius: 8rpx;
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

.interaction-bar {
  display: flex;
  justify-content: space-around;
  padding: 20rpx 0;
  border-top: 1rpx solid #eee;

  .interaction-item {
    display: flex;
    align-items: center;
    font-size: 24rpx;
    color: #666;

    uni-icons {
      margin-right: 6rpx;
    }
  }
}

.loading {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  font-size: 28rpx;
  color: #999;
}
</style>

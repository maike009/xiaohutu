<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getPostDetailAPI } from '@/services/post'
import { baseUrl, baseAvatarUrl } from '@/utils/base'
import { formatTime } from '@/utils/xiaohutu'

// 帖子详情数据
const postData = ref(null)
const defaultAvatar = baseAvatarUrl // 默认头像路径

// 页面加载数据
onLoad(async (options) => {
  console.log(options.id, 'postid')
  await getPostData(options.id)
})

// 获取帖子详情数据
async function getPostData(postId) {
  try {
    const res = await getPostDetailAPI(postId)
    console.log(res, '详情')
    postData.value = res.data
  } catch (error) {
    console.error('Failed to fetch post data:', error)
    // 可以在这里添加错误处理逻辑，比如显示错误消息
  }
}

// 处理点赞逻辑
const isLike = ref(false)
const like_type = computed(() => {
  if (!isLike.value) {
    return 'heart'
  } else {
    return 'heart-filled'
  }
})
function handlerLike(postId) {
  isLike.value = !isLike.value
}

// 处理收藏逻辑
const isFavorite = ref(false)
const favorite_type = computed(() => {
  if (!isFavorite.value) {
    return 'star'
  } else {
    return 'star-filled'
  }
})
function handlerFavorite(postId) {
  isFavorite.value = !isFavorite.value
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
    <view class="user-info">
      <image class="avatar" :src="postData.avatar || defaultAvatar" mode="aspectFill"></image>
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
        <text>{{ postData.likeCount || 0 }}</text>
      </view>
      <view class="interaction-item">
        <uni-icons type="chat" size="20"></uni-icons>
        <text>{{ postData.commentCount || 0 }}</text>
      </view>
      <view class="interaction-item" @tap="handlerFavorite(postData.id)">
        <uni-icons :type="favorite_type" size="20"></uni-icons>
        <text>{{ postData.favoriteCount || 0 }}</text>
      </view>
    </view>
  </view>
  <view v-else class="loading">
    <text>加载中...</text>
  </view>
</template>

<style lang="scss" scoped>
.post-detail {
  padding: 20rpx;
  background-color: #f8f8f8;
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

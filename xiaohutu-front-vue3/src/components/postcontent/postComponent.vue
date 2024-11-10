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
          <view class="item-text">{{ item.postTitle ? item.postTitle : item.contentText }}</view>
          <view
            class="item-text"
            :style="{
              color: item.status == 0 ? '#4cd964' : item.status == 1 ? '#ffcc00' : '#ff3b30'
            }"
            v-if="isAuditEnabled"
            ><span style="color: #333333">状态：</span
            >{{
              `${+item.status == 0 ? '审核通过' : item.status == 1 ? '审核中' : '审核不通过'}`
            }}</view
          >

          <!-- 用户信息 -->
          <view class="user-info">
            <image
              class="avatar"
              :src="item.avatar ? baseUrl + item.avatar : baseAvatarUrl"
              mode="aspectFill"
            ></image>
            <view class="user-text">
              <text class="nickname">{{ item.nickName }}</text>
              <text class="time">{{ formatTime(item.updateTime) }}</text>
            </view>
          </view>

          <!-- 地址和标签 -->
          <view class="post-meta">
            <view class="location" v-if="item.addr">
              <uni-icons type="location" size="16"></uni-icons>
              <text>{{ item.addr }}</text>
            </view>
            <view class="location">
              <uni-icons :type="'heart'" size="16"></uni-icons>
              <text>{{ item.likeCount || 0 }}</text>
            </view>
            <view class="location">
              <uni-icons :type="'star'" size="16"></uni-icons>
              <text>{{ item.favoriteCount || 0 }}</text>
            </view>
            <view class="tag" v-if="item.tagContent">
              <uni-icons type="tag" size="16"></uni-icons>
              <text>{{
                item.tagContent.length > 5
                  ? item.tagContent.substring(0, 5) + '...'
                  : item.tagContent
              }}</text>
            </view>
          </view>
        </view>
      </view>
    </view>
    <uni-load-more :status="status" :content-text="contentText" />
  </view>
</template>

<script setup>
import { ref, computed, defineProps } from 'vue'
import { baseUrl, baseAvatarUrl } from '@/utils/base'
import { formatTime } from '@/utils/xiaohutu'
import { onReachBottom } from '@dcloudio/uni-app'

const props = defineProps({
  postList: Array,
  status: String,
  contentText: Object,
  loadMorePosts: Function,
  isAuditEnabled: Boolean
})

const columnCount = 2
const columns = computed(() => {
  const cols = Array.from({ length: columnCount }, () => [])
  props.postList.forEach((item, index) => {
    cols[index % columnCount].push(item)
  })
  return cols
})

// 获取帖子详情
const goPostDetail = (item) => {
  if (item.draftStatus === 1) {
    uni.navigateTo({
      url: '/pages/addPost/addPost?id=' + item.id
    })
    return
  }
  uni.navigateTo({
    url: '/pages/postDetail/postDetail?id=' + item.id
  })
}

const onImageLoad = (item) => {
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

onReachBottom(() => {
  if (props.status !== 'no-more') {
    props.loadMorePosts()
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
  background-color: rgba(255, 255, 255, 0.7); // 更改为半透明白色
  border-radius: 16rpx;
  overflow: hidden;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.2);
  transition:
    box-shadow 0.3s ease,
    backdrop-filter 0.3s ease;
  backdrop-filter: blur(10px); // 添加毛玻璃效果
  -webkit-backdrop-filter: blur(10px); // 为 iOS 设备添加支持

  &:hover {
    box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.15);
    backdrop-filter: blur(15px); // 悬停时增强毛玻璃效果
    -webkit-backdrop-filter: blur(15px);
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
  padding: 0 16rpx; // 添加左右内边距

  .avatar {
    width: 60rpx;
    height: 60rpx;
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
  padding: 0 16rpx; // 添加左右内边距

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

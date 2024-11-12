<script setup>
import { ref, onMounted, defineProps } from 'vue'
import { baseAvatarUrl, baseUrl } from '@/utils/base'

// 假设我们有一个获取粉丝列表的API
import { getFollowingUserListAPI, getFollowerUserListAPI } from '@/services/user'
// 我的粉丝列表
const fansList = ref([])
// 我的关注列表
const followerList = ref([])
const loading = ref(false)
const finished = ref(false)
// 请求参数
const queryParams = ref({
  pageNum: 1,
  pageSize: 20
})

const props = defineProps({
  pageType: String
})

const loadFans = async () => {
  if (loading.value || finished.value) return

  loading.value = true
  try {
    let res
    console.log(props.pageType, 'parops')
    if (props.pageType === 'followingUser') {
      console.log('发请求')
      res = await getFollowingUserListAPI(queryParams.value)
    } else {
      res = await getFollowerUserListAPI(queryParams.value)
    }
    if (res.rows.length > 0) {
      fansList.value.push(...res.rows)
      queryParams.value.pageNum++
    } else {
      finished.value = true
    }
  } catch (error) {
    console.error('获取粉丝列表失败:', error)
    uni.showToast({
      title: '加载失败，请重试',
      icon: 'none'
    })
  } finally {
    loading.value = false
  }
}

const truncateBio = (bio) => {
  return bio.length > 50 ? bio.slice(0, 50) + '...' : bio
}

onMounted(() => {
  loadFans()
})
function goToUserDetail(userId) {
  uni.navigateTo({
    url: '/pages/userDetail/userDetail?userId=' + userId
  })
}
</script>

<template>
  <view class="fans-list-container">
    <view class="header">
      <text class="title">{{ pageType === 'followingUser' ? '我的粉丝' : '我的关注' }}</text>
    </view>

    <scroll-view class="fans-list" scroll-y @scrolltolower="loadFans">
      <view
        v-for="fan in fansList"
        :key="fan.userId"
        class="fan-item"
        @tap.stop="goToUserDetail(fan.userId)"
      >
        <image
          :src="fan.avatar ? baseUrl + fan.avatar : baseAvatarUrl"
          class="avatar"
          mode="aspectFill"
        />
        <view class="fan-info">
          <text class="nickname">{{ fan.nickName }}</text>
          <text class="bio">{{ truncateBio(fan.bio || '这个人很懒，什么都没写~') }}</text>
        </view>
      </view>

      <view v-if="loading" class="loading"> 加载中... </view>
      <view v-if="finished" class="no-more">
        没有更多{{ pageType === 'followingUser' ? '粉丝' : '关注' }}了
      </view>
    </scroll-view>
  </view>
</template>

<style lang="scss" scoped>
.fans-list-container {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f5f5f5;
}

.header {
  padding: 20rpx;
  background-color: #ffffff;
  border-bottom: 1rpx solid #e0e0e0;

  .title {
    font-size: 36rpx;
    font-weight: bold;
    color: #333;
  }
}

.fans-list {
  flex: 1;
  padding: 20rpx;
}

.fan-item {
  display: flex;
  align-items: center;
  padding: 20rpx;
  margin-bottom: 20rpx;
  background-color: #ffffff;
  border-radius: 10rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.1);
}

.avatar {
  width: 100rpx;
  height: 100rpx;
  border-radius: 50%;
  margin-right: 20rpx;
}

.fan-info {
  display: flex;
  flex-direction: column;
  flex: 1;

  .nickname {
    font-size: 28rpx;
    font-weight: bold;
    color: #333;
    margin-bottom: 10rpx;
  }

  .bio {
    font-size: 24rpx;
    color: #666;
    line-height: 1.4;
  }
}

.loading,
.no-more {
  text-align: center;
  padding: 20rpx;
  color: #999;
  font-size: 24rpx;
}
</style>

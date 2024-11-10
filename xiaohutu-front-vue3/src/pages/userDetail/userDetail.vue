<script setup>
import { computed, ref, defineProps, onMounted } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getUserInfoAPI } from '@/services/user'
import { baseAvatarUrl, baseUrl } from '@/utils/base'
import PostComponent from '@/components/postcontent/postComponent.vue'
import { getPostListAPI } from '@/services/post'

const props = defineProps({
  userId: String
})
// 页面显示时的处理
onMounted((options) => {
  console.log(options?.userId, 'userid')
  console.log(props.userId, 'props  ---#userid')
  getUserDetail(props.userId)
  queryParams.value.userId = props.userId
  getUserPostList()
})

// 用户详情数据
const userDetail = ref({})
// 控制是否显示完整简介
const isFullBioVisible = ref(false)
// 当前激活的标签
const activeTab = ref('works')
// 背景图片的缩放比例
const backgroundScale = ref(1)
// 背景图片的垂直偏移
const backgroundOffsetY = ref(0)

// 计算属性：截断的个人简介
const truncatedBio = computed(() => {
  if (!userDetail.value.bio) return '此人很懒什么都没有写'
  return userDetail.value.bio.length > 50
    ? userDetail.value.bio.slice(0, 50) + '...'
    : userDetail.value.bio
})

// 计算属性：背景图片URL
const backgroundImage = computed(() => {
  return userDetail.value.backgroundImage
    ? baseUrl + userDetail.value.backgroundImage
    : '/static/images/bgc2.jpg'
})

// 获取用户详情
async function getUserDetail(userId) {
  try {
    const res = await getUserInfoAPI(userId)
    userDetail.value = res.data
    console.log(res.data)
  } catch (error) {
    console.error('获取用户详情失败:', error)
    uni.showToast({
      title: '获取用户信息失败',
      icon: 'none'
    })
  }
}

// 切换简介显示状态
function toggleBio() {
  isFullBioVisible.value = !isFullBioVisible.value
}

// 切换标签
function changeTab(tab) {
  activeTab.value = tab
  // 这里可以添加获取对应标签内容的逻辑
  console.log('切换到标签:', tab)
}

// 处理页面滚动
function handleScroll(event) {
  const scrollTop = event.detail.scrollTop
  // 调整背景图片的缩放和偏移
  backgroundScale.value = 1 + scrollTop * 0.001 // 根据需要调整系数
  backgroundOffsetY.value = scrollTop * 0.5 // 根据需要调整系数
}
function goToEditUserPage() {
  uni.navigateTo({
    url: '/pages/editUser/editUser'
  })
}
// 帖子列表数据
const postList = ref([])
const status = ref('more')
const contentText = ref({
  contentdown: '查看更多',
  contentrefresh: '加载中',
  contentnomore: '没有更多'
})

const queryParams = ref({
  userId: null,
  pageNum: 1,
  pageSize: 10
})
// watch(
//     () => ,
//     (newValue) => {
//       loadPosts()
//     }
// )
// 获取用户的帖子列表
async function getUserPostList() {
  try {
    const res = await getPostListAPI(queryParams.value)
    const rs = res.rows.map((item) => {
      const imgUrlArr = (item.contentImage ?? '').split(',')
      item.contentImage = baseUrl + imgUrlArr[0]
      return item
    })
    postList.value = rs
  } catch (error) {
    // console.error('加载帖子数据失败', error)
  }
}

// 帖子数据封装结果
const loadMorePosts = async () => {
  if (status.value === 'loading' || status.value === 'no-more') return

  status.value = 'loading'
  queryParams.value.pageNum++
  try {
    let res
    if (activeTab.value === 'works') {
      res = await getPostListAPI(queryParams.value)
    }

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

<template>
  <view
    class="background-image"
    :style="{
      backgroundImage: `url(${backgroundImage})`,
      transform: `scale(${backgroundScale}) translateY(${backgroundOffsetY}px)`
    }"
  ></view>
  <view class="content">
    <view class="glassmorphism user-info">
      <image
        class="avatar"
        :src="userDetail.avatar ? baseUrl + userDetail.avatar : baseAvatarUrl"
        mode="aspectFill"
      ></image>
      <view class="user-details">
        <text class="nickname">{{ userDetail.nickName }}</text>
        <text class="username">账号：{{ userDetail.userName }}</text>
      </view>
    </view>

    <view class="glassmorphism stats">
      <view class="stat-item">
        <text class="stat-value">{{ userDetail.totalLikes || 0 }}</text>
        <text class="stat-label">获赞</text>
      </view>
      <view class="stat-item">
        <text class="stat-value">{{ userDetail.followersCount || 0 }}</text>
        <text class="stat-label">粉丝</text>
      </view>
      <view class="stat-item">
        <text class="stat-value">{{ userDetail.followingCount || 0 }}</text>
        <text class="stat-label">关注</text>
      </view>
    </view>

    <view class="glassmorphism combined-section">
      <view class="bio-section">
        <text class="bio-text">简介：</text>
        <text class="bio-text" @tap="toggleBio">
          {{ isFullBioVisible ? userDetail.bio || '此人很懒什么都没有写' : truncatedBio }}
        </text>
        <text
          v-if="userDetail.bio && userDetail.bio.length > 80"
          class="bio-toggle"
          @tap="toggleBio"
        >
          {{ isFullBioVisible ? '收起' : '展开' }}
        </text>
      </view>

      <view class="tabs">
        <view
          v-for="tab in ['works']"
          :key="tab"
          class="tab-item"
          :class="{ active: activeTab === tab }"
          @tap="changeTab(tab)"
        >
          {{ '他的作品' }}
        </view>
      </view>

      <view class="content-list">
        <view v-if="activeTab === 'works'">
          <post-component
            :postList="postList"
            :status="status"
            :contentText="contentText"
            :loadMorePosts="loadMorePosts"
          ></post-component
        ></view>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.personal-center {
  height: 100vh;
  position: relative;
  background-color: transparent;
}

.background-image {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-size: cover;
  background-position: center;
  z-index: 1;
  transition: transform 0.3s ease-out;
}

.content {
  position: relative;
  z-index: 2;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.glassmorphism {
  position: relative;
  border-radius: 15px;
  overflow: hidden;
}

.glassmorphism::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  z-index: -1;
}

.user-info,
.stats,
.combined-section {
  position: relative;
  padding: 20px;
  border: 1px solid rgba(255, 255, 255, 0.3);
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
}

.user-info {
  display: flex;
  align-items: center;
}

.avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  margin-right: 15px;
  border: 3px solid rgba(255, 255, 255, 0.5);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.user-details {
  display: flex;
  flex-direction: column;

  .nickname {
    font-size: 18px;
    font-weight: bold;
    color: #fff;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
  }

  .username {
    font-size: 14px;
    color: #eee;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
  }
}

.stats {
  display: flex;
  justify-content: space-around;

  .stat-item {
    display: flex;
    flex-direction: column;
    align-items: center;

    .stat-value {
      font-size: 18px;
      font-weight: bold;
      color: #fff;
    }

    .stat-label {
      font-size: 12px;
      color: #eee;
    }
  }
}

.combined-section {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.bio-section {
  .bio-text {
    font-size: 14px;
    line-height: 1.4;
    color: #fff;
  }

  .bio-toggle {
    color: #a0e9ff;
    font-size: 12px;
    margin-top: 5px;
  }
}

.tabs {
  display: flex;
  justify-content: space-around;
  border-bottom: 1px solid rgba(255, 255, 255, 0.3);

  .tab-item {
    padding: 10px 0;
    flex: 1;
    text-align: center;
    font-size: 14px;
    color: #eee;

    &.active {
      color: #a0e9ff;
      border-bottom: 2px solid #a0e9ff;
    }
  }
}

.content-list {
  min-height: 200px;
  color: #fff;
}
</style>

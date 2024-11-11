<script setup>
import { onMounted, ref, reactive, computed, watch } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { useTabStore, useUserStore } from '@/stores'
import { getUserDetailAPI /*followUserAPI, unfollowUserAPI */ } from '@/services/user'
import { baseAvatarUrl, baseUrl } from '@/utils/base'
import PostComponent from '@/components/postcontent/postComponent.vue'
import {
  getMyDraftPostListAPI,
  getMyFavoritePostListAPI,
  getMyLikePostListAPI,
  getMyPostListAPI
} from '@/services/post'
import { logoutAPI } from '@/services/login'

// 页面显示时的处理
onShow(() => {
  const tabStore = useTabStore()
  console.log('上一次的tab路径', tabStore.lastTab)
  tabStore.setTaBList('user')
  getUserDetail()
  queryParams.value.pageNum = 1
  getMyPostList()
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

// 新增：控制抽屉的显示状态
const isDrawerOpen = ref()

// 新增：打开抽屉
const openDrawer = () => {
  isDrawerOpen.value.open()
  console.log('isDrawerOpen:', isDrawerOpen.value)
}

// 新增：关闭抽屉
const closeDrawer = (e) => {
  console.log('关闭', e)
}

// 新增：处理抽屉选项点击
const handleDrawerOptionClick = (option) => {
  console.log(`Selected option: ${option}`)
  if (option === 'settings') {
    uni.navigateTo({
      url: '/pages/editUser/editUser'
    })
  } else if (option === 'logout') {
    // 弹框确认是否退出登录
    uni.showModal({
      title: '提示',
      content: '确定退出登录吗？',
      success: (res) => {
        if (res.confirm) {
          // 清除用户信息
          useUserStore().clearToken()
          useUserStore().clearProfile()
          logoutAPI()
          // 跳转到登录页面
          uni.reLaunch({
            url: '/pages/login/login'
          })
        }
      }
    })
  } else if (option === 'help') {
    uni.navigateTo({
      url: '/pages/systemHelp/systemHelp'
    })
  } else if (option === 'history') {
    uni.navigateTo({
      url: '/pages/history/history'
    })
  }
  // 这里可以添加相应的逻辑，比如导航到不同的页面
  isDrawerOpen.value.close()
}

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

// 新增：关注状态
const isFollowing = ref(false)

// 新增：切换关注状态
const toggleFollow = async (event) => {
  event.stopPropagation() // 阻止事件冒泡
  try {
    if (isFollowing.value) {
      await unfollowUserAPI(userDetail.value.userId)
      isFollowing.value = false
      userDetail.value.followersCount--
    } else {
      await followUserAPI(userDetail.value.userId)
      isFollowing.value = true
      userDetail.value.followersCount++
    }
  } catch (error) {
    console.error('关注/取消关注失败:', error)
    uni.showToast({
      title: '操作失败，请重试',
      icon: 'none'
    })
  }
}

// 获取用户详情
async function getUserDetail() {
  try {
    const res = await getUserDetailAPI()
    userDetail.value = res.data
    isFollowing.value = res.data.isFollowing // 假设API返回的数据中包含isFollowing字段
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
  queryParams.value.pageNum = 1
  console.log('切换到标签:', tab)
  // 这里可以添加获取对应标签内容的逻辑
  if (activeTab.value === 'works') {
    getMyPostList()
  } else if (activeTab.value === 'likes') {
    getLikePostList()
  } else if (activeTab.value === 'favorites') {
    getFavoritePostList()
  } else {
    getMyDraftPostList()
  }
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
  pageNum: 1,
  pageSize: 10
})

// 获取我的帖子列表
async function getMyPostList() {
  try {
    const res = await getMyPostListAPI(queryParams.value)
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

// 获取我点赞的帖子列表
const getLikePostList = async () => {
  try {
    const res = await getMyLikePostListAPI(queryParams.value)
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

// 获取我收藏的帖子列表
const getFavoritePostList = async () => {
  try {
    const res = await getMyFavoritePostListAPI(queryParams.value)
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

const getMyDraftPostList = async () => {
  try {
    const res = await getMyDraftPostListAPI(queryParams.value)
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
    let res
    if (activeTab.value === 'works') {
      res = await getMyPostListAPI(queryParams.value)
    } else if (activeTab.value === 'likes') {
      res = await getMyLikePostListAPI(queryParams.value)
    } else if (activeTab.value === 'favorites') {
      res = await getMyFavoritePostListAPI(queryParams.value)
    } else {
      res = await getMyDraftPostListAPI(queryParams.value)
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
// 帖子审核状态开关
const isAuditEnabled = ref(true)

// 去关注列表页面
const goToFollower = (pageType) => {
  uni.navigateTo({
    url: `/pages/follower/follower?pageType=${pageType}`
  })
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
    <view class="glassmorphism user-info" @tap="goToEditUserPage">
      <!-- 新增：菜单图标 -->
      <view class="menu-icon" @tap.stop="openDrawer">
        <uni-icons type="bars" size="24" color="#fff"></uni-icons>
      </view>
      <image
        class="avatar"
        :src="userDetail.avatar ? baseUrl + userDetail.avatar : baseAvatarUrl"
        mode="aspectFill"
      ></image>
      <view class="user-details">
        <view style="display: flex; flex-direction: column">
          <text class="nickname">{{ userDetail.nickName }}</text>
          <text class="username">账号：{{ userDetail.userName }}</text>
        </view>
        <!--         新增：关注按钮 -->
        <!--        <button class="follow-button" @tap.stop="toggleFollow">-->
        <!--          {{ isFollowing ? '已关注' : '关注' }}-->
        <!--        </button>-->
      </view>
    </view>

    <view class="glassmorphism stats">
      <view class="stat-item">
        <text class="stat-value">{{ userDetail.totalLikes || 0 }}</text>
        <text class="stat-label">获赞</text>
      </view>
      <view class="stat-item" @tap.stop="goToFollower('followingUser')">
        <text class="stat-value">{{ userDetail.followingUserCount || 0 }}</text>
        <text class="stat-label">粉丝</text>
      </view>
      <view class="stat-item" @tap.stop="goToFollower('follower')">
        <text class="stat-value">{{ userDetail.followerCount || 0 }}</text>
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
          v-for="tab in ['works', 'likes', 'favorites', 'drafts']"
          :key="tab"
          class="tab-item"
          :class="{ active: activeTab === tab }"
          @tap="changeTab(tab)"
        >
          {{
            tab === 'works'
              ? '我的作品'
              : tab === 'likes'
                ? '我的点赞'
                : tab === 'favorites'
                  ? '我的收藏'
                  : '草稿箱'
          }}
        </view>
      </view>

      <view class="content-list">
        <view v-if="activeTab === 'works'"
          ><post-component
            :postList="postList"
            :status="status"
            :contentText="contentText"
            :loadMorePosts="loadMorePosts"
            :isAuditEnabled="isAuditEnabled"
          ></post-component
        ></view>
        <view v-else-if="activeTab === 'likes'">
          <post-component
            :postList="postList"
            :status="status"
            :contentText="contentText"
            :loadMorePosts="loadMorePosts"
          ></post-component>
        </view>
        <view v-else-if="activeTab === 'favorites'">
          <post-component
            :postList="postList"
            :status="status"
            :contentText="contentText"
            :loadMorePosts="loadMorePosts"
          ></post-component>
        </view>
        <view v-else-if="activeTab === 'drafts'">
          <post-component
            :postList="postList"
            :status="status"
            :contentText="contentText"
            :loadMorePosts="loadMorePosts"
          ></post-component>
        </view>
      </view>
    </view>

    <!-- 新增：抽屉组件 -->
    <uni-drawer ref="isDrawerOpen" mode="right" @change="closeDrawer">
      <view class="drawer-content">
        <view class="drawer-header">
          <text class="drawer-title">菜单</text>
        </view>
        <view class="drawer-list">
          <view class="drawer-item" @tap="handleDrawerOptionClick('settings')">
            <text>个人设置</text>
          </view>
          <view class="drawer-item" @tap="handleDrawerOptionClick('history')">
            <text>历史记录</text>
          </view>
          <view class="drawer-item" @tap="handleDrawerOptionClick('help')">
            <text>系统帮助</text>
          </view>
          <view class="drawer-item" @tap="handleDrawerOptionClick('logout')">
            <text>退出登录</text>
          </view>
        </view>
      </view>
    </uni-drawer>
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
  padding: 15px;
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

  align-items: flex-start;

  .nickname {
    width: 140px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 18px;
    font-weight: bold;
    color: #fff;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
  }

  .username {
    font-size: 14px;
    color: #eee;
    padding-right: 20px;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
    margin-bottom: 10px;
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

// 新增：菜单图标样式
.menu-icon {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 10;
}

// 新增：抽屉内容样式
.drawer-content {
  padding: 20px;
}

.drawer-header {
  margin-bottom: 20px;
}

.drawer-title {
  font-size: 20px;
  font-weight: bold;
}

.drawer-list {
  .drawer-item {
    padding: 15px 0;
    border-bottom: 1px solid #eee;

    &:last-child {
      border-bottom: none;
    }

    text {
      font-size: 16px;
    }
  }
}

// 新增：关注按钮样式
.follow-button {
  font-size: 14px;
  padding: 5px 15px;
  border-radius: 20px;
  background-color: #a0e9ff;
  color: #333;
  border: none;
  cursor: pointer;
  transition: background-color 0.3s ease;

  &:hover {
    background-color: #7ad7ff;
  }
}
</style>

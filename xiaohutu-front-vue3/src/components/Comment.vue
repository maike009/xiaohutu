<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { getCommentListAPI, addCommentAPI } from '@/services/comment'
import { formatTime } from '@/utils/xiaohutu'
import { baseUrl, baseAvatarUrl } from '@/utils/base'
import { useUserStore } from '@/stores'

// 定义组件的 props
const props = defineProps({
  postId: {
    type: [Number, String],
    required: true
  },
  replyTo: {
    type: Object
  },
  refreshPostData: Function
})

// 用户store
const userStore = useUserStore()

// 评论列表数据
const commentList = ref([])
const commentTotal = ref(0)
// 分页参数
const pageNum = ref(1)
const pageSize = ref(10)
// 加载状态
const loading = ref(false)
const finished = ref(false)

// 回复相关
const replyTo = ref(null)
const replyContent = ref('')

// 获取评论列表
const getCommentList = async (reset = false) => {
  if (loading.value) return
  loading.value = true

  if (reset) {
    pageNum.value = 1
    finished.value = false
    commentList.value = []
  }

  try {
    const res = await getCommentListAPI(props.postId, pageNum.value, pageSize.value)
    const newComments = (res.rows || []).filter((comment) => comment.topId === 0)
    commentTotal.value = res.total
    commentList.value.push(...newComments)
    toggleExpand(newComments[0].commentId)

    if (newComments.length < pageSize.value) {
      finished.value = true
    } else {
      pageNum.value++
    }
  } catch (error) {
    console.error('获取评论列表失败:', error)
  } finally {
    loading.value = false
  }
}

// 展开子评论
const expandedComments = ref(new Set())
const toggleExpand = (commentId) => {
  if (expandedComments.value.has(commentId)) {
    expandedComments.value.delete(commentId)
  } else {
    expandedComments.value.add(commentId)
    getChildComments(commentId)
  }
}

// 获取子评论
const getChildComments = async (parentCommentId) => {
  try {
    const res = await getCommentListAPI(props.postId, 1, 5, parentCommentId)
    const parentComment = commentList.value.find((c) => c.commentId === parentCommentId)
    if (parentComment) {
      parentComment.children = res.rows || []
      toggleExpand(parentComment.children[0].commentId)
    }
  } catch (error) {
    console.error('获取子评论失败:', error)
  }
}

// 回复评论
const replyToComment = (comment) => {
  replyTo.value = comment
  replyContent.value = `@${comment.nickName} `
}

// 提交回复
const submitReply = async () => {
  if (!replyContent.value.trim()) {
    uni.showToast({ title: '请输入回复内容', icon: 'none' })
    return
  }

  try {
    // 这里需要实现提交回复的API
    const res = await addCommentAPI({
      postId: props.postId,
      userId: userStore.profile.userId,
      parentCommentId: replyTo.value.commentId || 0,
      topId: replyTo.value.topId || replyTo.value.commentId || 0,
      commentText: replyContent.value
    })

    // 模拟API响应
    // const res = {
    //   commentId: Date.now(),
    //   userId: userStore.profile.userId,
    //   nickName: userStore.profile.nickName,
    //   avatar: userStore.profile.avatar,
    //   commentText: replyContent.value,
    //   commentTime: new Date().toISOString(),
    //   parentCommentId: replyTo.value.commentId,
    //   topId: replyTo.value.topId || replyTo.value.commentId
    // }

    if (res) {
      if (replyTo.value.topId === 0) {
        // 回复根评论
        const parentComment = commentList.value.find((c) => c.commentId === replyTo.value.commentId)
        if (parentComment) {
          parentComment.children = parentComment.children || []
          parentComment.children.unshift(res)
        }
      } else {
        // 回复子评论
        const topComment = commentList.value.find((c) => c.commentId === replyTo.value.topId)
        if (topComment && topComment.children) {
          topComment.children.unshift(res)
        }
      }
      replyContent.value = ''
      replyTo.value = null
      uni.showToast({ title: '回复成功', icon: 'success' })
      props.refreshPostData()
      getCommentList()
    }
  } catch (error) {
    console.error('提交回复失败:', error)
    uni.showToast({ title: '回复失败，请重试', icon: 'none' })
  }
}

// 监听 postId 变化，重新加载评论
watch(
  () => props.postId,
  () => {
    getCommentList(true)
  }
)
watch(
  () => props.replyTo,
  (newValue) => {
    replyTo.value = newValue
  }
)

// 组件挂载时加载评论
onMounted(() => {
  getCommentList()
})
</script>

<template>
  <view class="comment-section">
    <view class="comment-header">
      <text class="comment-title">评论 ({{ commentTotal }})</text>
    </view>

    <view v-for="comment in commentList" :key="comment.commentId" class="comment-item">
      <view class="comment-main">
        <image
          :src="comment.avatar ? baseUrl + comment.avatar : baseAvatarUrl"
          class="avatar"
          mode="aspectFill"
        />
        <view class="comment-content">
          <view class="comment-info">
            <text class="nickname">{{ comment.nickName }}</text>
            <text class="time">{{ formatTime(comment.commentTime) }}</text>
          </view>
          <text class="comment-text">{{ comment.commentText }}</text>
          <view class="comment-actions">
            <text @tap="replyToComment(comment)" class="action-text">回复</text>
            <text
              @tap="toggleExpand(comment.commentId)"
              class="action-text"
              v-if="comment.children && comment.children.length"
            >
              {{ expandedComments.has(comment.commentId) ? '收起回复' : '查看回复' }}
            </text>
          </view>
        </view>
      </view>

      <!-- 子评论 -->
      <view
        v-if="
          expandedComments.has(comment.commentId) && comment.children && comment.children.length > 0
        "
        class="sub-comments"
      >
        <view
          v-for="childComment in comment.children"
          :key="childComment.commentId"
          class="sub-comment-item"
        >
          <image
            :src="childComment.avatar ? baseUrl + childComment.avatar : baseAvatarUrl"
            class="avatar"
            mode="aspectFill"
          />
          <view class="comment-content">
            <view class="comment-info">
              <text class="nickname">{{ childComment.nickName }}</text>
              <text class="time">{{ formatTime(childComment.commentTime) }}</text>
            </view>
            <text class="comment-text">
              <text v-if="childComment.parentCommentId !== comment.commentId" class="reply-to"
                >回复 @{{
                  comment.children.find((c) => c.commentId === childComment.parentCommentId)
                    ?.nickName
                }}：</text
              >
              {{ childComment.commentText }}
            </text>
            <view class="comment-actions">
              <text @tap="replyToComment(childComment)" class="action-text">回复</text>
            </view>
          </view>
        </view>
      </view>
    </view>

    <view v-if="loading" class="loading">加载中...</view>
    <view v-if="finished && !loading" class="no-more">没有更多评论了</view>

    <!-- 回复输入框 -->
    <view v-if="replyTo" class="reply-input">
      <input
        v-model="replyContent"
        type="text"
        placeholder="请输入回复内容"
        @confirm="submitReply"
      />
      <button @tap="submitReply">发送</button>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.comment-section {
  padding: 20rpx;
  background-color: #fff;
}

.comment-header {
  margin-bottom: 20rpx;
  .comment-title {
    font-size: 32rpx;
    font-weight: bold;
  }
}

.comment-item {
  margin-bottom: 30rpx;
}

.comment-main {
  display: flex;
  margin-bottom: 10rpx;
}

.avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  margin-right: 20rpx;
}

.comment-content {
  flex: 1;
}

.comment-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10rpx;

  .nickname {
    font-size: 28rpx;
    font-weight: bold;
    color: #333;
  }

  .time {
    font-size: 24rpx;
    color: #999;
  }
}

.comment-text {
  font-size: 28rpx;
  color: #333;
  line-height: 1.4;
}

.comment-actions {
  margin-top: 10rpx;

  .action-text {
    font-size: 24rpx;
    color: #007aff;
    margin-right: 20rpx;
  }
}

.sub-comments {
  margin-left: 100rpx;
}

.sub-comment-item {
  display: flex;
  margin-top: 20rpx;
}

.reply-to {
  color: #007aff;
  font-weight: bold;
}

.loading,
.no-more {
  text-align: center;
  font-size: 24rpx;
  color: #999;
  padding: 20rpx 0;
}

.reply-input {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  padding: 20rpx;
  background-color: #f8f8f8;
  border-top: 1rpx solid #e0e0e0;

  input {
    flex: 1;
    height: 70rpx;
    padding: 0 20rpx;
    border: 1rpx solid #e0e0e0;
    border-radius: 35rpx;
    font-size: 28rpx;
  }

  button {
    margin-left: 20rpx;
    height: 70rpx;
    line-height: 70rpx;
    padding: 0 30rpx;
    font-size: 28rpx;
    color: #fff;
    background-color: #007aff;
    border-radius: 35rpx;
  }
}
</style>

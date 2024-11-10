<script setup>
import { baseAvatarUrl, baseUrl } from '@/utils/base'
import { defineProps } from 'vue'
import { formatTime } from '../utils/xiaohutu'

const props = defineProps({
  comment: {
    type: Object,
    required: true
  }
})
console.log(props.comment)
const emit = defineEmits(['reply', 'load-more-replies'])

const replyToComment = () => {
  emit('reply', props.comment)
}

const loadMoreReplies = () => {
  emit('load-more-replies', props.comment)
}
</script>

<template>
  <view class="comment-item">
    <image
      :src="comment.avatar ? baseUrl + comment.avatar : baseAvatarUrl"
      class="comment-avatar"
      mode="aspectFill"
    />
    <view class="comment-content">
      <view class="comment-user">{{ comment.nickName || '用户1' }}</view>
      <view class="comment-text"
        >{{ comment.parentCommentId ? '@' + comment.parentCommentId + ' ' : ''
        }}{{ comment.commentText }}</view
      >
      <view v-if="comment.commentImage" class="comment-image">
        <image :src="baseUrl + comment.commentImage" mode="aspectFit" />
      </view>
      <view class="comment-meta">
        <text class="comment-time">{{ formatTime(comment.commentTime) }}</text>
        <text class="comment-reply" @tap="replyToComment">回复</text>
      </view>

      <!-- 子评论 -->
      <view v-if="comment.replies && comment.replies.length > 0" class="replies">
        <comment-item
          v-for="reply in comment.replies.slice(0, comment.loadedReplies)"
          :key="reply.commentId"
          :comment="reply"
          @reply="replyToComment"
          @load-more-replies="loadMoreReplies"
        />
      </view>

      <!-- 展开更多按钮 -->
      <view v-if="comment.replies?.length != 0" class="load-more">
        <button @tap="loadMoreReplies" class="load-more-btn">展开更多</button>
      </view>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.comments-section {
  padding: 20rpx;
  background-color: #fff;
}

.comments-header {
  margin-bottom: 20rpx;
}

.comments-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.comments-list {
  .comment-item {
    display: flex;
    margin-bottom: 30rpx;
  }

  .comment-avatar {
    width: 80rpx;
    height: 80rpx;
    border-radius: 50%;
    margin-right: 20rpx;
  }

  .comment-content {
    flex: 1;
  }

  .comment-user {
    font-size: 28rpx;
    font-weight: bold;
    color: #333;
    margin-bottom: 10rpx;
  }

  .comment-text {
    font-size: 28rpx;
    color: #666;
    margin-bottom: 10rpx;
  }

  .comment-image {
    margin-top: 10rpx;

    image {
      width: 200rpx;
      height: 200rpx;
      border-radius: 8rpx;
    }
  }

  .comment-meta {
    display: flex;
    justify-content: space-between;
    font-size: 24rpx;
    color: #999;
  }

  .comment-reply {
    color: #007aff;
  }
}

.no-comments {
  text-align: center;
  padding: 40rpx 0;
  color: #999;
}

.load-more {
  text-align: center;
  margin-top: 20rpx;
}

.load-more-btn {
  font-size: 28rpx;
  color: #007aff;
  background-color: transparent;
  border: none;
}

.loading {
  text-align: center;
  padding: 20rpx 0;
  color: #999;
}
</style>

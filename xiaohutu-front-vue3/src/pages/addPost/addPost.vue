<template>
  <view class="post-page">
    <!-- 自定义导航栏 -->
    <view class="custom-nav">
      <view class="nav-left" @tap="handleBack">
        <text class="iconfont icon-back">←</text>
      </view>
      <view class="nav-title">发布帖子</view>
    </view>

    <view class="post-container">
      <!-- 输入区域 -->
      <view class="input-group">
        <input class="title-input" v-model="postTitle" placeholder="请输入标题" maxlength="50" />
        <textarea
          class="content-input"
          v-model="postContent"
          placeholder="分享你的想法..."
          maxlength="1000"
        />
      </view>

      <!-- 标签选择器 -->
      <view class="tags-container">
        <scroll-view class="tags-scroll" scroll-x="true" :show-scrollbar="false" :enhanced="true">
          <view class="tags-wrapper">
            <view
              v-for="(tag, index) in tags"
              :key="index"
              class="tag-item"
              :class="{ active: selectedTags.includes(tag.id) }"
              @tap="toggleTag(tag.id)"
            >
              {{ tag.tagContent }}
            </view>
          </view>
        </scroll-view>
      </view>

      <!-- 图片上传区域 -->
      <view class="image-upload">
        <view v-for="(image, index) in images" :key="index" class="image-item">
          <image :src="image.preview" mode="aspectFill" />
          <text class="delete-btn" @tap="deleteImage(index)">×</text>
        </view>
        <view class="upload-btn" @tap="chooseImage" v-if="images.length < 9">
          <text class="iconfont icon-add">+</text>
        </view>
      </view>

      <button class="publish-btn" @tap="publishPost" :disabled="!isFormValid">发布</button>
    </view>
  </view>
</template>

<script setup>
import { computed, ref, onMounted, nextTick } from 'vue'
import { onBackPress, onLoad } from '@dcloudio/uni-app'
import { useUserStore } from '@/stores'
import { getTagListAPI } from '@/services/tag'

const postTitle = ref('')
const postContent = ref('')
const images = ref([])
const tags = ref([])
const selectedTags = ref([])
const tagsWrapperWidth = ref(0)

const isFormValid = computed(() => {
  return (
    postTitle.value.trim() !== '' &&
    postContent.value.trim() !== '' &&
    selectedTags.value.length > 0
  )
})

const hasContent = computed(() => {
  return (
    postTitle.value.trim() !== '' ||
    postContent.value.trim() !== '' ||
    images.value.length > 0 ||
    selectedTags.value.length > 0
  )
})

// 图片上传逻辑
const MAX_IMAGES = 9
const MAX_SIZE = 10 * 1024 * 1024 // 10MB

const chooseImage = async () => {
  try {
    const res = await uni.chooseImage({
      count: 9 - images.value.length,
      sizeType: ['compressed', 'original'],
      sourceType: ['album', 'camera']
    })

    res.tempFiles.forEach((file) => {
      if (file.size > MAX_SIZE) {
        uni.showToast({ title: '图片不能超过10MB', icon: 'none' })
        return
      }
      if (images.value.length >= MAX_IMAGES) {
        uni.showToast({ title: '最多上传9张图片', icon: 'none' })
        return
      }
      if (file.size <= MAX_SIZE && images.value.length < MAX_IMAGES) {
        images.value.push({
          file,
          preview: file.path
        })
      }
    })
  } catch (err) {
    console.log('选择图片出错', err)
  }
}

const deleteImage = (index) => {
  images.value.splice(index, 1)
}

// 标签选择逻辑
const toggleTag = (tagId) => {
  const index = selectedTags.value.indexOf(tagId)
  if (index === -1) {
    selectedTags.value.push(tagId)
  } else {
    selectedTags.value.splice(index, 1)
  }
}

const getTags = async () => {
  try {
    const res = await getTagListAPI()
    tags.value = res.rows?.filter((item) => item.id !== 0)
    nextTick(() => {
      calculateTagsWidth()
    })
  } catch (error) {
    console.error('获取标签失败:', error)
    uni.showToast({
      title: '获取标签失败',
      icon: 'none'
    })
  }
}

const calculateTagsWidth = () => {
  const query = uni.createSelectorQuery().in(this)
  query
    .selectAll('.tag-item')
    .boundingClientRect((rects) => {
      let totalWidth = 0
      rects.forEach((rect) => {
        totalWidth += rect.width + 10 // 10 is the margin
      })
      tagsWrapperWidth.value = totalWidth
    })
    .exec()
}

const onScroll = (e) => {
  // 可以在这里添加滚动相关的逻辑，如果需要的话
  console.log('Scrolling', e)
}

const publishPost = async () => {
  if (!isFormValid.value) {
    uni.showToast({
      title: '请填写标题、内容并选择至少一个标签',
      icon: 'none'
    })
    return
  }

  // 图片上传逻辑
  const uploadPromises = images.value.map((image) => {
    return uni.uploadFile({
      url: 'http://localhost:8080/common/uploads',
      header: {
        Authorization: useUserStore().token
      },
      filePath: image.file.path,
      name: 'files',
      formData: {
        description: '图片上传测试'
      }
    })
  })

  try {
    const results = await Promise.all(uploadPromises)
    const postImageUrl = results.map((result) => JSON.parse(result.data).fileNames).join(',')

    // 这里通常会发送帖子数据到后端
    console.log('发布帖子:', {
      title: postTitle.value,
      content: postContent.value,
      images: postImageUrl,
      tags: selectedTags.value
    })

    // 发布成功后清空表单
    postTitle.value = ''
    postContent.value = ''
    images.value = []
    selectedTags.value = []

    uni.showToast({
      title: '发布成功',
      icon: 'success'
    })
  } catch (error) {
    console.error('发布帖子失败:', error)
    uni.showToast({
      title: '发布失败',
      icon: 'none'
    })
  }
}

// 导航逻辑
const lastPath = ref('')
onLoad((options) => {
  lastPath.value = options.lastPath
  getTags() // 组件加载时获取标签
})

const handleBack = () => {
  if (hasContent.value) {
    uni.showModal({
      title: '提示',
      content: '有内容没有保存，是否存入草稿箱？',
      success: (res) => {
        if (res.confirm) {
          console.log('保存草稿', {
            title: postTitle.value,
            content: postContent.value,
            images: images.value,
            tags: selectedTags.value
          })
          uni.showToast({
            title: '已保存到草稿箱',
            icon: 'success'
          })
        }
        uni.switchTab({
          url: `/pages/${lastPath.value}/${lastPath.value}`
        })
      }
    })
  } else {
    uni.switchTab({
      url: `/pages/${lastPath.value}/${lastPath.value}`
    })
  }
}

onBackPress(() => {
  if (hasContent.value) {
    handleBack()
    return true
  }
  return false
})

onMounted(() => {
  nextTick(() => {
    calculateTagsWidth()
  })
})
</script>

<style lang="scss" scoped>
.post-page {
  padding-top: 88rpx;
}

.custom-nav {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 88rpx;
  background-color: #fff;
  display: flex;
  align-items: center;
  padding: 0 20rpx;
  z-index: 100;
  box-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.1);

  .nav-left {
    width: 60rpx;
    height: 60rpx;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .nav-title {
    flex: 1;
    text-align: center;
    font-size: 32rpx;
    font-weight: bold;
  }
}

.post-container {
  padding: 20rpx;
}

// 修改后的标签样式
.tags-container {
  margin-bottom: 20rpx;
  height: 120rpx; // 调整高度以适应两行标签
  overflow: hidden;
}

.tags-scroll {
  width: 100%;
  height: 100%;
}

.tags-wrapper {
  display: grid;
  grid-template-columns: repeat(12, auto); // 每行显示14个
  grid-auto-flow: row;
  grid-auto-rows: 50rpx; // 固定每行高度
  gap: 10rpx;
  padding: 10rpx;
  width: max-content; // 允许内容自然延伸
}

.tag-item {
  height: 40rpx;
  padding: 0 16rpx;
  font-size: 24rpx;
  color: #333;
  background-color: #f5f5f5;
  border-radius: 20rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  white-space: nowrap;
  transition: all 0.3s ease;

  &.active {
    color: #fff;
    background-color: #ff2442;
  }
}

// 其他样式保持不变
.input-group {
  margin-bottom: 20rpx;
}

.title-input {
  font-size: 32rpx;
  padding: 20rpx;
  border-bottom: 1rpx solid #eee;
}

.content-input {
  font-size: 28rpx;
  padding: 20rpx;
  height: 200rpx;
  width: 100%;
  box-sizing: border-box;
}

.image-upload {
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 20rpx;
}

.image-item {
  width: 200rpx;
  height: 200rpx;
  margin-right: 20rpx;
  margin-bottom: 20rpx;
  position: relative;

  image {
    width: 100%;
    height: 100%;
    border-radius: 8rpx;
  }

  .delete-btn {
    position: absolute;
    top: -10rpx;
    right: -10rpx;
    width: 40rpx;
    height: 40rpx;
    line-height: 40rpx;
    text-align: center;
    background-color: rgba(0, 0, 0, 0.5);
    color: #fff;
    border-radius: 50%;
    font-size: 32rpx;
  }
}

.upload-btn {
  width: 200rpx;
  height: 200rpx;
  background-color: #f8f8f8;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 1rpx dashed #ddd;
  border-radius: 8rpx;

  .icon-add {
    font-size: 60rpx;
    color: #999;
  }
}

.publish-btn {
  background-color: #ff2442;
  color: #fff;
  border: none;
  border-radius: 40rpx;
  padding: 20rpx 0;
  font-size: 32rpx;

  &:disabled {
    background-color: #ccc;
  }
}
</style>

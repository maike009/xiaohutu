<script setup>
import { computed, ref, watch, reactive, onMounted, nextTick } from 'vue'
import { onBackPress, onLoad } from '@dcloudio/uni-app'
import { useTabStore, useUserStore } from '@/stores'
import { getTagListAPI } from '@/services/tag'
import {
  delPostAPI,
  getMyDraftPostDetailAPI,
  getPostDetailAPI,
  publishPostAPI,
  updatePostAPI
} from '@/services/post'
import { baseUrl } from '@/utils/base'

// 创建一个响应式对象来存储帖子数据
const postData = reactive({
  id: null,
  userId: null,
  postTitle: '',
  contentText: '',
  contentImage: '',
  tagId: '',
  isPublic: 0,
  draftStatus: 0
})
//
const userId = ref()

const switchPublic = ref(true)
// 创建一个引用对象来存储标签列表
const tags = ref([])
// 创建一个引用对象来存储选中的标签列表
const selectedTags = ref([])
// 创建一个引用对象来存储图片列表
const images = ref([])
// 服务器图片路径
const serverImagePath = ref([])
// 创建一个引用对象来存储标签区域的宽度
const tagsWrapperWidth = ref(0)
// 创建一个引用对象来存储上一个页面的路径
const lastPath = ref()

// 计算表单是否有效，确保帖子标题、内容文本和选中的标签不为空
const isFormValid = computed(() => {
  return (
    postData.postTitle.trim() !== '' &&
    postData.contentText.trim() !== '' &&
    selectedTags.value.length > 0
  )
})

// 计算是否有内容，包括帖子标题、内容文本、图片和选中的标签
const hasContent = computed(() => {
  return (
    postData.postTitle.trim() !== '' ||
    postData.contentText.trim() !== '' ||
    images.value.length > 0 ||
    selectedTags.value.length > 0
  )
})

// 定义最多可以上传的图片数量
const MAX_IMAGES = 9
// 定义图片的最大大小
const MAX_SIZE = 10 * 1024 * 1024

/**
 * 选择图片函数，用于从相册或相机选择图片
 * 此函数会检查已选图片数量，压缩图片，验证图片大小，并添加到图片列表中
 */
const chooseImage = async () => {
  try {
    const res = await uni.chooseImage({
      count: MAX_IMAGES - images.value.length,
      sizeType: ['compressed', 'original'],
      sourceType: ['album', 'camera']
    })

    res.tempFiles.forEach((file) => {
      if (file.size > MAX_SIZE) {
        uni.showToast({ title: '图片不能超过10MB', icon: 'none' })
        return
      }
      if (images.value.length < MAX_IMAGES) {
        images.value.push({ file, preview: file.path })
      }
    })
  } catch (err) {
    console.error('选择图片出错', err)
  }
}

/**
 * 删除图片函数，根据索引从图片列表中移除图片
 * @param {number} index - 图片在列表中的索引
 */
const deleteImage = (index) => {
  images.value.splice(index, 1)
}

/**
 * 切换标签函数，用于添加或移除选中的标签
 * @param {string} tagId - 标签的ID
 */
const toggleTag = (tagId) => {
  const index = selectedTags.value.indexOf(tagId)
  if (index === -1) {
    selectedTags.value.push(tagId)
  } else {
    selectedTags.value.splice(index, 1)
  }
  console.log(selectedTags.value, 'selectedTags')
}

/**
 * 获取标签列表函数，用于从服务器获取标签数据
 * 此函数会过滤掉ID为0的标签，并在获取到标签后计算标签区域的宽度
 */
const getTags = async () => {
  try {
    const res = await getTagListAPI()
    tags.value = res.rows?.filter((item) => item.id !== 0)
    nextTick(() => calculateTagsWidth())
  } catch (error) {
    console.error('获取标签失败:', error)
    uni.showToast({ title: '获取标签失败', icon: 'none' })
  }
}

/**
 * 计算标签区域宽度的函数
 * 此函数会查询所有标签项的宽度，并计算总宽度
 */
const calculateTagsWidth = () => {
  const query = uni.createSelectorQuery().in(this)
  query
    .selectAll('.tag-item')
    .boundingClientRect((rects) => {
      let totalWidth = 0
      rects.forEach((rect) => {
        totalWidth += rect.width + 10
      })
      tagsWrapperWidth.value = totalWidth
    })
    .exec()
}

/**
 * 发布帖子函数，用于将帖子数据上传到服务器
 * 此函数会验证表单有效性，上传图片，并准备帖子数据
 */
const publishPost = async () => {
  if (!isFormValid.value) {
    uni.showToast({ title: '请填写标题、内容并选择至少一个标签', icon: 'none' })
    return
  }

  try {
    const uploadPromises = images.value.map((image) =>
      uni.uploadFile({
        url: '/common/uploads', // 你的上传地址
        header: { Authorization: useUserStore().token },
        filePath: image.file.path,
        name: 'files',
        formData: { description: '图片上传测试' }
      })
    )

    const results = await Promise.all(uploadPromises)
    serverImagePath.value = [
      ...serverImagePath.value,
      ...results.map((result) => JSON.parse(result.data).fileNames)
    ]
    postData.contentImage = serverImagePath.value.join(',')
    postData.tagId = selectedTags.value.join(',')
    postData.isPublic = switchPublic.value ? 0 : 1

    console.log('发布帖子,图片日志:', postData, 'imagePath', serverImagePath.value)
    if (isEdit.value) {
      postData.draftStatus = 0
      const res = await updatePostAPI(postData)
      console.log('修改成功', res)
    } else {
      postData.draftStatus = 0
      const res = await publishPostAPI(postData)
      console.log(res, '帖子发布成功')
    }

    // 清空表单
    // 发布成功后清空表单
    selectedTags.value = []
    images.value = []
    Object.assign(postData, {
      postTitle: '',
      contentText: '',
      contentImage: '',
      tagId: '',
      isPublic: 0
    })

    uni.showToast({ title: '发布成功', icon: 'success' })
    uni.switchTab({ url: `/pages/${lastPath.value}/${lastPath.value}` })
  } catch (error) {
    console.error('发布帖子失败:', error)
    uni.showToast({ title: '发布失败', icon: 'none' })
  }
}

// 页面加载时，获取上一个页面的路径，并获取标签列表
const edit = ref(false)
onLoad((options) => {
  lastPath.value = useTabStore().lastTab
  console.log(options, 'addddddddddd')
  edit.value = options.edit
  postId.value = options.id
  if (postId.value) {
    isEdit.value = true
  }
  getTags()
})
// 编辑草稿
const postId = ref()
const isEdit = ref(false)
watch(postId, async (newValue) => {
  console.log('watch postId', newValue)
  if (!edit.value) {
    const res = await getMyDraftPostDetailAPI(newValue)
    Object.assign(postData, res.data)
    userId.value = useUserStore().profile.userId
    console.log('watch postData', postData)
    console.log(res, '获取草稿草稿', postData.userId, userId.value)
  } else {
    const res = await getPostDetailAPI(newValue)
    Object.assign(postData, res.data)
    userId.value = useUserStore().profile.userId
    console.log('watch postData', postData)
  }
  console.log(postData.tagId.split(','))
  postData.tagId.split(',').forEach((tagId) => {
    selectedTags.value.push(Number.parseInt(tagId))
  })

  if (postData.contentImage !== '' && postData.contentImage !== null) {
    postData.contentImage.split(',').forEach((item) => {
      images.value.push({ file: { path: item }, preview: baseUrl + item })
    })
    serverImagePath.value = postData.contentImage.split(',')
  }
})

// if (isEdit) {
//   const res = await getMyDraftPostDetailAPI(postId.value)
//   console.log(res, '获取草稿草稿')
// }
/**
 * 处理返回逻辑，如果页面上有内容未保存，则提示用户是否保存到草稿箱
 */
const handleBack = () => {
  console.log('handle back to ---', lastPath.value)
  if (hasContent.value) {
    uni.showModal({
      title: '提示',
      content: '有内容没有保存，是否存入草稿箱？',
      success: async (res) => {
        if (res.confirm) {
          try {
            postData.draftStatus = 1
            const uploadPromises = images.value.map((image) =>
              uni.uploadFile({
                url: '/common/uploads', // 你的上传地址
                header: { Authorization: useUserStore().token },
                filePath: image.file.path,
                name: 'files',
                formData: { description: '图片上传测试' }
              })
            )

            const results = await Promise.all(uploadPromises)
            postData.contentImage = results
              .map((result) => JSON.parse(result.data).fileNames)
              .join(',')
            postData.tagId = selectedTags.value.join(',')
            postData.isPublic = switchPublic.value ? 0 : 1

            console.log('发布帖子:', postData)
            if (postData.id !== undefined && (postData.id !== '') !== null) {
              const res = await updatePostAPI(postData)
              console.log('修改成功', res)
            } else {
              const res = await publishPostAPI(postData)
              console.log(res, '帖子发布成功')
            }

            // 清空表单
            // 发布成功后清空表单
            selectedTags.value = []
            images.value = []
            Object.assign(postData, {
              postTitle: '',
              contentText: '',
              contentImage: '',
              tagId: '',
              isPublic: 0
            })

            uni.showToast({ title: '已添加到草稿箱', icon: 'success' })
            if (lastPath.value === 0) {
              uni.navigateBack()
            } else {
              uni.switchTab({ url: `/pages/${lastPath.value}/${lastPath.value}` })
              console.log('返回')
            }
          } catch (err) {
            console.error('添加到草稿箱失败:', err)
            uni.showToast({ title: '发布失败', icon: 'none' })
          }
          console.log('保存草稿:', {
            title: postData.postTitle,
            content: postData.contentText,
            images: images.value, // 使用images.value
            tags: selectedTags.value // 使用selectedTags.value
          })
          uni.showToast({ title: '已保存到草稿箱', icon: 'success' })
        }
        if (lastPath.value === 0) {
          uni.navigateBack()
        } else {
          console.log('返回 to ---', lastPath.value)
          uni.switchTab({ url: `/pages/${lastPath.value}/${lastPath.value}` })
        }
      }
    })
  } else {
    uni.switchTab({ url: `/pages/${lastPath.value}/${lastPath.value}` })
  }
}
// 删除草稿
function delDraft(postId) {
  console.log('delDraft', postId)
  // 弹出确认
  uni.showModal({
    title: '提示',
    content: '确定删除此草稿吗？',
    success: (res) => {
      if (res.confirm) {
        const res = delPostAPI(postId)
        console.log(res, '删除成功')
        uni.showToast({ title: '删除成功', icon: 'success' })
        uni.switchTab({ url: '/pages/user/user' })
      }
    }
  })
}

// 监听页面返回操作，如果有未保存的内容，则调用 handleBack 函数处理
onBackPress(() => {
  if (hasContent.value) {
    handleBack()
    return true // 阻止默认返回行为
  }
  return false // 允许默认返回行为
})

// 页面挂载后，计算标签区域的宽度
onMounted(() => {
  nextTick(() => calculateTagsWidth())
})
</script>

<template>
  <view class="post-page">
    <view class="custom-nav">
      <view class="nav-left" @tap="handleBack">
        <text class="iconfont icon-back">←</text>
      </view>
      <view class="nav-title">{{ isEdit ? '编辑' : '发布帖子' }}</view>
    </view>

    <view class="post-container">
      <view class="input-group">
        <input
          class="title-input"
          v-model="postData.postTitle"
          placeholder="请输入标题"
          maxlength="50"
        />
        <textarea
          class="content-input"
          v-model="postData.contentText"
          placeholder="分享你的想法..."
          maxlength="1000"
        />
      </view>

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

      <view class="image-upload">
        <view v-for="(image, index) in images" :key="index" class="image-item">
          <image :src="image.preview" mode="aspectFill" />
          <text class="delete-btn" @tap="deleteImage(index)">×</text>
        </view>
        <view class="upload-btn" @tap="chooseImage" v-if="images.length < 9">
          <text class="iconfont icon-add">+</text>
        </view>
      </view>

      <view class="public-switch">
        <text>是否公开帖子</text>
        <switch style="transform: scale(0.7)" :checked="switchPublic" color="#22a0fe" />
      </view>

      <button class="publish-btn" @tap="publishPost">发布</button>
      <button
        class="publish-btn"
        style="background-color: #ef395b"
        @tap="delDraft(postData.id)"
        v-if="userId === postData.userId"
      >
        删除
      </button>
    </view>
  </view>
</template>

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
  background-color: #5d84e4;
  color: #fff;
  border: none;
  border-radius: 40rpx;
  padding: 10rpx 0;
  font-size: 32rpx;
  margin-bottom: 20px;

  &:disabled {
    background-color: #ccc;
  }
}
</style>

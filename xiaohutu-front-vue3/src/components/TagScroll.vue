<template>
  <view class="tags-container">
    <scroll-view
      class="tags-scroll"
      scroll-x="true"
      :show-scrollbar="false"
      :enhanced="true"
      :paging-enabled="true"
    >
      <view class="tags-wrapper">
        <view
          v-for="(tag, index) in tags"
          :key="index"
          class="tag-item"
          :class="{ active: currentTag === tag.id }"
          @tap="selectTag(tag.id)"
        >
          {{ tag.tagContent }}
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
import { ref, defineEmits } from 'vue'
import { getTagListAPI } from '@/services/tag'
import { onLoad } from '@dcloudio/uni-app'

const emits = defineEmits(['getPostListTag'])
// 标签数据
const tags = ref([])
async function getTags() {
  const res = await getTagListAPI()
  tags.value = res.rows
}
onLoad(getTags)
const currentTag = ref(0)

const selectTag = (tagId) => {
  currentTag.value = tagId
  console.log('Selected tag:', tagId)
  emits('getPostListTag', tagId)
}
</script>

<style lang="scss" scoped>
.tags-container {
  background-color: #fff;
  padding: 20rpx 0;
}

.tags-scroll {
  margin-top: 60px;
  white-space: nowrap;
}

.tags-wrapper {
  display: inline-block;
  padding: 0 20rpx;
}

.tag-item {
  display: inline-block;
  padding: 10rpx 30rpx;
  margin-right: 20rpx;
  font-size: 28rpx;
  color: #333;
  background-color: #f5f5f5;
  border-radius: 30rpx;
  transition: all 0.3s ease;

  &.active {
    color: #fff;
    background-color: #ea5e88;
  }

  &:last-child {
    margin-right: 0;
  }
}
</style>

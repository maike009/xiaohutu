<script setup>
import { ref, computed, onMounted } from 'vue'
import { updateUserDetailAPI, getUserDetailAPI } from '@/services/user'
import { baseAvatarUrl, baseUrl } from '@/utils/base'
import { useUserStore } from '@/stores'

const userInfo = ref({
  avatar: '',
  phoneNumber: '',
  nickName: '',
  userName: '',
  email: '',
  addr: '',
  bio: '',
  gender: '',
  backgroundImage: ''
})

const genderOptions = [
  { label: '男', value: 'male' },
  { label: '女', value: 'female' },
  { label: '其他', value: 'other' }
]

const backgroundImage = computed(() => {
  return userInfo.value.backgroundImage || '/static/images/bgc3.jpg'
})

onMounted(async () => {
  try {
    const { data } = await getUserDetailAPI()
    userInfo.value = data
  } catch (error) {
    console.error('获取用户信息失败', error)
    uni.showToast({
      title: '获取用户信息失败',
      icon: 'none'
    })
  }
})

const updateUserInfo = async () => {
  try {
    await updateUserDetailAPI(userInfo.value)
    uni.showToast({
      title: '更新成功',
      icon: 'success'
    })
    uni.navigateBack()
  } catch (error) {
    console.error('更新用户信息失败', error)
    uni.showToast({
      title: '更新失败',
      icon: 'none'
    })
  }
}

const chooseImage = (type) => {
  uni.chooseImage({
    count: 1,
    sizeType: ['compressed'],
    sourceType: ['album', 'camera'],
    success: (res) => {
      const tempFilePath = res.tempFilePaths[0]
      uni.uploadFile({
        url: 'http://localhost:8080/common/upload',
        filePath: tempFilePath,
        header: { Authorization: useUserStore().token },
        name: 'file',
        success: (uploadRes) => {
          const data = JSON.parse(uploadRes.data)
          console.log(data, 'imaggggg')
          if (type === 'avatar') {
            userInfo.value.avatar = data.fileName
          } else if (type === 'background') {
            userInfo.value.backgroundImage = data.fileName
          }
        },
        fail: () => {
          uni.showToast({
            title: '上传失败',
            icon: 'none'
          })
        }
      })
    }
  })
}
</script>

<template>
  <view class="edit-user-info" :style="{ backgroundImage: `url(${baseUrl + backgroundImage})` }">
    <view class="glassmorphism-container">
      <view class="avatar-container">
        <image
          :src="baseUrl + userInfo.avatar || baseAvatarUrl"
          class="avatar"
          @tap="chooseImage('avatar')"
        />
        <text class="change-avatar-text">点击更换头像</text>
      </view>

      <view class="form-item">
        <text class="label">背景图片</text>
        <button class="change-background-btn" @tap="chooseImage('background')">更换背景图片</button>
      </view>

      <view class="form-item">
        <text class="label">电话号码</text>
        <input v-model="userInfo.phoneNumber" placeholder="请输入电话号码" />
      </view>

      <view class="form-item">
        <text class="label">昵称</text>
        <input v-model="userInfo.nickName" placeholder="请输入昵称" />
      </view>

      <view class="form-item">
        <text class="label">用户名</text>
        <input v-model="userInfo.userName" placeholder="请输入用户名" />
      </view>

      <view class="form-item">
        <text class="label">邮箱</text>
        <input v-model="userInfo.email" placeholder="请输入邮箱" />
      </view>

      <view class="form-item">
        <text class="label">地址</text>
        <input v-model="userInfo.address" placeholder="请输入地址" />
      </view>

      <view class="form-item">
        <text class="label">简介</text>
        <textarea v-model="userInfo.bio" placeholder="请输入个人简介" />
      </view>

      <view class="form-item">
        <text class="label">性别</text>
        <picker
          :range="genderOptions"
          range-key="label"
          @change="(e) => (userInfo.gender = genderOptions[e.detail.value].value)"
        >
          <view class="picker">
            {{
              genderOptions.find((option) => option.value === userInfo.gender)?.label ||
              '请选择性别'
            }}
          </view>
        </picker>
      </view>

      <button class="submit-btn" @tap="updateUserInfo">保存修改</button>
    </view>
  </view>
</template>

<style lang="scss" scoped>
.edit-user-info {
  min-height: 100vh;
  background-size: cover;
  background-position: center;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

.glassmorphism-container {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  padding: 30px;
  width: 100%;
  max-width: 500px;
  box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
}

.avatar-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 20px;
}

.avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  margin-bottom: 10px;
  border: 4px solid rgba(255, 255, 255, 0.5);
}

.change-avatar-text {
  font-size: 14px;
  color: #ffffff;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.5);
}

.form-item {
  margin-bottom: 10px;
}

.label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
  color: #ffffff;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 1);
}

input,
textarea,
.picker {
  width: 100%;
  padding: 10px;
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 4px;
  background: rgba(255, 255, 255, 0.1);
  color: #ffffff;
}

.change-background-btn {
  background-color: rgba(0, 122, 255, 0.7);
  color: white;
  padding: 10px 20px;
  border-radius: 4px;
  border: none;
  font-size: 16px;
}

.submit-btn {
  background-color: rgba(0, 122, 255, 0.7);
  color: white;
  padding: 10px 20px;
  border-radius: 4px;
  border: none;
  font-size: 16px;
  margin-top: 20px;
  width: 100%;
}

.picker {
  height: 40px;
  line-height: 40px;
}

::placeholder {
  color: rgba(255, 255, 255);
}
</style>

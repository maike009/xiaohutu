<script setup>
// 登录参数
import { ref } from 'vue'
import { getCodeImgAPI, loginAPI, registerAPI } from '@/services/login'
import { useUserStore } from '@/stores'

const loginForm = ref({
  username: 'test1',
  password: '123456',
  rememberMe: 0,
  code: '',
  uuid: ''
})
const loginRules = ref({
  username: {
    rules: [
      {
        required: true,
        errorMessage: '用户名不能为空'
      },
      // 长度不能超过30个字符
      {
        minLength: 3,
        maxLength: 30,
        errorMessage: '用户名长度在 {minLength} 到 {maxLength} 个字符之间'
      }
    ]
  },
  password: {
    rules: [
      {
        required: true,
        errorMessage: '密码不能为空'
      },
      // 长度不能超过30个字符
      {
        minLength: 6,
        maxLength: 30,
        errorMessage: '密码长度在 {minLength} 到 {maxLength} 个字符之间'
      }
    ]
  },
  code: {
    rules: [
      {
        required: true,
        errorMessage: '验证码不能为空'
      }
    ]
  }
})
function changeRememberMe(e) {
  console.log('e', e)
}
const codeUrl = ref('')
const loading = ref(false)
// 验证码开关
const captchaEnabled = ref(true)

const redirect = ref(undefined)

const loginRef = ref()

const userStore = useUserStore()
/**
 * 登录方法
 */
function handleLogin() {
  loginRef.value
    .validate()
    .then(async (formdata) => {
      console.log('登录表单数据', formdata)
      const res = await loginAPI(loginForm.value)
      console.log(res.token)
      userStore.setToken(res.token)
      uni.showToast({
        title: '登录成功',
        icon: 'success'
      })
      uni.switchTab({
        url: '/pages/index/index'
      })
    })
    .catch((err) => {
      console.log('表单校验失败', err)
    })
}
const registerRef = ref()

// 注册开关
const isRegister = ref(false)

// 注册表单校验
const registerForm = ref({
  username: '',
  nickname: '',
  sex: '0',
  password: '',
  confirmPassword: '',
  code: '',
  uuid: ''
})

const registerRules = ref({
  username: {
    rules: [
      {
        required: true,
        errorMessage: '用户名不能为空'
      },
      // 长度不能超过30个字符
      {
        minLength: 3,
        maxLength: 30,
        errorMessage: '用户名长度在 {minLength} 到 {maxLength} 个字符之间'
      }
    ]
  },
  nickname: {
    rules: [
      {
        required: true,
        errorMessage: '昵称不能为空'
      },
      // 长度不能超过30个字符
      {
        minLength: 3,
        maxLength: 30,
        errorMessage: '昵称长度在 {minLength} 到 {maxLength} 个字符之间'
      }
    ]
  },
  password: {
    rules: [
      {
        required: true,
        errorMessage: '密码不能为空'
      },
      // 长度不能超过30个字符
      {
        minLength: 6,
        maxLength: 30,
        errorMessage: '密码长度在 {minLength} 到 {maxLength} 个字符之间'
      }
    ]
  },
  confirmPassword: {
    rules: [
      {
        required: true,
        errorMessage: '确认密码不能为空'
      },
      {
        validate: (rule, value, callback) => {
          if (value !== registerForm.value.password) {
            return callback(new Error('两次密码不一致'))
          }
          return callback()
        }
      }
    ]
  }
})
function switchRegister() {
  isRegister.value = !isRegister.value
}

/**
 *注册逻辑
 */
const handleRegister = () => {
  console.log(registerRef)

  registerRef.value
    ?.validate()
    .then(async (formData) => {
      console.log('注册表单数据', formData)
      const res = await registerAPI(registerForm.value)
      uni.showToast({
        title: '注册成功',
        icon: 'success'
      })
      uni.redirectTo({
        url: '/pages/login/login'
      })
    })
    .catch((err) => {
      console.log('表单数据校验失败', err)
    })
}

// 获取验证码
function getCode() {
  getCodeImgAPI().then((res) => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = 'data:image/gif;base64,' + res.img
      loginForm.value.uuid = res.uuid
      registerForm.value.uuid = res.uuid
    }
  })
}

getCode()
</script>

<template>
  <view class="login-page">
    <view class="blur-background"> </view>
    <span class="text-title">小糊涂</span>
    <uni-forms
      ref="loginRef"
      :modelValue="loginForm"
      :rules="loginRules"
      class="login-form"
      v-if="!isRegister"
    >
      <view class="title">欢迎登录小糊涂社区</view>

      <uni-forms-item name="username" required label="用户名">
        <uni-easyinput prefixIcon="auth" v-model="loginForm.username" placeholder="请输入用户名" />
      </uni-forms-item>

      <uni-forms-item name="password" required label="密码" leftIcon="locked">
        <uni-easyinput
          prefixIcon="locked"
          v-model="loginForm.password"
          type="password"
          placeholder="请输入密码"
        />
      </uni-forms-item>

      <uni-forms-item label="验证码" name="code" required v-if="captchaEnabled">
        <uni-easyinput
          v-model="loginForm.code"
          placeholder="验证码"
          inputAlign="center"
          :inputBorder="false"
          prefixIcon="eye"
          style="width: 65%"
        />
        <view class="login-code">
          <image :src="codeUrl" @click="getCode" mode="widthFix" class="login-code-img"></image>
        </view>
      </uni-forms-item>

      <uni-forms-item name="rememberMe">
        <label class="login-remember-me">
          <input type="checkbox" :checked="loginForm.rememberMe" @click="changeRememberMe()" />
          记住我</label
        >
      </uni-forms-item>

      <button :loading="loading" type="primary" class="login-button" @click="handleLogin">
        <text v-if="!loading">登 录</text>
        <text v-else>登 录 中...</text>
      </button>

      <view class="register-link">
        <navigator class="link-type" @click="switchRegister">立即注册</navigator>
      </view>
    </uni-forms>

    <uni-forms
      ref="registerRef"
      :modelValue="registerForm"
      :rules="registerRules"
      class="login-form"
      v-if="isRegister"
    >
      <view class="title">用户注册</view>
      <!-- 注册表单内容 -->
      <uni-forms-item name="username" required label="用户名">
        <uni-easyinput
          prefixIcon="auth"
          v-model="registerForm.username"
          placeholder="请输入用户名"
        />
      </uni-forms-item>
      <uni-forms-item name="nickname" required label="昵称" leftIcon="account">
        <uni-easyinput
          prefixIcon="contact"
          v-model="registerForm.nickname"
          placeholder="请输入昵称"
        />
      </uni-forms-item>
      <uni-forms-item name="sex" required label="性别">
        <uni-data-checkbox
          v-model="registerForm.sex"
          :localdata="[
            { text: '男', value: '0' },
            { text: '女', value: '1' },
            { text: '保密', value: '2' }
          ]"
        ></uni-data-checkbox>
      </uni-forms-item>
      <uni-forms-item name="password" required label="密码" leftIcon="locked">
        <uni-easyinput
          prefixIcon="locked"
          v-model="registerForm.password"
          type="password"
          placeholder="请输入密码"
        />
      </uni-forms-item>
      <uni-forms-item name="confirmPassword" required label="确认密码" leftIcon="locked">
        <uni-easyinput
          prefixIcon="locked"
          v-model="registerForm.confirmPassword"
          type="password"
          placeholder="请再次输入密码"
        />
      </uni-forms-item>
      <uni-forms-item label="验证码" name="code" required v-if="captchaEnabled">
        <uni-easyinput
          v-model="registerForm.code"
          placeholder="请输入验证码"
          inputAlign="center"
          :inputBorder="false"
          prefixIcon="eye"
          style="width: 65%"
          @confirm="handleLogin"
        />
        <view class="login-code">
          <image :src="codeUrl" @click="getCode" mode="widthFix" class="login-code-img"></image>
        </view>
      </uni-forms-item>
      <button @tap="handleRegister" class="login-button" type="primary">注册</button>
      <view class="register-link">
        <navigator class="link-type" @click="switchRegister">已有账号，去登录</navigator>
      </view>
    </uni-forms>
  </view>
</template>

<style lang="scss" scoped>
.login-page {
  background: linear-gradient(135deg, #6a82fb, #fc5c7d); /* 彩色渐变 */
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  padding: 20px;
  box-sizing: border-box;

  .text-title {
    font-size: 3em; /* 增加字体大小 */
    font-weight: bold; /* 加粗字体 */
    color: #e46292; /* 字体颜色 */
    text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5); /* 添加阴影效果 */
    margin-bottom: 20px; /* 增加底部间距 */
    transition:
      transform 0.3s,
      color 0.3s; /* 添加过渡效果 */
  }

  .text-title:hover {
    color: #fc5c7d; /* 悬停时的颜色 */
    transform: scale(1.1); /* 悬停时放大效果 */
  }
  .title {
    font-size: 1.5em;
    margin-bottom: 20px;
  }
  .login-code {
    display: flex;
    flex-direction: column;
    width: 60%;
    height: 40%;
    margin: 1%;
  }
  .login-button {
    width: 100%;
    margin-top: 20px;
  }
  .register-link {
    text-align: right;
    margin-top: 10px;
  }
  .login-code-img {
    width: 100%;
  }
}
.blur-background {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
  background: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(15px);
  -webkit-backdrop-filter: blur(15px);
}
.login-form {
  z-index: 1;
  background-color: rgba(255, 255, 255, 0.4);
  padding: 40px;
  border-radius: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
}

.uni-forms-item {
  border-radius: 10px; /* 添加圆角 */
  margin-bottom: 20px; /* 每个表单项之间的间距 */
  /*overflow: hidden;*/ /* 确保子元素不超出边界 */
}

.uni-easyinput {
  border-radius: 10px; /* 确保输入框有圆角 */
}

.login-remember-me {
  display: flex;
  align-items: center; /* 垂直居中对齐 */
}
.login-remember-me input {
  margin-right: 8px; /* 右侧间距 */
}
</style>

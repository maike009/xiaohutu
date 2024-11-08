<template>
  <view> 个人中心 </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { useTabStore } from '@/stores'

onShow(() => {
  const tabStore = useTabStore()
  console.log('上一次的tab路径', tabStore.lastTab)
  tabStore.setTaBList('user')
})
// 校验表单数据
const valiFormData = ref({
  name: '',
  age: '',
  introduction: ''
})
const rules = ref({
  name: {
    rules: [
      {
        required: true,
        errorMessage: '姓名不能为空'
      }
    ]
  },
  age: {
    rules: [
      {
        required: true,
        errorMessage: '年龄不能为空'
      },
      {
        format: 'number',
        errorMessage: '年龄只能输入数字'
      }
    ]
  }
})

const valiForm = ref()
function submit() {
  valiForm.value
    .validate()
    .then((res) => {
      console.log('success', res)
      uni.showToast({
        title: `校验通过`
      })
    })
    .catch((err) => {
      console.log('err', err)
    })
}
</script>

<style lang="scss">
.example {
  padding: 15px;
  background-color: #fff;
}

.segmented-control {
  margin-bottom: 15px;
}

.button-group {
  margin-top: 15px;
  display: flex;
  justify-content: space-around;
}

.form-item {
  display: flex;
  align-items: center;
}

.button {
  display: flex;
  align-items: center;
  height: 35px;
  margin-left: 10px;
}
</style>

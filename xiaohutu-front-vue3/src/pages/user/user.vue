<template>
  <view>
    <uni-section title="表单校验" type="line">
      <view class="example">
        <!-- 基础表单校验 -->
        <uni-forms ref="valiForm" :rules="rules" :modelValue="valiFormData">
          <uni-forms-item label="姓名" required name="name">
            <uni-easyinput v-model="valiFormData.name" placeholder="请输入姓名" />
          </uni-forms-item>
          <uni-forms-item label="年龄" required name="age">
            <uni-easyinput v-model="valiFormData.age" placeholder="请输入年龄" />
          </uni-forms-item>
          <uni-forms-item label="自我介绍" name="introduction">
            <uni-easyinput
              type="textarea"
              v-model="valiFormData.introduction"
              placeholder="请输入自我介绍"
            />
          </uni-forms-item>
        </uni-forms>
        <button type="primary" @click="submit()">提交</button>
      </view>
    </uni-section>
  </view>
</template>

<script setup>
import { ref } from 'vue'

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

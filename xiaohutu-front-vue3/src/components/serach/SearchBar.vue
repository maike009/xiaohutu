<template>
  <uni-search-bar
    @confirm="search"
    :focus="true"
    v-model="searchValue"
    @blur="blur"
    @focus="focus"
    @input="input"
    @cancel="cancel"
    @clear="clear"
  >
  </uni-search-bar>
</template>
<script setup>
import { ref } from 'vue'
const searchValue = ref('')

const emit = defineEmits(['getPostList'])

function getPostList(res) {
  console.log(res, 'getPostList')
  emit('getPostList', res)
}

function search(res) {
  getPostList(res.value)
}
function input(res) {
  console.log('----input:', res)
}
function clear(res) {
  getPostList(res.value)
}
function blur(res) {}
function focus(e) {}
function cancel(res) {
  getPostList(res.value)
}
</script>
<style lang="scss" scoped>
.search-result {
  padding-top: 10px;
  padding-bottom: 20px;
  text-align: center;
}

.search-result-text {
  text-align: center;
  font-size: 14px;
  color: #666;
}

.example-body {
  /* #ifndef APP-NVUE */
  display: block;
  /* #endif */
  padding: 0px;
}

.uni-mt-10 {
  margin-top: 10px;
}
</style>

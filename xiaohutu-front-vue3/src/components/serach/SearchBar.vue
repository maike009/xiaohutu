<template>
  <div class="search-box">
    <uni-search-bar
      @confirm="search"
      :focus="true"
      v-model="searchValue"
      @blur="blur"
      @focus="focus"
      @input="input"
      @cancel="cancel"
      @clear="clear"
      style="width: 90%; margin: 0 auto"
    >
    </uni-search-bar>
  </div>
</template>
<script setup>
import { ref, defineEmits } from 'vue'
const searchValue = ref('')

const emit = defineEmits(['getSearchValue'])

function getSearchValue(res) {
  console.log(res, 'getSearchValue')
  emit('getSearchValue', res)
}

function search(res) {
  console.log('----search:', res)
  getSearchValue(res.value)
}
function input(res) {
  console.log('----input:', res)
}
function clear(res) {
  console.log('----clear:', res)
  getSearchValue(res.value)
}
function blur(res) {}
function focus(e) {}
function cancel(res) {
  getSearchValue('')
}
</script>
<style lang="scss" scoped>
.search-box {
  position: fixed;
  z-index: 99;
  width: 100%;
  height: 70px;
  background: #ffffff;
}
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

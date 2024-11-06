<template>
  <search-bar @get-post-list="handleGetPostList"></search-bar>

  <post-component></post-component>
</template>

<script setup>
import SearchBar from '@/components/serach/SearchBar.vue'
import PostComponent from '@/components/postcontent/postComponent.vue'
import { ref } from 'vue'

function handleGetPostList(searchValue) {
  console.log(searchValue, 'from child')
}
</script>

<style scoped></style>

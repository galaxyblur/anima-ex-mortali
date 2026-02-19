<script setup lang="ts">
const { data: about } = await useAsyncData('about', () => {
  return queryCollection('content').path('/about').first()
})
</script>

<template>
  <article v-if="about" class="prose mx-auto">
    <ContentRenderer :value="about" />
  </article>
</template>

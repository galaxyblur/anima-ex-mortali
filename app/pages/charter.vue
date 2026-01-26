<script setup lang="ts">
const { data: charter } = await useAsyncData('charter', () => {
  return queryCollection('content').path('/charter').first()
})
</script>

<template>
  <article v-if="charter" class="prose mx-auto">
    <ContentRenderer :value="charter" />
  </article>
</template>

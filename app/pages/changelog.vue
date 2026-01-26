<script setup lang="ts">
const { data: changelog } = await useAsyncData('changelog', () => {
  return queryCollection('content').path('/changelog').first()
})
</script>

<template>
  <div>
    <h1 class="font-heading text-3xl mb-8">What's New</h1>
    <article v-if="changelog" class="prose">
      <ContentRenderer :value="changelog" />
    </article>
  </div>
</template>

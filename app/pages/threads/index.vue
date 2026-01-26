<script setup lang="ts">
const { data: threads } = await useAsyncData('threads', () => {
  return queryCollection('threads').all()
})

const { data: artifacts } = await useAsyncData('artifacts', () => {
  return queryCollection('artifacts').all()
})

const threadsWithCount = computed(() => {
  if (!threads.value || !artifacts.value) return []
  return threads.value.map((thread: any) => {
    const count = artifacts.value.filter((a: any) =>
      a.threads?.includes(thread.stem)
    ).length
    return { ...thread, artifactCount: count }
  })
})
</script>

<template>
  <div>
    <h1 class="font-serif text-3xl mb-6">Threads</h1>
    <p class="text-stone-600 mb-8">Lines of inquiry connecting the work.</p>

    <div class="space-y-4">
      <NuxtLink
        v-for="thread in threadsWithCount"
        :key="thread.path"
        :to="thread.path"
        class="block p-6 bg-white border border-stone-200 hover:border-stone-400 transition-colors"
      >
        <h2 class="font-serif text-xl mb-1">{{ thread.title }}</h2>
        <p v-if="thread.description" class="text-stone-600 text-sm mb-2">
          {{ thread.description }}
        </p>
        <span class="text-xs text-stone-500">
          {{ thread.artifactCount }} artifact{{ thread.artifactCount !== 1 ? 's' : '' }}
        </span>
      </NuxtLink>

      <p v-if="!threadsWithCount.length" class="text-stone-500 italic">
        No threads yet.
      </p>
    </div>
  </div>
</template>

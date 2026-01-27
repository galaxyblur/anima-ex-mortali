<script setup lang="ts">
const { data: threads } = await useAsyncData('threads-index', () => {
  return queryCollection('threads').all()
})

const { data: artifacts } = await useAsyncData('threads-index-artifacts', () => {
  return queryCollection('artifacts').all()
})

const threadsWithCount = computed(() => {
  if (!threads.value || !artifacts.value) return []
  return threads.value.map((thread: any) => {
    const threadSlug = thread.path?.split('/').pop()
    const count = artifacts.value?.filter((a: any) =>
      a.threads?.includes(threadSlug)
    ).length ?? 0
    return { ...thread, artifactCount: count }
  })
})
</script>

<template>
  <div>
    <h1 class="font-heading text-3xl mb-6">Threads</h1>
    <p class="text-secondary mb-8">Lines of inquiry connecting the work.</p>

    <div class="space-y-4">
      <NuxtLink
        v-for="thread in threadsWithCount"
        :key="thread.path"
        :to="thread.path"
        class="block p-6 bg-elevated border border-border-subtle hover:border-border-default transition-colors duration-300"
      >
        <h2 class="font-heading text-xl mb-1">{{ thread.title }}</h2>
        <p v-if="thread.description" class="text-secondary text-sm mb-2">
          {{ thread.description }}
        </p>
        <span class="text-xs text-tertiary">
          {{ thread.artifactCount }} artifact{{ thread.artifactCount !== 1 ? 's' : '' }}
        </span>
      </NuxtLink>

      <p v-if="!threadsWithCount.length" class="text-tertiary italic">
        No threads yet.
      </p>
    </div>
  </div>
</template>

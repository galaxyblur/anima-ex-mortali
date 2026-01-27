<script setup lang="ts">
const route = useRoute()

const { data: thread } = await useAsyncData(`thread-${route.params.slug}`, () => {
  return queryCollection('threads').path(`/threads/${route.params.slug}`).first()
})

const { data: artifacts } = await useAsyncData(`thread-${route.params.slug}-artifacts`, () => {
  return queryCollection('artifacts').all()
})

const threadSlug = route.params.slug as string

const threadArtifacts = computed(() => {
  if (!thread.value || !artifacts.value) return []
  return artifacts.value.filter((a: any) =>
    a.threads?.includes(threadSlug)
  )
})
</script>

<template>
  <div v-if="thread">
    <header class="mb-8">
      <h1 class="font-heading text-3xl mb-2">{{ thread.title }}</h1>
      <p v-if="thread.description" class="text-secondary">
        {{ thread.description }}
      </p>
    </header>

    <div v-if="thread.body" class="prose mb-8">
      <ContentRenderer :value="thread" />
    </div>

    <section>
      <h2 class="text-sm text-tertiary mb-4">
        Artifacts in this thread ({{ threadArtifacts.length }})
      </h2>
      <div class="space-y-4">
        <NuxtLink
          v-for="artifact in threadArtifacts"
          :key="artifact.path"
          :to="artifact.path"
          class="block p-4 bg-elevated border border-border-subtle hover:border-border-default transition-colors duration-300"
        >
          <h3 class="font-heading text-lg mb-1">{{ artifact.title }}</h3>
          <p class="text-secondary text-sm mb-2">{{ artifact.description }}</p>
          <div class="flex gap-3 text-xs text-tertiary">
            <span class="capitalize">{{ artifact.medium }}</span>
            <span>{{ artifact.status }}</span>
          </div>
        </NuxtLink>

        <p v-if="!threadArtifacts.length" class="text-tertiary italic">
          No artifacts in this thread yet.
        </p>
      </div>
    </section>
  </div>
</template>

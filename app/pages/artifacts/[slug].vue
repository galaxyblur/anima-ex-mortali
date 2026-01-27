<script setup lang="ts">
const route = useRoute()

const { data: artifact } = await useAsyncData(`artifact-${route.params.slug}`, () => {
  return queryCollection('artifacts').path(`/artifacts/${route.params.slug}`).first()
})

const { data: threads } = await useAsyncData(`artifact-${route.params.slug}-threads`, () => {
  return queryCollection('threads').all()
})

const artifactThreads = computed(() => {
  if (!artifact.value?.threads || !threads.value) return []
  return threads.value.filter((t: any) =>
    artifact.value?.threads?.includes(t.stem)
  )
})
</script>

<template>
  <article v-if="artifact">
    <header class="mb-8">
      <h1 class="font-heading text-3xl mb-2">{{ artifact.title }}</h1>
      <p class="text-secondary mb-4">{{ artifact.description }}</p>
      <div class="flex flex-wrap gap-4 text-sm text-tertiary">
        <span class="capitalize">{{ artifact.medium }}</span>
        <span>{{ artifact.status }}</span>
        <span v-if="artifact.date_created">Created {{ artifact.date_created }}</span>
      </div>
    </header>

    <div v-if="artifact.external_links?.length" class="mb-8 flex flex-wrap gap-3">
      <a
        v-for="link in artifact.external_links"
        :key="link.url"
        :href="link.url"
        target="_blank"
        rel="noopener"
        class="inline-flex items-center gap-1 px-4 py-2 border border-border-default hover:border-verdigris text-sm transition-colors duration-300"
      >
        {{ link.label }}
        <span class="text-tertiary">&nearr;</span>
      </a>
    </div>

    <div v-if="artifactThreads.length" class="mb-8">
      <h2 class="text-sm text-tertiary mb-2">Threads</h2>
      <div class="flex flex-wrap gap-2">
        <NuxtLink
          v-for="thread in artifactThreads"
          :key="thread.path"
          :to="thread.path"
          class="px-3 py-1 bg-hover hover:bg-verdigris-dim text-sm transition-colors duration-300"
        >
          {{ thread.title }}
        </NuxtLink>
      </div>
    </div>

    <div class="prose">
      <ContentRenderer :value="artifact" />
    </div>
  </article>
</template>

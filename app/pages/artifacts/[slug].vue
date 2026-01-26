<script setup lang="ts">
const route = useRoute()

const { data: artifact } = await useAsyncData(`artifact-${route.params.slug}`, () => {
  return queryCollection('artifacts').path(`/artifacts/${route.params.slug}`).first()
})

const { data: threads } = await useAsyncData('threads', () => {
  return queryCollection('threads').all()
})

const artifactThreads = computed(() => {
  if (!artifact.value?.threads || !threads.value) return []
  return threads.value.filter((t: any) =>
    artifact.value.threads.includes(t.stem)
  )
})
</script>

<template>
  <article v-if="artifact">
    <header class="mb-8">
      <h1 class="font-serif text-3xl mb-2">{{ artifact.title }}</h1>
      <p class="text-stone-600 mb-4">{{ artifact.description }}</p>
      <div class="flex flex-wrap gap-4 text-sm text-stone-500">
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
        class="inline-flex items-center gap-1 px-4 py-2 border border-stone-300 hover:border-stone-400 text-sm"
      >
        {{ link.label }}
        <span class="text-stone-400">&nearr;</span>
      </a>
    </div>

    <div v-if="artifactThreads.length" class="mb-8">
      <h2 class="text-sm text-stone-500 mb-2">Threads</h2>
      <div class="flex flex-wrap gap-2">
        <NuxtLink
          v-for="thread in artifactThreads"
          :key="thread.path"
          :to="thread.path"
          class="px-3 py-1 bg-stone-100 hover:bg-stone-200 text-sm"
        >
          {{ thread.title }}
        </NuxtLink>
      </div>
    </div>

    <div class="prose prose-stone">
      <ContentRenderer :value="artifact" />
    </div>
  </article>
</template>

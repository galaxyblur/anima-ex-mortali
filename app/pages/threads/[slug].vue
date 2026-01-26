<script setup lang="ts">
const route = useRoute()

const { data: thread } = await useAsyncData(`thread-${route.params.slug}`, () => {
  return queryCollection('threads').path(`/threads/${route.params.slug}`).first()
})

const { data: artifacts } = await useAsyncData('artifacts', () => {
  return queryCollection('artifacts').all()
})

const threadArtifacts = computed(() => {
  if (!thread.value || !artifacts.value) return []
  return artifacts.value.filter((a: any) =>
    a.threads?.includes(thread.value.stem)
  )
})
</script>

<template>
  <div v-if="thread">
    <header class="mb-8">
      <h1 class="font-serif text-3xl mb-2">{{ thread.title }}</h1>
      <p v-if="thread.description" class="text-stone-600">
        {{ thread.description }}
      </p>
    </header>

    <div v-if="thread.body" class="prose prose-stone mb-8">
      <ContentRenderer :value="thread" />
    </div>

    <section>
      <h2 class="text-sm text-stone-500 mb-4">
        Artifacts in this thread ({{ threadArtifacts.length }})
      </h2>
      <div class="space-y-4">
        <NuxtLink
          v-for="artifact in threadArtifacts"
          :key="artifact.path"
          :to="artifact.path"
          class="block p-4 bg-white border border-stone-200 hover:border-stone-400"
        >
          <h3 class="font-serif text-lg mb-1">{{ artifact.title }}</h3>
          <p class="text-stone-600 text-sm mb-2">{{ artifact.description }}</p>
          <div class="flex gap-3 text-xs text-stone-500">
            <span class="capitalize">{{ artifact.medium }}</span>
            <span>{{ artifact.status }}</span>
          </div>
        </NuxtLink>

        <p v-if="!threadArtifacts.length" class="text-stone-500 italic">
          No artifacts in this thread yet.
        </p>
      </div>
    </section>
  </div>
</template>

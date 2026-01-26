<script setup lang="ts">
const route = useRoute()
const medium = computed(() => route.query.medium as string | undefined)

const { data: artifacts } = await useAsyncData('artifacts', () => {
  const query = queryCollection('artifacts')
  return query.all()
})

const filteredArtifacts = computed(() => {
  if (!artifacts.value) return []
  if (!medium.value) return artifacts.value
  return artifacts.value.filter((a: any) => a.medium === medium.value)
})

const mediums = ['prose', 'poetry', 'code', 'music']
</script>

<template>
  <div>
    <h1 class="font-serif text-3xl mb-6">Artifacts</h1>

    <nav class="flex gap-4 mb-8 text-sm">
      <NuxtLink
        to="/artifacts"
        :class="[
          'px-3 py-1 border',
          !medium ? 'border-stone-900 bg-stone-900 text-white' : 'border-stone-300 hover:border-stone-400'
        ]"
      >
        All
      </NuxtLink>
      <NuxtLink
        v-for="m in mediums"
        :key="m"
        :to="`/artifacts?medium=${m}`"
        :class="[
          'px-3 py-1 border capitalize',
          medium === m ? 'border-stone-900 bg-stone-900 text-white' : 'border-stone-300 hover:border-stone-400'
        ]"
      >
        {{ m }}
      </NuxtLink>
    </nav>

    <div class="space-y-6">
      <article
        v-for="artifact in filteredArtifacts"
        :key="artifact.path"
        class="p-6 bg-white border border-stone-200"
      >
        <NuxtLink :to="artifact.path" class="block group">
          <h2 class="font-serif text-xl mb-2 group-hover:text-stone-600">
            {{ artifact.title }}
          </h2>
          <p class="text-stone-600 text-sm mb-3">{{ artifact.description }}</p>
          <div class="flex gap-3 text-xs text-stone-500">
            <span class="capitalize">{{ artifact.medium }}</span>
            <span>{{ artifact.status }}</span>
          </div>
        </NuxtLink>
      </article>

      <p v-if="filteredArtifacts.length === 0" class="text-stone-500 italic">
        No artifacts yet.
      </p>
    </div>
  </div>
</template>

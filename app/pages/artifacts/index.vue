<script setup lang="ts">
const route = useRoute()
const medium = computed(() => route.query.medium as string | undefined)

const { data: artifacts } = await useAsyncData('artifacts-index', () => {
  return queryCollection('artifacts').all()
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
    <h1 class="font-heading text-3xl mb-6">Artifacts</h1>

    <nav class="flex gap-4 mb-8 text-sm">
      <NuxtLink
        to="/artifacts"
        :class="[
          'px-3 py-1 border transition-colors duration-300',
          !medium ? 'border-ember bg-ember text-void' : 'border-border-default hover:border-ember-dim'
        ]"
      >
        All
      </NuxtLink>
      <NuxtLink
        v-for="m in mediums"
        :key="m"
        :to="`/artifacts?medium=${m}`"
        :class="[
          'px-3 py-1 border capitalize transition-colors duration-300',
          medium === m ? 'border-ember bg-ember text-void' : 'border-border-default hover:border-ember-dim'
        ]"
      >
        {{ m }}
      </NuxtLink>
    </nav>

    <div class="space-y-6">
      <article
        v-for="artifact in filteredArtifacts"
        :key="artifact.path"
        class="p-6 bg-elevated border border-border-subtle"
      >
        <NuxtLink :to="artifact.path" class="block group">
          <h2 class="font-heading text-xl mb-2 group-hover:text-ember-glow transition-colors duration-300">
            {{ artifact.title }}
          </h2>
          <p class="text-secondary text-sm mb-3">{{ artifact.description }}</p>
          <div class="flex gap-3 text-xs text-tertiary">
            <span class="capitalize">{{ artifact.medium }}</span>
            <span>{{ artifact.status }}</span>
          </div>
        </NuxtLink>
      </article>

      <p v-if="filteredArtifacts.length === 0" class="text-tertiary italic">
        No artifacts yet.
      </p>
    </div>
  </div>
</template>

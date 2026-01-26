<template>
  <div class="space-y-12">
    <section class="text-center py-12">
      <h1 class="font-serif text-4xl mb-4">Anima Ex Mortali</h1>
      <p class="text-stone-600 text-lg italic">Soul from mortality</p>
    </section>

    <section class="prose prose-stone mx-auto">
      <p>
        A living exhibit of creative work unified by the theme of mortal angst—the
        existential anxiety that motivates human action.
      </p>
    </section>

    <nav class="grid gap-6 sm:grid-cols-3">
      <NuxtLink
        to="/charter"
        class="block p-6 bg-white border border-stone-200 hover:border-stone-400 transition-colors"
      >
        <h2 class="font-serif text-xl mb-2">Charter</h2>
        <p class="text-sm text-stone-600">Mission, values, and creative philosophy</p>
      </NuxtLink>

      <NuxtLink
        to="/threads"
        class="block p-6 bg-white border border-stone-200 hover:border-stone-400 transition-colors"
      >
        <h2 class="font-serif text-xl mb-2">Threads</h2>
        <p class="text-sm text-stone-600">Lines of inquiry connecting the work</p>
      </NuxtLink>

      <NuxtLink
        to="/artifacts"
        class="block p-6 bg-white border border-stone-200 hover:border-stone-400 transition-colors"
      >
        <h2 class="font-serif text-xl mb-2">Artifacts</h2>
        <p class="text-sm text-stone-600">Prose, code, poetry, and music</p>
      </NuxtLink>
    </nav>
  </div>
</template>

<template>
  <div class="min-h-screen bg-stone-50 text-stone-900">
    <NuxtRouteAnnouncer />
    <header class="border-b border-stone-200 bg-white">
      <nav class="mx-auto max-w-3xl px-4 py-4 flex items-center justify-between">
        <NuxtLink to="/" class="font-serif text-lg">Anima Ex Mortali</NuxtLink>
        <div class="flex gap-6 text-sm">
          <NuxtLink to="/artifacts" class="hover:text-stone-600">Artifacts</NuxtLink>
          <NuxtLink to="/threads" class="hover:text-stone-600">Threads</NuxtLink>
          <NuxtLink to="/changelog" class="hover:text-stone-600">What's New</NuxtLink>
        </div>
      </nav>
    </header>
    <main class="mx-auto max-w-3xl px-4 py-8">
      <NuxtPage />
    </main>
  </div>
</template>

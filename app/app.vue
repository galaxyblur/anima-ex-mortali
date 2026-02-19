<template>
  <div class="min-h-screen bg-void text-primary font-body">
    <NuxtRouteAnnouncer />
    <header class="border-b border-border-subtle bg-surface">
      <nav class="mx-auto max-w-3xl px-4 py-4 flex items-center justify-between">
        <NuxtLink to="/" class="font-heading text-lg text-primary">Anima Ex Mortali</NuxtLink>
        <div class="flex gap-6 text-sm">
          <NuxtLink to="/artifacts" class="text-secondary hover:text-primary transition-colors duration-300">Artifacts</NuxtLink>
          <NuxtLink to="/threads" class="text-secondary hover:text-primary transition-colors duration-300">Threads</NuxtLink>
          <NuxtLink to="/changelog" class="text-secondary hover:text-primary transition-colors duration-300">What's New</NuxtLink>
          <NuxtLink to="/about" class="text-secondary hover:text-primary transition-colors duration-300">About</NuxtLink>
        </div>
      </nav>
    </header>
    <main class="mx-auto max-w-3xl px-4 py-8">
      <NuxtPage />
    </main>
  </div>
</template>

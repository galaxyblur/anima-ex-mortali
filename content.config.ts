import { defineCollection, defineContentConfig, z } from '@nuxt/content'

export default defineContentConfig({
  collections: {
    artifacts: defineCollection({
      type: 'page',
      source: 'artifacts/**/*.md',
      schema: z.object({
        title: z.string(),
        description: z.string(),
        medium: z.enum(['prose', 'poetry', 'code', 'music', 'visual']),
        status: z.enum(['complete', 'in-progress', 'archived']),
        threads: z.array(z.string()).optional(),
        date_created: z.string(),
        date_added: z.string(),
        external_links: z.array(z.object({
          url: z.string(),
          label: z.string(),
          type: z.enum(['repository', 'streaming', 'demo', 'download', 'other'])
        })).optional()
      })
    }),
    threads: defineCollection({
      type: 'page',
      source: 'threads/**/*.md',
      schema: z.object({
        title: z.string(),
        description: z.string().optional()
      })
    }),
    content: defineCollection({
      type: 'page',
      source: '*.md'
    })
  }
})

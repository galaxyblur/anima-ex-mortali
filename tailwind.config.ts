import type { Config } from 'tailwindcss'
import typography from '@tailwindcss/typography'

export default {
  content: [
    './app/**/*.{vue,js,ts}',
    './components/**/*.{vue,js,ts}',
    './layouts/**/*.{vue,js,ts}',
    './pages/**/*.{vue,js,ts}',
  ],
  theme: {
    extend: {
      colors: {
        // Backgrounds
        void: '#0a0a0c',
        surface: '#111114',
        elevated: '#18181c',
        hover: '#1f1f24',

        // Text
        primary: '#e8e6e3',
        secondary: '#9a9590',
        tertiary: '#5c5856',

        // Accents
        ember: {
          DEFAULT: '#c4785a',
          dim: '#8a5540',
          glow: '#d4917a',
        },
        verdigris: {
          DEFAULT: '#5a8a7d',
          dim: '#3d5f55',
          glow: '#7aaa9d',
        },
        aureate: {
          DEFAULT: '#b8965a',
          dim: '#8a7044',
          glow: '#d4b87a',
        },

        // Semantic
        link: '#5a8a7d',
        'link-hover': '#7aaa9d',
        'border-subtle': '#252528',
        'border-default': '#333338',
      },
      fontFamily: {
        heading: ['Cormorant Garamond', 'Georgia', 'serif'],
        body: ['Source Serif 4', 'Georgia', 'serif'],
        mono: ['JetBrains Mono', 'Consolas', 'monospace'],
      },
      typography: {
        DEFAULT: {
          css: {
            '--tw-prose-body': '#e8e6e3',
            '--tw-prose-headings': '#e8e6e3',
            '--tw-prose-lead': '#9a9590',
            '--tw-prose-links': '#5a8a7d',
            '--tw-prose-bold': '#e8e6e3',
            '--tw-prose-counters': '#5c5856',
            '--tw-prose-bullets': '#5c5856',
            '--tw-prose-hr': '#333338',
            '--tw-prose-quotes': '#9a9590',
            '--tw-prose-quote-borders': '#8a5540',
            '--tw-prose-captions': '#5c5856',
            '--tw-prose-code': '#e8e6e3',
            '--tw-prose-pre-code': '#e8e6e3',
            '--tw-prose-pre-bg': '#18181c',
            '--tw-prose-th-borders': '#333338',
            '--tw-prose-td-borders': '#252528',
            fontFamily: 'Source Serif 4, Georgia, serif',
            h1: { fontFamily: 'Cormorant Garamond, Georgia, serif' },
            h2: { fontFamily: 'Cormorant Garamond, Georgia, serif' },
            h3: { fontFamily: 'Cormorant Garamond, Georgia, serif' },
            h4: { fontFamily: 'Cormorant Garamond, Georgia, serif' },
          },
        },
      },
    },
  },
  plugins: [typography],
} satisfies Config

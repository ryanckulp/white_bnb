const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')


module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*'
  ],
  theme: {
    extend: {
      fontFamily: {
        heading:['Josefin Slab', ...defaultTheme.fontFamily.sans],
        sans: ['Inter var', ...defaultTheme.fontFamily.sans]
      },
      // custom color palette for branding, see https://tailwindcss.com/docs/customizing-colors
      colors: {
        primary: colors.gray,
        brand: {
          rose:'#e5ddda',
          green:'#c2d3cc',
          sky:'#a6c6d1',
          indigo:'#919bbf',
        }
      },
      maxHeight: {
        'md': '28rem',
        'lg': '32rem',
        'xl': '36rem',
       '2xl': '42rem',
       '3xl': '48rem',
       '4xl': '56rem',
      },
      keyframes: {
        flashfade: { "0%, 100%": { opacity: "0" }, "5%, 80%": { opacity: "1" } },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}

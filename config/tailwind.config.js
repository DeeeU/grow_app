const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      backgroundColor: {
        'default-bg': '#f7fafc', // デフォルトの背景色を指定
      },
      fontSize: {
        'default-title': '2.25rem', // デフォルトのタイトルサイズを指定 (36px)
      },
      textColor: {
        'default-title-color': '#1e40af', // デフォルトのタイトル文字色を指定
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}

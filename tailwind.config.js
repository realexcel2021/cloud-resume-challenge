/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/frontend/*.{html,js}"],
  theme: {
    extend: {
      colors: {
        lightblue : "#3c4240",
        graycolor : "#2a3761",
        'background-c' : '#F5F5F5',
        'border-brown' : '#666666',
        'link' : '#C03E03',
        'line' : '#CCCCCC'
      }
    },
    screens: {
      '2xl': {'max': '1535px'},
      // => @media (max-width: 1535px) { ... }

      'xl': {'max': '1279px'},
      // => @media (max-width: 1279px) { ... }

      'lg': {'max': '1023px'},
      // => @media (max-width: 1023px) { ... }

      'md': {'max': '767px'},
      // => @media (max-width: 767px) { ... }

      'sm': {'max': '639px'},
      // => @media (max-width: 639px) { ... }
      'big': {'min': '1023px'}
    }
  },
  plugins: [],
}

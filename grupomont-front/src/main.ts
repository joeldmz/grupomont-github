import './assets/main.css'
import { createApp } from 'vue'
import App from './App.vue'
import  router from './router/Index'

import 'vuetify/styles'
import '@mdi/font/css/materialdesignicons.css'

import { createVuetify } from 'vuetify'
import VueApexCharts from 'vue3-apexcharts'

import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'

const vuetify = createVuetify({
  components,
  directives,
})

const app = createApp(App)
app
.use(vuetify)
.use(router)
.use(VueApexCharts)
.mount('#app')

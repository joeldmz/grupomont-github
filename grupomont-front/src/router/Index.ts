import { createRouter, createWebHistory } from 'vue-router'

import Dashboard from '../views/Dashboard.vue'
import Comercial from '../views/Comercial.vue'
import Marketing from '../views/Marketing.vue'
import Empresas from '../views/Empresas.vue'
import MontseguroDetalhe from '../views/MontseguroDetalhe.vue'
import Prop5Detalhe from '../views/Prop5Detalhe.vue'
import TechBraboDetalhe from '../views/TechbraboDetalhe.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'dashboard',
      component: Dashboard,
    },
    {
      path: '/comercial',
      name: 'comercial',
      component: Comercial,
    },
    {
      path: '/marketing',
      name: 'marketing',
      component: Marketing,
    },
    {
      path: '/empresas',
      name: 'empresas',
      component: Empresas,
    },
    {
      path: '/empresas/montseguro',
      name: 'montseguro-detalhe',
      component: MontseguroDetalhe
    },
    {
      path: '/empresas/prop5',
      name: 'prop5-detalhe',
      component: Prop5Detalhe
    },
    {
      path: '/empresas/techbrabo',
      name: 'techbrabo-detalhe',
      component: TechBraboDetalhe
    }
  ],
})

export default router
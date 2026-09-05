<template>
  <v-container fluid>

    <!-- Header -->
    <div class="d-flex align-center justify-space-between mb-6">

      <div>
        <h1 class="text-h4">
          Empresas
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Visão consolidada por unidade de negócio
        </p>
      </div>

      <!-- Filtro -->
      <v-select
        v-model="unidadeSelecionada"
        label="Unidade"
        :items="unidades"
        variant="outlined"
        density="comfortable"
        hide-details
        style="max-width: 220px"
      />

    </div>

    <!-- Cards das unidades -->
    <v-row>

      <v-col
        v-for="unidade in unidadesFiltradas"
        :key="unidade.id"
        cols="12"
        md="4"
      >

        <v-card
          height="100%"
          class="pa-4"
        >

          <!-- Título -->
          <div class="mb-4">

            <div class="text-h6 font-weight-bold">
              {{ unidade.nome }}
            </div>

            <div class="text-body-2 text-medium-emphasis">
              {{ unidade.descricao }}
            </div>

          </div>

          <v-divider class="mb-4" />

          <!-- Clientes -->
          <div class="mb-4">

            <div class="text-caption text-medium-emphasis">
              Clientes
            </div>

            <div class="text-h5 font-weight-medium">
              {{ unidade.clientes }}
            </div>

          </div>

          <!-- Indicador principal -->
          <div class="mb-4">

            <div class="text-caption text-medium-emphasis">
              {{ unidade.indicadorNome }}
            </div>

            <div class="text-h5 font-weight-medium">
              {{ unidade.indicadorValor }}
            </div>

          </div>

          <!-- Receita -->
          <div class="mb-5">

            <div class="text-caption text-medium-emphasis">
              Receita
            </div>

            <div class="text-h5 font-weight-medium">
              {{ formatarMoeda(unidade.receita) }}
            </div>

          </div>

          <!-- Botão -->
          <div class="d-flex justify-end">

            <v-btn
              variant="text"
              color="primary"
              @click="verDetalhes(unidade.id)"
            >
              Ver detalhes

              <v-icon end>
                mdi-arrow-right
              </v-icon>

            </v-btn>

          </div>

        </v-card>

      </v-col>

    </v-row>

  </v-container>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()

import { computed, ref } from 'vue'

interface UnidadeNegocio {
  id: number
  nome: string
  descricao: string
  clientes: number
  indicadorNome: string
  indicadorValor: string
  receita: number
}

const unidadeSelecionada = ref('Todas')

const unidades = [
  'Todas',
  'Montseguro',
  'Prop5',
  'TechBrabo'
]

const dadosUnidades: UnidadeNegocio[] = [

  {
    id: 1,
    nome: 'Montseguro',
    descricao: 'Planos de saúde empresariais',
    clientes: 24,
    indicadorNome: 'Vidas',
    indicadorValor: '842',
    receita: 185000
  },

  {
    id: 2,
    nome: 'Prop5',
    descricao: 'Consultoria patrimonial',
    clientes: 18,
    indicadorNome: 'Volume financeiro',
    indicadorValor: 'R$ 4,2M',
    receita: 95000
  },

  {
    id: 3,
    nome: 'TechBrabo',
    descricao: 'Projetos e soluções tecnológicas',
    clientes: 15,
    indicadorNome: 'Projetos ativos',
    indicadorValor: '6',
    receita: 85000
  }

]

const unidadesFiltradas = computed(() => {

  if (unidadeSelecionada.value === 'Todas') {
    return dadosUnidades
  }

  return dadosUnidades.filter(
    unidade => unidade.nome === unidadeSelecionada.value
  )

})

function formatarMoeda(valor: number) {

  return valor.toLocaleString('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  })

}

function verDetalhes(id: number) {
  if (id === 1) {
    router.push('/empresas/montseguro')
  }

  if (id === 2) {
    router.push('/empresas/prop5')
  }

  if (id === 3) {
    router.push('/empresas/techbrabo')
  }

}

</script>

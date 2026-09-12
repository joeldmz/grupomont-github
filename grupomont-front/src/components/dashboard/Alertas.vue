<template>
  <v-card style="height: 100%;"> 
    <v-card-title>
       Principale Alertas
    </v-card-title>
    <v-divider></v-divider>
    <div
      v-if="alertas.length"
      class="d-flex flex-column ga-3 pa-3"
    >
      <div
        v-for="(alerta, index) in alertas"
        :key="index"
        class="d-flex align-center"
      >
        <v-icon
          :icon="alerta.tipo === 'success'
            ? 'mdi-check-circle-outline'
            : 'mdi-alert-outline'"
          :color="alerta.tipo === 'success'
            ? 'success'
            : 'warning'"
          size="22"
          class="pr-3"
        />

        <span class="text-body-2">
          {{ alerta.mensagem }}
        </span>
      </div>
    </div>

    <div
      v-else
      class="d-flex align-center text-medium-emphasis"
    >
      <v-icon
        icon="mdi-check-circle-outline"
        color="success"
        class="mr-3"
      />

      <span class="text-body-2">
        Nenhum ponto de atenção no período.
      </span>
    </div>
  </v-card>
</template>

<script setup lang="ts">

import { computed } from 'vue'

const props = defineProps<{
  totalReceita: number
  valorMeta: number
  pipeline: number
  ponderado: number
  conversao: number
}>()

const percentualMeta = computed(() => {
  if (!props.valorMeta) return 0

  return (props.totalReceita / props.valorMeta) * 100
})

const percentualPipeline = computed(() => {
  if (!props.pipeline) return 0

  return (props.ponderado / props.pipeline) * 100
})

const alertas = computed(() => {

  const resultado: {
    tipo: 'warning' | 'success'
    mensagem: string
  }[] = []

  // Meta
  if (percentualMeta.value < 100) {
    resultado.push({
      tipo: 'warning',
      mensagem: `Meta abaixo do esperado (${percentualMeta.value.toFixed(0)}%)`
    })
  }

  // Conversão
  if (props.conversao < 20) {
    resultado.push({
      tipo: 'warning',
      mensagem: `Taxa de conversão baixa (${props.conversao.toFixed(1)}%)`
    })
  }

  // Pipeline
  if (percentualPipeline.value < 50) {
    resultado.push({
      tipo: 'warning',
      mensagem: `Pipeline com baixa probabilidade de conversão (${percentualPipeline.value.toFixed(0)}%)`
    })
  }

  // Caso esteja tudo bem
  if (resultado.length === 0) {
    resultado.push({
      tipo: 'success',
      mensagem: 'Indicadores comerciais dentro do esperado'
    })
  }

  return resultado.slice(0, 3)
})

</script>
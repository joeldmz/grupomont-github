<template>
  <v-container fluid>
    <div class="mb-6">
      <h1 class="text-h4">
        Comercial
      </h1>

      <p class="text-body-2 text-medium-emphasis">
        Desempenho das campanhas e canais de aquisição
      </p>
    </div>
    <v-row class="py-3">
        <v-col cols="12" md="4">
             <TotalCard :data="oportunidadePipeline"/>
        </v-col>
        <v-col cols="12" md="4">
            <Pipeline :data="funilConsolidado"/>
        </v-col>
        <v-col cols="12" md="4">
            <ReceitaCard :data="funilConsolidado" />
        </v-col>
    </v-row>

    <v-row class="py-3">
        <v-col cols="12">
            <HistoricoTable :data="funilHistoricoConsolidado"/>
        </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import Pipeline from '../components/comercial/Pipeline.vue'
import { getTotalOportunidade } from '../services/oportunidadeService.ts'
import { getFunilConsolidado, getHistoricoFunilConsolidado } from '../services/funilService.ts'
import { onMounted, ref } from 'vue'
import HistoricoTable from '@/components/comercial/HistoricoTable.vue'
import TotalCard from '@/components/comercial/TotalCard.vue'
import { getPipelineOportunidade } from '@/services/overviewService.ts'
import ReceitaCard from '@/components/comercial/ReceitaCard.vue'

const oportunidadePipeline = ref<any[]>([])
const totalOportunidade = ref<any>({})
const funilConsolidado = ref<any[]>([])
const funilHistoricoConsolidado = ref<any[]>([])

onMounted(async () => {
  try {
    totalOportunidade.value = await getTotalOportunidade()
    oportunidadePipeline.value = await getPipelineOportunidade()
    funilConsolidado.value = await getFunilConsolidado()
    funilHistoricoConsolidado.value = await getHistoricoFunilConsolidado()
  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
})
</script>
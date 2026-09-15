<template>
  <v-container fluid>
    <div class="dashboard-header d-flex flex-column flex-sm-row justify-space-between align-start ga-4 mb-6">
      <div>
        <h1 class="text-h4">
          Comercial
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Desempenho e volumen comrecial
        </p>
      </div>
      <DateRangeSelector
        :start-date="rangoData.start_date"
        :end-date="rangoData.end_date"
        @change="loadComercial"
      />
    </div>
    <v-row class="py-3">
        <v-col cols="12" md="3">
            <BasicCard title="Oportunidades" 
                      :value="oportunidadePipeline.total_oportunidades"/>
        </v-col>
        <v-col cols="12" md="3">
            <BasicCard title="Conversao" 
                      :value="Number(getPersentage)"
                      :format="'percentage'"
                      :info="'Oportunidade → Ganha'"/>
        </v-col>
        <v-col cols="12" md="3">
            <BasicCard title="Pipeline" 
                      :value="Number(oportunidadePipeline.valor_potencial).toFixed(2)"
                      format="currency"
                      :info="`R$ ${Number(oportunidadePipeline.valor_ponderado_abertas).toFixed(2)}  → %${oportunidadePipeline.probabilidade_media_abertas} probablidade`"
                      />
        </v-col>
        <v-col cols="12" md="3">
            <BasicCard title="Valor Realizado" 
                      :value="Number(oportunidadePipeline.valor_realizado).toFixed(2)"
                      format="currency"/>
        </v-col>
        <v-col cols="12" md="4">
             <TotalCard :items="oportunidadePipelineByUnidade"/>
        </v-col>
        <v-col cols="12" md="4">
            <Pipeline :data="funilConsolidado"/>
        </v-col>
        <v-col cols="12" md="4">
            <EquipePerformance :data="oportunidadeByEquipe" />
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
import { getOportunidadeByEquipe, getTotalOportunidade } from '../services/oportunidadeService.ts'
import { getFunilConsolidado, getHistoricoFunilConsolidado } from '../services/funilService.ts'
import { computed, onMounted, ref } from 'vue'
import HistoricoTable from '@/components/comercial/HistoricoTable.vue'
import TotalCard from '@/components/comercial/TotalCard.vue'
import { getPipelineOportunidade, getPipelineOportunidadeByUnidade } from '@/services/overviewService.ts'
import BasicCard from '@/components/common/BasicCard.vue'
import EquipePerformance from '@/components/comercial/EquipePerformance.vue'
import DateRangeSelector, { type DateRange } from '@/components/common/DateRangeSelector.vue'

const oportunidadePipeline = ref<any>({})
const oportunidadePipelineByUnidade = ref<any>({})
const totalOportunidade = ref<any>({})
const funilConsolidado = ref<any[]>([])
const funilHistoricoConsolidado = ref<any[]>([])
const oportunidadeByEquipe = ref<any>([])

const rangoData = ref<DateRange>({
  start_date: '2026-01-01',
  end_date: '2026-12-31'
})

const loadComercial = async (range = rangoData.value) => {
  rangoData.value = range
  try {
    totalOportunidade.value = await getTotalOportunidade(range)
    oportunidadePipeline.value = await getPipelineOportunidade(range)
    oportunidadePipelineByUnidade.value = await getPipelineOportunidadeByUnidade(range)
    funilConsolidado.value = await getFunilConsolidado({ ...range, status: ['Aberta'] })
    funilHistoricoConsolidado.value = await getHistoricoFunilConsolidado({ ...range, status: ['Aberta'] })
    oportunidadeByEquipe.value = await getOportunidadeByEquipe(range)
  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
}

onMounted(() => loadComercial())

const getPersentage = computed(() => {
  if(!oportunidadePipeline) return 0
  return (Number(oportunidadePipeline.value.oportunidades_ganhas) / Number(oportunidadePipeline.value.total_oportunidades) * 100).toFixed(0)
})
</script>
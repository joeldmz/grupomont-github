<template>
  <v-container fluid>
    <div class="dashboard-header d-flex flex-column flex-sm-row justify-space-between align-start ga-4 mb-6">
        <div class="mb-6">
          <h1 class="text-h4">
            Dashboard
          </h1>

          <p class="text-body-2 text-medium-emphasis">
            Visão Executiva
          </p>
        </div>
      <DateRangeSelector
        :start-date="dateRange.start_date"
        :end-date="dateRange.end_date"
        @change="loadDashboard"
      />
    </div>
  
    <v-row class="py-3">
      <v-col cols="12"
             md="3">
          <basic-card title="Receita" 
                      :value="totalReceita.toFixed(2)"
                      format="currency"/>
      </v-col>
      <v-col cols="12"
             md="3">
          <basic-card title="Meta" 
                      :value="valorMeta.toFixed(2)"
                      format="currency">
                <template #info>
                    <span :class="gapMeta > 0 ? 'text-success' : 'text-orange'">{{ `Gap: ${gapMeta > 0 ? '+' : '-'} R$${gapMeta.toFixed(2)}` }}</span>
                </template>
          </basic-card>
      </v-col>

       <v-col cols="12"
             md="3">
          <basic-card title="Pipeline" 
                      :value="getPipeline.toFixed(2)"
                      format="currency">
                <template #info>
                    <span style="font-weight: 900;">{{ `R$ ${getPonderado.toFixed(2)} - ` }}</span>
                    <span :class="`text-${getColor(getPercentajeProbabilidade)}`">{{ `${getPercentajeProbabilidade.toFixed(0)}% probabilidade` }}</span>
                </template>
          </basic-card>
      </v-col>

      <v-col cols="12"
             md="3">
          <basic-card title="Oportunidades" 
                      :value="getTotalOportunidades">
                <template #info>
                    <span :class="`text-${getColor(getPrecentajeConversao)}`">{{ `${getPrecentajeConversao.toFixed(0)}% Conversão oportunidade → ganha` }}</span>
                </template>
          </basic-card>
      </v-col>
      <v-col cols="12"
             md="12">
          <Receita :items="receitaByUnidade"/>
      </v-col>
      <v-col cols="12"
             md="6">
          <Investimento :items="campanhasByUnidade"/>
      </v-col>
      <v-col cols="12"
             md="6">
          <Periodo title="Receita por período" :data="receitaByPerido"/>
      </v-col>
      <!-- <v-col cols="12"
             md="4">
          <Alertas
            :total-receita="totalReceita"
            :valor-meta="valorMeta"
            :pipeline="getPipeline"
            :ponderado="getPonderado"
            :conversao="getPrecentajeConversao"
          />
      </v-col> -->
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { getPipelineByUnidade } from '../services/oportunidadeService.ts'
import { getTotalCampanhas } from '../services/campanhaService.ts'
import { getReceitaByPeriodo, getTotalReceita } from '@/services/receitaService.ts'
import BasicCard from '@/components/common/BasicCard.vue'
import { getMeta } from '@/services/metaService.ts'
import Investimento from '@/components/dashboard/Investimento.vue'
import Receita from '@/components/dashboard/Receita.vue'
import Periodo from '@/components/dashboard/Periodo.vue'
import DateRangeSelector, { type DateRange } from '@/components/common/DateRangeSelector.vue'
import type { CampaignSummary, MetaSummary, PipelineSummary, RevenueByUnit } from '@/types/api'

const campanhasByUnidade = ref<CampaignSummary[]>([])
const receitaByUnidade = ref<RevenueByUnit[]>([])
const pipelineByOportunidade = ref<PipelineSummary[]>([])
const metaGeral = ref<MetaSummary[]>([])
const receitaByPerido = ref<Record<string, unknown>[]>([])
const dateRange = ref<DateRange>({
  start_date: '2026-01-01',
  end_date: '2026-12-31',
})

const loadDashboard = async (range = dateRange.value) => {
  dateRange.value = range
  try {
    receitaByUnidade.value = await getTotalReceita(range)
    campanhasByUnidade.value = await getTotalCampanhas(range)
    pipelineByOportunidade.value = await getPipelineByUnidade(range)
    metaGeral.value = await getMeta({ tipo: 'Receita', meta_geral: true })
    receitaByPerido.value = await getReceitaByPeriodo(range)
  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
}

onMounted(() => loadDashboard())


const totalReceita = computed(() => {
    if(!receitaByUnidade) return 0
    return receitaByUnidade.value.reduce((total, item) => total + Number(item.receita_realizada), 0)
})

const valorMeta = computed(() => {
  if(!metaGeral) return 0
  return metaGeral.value.reduce((total, item) => total + Number(item.valor_meta), 0)
})

const gapMeta = computed(() => {
  const realizado = Number(totalReceita.value)
  const meta = Number(valorMeta.value)
  return (realizado - meta)
})

const getPipeline = computed(() => {
  if(!pipelineByOportunidade) return 0
  return pipelineByOportunidade.value.reduce((total, item) => total + Number(item.pipeline), 0)
})

const getPonderado = computed(() => {
  if(!pipelineByOportunidade) return 0
  return pipelineByOportunidade.value.reduce((total, item) => total + Number(item.pipeline_ponderado), 0)
})

const getPercentajeProbabilidade = computed(() => {
  if (!getPipeline.value) return 0
  return (getPonderado.value / getPipeline.value) * 100
})

const getTotalOportunidades = computed(() => {
  if(!campanhasByUnidade) return 0
  return campanhasByUnidade.value.reduce((total, item) => total + Number(item.oportunidades), 0)
})

const getTotalOportunidadesGanha = computed(() => {
  if(!campanhasByUnidade) return 0
  return campanhasByUnidade.value.reduce((total, item) => total + Number(item.oportunidades_ganhas), 0)
})

const getPrecentajeConversao = computed(() => {
  if(!getTotalOportunidades.value) return 0
  return getTotalOportunidadesGanha.value / getTotalOportunidades.value * 100
})

const getColor = (value: number) => {
  if (value >= 100) {
    return 'green'
  } else if (value >= 70) {
    return 'orange'
  } else {
    return 'red'
  }
}

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('pt-BR')
}

</script>
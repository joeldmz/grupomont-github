<template>
  <v-container fluid>
    <!-- Header -->
    <div class="dashboard-header d-flex flex-column flex-sm-row justify-space-between align-start ga-4 mb-6">
      <div>
        <h1 class="text-h4">
          Prop5
        </h1>
        <p class="text-body-2 text-medium-emphasis">
          Visão detalhada da unidade de negócio
        </p>
      </div>
      <DateRangeSelector
        :start-date="dateRange.start_date"
        :end-date="dateRange.end_date"
        @change="loadProp5"
      />
    </div>
    <v-row class="py-4">
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Operações" :value="operacoes.length ?? 0" />
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard
          title="Volume Financeiro"
          :value="mainData.pipeline_patrimonial ?? 0"
          format="currency"
        />
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard
          title="Volume Transacionado"
          :value="mainData.volume_transacionado ?? 0"
          format="currency"
        />
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard
          title="Receita"
          :value="mainData.receita_realizada ?? 0"
          format="currency"
        />
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12" md="3">
          <StatusList :items="funil" :active="16" :unidade_id="2"/>
      </v-col>
      <v-col cols="12" md="9">
          <OperacaoList :data="operacoes"/>
      </v-col>
    </v-row>
 </v-container>
</template>


<script setup lang="ts">
import BasicCard from '@/components/common/BasicCard.vue'
import StatusList from '@/components/common/StatusList.vue'
import OperacaoList from '@/components/prop5/OperacaoList.vue'
import DateRangeSelector, { type DateRange } from '@/components/common/DateRangeSelector.vue'
import { getFunilByUnidade } from '@/services/funilService'
import { getMainData, getOperacoes } from '@/services/operacaoService'
import { onMounted, ref } from 'vue';
import type { FunilItem, Prop5MainData } from '@/types/api'

const mainData = ref<Prop5MainData>({})
const funil = ref<FunilItem[]>([])
const operacoes = ref<Record<string, unknown>[]>([])
const dateRange = ref<DateRange>({
  start_date: '2026-01-01',
  end_date: '2026-12-31',
})

const loadProp5 = async (range = dateRange.value) => {
  dateRange.value = range
  try {
    mainData.value = await getMainData(range)
    funil.value = await getFunilByUnidade({ ...range, unidade_negocio_id: 2, status: ['Aberta', 'Ganha'] })
    operacoes.value = await getOperacoes(range)
  } catch (error) {
    console.error('Erro ao buscar dados do cliente:', error)
  }
}

onMounted(() => loadProp5())

</script>

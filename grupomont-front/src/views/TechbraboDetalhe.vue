<template>
  <v-container fluid>
    <!-- Header -->
    <div class="dashboard-header d-flex flex-column flex-sm-row justify-space-between align-start ga-4 pb-6">
      <div>
        <h1 class="text-h4">
          TechBrabo
        </h1>
        <p class="text-body-2 text-medium-emphasis">
          Visão detalhada da unidade de negócio
        </p>
      </div>
      <DateRangeSelector
        :start-date="dateRange.start_date"
        :end-date="dateRange.end_date"
        @change="loadTechbrabo"
      />
    </div>
    <v-row>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Projetos" :value="mainKpis.quantidade_projetos ?? 0" />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Progresso Medio" :value="Number(progresso.progresso_medio).toFixed(0)"  format="percentage">
          <template #info>
                <span :class="`text-${getColor(progresso.progresson_medio)}`">{{ getProgressMessage(progresso.progresso_medio) }}</span>
          </template>
        </BasicCard>
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Receita Pontual" :value="mainKpis.receita_pontual ?? 0" format="currency" />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Receita Recorrente" :value="mainKpis.receita_recorrente ?? 0" format="currency" />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="4"
      >
        <StatusList :items="funil" :active="23" :unidade_id="3"/>
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="8"
      >
        <ProjetoList :data="projetos"/>
      </v-col>
    </v-row>
  </v-container>
</template>


<script setup lang="ts">
import BasicCard from '@/components/common/BasicCard.vue'
import StatusList from '@/components/common/StatusList.vue'
import ProjetoList from '@/components/techbrabo/ProjetoList.vue'
import DateRangeSelector, { type DateRange } from '@/components/common/DateRangeSelector.vue'
import { getFunilByUnidade } from '@/services/funilService'
import { getMainKpis, getProgresso, getProjetos } from '@/services/projetoService'
import { computed, onMounted, ref } from 'vue';
import type { FunilItem, TechbraboMainKpis } from '@/types/api'

const mainKpis = ref<TechbraboMainKpis>({})
const funil = ref<FunilItem[]>([])
const projetos = ref<Record<string, unknown>[]>([])
const progresso = ref<any>({})
const dateRange = ref<DateRange>({
  start_date: '2026-01-01',
  end_date: '2026-12-31',
})

const loadTechbrabo = async (range = dateRange.value) => {
  dateRange.value = range
  try {
      mainKpis.value = await getMainKpis(range)
      funil.value = await getFunilByUnidade({ ...range, unidade_negocio_id: 3, status: ['Aberta', 'Ganha'] })
      projetos.value = await getProjetos(range)
      progresso.value = await getProgresso()
  } catch (error) {
    
  }
}

onMounted(() => loadTechbrabo())

const getColor = (value: number) => {
  if (value >= 90) {
    return 'red'
  } else if (value >= 75) {
    return 'orange'
  } else {
    return 'green'
  }
}

const getProgressMessage = (progress: number) => {
  if (progress >= 90) {
    return 'Conclusão se aproximando'
  }

  if (progress >= 75) {
    return 'Prazo se aproximando'
  }

  if (progress >= 50) {
    return 'Projetos em andamento'
  }

  return 'Projetos no prazo'
}


</script>

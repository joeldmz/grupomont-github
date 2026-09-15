<template>
  <v-container fluid>
    <div class="d-flex justify-space-between align-start mb-6">
      <div>
        <h1 class="text-h4">
          Marketing
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Desempenho das campanhas e canais de aquisição
        </p>
      </div>
      <DateRangeSelector
        :start-date="rangoData.start_date"
        :end-date="rangoData.end_date"
        @change="loadMarketing"
      />
    </div>

    <v-row class="py-2">
      <v-col cols="12" md="3">
        <BasicCard title="Investimento"
                    :value="getTotal(campanhasByUnidade, 'investimento')"
                    format="currency"/>
      </v-col>

      <v-col cols="12" sm="6" md="3">
        <KpiCard
          title="Leads"
          :value="getTotal(campanhasByUnidade, 'leads')"
          :target="getTotal(metaLeads, 'valor_meta')"
        />
      </v-col>

      <v-col cols="12" sm="6" md="3">
        <KpiCard
          title="Oportunidades"
          :value="getTotal(campanhasByUnidade, 'oportunidades')"
          :target="getTotal(metaOportunidades, 'valor_meta')"
        />
      </v-col>

      <v-col cols="12" sm="6" md="3">
          <BasicCard title="Conversao"
                     :value="Number(getConversao())"
                     format="percentage"
                     :info="'Lead → Oportunidade'"
          />
      </v-col>

      <v-col cols="12" md="6">
          <UnidadePerformance :data="campanhasByUnidade" 
                              :meta-leads="metaLeads"
                              :meta-oportunidades="metaOportunidades"/>
      </v-col>

      <v-col cols="12" md="6">
          <CanalChart :data="canalPerformance"/>
      </v-col>

      <v-col cols="12">
          <CampanhaList :data="campanhas"/>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import BasicCard from '@/components/common/BasicCard.vue';
import CampanhaList from '@/components/marketing/CampanhaList.vue';
import CanalChart from '@/components/marketing/CanalChart.vue';
import KpiCard from '@/components/marketing/KpiCard.vue';
import UnidadePerformance from '@/components/marketing/UnidadePerformance.vue';
import { getCampanhas, getResultadoByCanal, getTotalCampanhas } from '@/services/campanhaService';
import { getMeta } from '@/services/metaService';
import { getMarketingPerformance } from '@/services/overviewService';
import { onMounted, ref } from 'vue';
import DateRangeSelector, { type DateRange } from '@/components/common/DateRangeSelector.vue';

const campanhas = ref<any[]>([])
const marketingPerformance = ref<any[]>([])
const canalPerformance = ref<any[]>([])
const campanhasByUnidade = ref<any[]>([])
const metaLeads = ref<any[]>([])
const metaOportunidades = ref<any[]>([])

const rangoData = ref<DateRange>({
  start_date: '2026-01-01',
  end_date: '2026-12-31'
})

const loadMarketing = async (range = rangoData.value) => {
  rangoData.value = range
  try {
    campanhasByUnidade.value = await getTotalCampanhas(range)
    metaLeads.value = await getMeta({ tipo: 'Leads', meta_geral: true })
    metaOportunidades.value = await getMeta({ tipo: 'Oportunidades', meta_geral: true })
    campanhas.value = await getCampanhas(range)
    marketingPerformance.value = await getMarketingPerformance(rangoData.value)
    canalPerformance.value = await getResultadoByCanal(rangoData.value)
  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
}

onMounted(() => loadMarketing())


const getTotal = (array: any[], attr: string) => {
  if(!array) return 0
  return array.reduce((total: number, item: any) => total + Number(item[attr]), 0)
}

const getConversao = () => {
  return (getTotal(campanhasByUnidade.value,'oportunidades') / getTotal(campanhasByUnidade.value, 'leads') * 100).toFixed(0)
}



const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('pt-BR')
}
</script>
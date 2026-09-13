<template>
  <v-container fluid>
    <div class="mb-6">
      <h1 class="text-h4">
        Marketing
      </h1>

      <p class="text-body-2 text-medium-emphasis">
        Desempenho das campanhas e canais de aquisição
      </p>
    </div>

    <v-row class="py-2">
      <v-col cols="12" md="3">
        <!-- <KpiCard
          title="Investimento"
          :value="Number(investimento.investimento_consolidado)"
          :target="70000"
          type="currency"
        /> -->
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
          <!-- <ConversaoCard :data="{ value: oportunidades.value, target: leads.value }"/> -->
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
import ConversaoCard from '@/components/common/ConversaoCard.vue';
import CampanhaList from '@/components/marketing/CampanhaList.vue';
import CanalChart from '@/components/marketing/CanalChart.vue';
import KpiCard from '@/components/marketing/KpiCard.vue';
import UnidadePerformance from '@/components/marketing/UnidadePerformance.vue';
import { getCampanhas, getInvestimento, getResultadoByCanal, getTotalCampanhas } from '@/services/campanhaService';
import { getTotalLead } from '@/services/leadService';
import { getMeta } from '@/services/metaService';
import { getTotalOportunidade } from '@/services/oportunidadeService';
import { getMarketingPerformance } from '@/services/overviewService';
import { computed, onMounted, ref } from 'vue';

const campanhas = ref<any[]>([])
const investimento = ref<any>({})
const leads = ref<any>({})
const oportunidades = ref<any>({})
const marketingPerformance = ref<any[]>([])
const canalPerformance = ref<any[]>([])
const campanhasByUnidade = ref<any[]>([])
const metaLeads = ref<any[]>([])
const metaOportunidades = ref<any[]>([])

const rangoData = ref({
  start_date: '2026-01-01',
  end_date: '2026-10-01'
})

onMounted(async () => {
  try {
    campanhasByUnidade.value = await getTotalCampanhas()
    metaLeads.value = await getMeta({ tipo: 'Leads', meta_geral: true })
    metaOportunidades.value = await getMeta({ tipo: 'Oportunidades', meta_geral: true })
    //campanhas
    campanhas.value = await getCampanhas()
    // investimento.value = await getInvestimento(rangoData.value)
    // leads.value = await getTotalLead(rangoData.value)
    // oportunidades.value = await getTotalOportunidade(rangoData.value)
    marketingPerformance.value = await getMarketingPerformance(rangoData.value)
    canalPerformance.value = await getResultadoByCanal(rangoData.value)
  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
})


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
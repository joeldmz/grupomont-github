<template>
  <v-container fluid>
    <div class="d-flex justify-space-between">
        <h1 class="text-h4 mb-6">
            Visão Executiva
        </h1>
        <v-chip v-if="receita" size="small">{{ 'Periodo de analise - ' + formattedDate }}</v-chip>
    </div>
    

    <v-row class="py-3">
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard
            title="Investimento"
            :value="investimento"
            format="currency"
            :quantity="2"
            :target="57"
            :percentage="15.79"
            :gap="-48"
            period-text="vs meta de agosto"
        />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard
            title="Leads"
            :value="totalLead.value"
            :target="totalLead.target"
            @click="openLead"
        />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard
            title="Oportunidades"
            :value="totalOportunidade.value"
            :target="totalOportunidade.target"
            @click="openOportunidade"
        />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard
            title="Receita"
            format="currency"
            :value="92000"
            :target="9000"
        />
      </v-col>

      <!-- <v-col
        cols="12"
        sm="6"
        md="4"
      >
        <KpiCard
            title="Receita"
            :date="formattedDate"
            :value="receita.value || 0"
            :target="receita.target || 0"
            type="currency"
            @click="openMore"
            />
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="4"
      >
        <KpiCard
            title="Oportunidades de Negocio"
            :value="totalOportunidade.value || 0"
            :target="totalOportunidade.target || 0"
            @click="openOportunidade"
            />
      </v-col>

      <v-col cols="12" sm="6" md="4">
        <KpiCard
          title="Leads"
          :value="leadAtingimento.value || 0"
          :target="leadAtingimento.target || 0"
          @click="openLead"
        />
      </v-col> -->

    </v-row>

    <!-- <v-row class="py-3">
        <v-col cols="12">
            <Pipeline />
        </v-col>
    </v-row> -->

    <v-row class="py-3">
        <v-col cols="12" md="4">
            <ConversaoChart :data="formattedConversao" :categories="['Montseguro', 'Prop5', 'TechBrabo']"/>
        </v-col>
        <v-col cols="12" md="4">
            <OportunidadeCard :data="oportunidadePipeline" />
        </v-col>
        <v-col cols="12" md="4">
            <ResultadosGeradosCard :data="resultadosGerados"/>
        </v-col>
        <!-- <v-col cols="12" md="4">
            <ReceitaChart />
        </v-col> -->
    </v-row>

    <!-- <v-row class="py-3">
        <v-col cols="12" md="6">
            <FunilChart />
        </v-col>
    </v-row> -->

  </v-container>
</template>

<script setup lang="ts">
import KpiCard from '../components/dashboard/KpiCard.vue'
import Pipeline from '../components/dashboard/Pipeline.vue'
import ReceitaChart from '../components/dashboard/ReceitaChart.vue'
import FunilChart from '../components/dashboard/FunilChart.vue'
import { computed, onMounted, ref } from 'vue'
import { 
  getReceitaOverview, 
  getReceitaUnidadeOverview, 
  getTaixaConversao, 
  getPipelineOportunidade, 
  getResultadosGerados 
} from '../services/overviewService.ts'

import { getTotalOportunidade, getOportunidadeByUnidade } from '../services/oportunidadeService.ts'
import { getTotalLead, getLeadUnidade } from '../services/leadService.ts'
import { getCampanhas } from '../services/campanhaService.ts'
import { abrirDialog } from '../composables/UseDialog.ts'
import BasicCard from '@/components/common/BasicCard.vue'
import ConversaoChart from '@/components/dashboard/conversaoChart.vue'
import OportunidadeCard from '@/components/dashboard/oportunidadeCard.vue'
import ResultadosGeradosCard from '@/components/dashboard/resultadosGeradosCard.vue'

const receita = ref<any>({})
const campanhas = ref<any[]>([])
const taixaConverao = ref<any[]>([])
const receitaByUnidade = ref<any[]>([])
const leadByUnidade = ref<any[]>([])
const oportunidadeByUnidade = ref<any[]>([])
const oportunidadePipeline = ref<any[]>([])
const totalOportunidade = ref<any>({})
const totalLead = ref<any>({})
const resultadosGerados = ref<any>({})


onMounted(async () => {
  try {

    //campanhas
    campanhas.value = await getCampanhas('Ativa')

    //receita
    receita.value = await getReceitaOverview()
    receitaByUnidade.value = await getReceitaUnidadeOverview()

    //Leads
    totalLead.value = await getTotalLead()
    leadByUnidade.value = await getLeadUnidade()

    //Oportunidades
    totalOportunidade.value = await getTotalOportunidade()
    oportunidadeByUnidade.value = await getOportunidadeByUnidade()
    oportunidadePipeline.value = await getPipelineOportunidade()

    //conversao
    taixaConverao.value = await getTaixaConversao();
    resultadosGerados.value = await getResultadosGerados()

  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
})



const formattedDate = computed(() => {
  if (receita === null) return ''
  return `${formatDate(receita.value.periodo_inicio)} ao ${formatDate(receita.value.periodo_fim)}`
})

const investimento = computed(() => {
    if(campanhas === null) return 0
    return campanhas.value.reduce((total, v) => total + Number(v.investimento), 0);
})

const formattedConversao = computed(() => {
    return taixaConverao.value.map((value: any) => value.taxa_conversao);
})

function openMore() {
   abrirDialog(
    '',
    'Informações detalhadas geral da receita',
    [KpiCard, KpiCard, KpiCard],
    receitaByUnidade.value,
    () => {
      console.log('Confirmado')
    }
  )

}

function openOportunidade() {
    console.log(oportunidadeByUnidade.value)
   abrirDialog(
    'Oportunidades',
    'Informações detalhadas geral de oportunidades de negocio',
    [KpiCard, KpiCard, KpiCard],
    oportunidadeByUnidade.value,
    () => {
      console.log('Confirmado')
    }
  )

}

function openLead() {
   abrirDialog(
    'Leads',
    'Informações detalhadas geral de leads',
    [KpiCard, KpiCard, KpiCard],
    leadByUnidade.value,
    () => {
      console.log('Confirmado')
    }
  )

}

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('pt-BR')
}

</script>
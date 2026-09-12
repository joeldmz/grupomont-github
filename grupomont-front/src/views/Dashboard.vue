<template>
  <v-container fluid>
    <div class="d-flex justify-space-between">
        <div class="mb-6">
          <h1 class="text-h4">
            Dashboard
          </h1>

          <p class="text-body-2 text-medium-emphasis">
            Visão Executiva
          </p>
        </div>
        <!-- <v-chip v-if="receita" size="small">{{ 'Periodo de analise - ' + formattedDate }}</v-chip> -->
    </div>
  
    <v-row class="py-3">
      <v-col cols="12"
             md="3">
          <basic-card title="Receita" 
                      :value="totalReceita"
                      format="currency"/>
      </v-col>
      <v-col cols="12"
             md="3">
          <basic-card title="Meta" 
                      :value="valorMeta"
                      :info="`Gap: ${gapMeta.toFixed(2)}`"
                      format="currency"/>
      </v-col>

       <v-col cols="12"
             md="3">
          <basic-card title="Pipeline" 
                      :value="getPipeline"
                      :info="`R$ ${getPonderado.toFixed(2)} - %${getPercentajeProbabilidade.toFixed(0)} probablidade`"
                      format="currency"/>
      </v-col>

      <v-col cols="12"
             md="3">
          <basic-card title="Oportunidades" 
                      :value="getTotalOportunidades"
                      :info="`%${getPrecentajeConversao.toFixed(0)} Conversao oportunidade → Ganha`"
                      />
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
          <Periodo title="Crecimento por periodo" :data="receitaByPerido"/>
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
import { getCampanhas, getTotalCampanhas } from '../services/campanhaService.ts'
import { abrirDialog } from '../composables/UseDialog.ts'
import { getReceitaByPeriodo, getTotalReceita } from '@/services/receitaService.ts'
import BasicCard from '@/components/common/BasicCard.vue'
import { getMeta } from '@/services/metaService.ts'
import Investimento from '@/components/dashboard/Investimento.vue'
import Receita from '@/components/dashboard/Receita.vue'
import Periodo from '@/components/dashboard/Periodo.vue'
import Alertas from '@/components/dashboard/Alertas.vue'

const campanhasByUnidade = ref<any[]>([])
const receitaByUnidade = ref<any[]>([])
const pipelineByOportunidade = ref<any[]>([])
const metaGeral = ref<any[]>([])
const receitaByPerido = ref<any[]>([])

const receita = ref<any[]>([])
const taixaConverao = ref<any[]>([])
const leadByUnidade = ref<any[]>([])
const oportunidadeByUnidade = ref<any[]>([])
const oportunidadePipeline = ref<any[]>([])
const totalOportunidade = ref<any>({})
const totalLead = ref<any>({})
const resultadosGerados = ref<any>({})


onMounted(async () => {
  try {
    receitaByUnidade.value = await getTotalReceita()
    campanhasByUnidade.value = await getTotalCampanhas()
    pipelineByOportunidade.value = await getPipelineByUnidade()
    metaGeral.value = await getMeta({ tipo: 'Receita', meta_geral: true })
    receitaByPerido.value = await getReceitaByPeriodo()
  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
})


const totalReceita = computed(() => {
    if(!receitaByUnidade) return 0
    return receitaByUnidade.value.reduce((total: number, item: any) => total + Number(item.receita_realizada), 0)
})

const valorMeta = computed(() => {
  if(!metaGeral) return 0
  return metaGeral.value.reduce((total: number, item: any) => total + Number(item.valor_meta), 0)
})

const gapMeta = computed(() => {
  const realizado = Number(totalReceita.value)
  const meta = Number(valorMeta.value)
  return (realizado - meta)
})

const getPipeline = computed(() => {
  if(!pipelineByOportunidade) return 0
  return pipelineByOportunidade.value.reduce((total: number, item: any) => total + Number(item.pipeline), 0)
})

const getPonderado = computed(() => {
  if(!pipelineByOportunidade) return 0
  return pipelineByOportunidade.value.reduce((total: number, item: any) => total + Number(item?.pipeline_ponderado), 0)
})

const getPercentajeProbabilidade = computed(() => {
  if (!getPipeline.value) return 0
  return (getPonderado.value / getPipeline.value) * 100
})

const getTotalOportunidades = computed(() => {
  if(!campanhasByUnidade) return 0
  return campanhasByUnidade.value.reduce((total: number, item: any) => total + Number(item?.oportunidades), 0)
})

const getTotalOportunidadesGanha = computed(() => {
  if(!campanhasByUnidade) return 0
  return campanhasByUnidade.value.reduce((total: number, item: any) => total + Number(item?.oportunidades_ganhas), 0)
})


const getPrecentajeConversao = computed(() => {
  if(!getTotalOportunidades.value) return 0
  return getTotalOportunidadesGanha.value / getTotalOportunidades.value * 100
})


/*const formattedDate = computed(() => {
  if (receita === null) return ''
  return `${formatDate(receita.value.periodo_inicio)} ao ${formatDate(receita.value.periodo_fim)}`
}) */

/*const investimento = computed(() => {
    if(campanhas === null) return 0
    return campanhas.value.reduce((total, v) => total + Number(v.investimento), 0);
}) */

/*const formattedConversao = computed(() => {
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

} */

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('pt-BR')
}

</script>
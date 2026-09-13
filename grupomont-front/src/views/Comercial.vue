<template>
  <v-container fluid>
    <div class="mb-6">
      <h1 class="text-h4">
        Comercial
      </h1>

      <p class="text-body-2 text-medium-emphasis">
        Desempenho e volumen comrecial
      </p>
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
                      :value="oportunidadePipeline.valor_potencial"
                      format="currency"
                      :info="`R$ ${Number(oportunidadePipeline.valor_ponderado_abertas).toFixed(2)}  → %${oportunidadePipeline.probabilidade_media_abertas} probablidade`"
                      />
        </v-col>
        <v-col cols="12" md="3">
            <BasicCard title="Valor Realizado" 
                      :value="Number(oportunidadePipeline.valor_realizado)"
                      format="currency"/>
        </v-col>
        <v-col cols="12" md="4">
             <TotalCard :data="oportunidadePipeline"/>
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
import { getPipelineOportunidade } from '@/services/overviewService.ts'
import BasicCard from '@/components/common/BasicCard.vue'
import EquipePerformance from '@/components/comercial/EquipePerformance.vue'

const oportunidadePipeline = ref<any>({})
const totalOportunidade = ref<any>({})
const funilConsolidado = ref<any[]>([])
const funilHistoricoConsolidado = ref<any[]>([])
const oportunidadeByEquipe = ref<any>([])

onMounted(async () => {
  try {
    totalOportunidade.value = await getTotalOportunidade()
    oportunidadePipeline.value = await getPipelineOportunidade()
    funilConsolidado.value = await getFunilConsolidado()
    funilHistoricoConsolidado.value = await getHistoricoFunilConsolidado()
    oportunidadeByEquipe.value = await getOportunidadeByEquipe()
  } catch (error) {
    console.error('Erro ao carregar unidades:', error)
  }
})

const getPersentage = computed(() => {
  if(!oportunidadePipeline) return 0
  return (Number(oportunidadePipeline.value.oportunidades_ganhas) / Number(oportunidadePipeline.value.total_oportunidades) * 100).toFixed(0)
})
</script>
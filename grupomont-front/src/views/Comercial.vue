<template>
  <v-container fluid>

    <v-row class="py-3">
        <v-col cols="12" md="4">
            <!-- <ConversaoChart :data="formattedFunil" :categories="formattedLabelsFunil"/> -->
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

    <!-- <v-row class="py-3">
        <v-col cols="12">
            <Pipeline :data="funilConsolidado"/>
        </v-col>
    </v-row> -->
    <!-- <div class="mb-6">
      <h1 class="text-h4">
        Comercial
      </h1>

      <p class="text-body-2 text-medium-emphasis">
        Acompanhamento do desempenho comercial
      </p>
    </div>

    <v-row>
      <v-col class="py-2" cols="12" sm="6" md="3">
        <KpiCard
          title="Receita"
          :value="49500"
          :target="50000"
          type="currency"
        />
      </v-col>

      <v-col class="py-2" cols="12" sm="6" md="3">
        <KpiCard
          title="Oportunidades"
          :value="totalOportunidade.value || 0"
          :target="totalOportunidade.target || 0"
        />
      </v-col>

      <v-col class="py-2" cols="12" sm="6" md="3">
        <KpiCard
          title="Contratações"
          :value="3"
          :target="4"
        />
      </v-col>

      <v-col class="py-2" cols="12" sm="6" md="3">
        <KpiCard
          title="Taxa de Conversão"
          :value="38"
          :target="50"
        />
      </v-col>
    </v-row>

    <v-row class="py-2">
      <v-col cols="12">
        <Pipeline />
      </v-col>
    </v-row>

    <v-row class="py-2">
      <v-col cols="12" lg="6">
        <ReceitaChart />
      </v-col>

      <v-col cols="12" lg="6">
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
import { getTotalOportunidade } from '../services/oportunidadeService.ts'
import { getFunilConsolidado, getHistoricoFunilConsolidado } from '../services/funilService.ts'
import { computed, onMounted, ref } from 'vue'
import ConversaoChart from '@/components/dashboard/conversaoChart.vue'
import HistoricoTable from '@/components/dashboard/HistoricoTable.vue'
import TotalCard from '@/components/comercial/TotalCard.vue'
import { getPipelineOportunidade } from '@/services/overviewService.ts'
import OportunidadeCard from '@/components/dashboard/oportunidadeCard.vue'
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

const formattedLabelsFunil = computed(() => {
    return funilConsolidado.value.map((value: any) => value.etapa);
})

const formattedFunil = computed(() => {
    return funilConsolidado.value.map((value: any) => value.percentual);
})

const etapasProjeto = [

  {
    nome: 'Prospecção',
    quantidade: 6,
    valor: 180000
  },

  {
    nome: 'Proposta',
    quantidade: 4,
    valor: 250000
  },

  {
    nome: 'Contrato',
    quantidade: 2,
    valor: 120000
  },

  {
    nome: 'Implantação',
    quantidade: 3,
    valor: 210000
  }

]

</script>
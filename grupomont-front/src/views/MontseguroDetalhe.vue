<template>
  <v-container fluid>
    <!-- Header -->
    <div class="dashboard-header d-flex flex-column flex-sm-row justify-space-between align-start ga-4 mb-6">
      <div>
        <h1 class="text-h4">
          Montseguro
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Visão detalhada da unidade de negócio
        </p>
      </div>
      <DateRangeSelector
        :start-date="dateRange.start_date"
        :end-date="dateRange.end_date"
        @change="loadMontseguro"
      />
    </div>  
    <v-row class="py-4">
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Clientes Ativos" :value="totalClientes?.clientes_ativos" />
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Vidas Ativas" :value="totalClientes?.vidas_ativas" />
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Valor Mensal da Carteira" :value="valorMensalCarteira?.valor_mensal_carteira" format="currency" />
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Receita" :value="totalReceita?.receita_realizada" format="currency"/>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12" md="3">
          <StatusList :items="funil" :active="7" :unidade_id="1"/>
      </v-col>

      <v-col cols="12" md="9">
          <ClienteList :data="clientes"/>
      </v-col>

       <v-col cols="12" md="9">
          <ContratacaoChart :categories="getData('mes')" :data="getData('contratacoes')"/>
       </v-col>

       <v-col cols="12" md="3">
          <OperadoraCard :data="getOperadoraValues"/>
      </v-col>
    </v-row>
  </v-container>
</template>


<script setup lang="ts">
import BasicCard from '@/components/common/BasicCard.vue'
import { computed, onMounted, ref } from 'vue'
import { getClientes, getTotalClientes } from '@/services/clienteService.ts'
import { getTotalReceitaByUnidade, getValorMensalCarteria } from '@/services/receitaService.ts'
import ClienteList from '@/components/montseguro/ClienteList.vue'
import { getFunilByUnidade } from '@/services/funilService.ts'
import ContratacaoChart from '@/components/montseguro/ContratacaoChart.vue'
import { getContratacaoByOperadora, getContratacaoByperiodo, getContratacaoByPlano } from '@/services/contratacaoService.ts'
import OperadoraCard from '@/components/montseguro/OperadoraCard.vue'
import StatusList from '@/components/common/StatusList.vue'
import DateRangeSelector, { type DateRange } from '@/components/common/DateRangeSelector.vue'


const totalClientes = ref<any>({})
const totalReceita = ref<any>({})
const valorMensalCarteira = ref<any>({})
const clientes = ref<any>([])
const funil = ref<any>([])
const periodosContratacao = ref<any>([])
const contratacaoByPlano = ref<any>([])
const contratacaoByOperadora = ref<any>([])
const dateRange = ref<DateRange>({
  start_date: '2026-01-01',
  end_date: '2026-12-31',
})

const loadMontseguro = async (range = dateRange.value) => {
  dateRange.value = range
  try {
    totalClientes.value = await getTotalClientes({ ...range, status: 'Ativa' })
    totalReceita.value = await getTotalReceitaByUnidade({ ...range, unidade_negocio_id: 1 })
    valorMensalCarteira.value = await getValorMensalCarteria({ ...range, unidade_negocio_id: 1 })
    clientes.value = await getClientes({ ...range, unidade_negocio_id: 1, etapa_id: 7 })
    funil.value = await getFunilByUnidade({ ...range, unidade_negocio_id: 1, status: ['Aberta', 'Ganha'] })
    periodosContratacao.value = await getContratacaoByperiodo({ ...range, interval: 3 })
    contratacaoByPlano.value = await getContratacaoByPlano(range)
    contratacaoByOperadora.value = await getContratacaoByOperadora(range)
  } catch (error) {
    console.error('Erro ao buscar dados do cliente:', error)
  }
}

onMounted(() => loadMontseguro())


const getData = computed(() => {
  return (attr: string) => periodosContratacao.value.map((v: any) => v[attr])
})

const getOperadoraValues = computed(() => {
  return { operadoras: contratacaoByOperadora, planos: contratacaoByPlano}
})

</script>

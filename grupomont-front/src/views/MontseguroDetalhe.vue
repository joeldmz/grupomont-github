<template>
  <v-container fluid>
    <!-- Header -->
    <div class="d-flex align-center mb-6">
      <div>
        <h1 class="text-h4">
          Montseguro
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Visão detalhada da unidade de negócio
        </p>
      </div>
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
      <v-col cols="12">
          <Jornada :data="funil"/>
      </v-col>

      <v-col cols="12" md="9">
          <ClienteList :data="clientes"/>
      </v-col>
      
      <v-col cols="12" md="3">
          <OperadoraCard :data="getOperadoraValues"/>
      </v-col>

      <v-col cols="12" md="12">
          <ContratacaoChart :categories="getData('periodo')" :data="getData('contratacoes')"/>
      </v-col>
    </v-row>
  </v-container>
</template>


<script setup lang="ts">
import BasicCard from '@/components/common/BasicCard.vue'
import { computed, onMounted, ref } from 'vue'
import { getClientes, getTotalClientes } from '@/services/clienteService.ts'
import { getTotalReceitaByUnidade, getValorMensalCarteria } from '@/services/receitaService.ts'
import Jornada from '@/components/montseguro/Jornada.vue'
import ClienteList from '@/components/montseguro/ClienteList.vue'
import { getFunilByUnidade } from '@/services/funilService.ts'
import ContratacaoChart from '@/components/montseguro/ContratacaoChart.vue'
import { getContratacaoByOperadora, getContratacaoByperiodo, getContratacaoByPlano } from '@/services/contratacaoService.ts'
import OperadoraCard from '@/components/montseguro/OperadoraCard.vue'


const totalClientes = ref<any>({})
const totalReceita = ref<any>({})
const valorMensalCarteira = ref<any>({})
const clientes = ref<any>([])
const funil = ref<any>([])
const periodosContratacao = ref<any>([])
const contratacaoByPlano = ref<any>([])
const contratacaoByOperadora = ref<any>([])


onMounted(async () => {
  try {
    totalClientes.value = await getTotalClientes( { status: 'Ativa' } )
    totalReceita.value = await getTotalReceitaByUnidade({ unidade_negocio_id: 1 })
    valorMensalCarteira.value = await getValorMensalCarteria({ unidade_negocio_id: 1 })
    clientes.value = await getClientes({ unidade_negocio_id: 1 })
    funil.value = await getFunilByUnidade({ unidade_negocio_id: 1 })
    periodosContratacao.value = await getContratacaoByperiodo({ interval: 3 }) // so para monseguro
    contratacaoByPlano.value = await getContratacaoByPlano()
    contratacaoByOperadora.value = await getContratacaoByOperadora()
  } catch (error) {
    console.error('Erro ao buscar dados do cliente:', error)
  }
})


const getData = computed(() => {
  return (attr: string) => periodosContratacao.value.map((v: any) => v[attr])
})

const getOperadoraValues = computed(() => {
  return { operadoras: contratacaoByOperadora, planos: contratacaoByPlano}
})

</script>

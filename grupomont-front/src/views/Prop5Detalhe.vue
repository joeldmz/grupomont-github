<template>
  <v-container fluid>
    <!-- Header -->
    <div class="d-flex align-center mb-6">
      <div>
        <h1 class="text-h4">
          Prop5
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
        <BasicCard title="Clientes" :value="mainData.quantidade_clientes" />
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Volume Financeiro" :value="mainData.pipeline_patrimonial" format="currency"/>
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Volume Transacionado" :value="mainData.volume_transacionado" format="currency"/>
      </v-col>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Receita" :value="mainData.receita_realizada" format="currency"/>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12" md="4">
          <JornadaCosultiva title="Pipeline" :data="funil"/>
      </v-col>
      <v-col cols="12" md="8">
          <OperacaoList :data="operacoes"/>
      </v-col>
    </v-row>
 </v-container>
</template>


<script setup lang="ts">
import BasicCard from '@/components/common/BasicCard.vue';
import JornadaCosultiva from '@/components/prop5/JornadaCosultiva.vue';
import OperacaoList from '@/components/prop5/OperacaoList.vue';
import { getFunilByUnidade } from '@/services/funilService';
import { getMainData, getOperacoes } from '@/services/operacaoService';
import { onMounted, ref } from 'vue';

const mainData = ref<any>({})
const funil = ref<any>([])
const operacoes = ref<any>([])
const operacoesByCliente = ref<any>([])

onMounted(async() => {
  try {
    mainData.value = await getMainData()
    funil.value = await getFunilByUnidade({ unidade_negocio_id: 2 })
    operacoes.value = await getOperacoes()
  } catch (error) {
    console.error('Erro ao buscar dados do cliente:', error)
  }
})

function voltar() {

  window.history.back()

}

</script>

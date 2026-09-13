<template>
  <v-container fluid>
    <!-- Header -->
    <div class="d-flex align-center pb-6">
      <div>
        <h1 class="text-h4">
          TechBrabo
        </h1>
        <p class="text-body-2 text-medium-emphasis">
          Visão detalhada da unidade de negócio
        </p>
      </div>
    </div>
    <v-row>
      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Clientes" :value="mainKpis.quantidade_clientes"/>
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Projetos" :value="mainKpis.quantidade_projetos"/>
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Receita Pontual" :value="mainKpis.receita_pontual" format="currency"/>
      </v-col>

      <v-col
        cols="12"
        sm="6"
        md="3"
      >
        <BasicCard title="Receita Recorrente" :value="mainKpis.receita_recorrente" format="currency"/>
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
import { getFunilByUnidade } from '@/services/funilService'
import { getMainKpis, getProjetos } from '@/services/projetoService'
import { onMounted, ref } from 'vue';

const mainKpis = ref<any>({})
const funil = ref<any>([])
const projetos = ref<any>([])


onMounted(async() => {
  try {
      mainKpis.value = await getMainKpis()
      funil.value = await getFunilByUnidade({ unidade_negocio_id: 3 })
      projetos.value = await getProjetos()
  } catch (error) {
    
  }
})

</script>

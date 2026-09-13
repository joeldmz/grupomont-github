<template>
  <v-card>
    <v-card-title>
            Jornada
    </v-card-title>

    <v-divider></v-divider>

    <!-- <div class="d-flex justify-space-around py-6 px-3">
        <div class="text-center">
            <div style="margin-left: -10px;"> <v-icon color="green">mdi-circle-medium</v-icon> Cotacao</div>
            <div style="font-weight: bold;">{{ getTotal((['1', '2', '3'])) }} clientes</div>
            <v-chip color="orange" class="py-2" size="x-small">Atencao</v-chip>
        </div>
        <div class="d-flex">
            <v-icon color="grey" class="pt-4">mdi-arrow-right-bold-circle-outline</v-icon>
        </div>

        <div class="text-center">
            <div style="margin-left: -10px;"> <v-icon color="green">mdi-circle-medium</v-icon> Proposta</div>
            <div style="font-weight: bold;">{{ getTotal((['4'])) }} clientes</div>
            <v-chip color="orange" class="py-2" size="x-small">Atencao</v-chip>
        </div>
        <div class="d-flex">
            <v-icon color="grey" class="pt-4">mdi-arrow-right-bold-circle-outline</v-icon>
        </div>
        <div class="text-center">
            <div style="margin-left: -10px;"> <v-icon color="green">mdi-circle-medium</v-icon> Contratacao</div>
            <div style="font-weight: bold;">{{ getTotal((['5'])) }}  clientes</div>
            <v-chip color="orange" class="py-2" size="x-small">Atencao</v-chip>
        </div>
        <div class="d-flex">
            <v-icon color="grey" class="pt-4">mdi-arrow-right-bold-circle-outline</v-icon>
        </div>
         <div class="text-center">
            <div style="margin-left: -10px;"> <v-icon color="green">mdi-circle-medium</v-icon> Implantacao</div>
            <div style="font-weight: bold;">{{ getTotal((['6'])) }}  clientes</div>
            <v-chip color="orange" class="py-2" size="x-small">Atencao</v-chip>
        </div>
    </div> -->

    <!-- <v-timeline 
    align="center" 
    density="compact"
    class="pa-6" 
    truncate-line="both"
    direction="vertical">
        <v-timeline-item
          v-for="(item, index) in data"
          :key="index"
          dot-color="green"
          size="8"
          fill-dot
        >
          <div style="margin-top: 10px;">
            <div class="font-weight-bold">
              <strong>{{ item.etapa }}</strong>
            </div>

            <div class="text-body-2 text-medium-emphasis">
              Clientes: {{ item.quantidade_clientes }}
            </div>
          </div>
        </v-timeline-item>
      </v-timeline> -->
  </v-card>
</template>

<script setup lang="ts">
import { computed } from 'vue';


interface Props {
  title?: string,
  data?: any[],
}

const props = defineProps<Props>()

const getTotal = computed(() => {
    return (ids: string[]) => {
        return props.data?.filter((value) => ids.includes(value.etapa_id))
               .reduce((total, value) => total + Number(value.quantidade_clientes), 0)
    }
})

const items = [
  { label: 'Cotização' },
  { label: 'Proposta' },
  { label: 'Contratação' },
  { label: 'Implementação' },
  { label: 'Clientes ativos' }
]

 const messages = [
    {
      id:1,
      from: 'Cotização',
      message: `Cotização enviada para o cliente.`,
      time: '10:42am',
      color: 'green',
    },
    {
      from: 'Proposta',
      message: 'Proposta enviada para o cliente.',
      time: '10:37am',
      color: 'green',
    },
    {
      id: 3,
      from: 'Contratação',
      message: 'Contratação realizada com sucesso.',
      time: '10:30am    ',
      color: 'green',
    },
    {
      id: 2,
      from: 'Implementação',
      message: 'Implementação iniciada.',
      time: '9:47am',
      color: 'green',
    },
    {
      id: 1,
      from: 'Ativo',
      message: 'Cliente adicionado aos ativos.',
      color: 'green',
    }
  ]

</script>

<style scoped>

</style>
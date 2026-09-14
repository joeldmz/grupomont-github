<template>
    <v-card style="height: 100%;">
        <v-card-item class="pb-0">
            <v-card-title class="font-weight-bold">
                Status das Oportunidades
            </v-card-title>

            <v-card-subtitle>
                Distribuição das oportunidades por status
            </v-card-subtitle>
        </v-card-item>
        <v-divider></v-divider>
        <v-expansion-panels variant="accordion" elevation="0" v-model="expanded">

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <div>
                          <v-icon
                              color="primary"
                              icon="mdi-progress-clock"
                              class="pr-2"
                              size="22"
                          />
                          <span>Abertas <span style="font-weight: 800;">({{ getTotal('oportunidades_abertas') }})</span></span>
                      </div>
                      <span class="font-weight-bold" style="font-weight: bold;">R$ {{ getTotal('valor_potencial').toFixed(2)}}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                    <div v-for="value in items" class="d-flex justify-space-between">
                     <div class="pa-1">{{ value.unidade_negocio }} ({{ value.oportunidades_abertas }}) </div>
                     <div>R$ {{ value.valor_potencial }}</div>
                   </div>
                </v-expansion-panel-text>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                      <div>
                          <v-icon
                              color="green"
                              icon="mdi-check-circle-outline"
                              class="pr-2"
                              size="22"
                          />
                          <span>Ganhas <span style="font-weight: 800;">({{ getTotal('oportunidades_ganhas') }})</span></span>
                      </div>
                      <span class="font-weight-bold" style="font-weight: bold;">R$ {{ getTotal('valor_realizado').toFixed(2) }}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                   <div v-for="value in items" class="d-flex justify-space-between">
                     <div class="pa-1">{{ value.unidade_negocio }} ({{ value.oportunidades_ganhas }}) </div>
                     <div>R$ {{ value.valor_realizado }}</div>
                   </div>
                </v-expansion-panel-text>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <div>
                          <v-icon
                              color="red"
                              icon="mdi-close-circle-outline"
                              class="pr-2"
                              size="22"
                          />
                          <span>Perdas <span style="font-weight: 800;">({{ getTotal('oportunidades_perdidas') }})</span></span>
                      </div>
                      <span class="text-red" style="font-weight: bold;">-R$ {{ getTotal('valor_perdido').toFixed(2) }}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                    <div v-for="value in items" class="d-flex justify-space-between">
                     <div class="pa-1">{{ value.unidade_negocio }} ({{ value.oportunidades_perdidas }})</div>
                     <div class="text-red">-R$ {{ value.valor_perdido }}</div>
                   </div>
                </v-expansion-panel-text>
            </v-expansion-panel>
        </v-expansion-panels>
    </v-card>
</template>

<script setup lang="ts">
import { computed, ref, watch } from 'vue';

const expanded = ref([0])

interface Props {
  title?: string,
  items?: any[],
}


const props = withDefaults(defineProps<Props>(), {
  items: () => []
})

const getTotal = (attr: string) => {
  if(!props.items.length) return 0
  return Number(props.items.reduce((total: number, item: any) => total + Number(item[attr]), 0))
}

const getColor = (value: number) => {
  if (value >= 100) {
    return 'green'
  } else if (value >= 70) {
    return 'orange'
  } else {
    return 'red'
  }
}
 
</script>
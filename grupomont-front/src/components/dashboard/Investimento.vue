<template>
    <v-card title="Investimento em marketing" style="height: 100%;">
        <v-divider></v-divider>
        <v-expansion-panels variant="accordion" elevation="0">
            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <span>Investimento</span>
                        <span class="font-weight-bold" style="font-weight: bold;">R$ {{ getTotal('investimento').toFixed(2) }}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                   <div v-for="value in items" class="d-flex justify-space-between">
                     <div class="pa-1">{{ value.unidade_negocio }}</div>
                     <div>R$ {{ Number(value.investimento ).toFixed(2)}}</div>
                   </div>
                </v-expansion-panel-text>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <span>Leads</span>
                        <span class="font-weight-bold">{{ getTotal('leads') }}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                    <div v-for="value in items" class="d-flex justify-space-between">
                     <div class="pa-1">{{ value.unidade_negocio }}</div>
                     <div>{{ value.leads }}</div>
                   </div>
                </v-expansion-panel-text>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <span>Oportunidades</span>
                        <span class="font-weight-bold">{{ getTotal('oportunidades') }}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                    <div v-for="value in items" class="d-flex justify-space-between">
                     <div class="pa-1">{{ value.unidade_negocio }}</div>
                     <div>{{ value.oportunidades }}</div>
                   </div>
                </v-expansion-panel-text>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <span>Conversão</span>
                        <span style="font-weight: 900;" :class="`text-${getColor(getConversao(getTotal('leads'), getTotal('oportunidades')))}`">{{ getConversao(getTotal('leads'), getTotal('oportunidades')).toFixed(0) }}%</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                    <div v-for="value in items" class="d-flex justify-space-between">
                        <div class="pa-1">{{ value.unidade_negocio }}</div>
                        <div>{{ getConversao(value.leads, value.oportunidades).toFixed(0) }}%</div>
                    </div>
                </v-expansion-panel-text>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <span>Receita</span>
                        <span class="font-weight-bold" style="font-weight: bold;">R$ {{ getTotal('receita_realizada').toFixed(2) }}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                     <div v-for="value in items" class="d-flex justify-space-between">
                        <div class="pa-1">{{ value.unidade_negocio }}</div>
                        <div>R$ {{ value.receita_realizada }}</div>
                     </div>
                </v-expansion-panel-text>
            </v-expansion-panel>

            <v-expansion-panel>
                <v-expansion-panel-title>
                    <div class="d-flex justify-space-between align-center w-100 me-4">
                        <span>ROI</span>
                        <span class="font-weight-bold">{{ getRoi(getTotal('receita_realizada'), getTotal('investimento')).toFixed(2) }}</span>
                    </div>
                </v-expansion-panel-title>
                <v-expansion-panel-text>
                    <div v-for="value in items" class="d-flex justify-space-between">
                        <div class="pa-1">{{ value.unidade_negocio }}</div>
                        <div>{{ getRoi(value.receita_realizada, value.investimento).toFixed(1) }}</div>
                     </div>
                </v-expansion-panel-text>
            </v-expansion-panel>
        </v-expansion-panels>
    </v-card>
</template>

<script setup lang="ts">
import { computed } from 'vue';


interface Props {
  title?: string,
  items?: any[],
}

const props = withDefaults(defineProps<Props>(), {
  items: () => []
})

const getTotal = (attr: string) => {
  if(!props.items) return 0
  return Number(props.items.reduce((total: number, item: any) => total + Number(item[attr]), 0))
}

const getConversao = (leads: number, oportunidades: number) => {
    if(!props.items) return 0
    return oportunidades / leads * 100
}

const getRoi = (receita: number, investimento: number) => {
    if(!props.items) return 0
    return receita / investimento
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
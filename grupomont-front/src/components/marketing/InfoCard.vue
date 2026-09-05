<template>
  <v-card elevation="0" class="pa-1" max-width="480px">
    <!-- Header -->
    <v-row align="center" class="mb-4 pb-4" style="border-bottom: 1px solid var(--v-border-light);">
      <v-col class="ps-3">
        <div class="text-h6" style="font-weight: bold;">{{ data[0]?.unidade_negocio }}</div>
        <div class="text-h6 font-weight-medium">{{ data[0]?.nome }}</div>
        <div class="text-caption text-medium-emphasis">Período: {{ formatDate(data[0]?.data_inicio) }} → {{ formatDate(data[0]?.data_fim)  }}</div>
      </v-col>
      <v-col cols="auto">
        <v-chip :color="data[0]?.status === 'Ativa' ? 'green' : 'grey'" size="small" variant="tonal" class="font-weight-medium">
          <v-icon start size="12">{{ data[0]?.status === 'Ativa' ? 'mdi-circle' : 'mdi-circle-outline' }}</v-icon>
          {{ data[0]?.status }}
        </v-chip>
      </v-col>
    </v-row>

    
    <kpi-card
      title="Leads"
      :value="data[0]?.leads"
      :target="data[0]?.meta_leads"
      :elevation="0"
      type="number"
    />

    <v-divider class="py-2"></v-divider>

    <kpi-card
      title="Oportunidades"
      :value="data[0]?.oportunidades"
      :target="data[0]?.meta_oportunidades"
      :elevation="0"
      type="number"
    />

    <v-divider class="py-2"></v-divider>

    <v-sheet variant="tonal" class="pa-4" rounded="lg">
      <div class="d-flex justify-space-between align-center mb-1">
        <span class="text-caption text-medium-emphasis font-weight-medium">Investimento</span>
        <span class="text-h6 font-weight-medium text-primary">R$ 8.000</span>
      </div>
      <div class="d-flex justify-space-between text-caption mb-1">
        <span>R$ 8.000 / R$ 15.000</span>
        <span class="font-weight-medium">53%</span>
      </div>
      <v-progress-linear model-value="53" color="primary" height="6" rounded />
    </v-sheet>

  </v-card>
</template>

<script setup lang="ts">
import { computed, watch } from 'vue'
import KpiCard from '../dashboard/KpiCard.vue';

interface Props {
  data?: any[]
}

const props = withDefaults(defineProps<Props>(), {
  data: () => []
})

watch(() => props.data, (value) => {
  console.log(value)
}, { immediate: true })

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('pt-BR')
}

</script>
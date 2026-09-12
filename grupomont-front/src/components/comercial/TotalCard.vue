<template>
  <v-card
    class="kpi-card pa-5"
    elevation="1"
  >
        <!-- Título -->
        <div class="text-center">
            <div class="text-subtitle-2 text-medium-emphasis">
            Total de oportunidades
        </div>

        <!-- Valor principal -->
        <div class="pt-2">
            <span class="kpi-value">
                {{ data.total_oportunidades }}
            </span>
        </div>
     </div>
    

    <v-card-text>
      <!-- Status -->
      <div class="py-3">
        <!-- Ganadas -->
        <div class="d-flex justify-space-between py-4">
          <div class="d-flex align-center">
              <v-icon
                class="px-6"
                color="green"
                icon="mdi-check-circle-outline"
                size="22"
              />

            <div>
              <div class="text-body-1 font-bold">
                Ganhas
              </div>

              <div class="text-caption text-medium-emphasis">
                {{ percentage(data.oportunidades_ganhas) }}% del total
              </div>
            </div>
          </div>

          <span class="text-h5 font-bold pt-3" style="font-weight: bold; font-size: 16px;">
            {{ data.oportunidades_ganhas }}
          </span>
        </div>

        <!-- Abiertas -->
        <div class="status-item d-flex justify-space-between py-4">
          <div class="d-flex align-center">
              <v-icon
                color="blue"
                icon="mdi-progress-clock"
                class="px-6"
                size="22"
              />
            <div>
              <div class="text-body-2 font-weight-bold">
                Abertas
              </div>

              <div class="text-caption text-medium-emphasis">
                {{ percentage(data.oportunidades_abertas) }}% del total
              </div>

              <!-- <v-chip
                    class="ma-2"
                    color="gray"
                    size="small"
                    label
                    >
                    <v-icon icon="mdi-label" start></v-icon>
                    {{ data.probabilidade_media_abertas }}% probabilidade geral de fechamento
              </v-chip> -->
            </div>
          </div>

          <span class="pt-4" style="font-weight: bold; font-size: 16px;">
            {{ data.oportunidades_abertas }}
          </span>
        </div>

        <!-- Perdidas -->
        <div class="status-item d-flex justify-space-between py-4">
          <div class="d-flex align-center">
              <v-icon
                color="red"
                class="px-6"
                icon="mdi-close-circle-outline"
                size="22"
              />

            <div>
              <div class="text-body-2 font-weight-medium">
                Perdas
              </div>

              <div class="text-caption text-medium-emphasis">
                {{ percentage(data.oportunidades_perdidas) }}% del total
              </div>
            </div>
          </div>

          <span class="pt-3" style="font-weight: bold; font-size: 16px;">
            {{ data.oportunidades_perdidas }}
          </span>
        </div>

      </div>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps({
  data: {
    type: Object,
    required: true
  }
})

const percentage = (value:any) => {
  if (!props.data.total_oportunidades) return 0

  return Math.round(
    (value / props.data.total_oportunidades) * 100
  )
}

const formatCurrency = (value: any) => {
  return new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value || 0)
}

</script>

<style scoped>
.kpi-card {
  height: 100%;
}

.kpi-value {
  font-size: 38px;
  font-weight: 600;
  line-height: 1.1;
}
</style>
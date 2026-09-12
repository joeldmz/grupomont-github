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

    <v-card-text>
      <!-- Status -->
      <div>
        <!-- Ganadas -->
        <div class="d-flex justify-space-between py-6">
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

          <div class="text-right">
            <span class="text-h5 font-bold" style="font-weight: bold; font-size: 16px;">
              {{ data.oportunidades_ganhas }}
            </span>
            <br>
            <span class="text-h5 font-bold" style="font-weight: bold; font-size: 16px;">
              R$ {{ data.valor_realizado}}
            </span>
          </div>
         
        </div>

        <v-divider></v-divider>

        <!-- Abiertas -->
        <div class="status-item d-flex justify-space-between py-6">
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
          <div class="text-right">
            <span style="font-weight: bolder; font-size: 16px;">
              {{ data.oportunidades_abertas }}
            </span>
            <br>
            <span style="font-weight: bold; font-size: 16px;">
              R$ {{ data.valor_potencial }}
            </span>
          </div>
        </div>

        <v-divider></v-divider>

        <!-- Perdidas -->
        <div class="status-item d-flex justify-space-between py-6">
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

          <div class="text-right text-error">
            <span style="font-weight: bold; font-size: 16px;">
            {{ data.oportunidades_perdidas }}
            </span>
            <br>
            <span style="font-weight: bold; font-size: 16px;">
              - R$ {{ data.valor_perdido }}
            </span>
          </div>
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
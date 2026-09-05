<template>
  <v-card
    class="opportunities-card"
  >
    <v-card-title>
      Pipeline de oportunidades
    </v-card-title>
    <!-- Header -->
    <!-- <v-card-item>
      <div class="d-flex justify-space-between align-start">
        <div>
          <div class="text-subtitle-2 font-weight-bold">
            Oportunidades - pipeline actual
          </div>
        </div>
      </div>
    </v-card-item> -->

    <v-card-text>
      <!-- Total -->
      <div class="mb-5">
        <div class="text-h1 font-weight-bold">
          {{ data.total_oportunidades }}
        </div>

        <div class="text-caption text-medium-emphasis">
          oportunidades totales
        </div>
      </div>

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

          <span class="text-h6 font-weight-bold">
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

              <v-chip
                    class="ma-2"
                    color="gray"
                    size="small"
                    label
                    >
                    <v-icon icon="mdi-label" start></v-icon>
                    {{ data.probabilidade_media_abertas }}% probabilidade geral de fechamento
              </v-chip>
            </div>
          </div>

          <span class="text-h6 font-weight-bold">
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

          <span class="text-h6 font-weight-bold">
            {{ data.oportunidades_perdidas }}
          </span>
        </div>

      </div>

      <!-- Pipeline ponderado -->
      <!-- <v-divider class="my-5" />

      <div class="d-flex justify-space-between align-center">
        <div>
          <div class="text-caption text-medium-emphasis">
            Pipeline ponderado
          </div>

          <div class="text-subtitle-1 font-weight-bold">
            R$ {{ formatCurrency(data.valor_ponderado_abertas) }}
          </div>
        </div>
      </div> -->
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
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
.opportunities-card {
  height: 100%;
}

/* .status-list {
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.status-item {
  display: flex;
  padding: 20px;
  justify-content: space-between;
  align-items: center;
} */
</style>
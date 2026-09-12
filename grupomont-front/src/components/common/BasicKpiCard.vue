<template>
  <v-card
    class="kpi-card pa-5 text-center"
    elevation="1"
  >
    <!-- Título -->
    <div class="text-subtitle-2 text-medium-emphasis">
      {{ title }}
    </div>

    <!-- Valor principal -->
    <div class="mt-4">
      <span class="kpi-value">
        {{ formattedValue }}
      </span>
    </div>

    <!-- Indicador -->
    <div
      v-if="quantity"
      class="py-1"
    >
        <v-chip size="small" color="blue">
          {{ quantity }} canpanhas ativas
        </v-chip>
    </div>

    <!-- Indicador -->
     <div v-if="!quantity">
        <div
            class="mt-1"
            :class="statusColor"
            >
            <v-icon
                size="20"
                class="mr-1"
            >
                {{ statusIcon }}
            </v-icon>

            <span class="text-body-2 font-weight-medium">
                {{ percentage }}%
            </span>
            </div>

            <!-- Información adicional -->
            <div class="text-caption text-medium-emphasis mt-4">
            {{ gapText }}
            </div>

            <!-- <div class="text-caption text-medium-emphasis mt-1">
            {{ periodText }}
            </div> -->
     </div>
  </v-card>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  title: string
  value: number
  target: number
  quantity?: number,
  periodText?: string
  format?: 'number' | 'currency' | 'percentage'
}

const props = withDefaults(defineProps<Props>(), {
  periodText: 'vs meta do período',
  format: 'number'
})

// porcentual atingimento
const percentage = computed(() => {
  if (props.target === null || props.target === 0) return 0

  return Math.round((props.value / props.target) * 100)
})

// GAP
const gap = computed(() => {
  if (props.target === null || props.target === 0) return 0
  return Math.max(props.target - props.value, 0);
})

const formattedValue = computed(() => {
  if (props.format === 'currency') {
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL',
      maximumFractionDigits: 0
    }).format(props.value)
  }

  return new Intl.NumberFormat('pt-BR').format(props.value)
})

const statusIcon = computed(() => {
  return percentage.value >= 100
    ? 'mdi-arrow-up'
    : 'mdi-arrow-down'
})

const statusColor = computed(() => {
  return percentage.value >= 100
    ? 'text-success'
    : 'text-error'
})

const gapText = computed(() => {
  if (gap.value <= 0) {
    return 'Meta atingida'
  }

  if (gap.value > 0) {
    return `+${gap.value} para atingir meta`
  }

  return `${props.value} abaixo da meta`
})
</script>

<style scoped>
.kpi-card {
  min-height: 190px;
  background: #ffffff;
}

.kpi-value {
  font-size: 38px;
  font-weight: 600;
  line-height: 1.1;
}
</style>
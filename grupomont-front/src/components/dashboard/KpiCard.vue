<template>
  <v-card :elevation="elevation" class="mt-3" style="height: 100%;">
    <v-card-text>
      <div class="d-flex justify-space-between">
        {{ title }}
      </div>

      <div class="text-h5 pb-3" style="font-size: 16px; font-weight: bold;">
        {{ formattedValue }}
      </div>

      <div class="d-flex justify-space-between mb-2">
        <span class="text-caption">
          Meta: {{ formattedTarget }}
        </span>

        <span class="text-caption font-weight-bold">
          {{ percentage }}%
        </span>
      </div>

      <v-progress-linear
        :model-value="percentage"
        rounded
        height="8"
        :color="percentage >= 100 ? 'green' : percentage >= 70 ? 'orange' : 'red'"
      />

      <div class="d-flex justify-space-between mt-3">
        <span class="text-caption text-medium-emphasis">
          {{ gapText }}
        </span>

        <!-- <span class="text-caption font-weight-bold">
          {{ formattedGap }}
        </span> -->
      </div>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
import { target } from 'apexcharts/unit-shapes'
import { computed } from 'vue'

interface Props {
  title: string
  value: number
  date?: string,
  target: number | null
  type?: 'currency' | 'number'
  elevation?: number 
}

const props = withDefaults(defineProps<Props>(), {
  type: 'number',
  elevation: 1
})

// porcentual atingimento
const percentage = computed(() => {
  if (props.target === null || Number(props.target) === 0) return 0

  return Math.round((props.value / props.target) * 100)
})

// GAP
const gap = computed(() => {
  if (props.target === null || props.target === 0) return 0
  return Math.max(props.target - props.value, 0)
})

// valor formatado
const formattedValue = computed(() => {

  if (props.type === 'currency') {
    return props.value.toLocaleString('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    })
  }

  return props.value.toLocaleString('pt-BR')
})

// meta formatada
const formattedTarget = computed(() => {

  if (props.target === null || props.target === 0) return 0

  if (props.type === 'currency') {
    return props.target.toLocaleString('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    })
  }

  return props.target.toLocaleString('pt-BR')
})

// gap formatado
const formattedGap = computed(() => {
  if (props.type === 'currency') {
    return gap.value.toLocaleString('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    })
  }

  return gap.value.toLocaleString('pt-BR')
})

const isAboveTarget = computed(() => {
  return props.target !== null && props.value > props.target
})

const isTargetReached = computed(() => {
  return props.target !== null && props.value === props.target
})

const gapText = computed(() => {
  
  if(Number(props.target )=== 0) {
     return 'Meta nao definida'
  }

  if (gap.value <= 0) {
    return 'Meta atingida'
  }

  if (gap.value > 0) {
    return `+${gap.value} para atingir a meta`
  }

  return `${props.value} abaixo da meta`
})

/* const gapLabel = computed(() => {
  if (props.target === null) {
    return 'Meta não definida'
  }

  if (isAboveTarget.value) {
    return 'Acima da meta'
  }

  if (isTargetReached.value) {
    return 'Meta atingida'
  }

  return 'GAP'
}) */

</script>
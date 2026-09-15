<template>
  <div class="date-range-selector d-flex align-center ga-2">
    <v-text-field
      v-model="startDate"
      label="Desde"
      type="date"
      density="compact"
      variant="outlined"
      hide-details
    />
    <v-text-field
      v-model="endDate"
      label="Hasta"
      type="date"
      density="compact"
      variant="outlined"
      hide-details
    />
    <v-btn color="primary" @click="applyRange">
      Aplicar
    </v-btn>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import type { DateRange } from '@/types/api'

export type { DateRange }

const getDefaultStartDate = () => {
  return `${new Date().getFullYear()}-01-01`
}

const getDefaultEndDate = () => `${new Date().getFullYear()}-12-31`

const props = defineProps<{
  startDate?: string
  endDate?: string
}>()

const startDate = ref(props.startDate ?? getDefaultStartDate())
const endDate = ref(props.endDate ?? getDefaultEndDate())

const emit = defineEmits<{
  change: [range: DateRange]
}>()

const applyRange = () => {
  if (!startDate.value || !endDate.value || startDate.value > endDate.value) return

  emit('change', {
    start_date: startDate.value,
    end_date: endDate.value,
  })
}
</script>

<style scoped>
.date-range-selector {
  width: min(100%, 420px);
  flex-wrap: wrap;
}

.date-range-selector .v-text-field {
  min-width: 0;
  flex: 1 1 160px;
}

@media (max-width: 600px) {
  .date-range-selector {
    width: 100%;
  }

  .date-range-selector .v-text-field {
    flex: 1 1 100%;
  }

  .date-range-selector .v-btn {
    width: 100%;
  }
}
</style>

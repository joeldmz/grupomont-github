<template>
  <v-card>
    <v-card-item class="pb-0">
        <v-card-title class="font-weight-bold">
            Equipe
        </v-card-title>

        <v-card-subtitle>
            Performance de oportunidades
        </v-card-subtitle>
    </v-card-item>
    <v-divider></v-divider>
    <v-card-text>
      <apexchart
        type="bar"
        height="300"
        :options="chartOptions"
        :series="series"
      />
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
import { onMounted, ref, watch } from 'vue'

interface Props {
  title?: string,
  categories?: any[],
  data?: any[]
}

const key = ref(0)
const series = ref<any[]>([])
const chartOptions = ref<any>({})

const props = defineProps<Props>()

watch(() => props.data, () => {
  series.value = [
    {
      name: 'Oportunidades',
      data: props.data?.map(item => item.oportunidades) || [0, 0, 0, 0, 0, 0, 0],
    },
    {
      name: 'Ganhas',
      data: props.data?.map(item => item.oportunidades_ganhas) || [0, 0, 0, 0, 0, 0, 0],
    }
  ]

  chartOptions.value = {
    chart: {
      type: 'bar',
      toolbar: {
        show: true,
      },
    },
    plotOptions: {
      bar: {
        horizontal: true,
        barHeight: '90%',
        borderRadius: 4,
      },
    },
    dataLabels: {
      enabled: true,
    },
    xaxis: {
        categories: props.data?.map(item =>
            `${item.equipe} - conversao (${Number(item.conversao).toFixed(1)}%)`
        ) || [],
    }
  }
  key.value ++
})
</script>
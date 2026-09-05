<template>
  <v-card>
    <v-card-title>
      Leads/Oportunidades por canal
    </v-card-title>
    <v-divider></v-divider>
    <v-card-text>
      <apexchart
        type="bar"
        height="250"
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
      name: 'Leads',
      data: props.data?.map(item => item.leads) || [0, 0, 0, 0, 0, 0, 0],
    },
    {
      name: 'Oportunidades',
      data: props.data?.map(item => item.oportunidades) || [0, 0, 0, 0, 0, 0, 0],
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
        horizontal: false,
        barHeight: '10%',
        borderRadius: 6,
      },
    },
    dataLabels: {
      enabled: true,
    },
    xaxis: {
      categories: props.data?.map(item => item.canal) || [],
    },
  }
  key.value ++
})
</script>
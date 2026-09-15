<template>
  <v-card style="height: 100%;">
    <v-card-title>
      Contratação por período
    </v-card-title>

    <v-card-text>
      <apexchart
        v-if="data"
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

const props = defineProps<Props>()
const chartOptions = ref<any>({})

watch(() => props.data, (data: any) => {
    series.value = [
        {
            name: 'Percentual de conversão',
            data: data
        }
    ]

    chartOptions.value = {
        chart: {
        type: 'bar',
        height: 500,
        toolbar: {
          show: true,
        },
    },

    plotOptions: {
        bar: {
          horizontal: false,
          barHeight: '80%',
          barWidth: '50%',
          borderRadius: 6,
        },
    },

    dataLabels: {
        enabled: true,
        formatter: (val: any) => `${val ? val.toFixed(1) : 0}%`,
    },

    xaxis: {
        categories: props.categories,
        max: 100,
    },
    }
    key.value ++
})

const series = ref([
  {
    name: 'Percentual de conversão',
    data: props.data
  }
])
</script>
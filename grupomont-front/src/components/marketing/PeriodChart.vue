<template>
  <v-card :elevation="0">
    <v-card-text>
      <apexchart
        type="bar"
        height="400"
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

watch(() => props.data, (data: any) => {
    key.value ++
})

const series = ref([
  {
    name: 'Percentaje Conversao',
    data: [1, 5]
  }
])

const chartOptions = ref({
  chart: {
    type: 'bar',
    toolbar: {
      show: false,
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
    formatter: (val: any) => `${val ? val.toFixed(1) : 0}%`,
  },

  xaxis: {
    categories: ['01/08 - 30-08' , '01/09 - 31/09'],
    max: 100,
  },
});
</script>
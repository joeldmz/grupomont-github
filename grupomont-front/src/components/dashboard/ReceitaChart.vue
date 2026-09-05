<template>
  <v-card>
    <v-card-title>
      Receita x Meta
    </v-card-title>

    <v-card-text>
      <apexchart
        type="line"
        height="350"
        :options="chartOptions"
        :series="series"
      />
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const series = ref([
  {
    name: 'Receita',
    data: [12000, 18000, 22000, 28000, 35000, 49500]
  },
  {
    name: 'Meta',
    data: [15000, 20000, 25000, 30000, 40000, 50000]
  }
])

const chartOptions = ref({
  chart: {
    toolbar: {
      show: false
    }
  },

  xaxis: {
    categories: [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun'
    ]
  },

  yaxis: {
    labels: {
      formatter: (value: number) => {
        return `R$ ${value.toLocaleString('pt-BR')}`
      }
    }
  },

  tooltip: {
    y: {
      formatter: (value: number) => {
        return `R$ ${value.toLocaleString('pt-BR')}`
      }
    }
  }
})
</script>
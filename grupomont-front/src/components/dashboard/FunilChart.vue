<template>
  <v-card>
    <v-card-title>
      Funil Comercial
    </v-card-title>

    <v-card-text>
      <apexchart
        type="bar"
        height="450"
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
    name: 'Oportunidades',
    data: [
      12,
      8,
      6,
      4,
      3,
      2,
      2,
      1,
      1
    ]
  }
])

const chartOptions = ref({
  chart: {
    toolbar: {
      show: false
    }
  },

  plotOptions: {
    bar: {
      horizontal: true,
      distributed: true,
      barHeight: '50%'
    }
  },

  xaxis: {
    categories: [
      'Atendimento',
      'Qualificação',
      'Cotação',
      'Apresentação',
      'Proposta',
      'Negociação',
      'Contratação',
      'Implantação',
      'Cliente Ativo'
    ]
  },

  dataLabels: {
    enabled: true
  },

  legend: {
    show: false
  }
})
</script>
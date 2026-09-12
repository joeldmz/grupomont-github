<template>
  <v-card style="height: 100%;">
    <v-card-title>
      {{ title }}
    </v-card-title>
    <v-divider></v-divider>
    <v-card-text>
      <apexchart
        type="bar"
        height="350"
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
  horizontal?: boolean,
  data?: any[]
}

const key = ref(0)

const props = defineProps<Props>()
const chartOptions = ref<any>({})
const series = ref([
  {
    name: 'Percentaje Conversao',
    data: props.data
  }
])

watch(() => props.data, (data: any) => {
  series.value = [
      {
          name: 'Clientes',
          data: data.map((v: any) => Number(v.quantidade_clientes))
      }
  ]

  chartOptions.value = {
        chart: {
          type: 'bar',
          height: 300,
          events: {
            dataPointMouseEnter: function () {
              console.log('HOVER')
            }
          }
        },
        plotOptions: {
          bar: {
            borderRadius: 4,
            borderRadiusApplication: 'end',
            horizontal: props.horizontal
          },
        },
        dataLabels: {
          enabled: false,
        },
        xaxis: {
          categories: data.map((v: any) => v.etapa),
          labels: {
            formatter: function (val: string) {
              return Math.round(Number(val)).toString()
            },
          },
        },
        tooltip: {
          y: {
            formatter: (value: number, { dataPointIndex }: any) => {
              const item = data[dataPointIndex]

              return `
                ${value} oportunidade(s)<br>
                Pipeline: R$ ${Number(item.valor_pipeline).toLocaleString('pt-BR', {
                  minimumFractionDigits: 2
                })}<br>
                Ponderado: R$ ${Number(item.valor_ponderado).toLocaleString('pt-BR', {
                  minimumFractionDigits: 2
                })}
              `
            }
          }
        },
      }
      key.value ++
})

</script>
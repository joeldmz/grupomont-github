<template>
  <v-card style="height: 100%;">
    <v-card-title>
      {{ title }}
    </v-card-title>
    <v-divider></v-divider>
    <v-card-text>
      <apexchart
        :key="key"
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
  attr?: string,
  data?: any[]
}

const key = ref(0)

const props = defineProps<Props>()
const chartOptions = ref<any>({})
const series = ref([
  {
    name: 'Percentual de conversão',
    data: props.data
  }
])

watch(() => props.data, (data: any) => {
  data.reverse()
  series.value = [
      {
          name: 'Montseguro',
          data: data.map((v: any) => Number(v.montseguro)) || [0, 0, 0, 0, 0, 0, 0]
      },
      {
        name: 'Prop5',
        data: props.data?.map(v => Number(v.prop5)) || [0, 0, 0, 0, 0, 0, 0],
      },
      {
        name: 'Techbrabo',
        data: props.data?.map(v => Number(v.techbrabo)) || [0, 0, 0, 0, 0, 0, 0],
      }
  ]

  chartOptions.value = {
        chart: {
          type: 'bar',
          height: 350,
          events: {
            dataPointMouseEnter: function () {
              console.log('HOVER')
            }
          }
        },
        colors: ['#1976D2', '#43A047', '#C8E3AF'],
        plotOptions: {
          bar: {
            borderRadius: 4,
            borderRadiusApplication: 'end',
            horizontal: props.horizontal,
            columnWidth: '30%'
          },
        },
        dataLabels: {
          enabled: false,
        },
        xaxis: {
          categories: data.map((v: any) => v.periodo)
        }
      }
      key.value ++
})

</script>
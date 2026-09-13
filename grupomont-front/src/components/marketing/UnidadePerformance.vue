<template>
    <v-card style="height: 100%;">
          <v-card-title>
            Performance por unidade de negocio 
          </v-card-title>
          <v-divider></v-divider>

          <v-card-text>
            <v-table>
              <thead>
                <tr>
                  <th class="text-left" style="width: 250px;">Unidade de negocio</th>
                  <th style="width: 250px;">Leads/meta</th>
                  <th style="width: 250px;">Oportunidades/meta</th>
                  <th>Conversao</th>
                  <th></th>
                </tr>
              </thead>

              <tbody>
                <tr v-for="value in data" :key="value.id">
                  <td>{{ value.unidade_negocio }}</td>
                  <td>
                    {{ value.leads }}/{{ getTotal(Number(value.unidade_negocio_id), metaLeads, 'valor_meta') }}
                    <v-progress-linear 
                    rounded="2"
                    :color="getColor(value, getTotal(Number(value.unidade_negocio_id), metaLeads, 'valor_meta'))"
                    height="5"
                    :model-value="getPercentage(value.leads, getTotal(Number(value.unidade_negocio_id), metaLeads, 'valor_meta'))">
                    </v-progress-linear>
                  </td>

                  <td>
                    {{ value.oportunidades }}/{{getTotal(Number(value.unidade_negocio_id), metaOportunidades, 'valor_meta') }}
                    <v-progress-linear 
                    :color="getColor(value.oportunidades, getTotal(Number(value.unidade_negocio_id), metaOportunidades, 'valor_meta') )"
                    :model-value="getPercentage(value.oportunidades, getTotal(Number(value.unidade_negocio_id), metaOportunidades, 'valor_meta') )">
                    </v-progress-linear>
                  </td>
                  <td>
                    {{ 
                      getPercentage(value.oportunidades, value.leads).toFixed(0) 
                    }}%</td>
                </tr>
              </tbody>
            </v-table>
          </v-card-text>
        </v-card>
</template>

<script setup lang="ts">

interface Props {
  data?: any[],
  metaLeads?: any[],
  metaOportunidades?: any[]
}

const props = withDefaults(defineProps<Props>(), {
  data: () => [],
  metaLeads: () => [],
  metaOportunidades: () => []
})

const getPercentage = (value: number, target: number) => {
  if (target === 0) return 0
  return (value / target) * 100
}

const getColor = (value: number, target: number) => {
  const percentage = (value / target) * 100
  if (percentage >= 100) {
    return 'green'
  } else if (percentage >= 70) {
    return 'orange'
  } else {
    return 'red'
  }
}

const getTotal = (id: number, array: any[], attr: string) => {
  if(!array) return 0
  console.log(array.filter(v => Number(v.unidade_negocio_id) === id))
  return array.filter(v => Number(v.unidade_negocio_id) === id).reduce((total: number, item: any) => total + Number(item[attr]), 0)
}


</script>
<template>
    <v-card style="height: 100%;">
          <v-card-title>
            Performance por unidade de negócio 
          </v-card-title>
          <v-divider></v-divider>

          <v-card-text>
            <v-table>
              <thead>
                <tr>
                  <th class="text-left" style="width: 250px;">Unidade de negócio</th>
                  <th style="width: 250px;">Leads/meta</th>
                  <th style="width: 250px;">Oportunidades/meta</th>
                  <th>Conversão</th>
                  <th></th>
                </tr>
              </thead>

              <tbody>
                <tr v-for="value in data" :key="value.id">
                  <td>{{ value.unidade_negocio }}</td>
                  <td>
                    {{ value.leads }}/{{ value.meta_leads }}
                    <v-progress-linear 
                    rounded="2"
                    :color="getColor(value.leads, value.meta_leads)"
                    height="5"
                    :model-value="getPercentage(value.leads, value.meta_leads)">
                    </v-progress-linear>
                  </td>

                  <td>
                    {{ value.oportunidades }}/{{ value.meta_oportunidades }}
                    <v-progress-linear 
                    :color="getColor(value.oportunidades, value.meta_oportunidades)"
                    :model-value="getPercentage(value.oportunidades, value.meta_oportunidades)">
                    </v-progress-linear>
                  </td>
                  <td>
                    {{ 
                      getConversao(value.oportunidades, value.leads).toFixed(0) 
                    }}%</td>
                </tr>
              </tbody>
            </v-table>
          </v-card-text>
        </v-card>
</template>

<script setup lang="ts">
import { watch } from 'vue';


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

watch(() => [props.metaLeads, props.metaOportunidades], () =>{
    props.data.forEach(v => {
      v.meta_leads = getTotal(Number(v.unidade_negocio_id), props.metaLeads, 'valor_meta')
      v.meta_oportunidades = getTotal(Number(v.unidade_negocio_id), props.metaOportunidades, 'valor_meta')
    })
})

const getPercentage = (value: number, target: number) => {
  if (target === 0) return 0
  return (value / target) * 100
}

const getConversao = (value_a: number, value_b: number) => {
  if(!value_a) return 0
  return (value_a / value_b) * 100
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
  return array.filter(v => Number(v.unidade_negocio_id) === id).reduce((total: number, item: any) => total + Number(item[attr]), 0)
}


</script>
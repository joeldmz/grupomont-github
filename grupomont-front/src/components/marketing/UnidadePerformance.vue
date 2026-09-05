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
                  <th style="width: 250px;">Leads</th>
                  <th style="width: 250px;">Oportunidades</th>
                  <th>Conversao</th>
                  <th></th>
                </tr>
              </thead>

              <tbody>
                <tr v-for="value in data" :key="value.id">
                  <td>{{ value.unidade_negocio }}</td>
                  <td>
                    {{ value.leads_realizados }}/{{ parseInt(value.meta_leads) }}
                    <v-progress-linear 
                    rounded="2"
                    :color="getColor(value.leads_realizados, value.meta_leads)"
                    height="5"
                    :model-value="getPercentage(value.leads_realizados, value.meta_leads)">
                    </v-progress-linear>
                  </td>

                  <td>
                    {{ value.oportunidades_realizadas }}/{{parseInt( value.meta_oportunidades) }}
                    <v-progress-linear 
                    :color="getColor(value.oportunidades_realizadas, value.meta_oportunidades)"
                    :model-value="getPercentage(value.oportunidades_realizadas, value.meta_oportunidades)">
                    </v-progress-linear>
                  </td>
                  <td>{{ getPercentage(value.oportunidades_realizadas, value.meta_oportunidades).toFixed(2) }}%</td>
                </tr>
              </tbody>
            </v-table>
          </v-card-text>
        </v-card>
</template>

<script setup lang="ts">

interface Props {
  data?: any[]
}

const props = withDefaults(defineProps<Props>(), {
  data: () => []
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

</script>
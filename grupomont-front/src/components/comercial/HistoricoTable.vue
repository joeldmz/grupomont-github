<template>
  <v-card>

    <v-card-item class="pb-0">
      <v-card-title class="font-weight-bold">
        Performance
      </v-card-title>

      <v-card-subtitle>
        Conversão e tempo médio por etapa
      </v-card-subtitle>
    </v-card-item>

    <v-divider class="mt-4" />

    <v-data-table
    :headers="headers"
    :items="data"
    class="text-body-small"
    item-value="name"
    hide-default-footer
    hover
  >
    <template v-slot:item="{ item }">
      <tr class="text-no-wrap">
        <td>{{ item.ordem }}</td>
        <td>{{ item.etapa }}</td>
        <td>
          <v-chip
            class="ma-2"
            :color="getSaude(item)"
            size="small"
            label
          >
            {{ getSaude(item) === 'success' ?  `Saudavel` : `Requer atencao` }} 
          </v-chip>
        </td>
        <td>{{ item.total_oportunidades }}</td>
        <td>
          <div v-if="item.taxa_conversao">
            {{ item.taxa_conversao }}%
            <v-progress-linear
                v-if="item.taixa_conversao !== null"
                :model-value="item.taxa_conversao"
                :color="getHealth(item.taxa_conversao)"
                height="6"
                rounded
              />
          </div>
        </td>
        <td>
            <v-icon icon="mdi-clock-outline px-3" :color="getHealthDias(item)" start></v-icon>
            {{ `${item.media_dias} dias` }}
        </td>
      </tr>
    </template>
  </v-data-table>
  </v-card>
</template>

<script setup lang="ts">


interface Props {
  title?: string,
  data?: any[]
}

const props = defineProps<Props>()

  const headers: any = [
    { title: 'Ordem', key: 'ordem', align: 'start' },
    { title: 'Etapa', key: 'etapa' },
    { title: 'Saude', key: 'saude' },
    { title: 'Oportunidades', key: 'total_oportunidades' },
    { title: 'Taixa de conversao', key: 'taixa_conversao' },
    { title: 'Tempo medio', key: 'media_dias' },
  ]

  const estimacao_dias = [
    { ordem: 1 , dias: 15 },
    { ordem: 2 , dias: 10 },
    { ordem: 3, dias: 3 },
    { ordem: 4 , dias: 5 },
    { ordem: 5 , dias: 10 }
]

const getSaude = (item: any) => {
  if(getHealth(item.taxa_conversao) === 'error' || getHealthDias(item) === 'error') {
     return 'error'
  }
  return 'success'
}

const getHealth = (item: any) => {
    if (item === null) return 'primary'

    if (item >= 70) {
      return 'success'
    }

    if (item < 40) {
      return 'error'
    }

    return 'warning'
}

const getHealthDias = (item: any) => {
    if (item === null) return 'primary'
    const dias = estimacao_dias.find((v) => v.ordem === item.ordem)?.dias || 0
    console.log(dias)
    if (item.media_dias <= dias) {
      return 'success'
    }

    if (item.media_dias > dias) {
      return 'error'
    }

    return 'warning'
}

</script>

<style scoped>
.custom-card {
  height: 100%;
}
</style>
<template>
  <v-card style="height: 100%;">
    <v-card-item class="pb-0">
      <v-card-title class="d-flex justify-space-between font-weight-bold">
        
        <span>
          Performance
        </span>
        <v-select
          label="Unidade"
          :items="unidadesNegocio"
          v-model="unidadeSelecionada"
          item-title="nome"
          item-value="id"
          @update:model-value="onUnidadeChange"
          density="compact"
          variant="outlined"
          hide-details
          class="unit-selector"
        />
      </v-card-title>

      <v-card-subtitle>
        Conversão e tempo médio por etapa
      </v-card-subtitle>
    </v-card-item>

    <v-divider class="mt-4" />

    
  <v-data-table
    :headers="headers"
    :items="funil"
    class="text-body-small"
    item-value="name"
    hide-default-footer
    hover
  >
    <template v-slot:item="{ item }">
      <tr class="text-no-wrap">
        <td>{{ item.etapa }}</td>
        <td>
          <v-chip
            v-if="Number(item.oportunidades > 0)"
            class="ma-2"
            :color="getSaude(item)"
            size="small"
            label
          >
            {{ getSaude(item) === 'success' ?  `Saudável` : `Requer atenção` }}
          </v-chip>
        </td>
        <td>{{ item.oportunidades }}</td>
        <td>
            <div v-if="Number(item.oportunidades > 0)">
                <div v-if="item.taxa_conversao">
                    {{ item.taxa_conversao }}%
                    <v-progress-linear
                        v-if="item.taixa_conversao !== null"
                        :model-value="item.taxa_conversao"
                        :color="getHealth(Number(item.taxa_conversao))"
                        height="6"
                        rounded
                    />
                </div>
            </div>
        </td>
        <td>
            <div v-if="Number(item.oportunidades > 0)">
                <v-icon icon="mdi-clock-outline px-3" :color="getHealthDias(item)" start></v-icon>
                {{ `${item.tempo_medio} dias` }}
            </div>
        </td>
      </tr>
    </template>
  </v-data-table>
  </v-card>
</template>

<script setup lang="ts">
import { abrirDialog } from '@/composables/UseDialog';
import { getFunilByUnidade, getHistoricoFunilByUnidade } from '@/services/funilService';
import { onMounted, ref } from 'vue'

interface Props {
  title?: string
  data?: any[]
}

const props = defineProps<Props>()

const unidadesNegocio = [
  { id: 1, nome: 'Montseguro' },
  { id: 2, nome: 'Prop5' },
  { id: 3, nome: 'TechBrabo' },
]

const headers: any = [
    { title: 'Etapa', key: 'etapa' },
    { title: 'Saúde', key: 'saude' },
    { title: 'Oportunidades', key: 'oportunidades' },
    { title: 'Taxa de conversão', key: 'taixa_conversao' },
    { title: 'Tempo medio', key: 'media_dias' },
  ]

  const estimacao_dias = [
    { ordem: 1 , dias: 15 },
    { ordem: 2 , dias: 10 },
    { ordem: 3, dias: 3 },
    { ordem: 4 , dias: 5 },
    { ordem: 5 , dias: 10 },
    { ordem: 6 , dias: 5 },
    { ordem: 7 , dias: 3 },
    { ordem: 8 , dias: 7 },
    { ordem: 9 , dias: 10 }
]

const unidadeSelecionada = ref<number | null>(1)
const funil = ref<any[]>(props.data ?? [])

onMounted(() => onUnidadeChange(1))

const onUnidadeChange = async(unidadeId: number | null) => {
  unidadeSelecionada.value = unidadeId

  if (unidadeId === null) return

  try {
    funil.value = await getHistoricoFunilByUnidade({
      unidade_negocio_id: unidadeId,
      status: ['Aberta', 'Ganha'],
    })
  } catch (error) {
    console.error(error)
  }
}

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
.unit-selector {
  max-width: 180px;
  min-width: 140px;
}
</style>
<template>
  <v-card style="height: 100%;">
    <v-card-item class="pb-0">
      <v-card-title class="d-flex justify-space-between font-weight-bold">
        
        <span>
          Pipeline
        </span>
        <v-btn
          class="open-funil-btn"
          icon="mdi-arrow-expand"
          variant="flat"
          size="small"
          aria-label="Abrir funil"
          @click="openFunil"
        />
      </v-card-title>

      <v-card-subtitle>
        Estágio atual de oportunidades por etapa
      </v-card-subtitle>
    </v-card-item>

    <v-divider class="mt-4" />

    
  <v-table>
    <thead>
      <tr>
        <th class="text-left">
          Etapa 
        </th>
        <th class="text-left">
          Oportunidades
        </th>
        <th class="text-left">
          (%) Probabilidade de fechamento
        </th>
        <!-- <th class="text-left">
          Receita Estimada
        </th> -->
      </tr>
    </thead>
    <tbody>
      <tr
        v-for="item in data"
        :key="item.name"
      >
        <td>{{ item.etapa }}</td>
        <td>{{ item.total }}</td>
        <td v-if="item.ordem !== 5">
            {{ item.probabilidade_media }}%
            <v-progress-linear
                :model-value="item.probabilidade_media ?? 0"
                color="green"
                height="6"
                rounded
            />
        </td>
        <!-- <td>
            R${{ item.valor_ponderado }}
        </td> -->
      </tr>
    </tbody>
  </v-table>
    <!-- <v-timeline
      class="pa-5"
      align="start"
      density="compact"
      side="end"
    >
      <v-timeline-item
        v-for="(item, index) in data"
        :key="item.etapa"
        :dot-color="getHealthColor(item)"
        size="small"
        fill-dot
      >
        <template #icon>
          <span class="text-caption font-weight-bold">
            {{ index + 1 }}
          </span>
        </template>

        <div class="stage-card pa-4 w-full">
          <!-- Header
          <div class="d-flex justify-space-between align-center mb-4">
            <div>
              <div class="text-subtitle-1 font-weight-bold">
                {{ item.etapa }}
              </div>
            </div>

            <v-chip
              size="small"
              :color="getHealthColor(item)"
              variant="tonal"
            >
              {{ getHealthLabel(item) }}
            </v-chip>
          </div>

          <v-row class="py-3" dense>
            <v-col cols="4">
              <div class="metric">
                <div class="text-caption text-medium-emphasis">
                  Oportunidades
                </div>

                <div class="text-h6 font-weight-bold">
                  {{ item.total_oportunidades }}
                </div>
              </div>
            </v-col>

            <v-col cols="4">
              <div class="metric">
                <div class="text-caption text-medium-emphasis">
                  Conversão
                </div>
                <div class="text-h6 font-weight-bold">
                  {{
                    item.taxa_conversao !== null
                      ? `${item.taxa_conversao}%`
                      : '—'
                  }}
                </div>
              </div>
            </v-col>

            <v-col cols="4">
              <div class="metric">
                <div class="text-caption text-medium-emphasis">
                  Tempo médio
                </div>
                <div class="text-h6 font-weight-bold">
                  {{ item.media_dias }} dias
                </div>
              </div>
            </v-col>
          </v-row>
          <div
            v-if="item.taxa_conversao !== null"
            class="mt-4"
          >
            <div class="d-flex justify-space-between mb-1">
              <span class="text-caption text-medium-emphasis">
                Avanço para esta etapa
              </span>

              <span class="text-caption font-weight-bold">
                {{ item.taxa_conversao }}%
              </span>
            </div>

            <v-progress-linear
              :model-value="item.taxa_conversao"
              :color="getHealthColor(item)"
              height="6"
              rounded
            />
          </div>
        </div>
      </v-timeline-item>
    </v-timeline> -->
  </v-card>
</template>

<script setup lang="ts">
import { abrirDialog } from '@/composables/UseDialog';
import { getFunilByUnidade } from '@/services/funilService';
import { onMounted, ref } from 'vue';
import UnidadePipeline from './UnidadePipeline.vue';
import type { FunilItem, HistoricoFunilItem } from '@/types/api'
const funil = ref<FunilItem[]>([])

interface Props {
  title?: string
  data?: FunilItem[]
}

defineProps<Props>()



const estimacao_dias = [
    { etapa: 'Qualificacao' , dias: 10 },
    { etapa: 'Diagnostico' , dias: 5 },
    { etapa: 'Proposta' , dias: 3 },
    { etapa: 'Negociacao' , dias: 5 },
    { etapa: 'Fechamento' , dias: 10 }
]

const getHealthColor = (item: HistoricoFunilItem) => {
  if (item.taxa_conversao == null) return 'primary'

  const dias = estimacao_dias.find((v) => v.etapa === item.etapa)?.dias || 0
  const taxaConversao = Number(item.taxa_conversao)
  const mediaDias = Number(item.media_dias ?? 0)

  if (taxaConversao >= 70 && mediaDias <= dias) {
    return 'success'
  }

  if (taxaConversao < 40 && mediaDias > dias) {
    return 'error'
  }

  return 'warning'
}

const getHealthLabel = (item: HistoricoFunilItem) => {
  if (item.taxa_conversao == null) return 'Inicial'

  const dias = estimacao_dias.find((v) => v.etapa === item.etapa)?.dias || 0
  const taxaConversao = Number(item.taxa_conversao)
  const mediaDias = Number(item.media_dias ?? 0)

  if (taxaConversao >= 70 && mediaDias <= dias) {
    return 'Saudável'
  }

  if (taxaConversao < 40 && mediaDias > dias) {
    return 'Crítico - taxa de conversão baixa'
  }

  return 'Atenção'
}

const openFunil = async() => {
  try {
      funil.value = await getFunilByUnidade({ unidade_negocio_id: 1, status: ['Aberta', 'Ganha'] })
      abrirDialog(
        '',
        '',
        [UnidadePipeline],
        [ {data: funil.value}],
        700,
        () => {
          console.log('Confirmado')
        }
      )
  } catch (error) {
    console.error(error)
  }
}

</script>

<style scoped>
.stage-card {
  border: 1px solid rgba(var(--v-border-color), var(--v-border-opacity));
  width: 550px;
  border-radius: 5px;
  transition: 0.2s ease;
}

.stage-card:hover {
  transform: translateY(-2px);
}

.metric {
  display: flex;
  flex-direction: column;
}

.open-funil-btn {
  width: 36px;
  height: 36px;
  border-color: rgba(var(--v-border-color), 0.35);
  border-radius: 8px;
  background-color: white;
}
</style>
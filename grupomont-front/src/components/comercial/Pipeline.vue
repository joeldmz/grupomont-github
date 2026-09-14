<template>
  <v-card style="height: 100%;">
    <v-card-item class="pb-0">
      <v-card-title class="font-weight-bold">
        Pipeline
      </v-card-title>

      <v-card-subtitle>
        Estagio atual de oportunidades por etapa
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
          (%) Probabildade de Fechamento
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
                :model-value="item.probabilidade_media"
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


interface Props {
  title?: string
  data?: any[]
}

defineProps<Props>()

const estimacao_dias = [
    { etapa: 'Qualificacao' , dias: 10 },
    { etapa: 'Diagnostico' , dias: 5 },
    { etapa: 'Proposta' , dias: 3 },
    { etapa: 'Negociacao' , dias: 5 },
    { etapa: 'Fechamento' , dias: 10 }
]

const getHealthColor = (item: any) => {
  if (item.taxa_conversao === null) return 'primary'

  const dias = estimacao_dias.find((v) => v.etapa === item.etapa)?.dias || 0
  if (item.taxa_conversao >= 70 && item.media_dias <= dias) {
    return 'success'
  }

  if (item.taxa_conversao < 40 && item.media_dias > dias) {
    return 'error'
  }

  return 'warning'
}

const getHealthLabel = (item: any) => {
  if (item.taxa_conversao === null) return 'Inicial'

  const dias = estimacao_dias.find((v) => v.etapa === item.etapa)?.dias || 0
  if (item.taxa_conversao >= 70 && item.media_dias <= dias) {
    return 'Saudável'
  }

  if (item.taxa_conversao < 40 && item.media_dias > dias) {
    return  item.taxa_conversao < 40 ? 'Crítico - taixa de convercao baixa' : 'Crítico - demora em etapa'
  }

  return 'Atenção'
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
</style>
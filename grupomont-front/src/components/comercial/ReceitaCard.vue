
<template>
    <v-card style="height: 100%;">
        <v-card-item class="pb-0">
        <v-card-title class="font-weight-bold">
            Resultados gerados
        </v-card-title>

        <v-card-subtitle>
            Potencial e realizado
        </v-card-subtitle>
        </v-card-item>

        <v-divider class="mt-4" />

        <v-card-text>
      <!-- Status -->
      <div class="py-3">
        <!-- Ganadas -->
        <!-- <div class="d-flex justify-space-between py-4">
          <div class="d-flex align-center">
            <div>
              <div class="text-body-1 font-bold">
                Valor Potencial
              </div>
            </div>
          </div>

          <span class="text-h5 font-bold pt-3" style="font-weight: bold; font-size: 16px;">
            R$ {{ getPotencial(data) }}
          </span>
        </div> -->

        <!-- Abiertas -->
        <div class="status-item d-flex justify-space-between">
          <div class="d-flex align-center">
            <div>
              <div class="text-body-2 font-weight-bold">
                Oportunidades activas
              </div>
              <v-chip
                    class="ma-2"
                    color="gray"
                    size="small"
                    label
                    >
                    <v-icon icon="mdi-label" start></v-icon>
                    {{ 80 }}% probabilidade geral de fechamento
              </v-chip>
            </div>
          </div>
          <span class="pt-4" style="font-weight: bold; font-size: 16px;">
            R$ {{ getAtivos(data) }}
          </span>
        </div>

        <!-- Perdidas -->
        <div class="status-item d-flex justify-space-between py-4">
          <div class="d-flex align-center">
            <div>
              <div class="text-body-2 font-weight-medium">
                Oportunidades fechadas
              </div>
            </div>
          </div>

          <span class="pt-3" style="font-weight: bold; font-size: 16px;">
            R$ {{ getGanhados(data) }}
          </span>
        </div>

        <v-divider></v-divider>

        <!-- Perdidas -->
        <div class="status-item d-flex justify-space-around py-6">
          <div class="text-center pt-6">
             Valor Potencial
             <div style="font-weight: bold; font-size: 16px;">R$ {{ getPotencial(data) }}</div>
          </div>

          <div class="text-center pt-6">
             Valor Realizado
             <div style="font-weight: bold; font-size: 16px;">R$ {{ getGanhados(data) }}</div>
             <!-- <div>
                <div
                    class="mt-1"
                    :class="'text-error'"
                    >
                    <v-icon
                        size="20"
                        class="mr-1"
                    >
                        {{ 'mdi-arrow-down' }}
                    </v-icon>

                    <span class="text-body-2 font-weight-medium">
                        {{ gapPercentual(getGanhados(data), getPotencial(data)) }}%
                    </span>
                </div>
            </div> -->
          </div>
        </div>

      </div>
    </v-card-text>

    </v-card>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps({
  data: {
    type: Array,
    required: true
  }
})

const getPotencial = (data: any[]) => {
    if(!data) return 0
    return data.reduce((total:any, v: any) => total + Number(v.valor_pipeline), 0);
}

const getGanhados = (data: any[]) => {
    return data.filter((v: any) => Number(v.ordem) === 5).reduce((total:any, v: any) => total + Number(v.valor_ponderado), 0);
}

const getAtivos = (data: any[]) => {
    return data.filter((v: any) => Number(v.ordem) !== 5).reduce((total:any, v: any) => total + Number(v.valor_ponderado), 0);
}

const gapPercentual = (potencial: number, ganhas: number) => {
  if (potencial) return 0

  return  ((potencial / ganhas) * 100)
}


</script>
<template>
  <v-card style="height: 100%;" elevation="0">
    <v-card-item class="pb-0">
      <v-card-title class="d-flex justify-space-between font-weight-bold">
        
        <span>
          Pipeline
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
        v-for="item in funil"
        :key="item.name"
      >
        <td>{{ item.etapa }}</td>
        <td>{{ item.quantidade_clientes }}</td>
        <td>
          {{ item.probabilidade_media ?? 0 }}%
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
  </v-card>
</template>

<script setup lang="ts">
import { abrirDialog } from '@/composables/UseDialog';
import { getFunilByUnidade } from '@/services/funilService';
import { ref } from 'vue'
import type { FunilItem } from '@/types/api'

interface Props {
  title?: string
  data?: FunilItem[]
}

const props = defineProps<Props>()

const unidadesNegocio = [
  { id: 1, nome: 'Montseguro' },
  { id: 2, nome: 'Prop5' },
  { id: 3, nome: 'TechBrabo' },
]

const unidadeSelecionada = ref<number | null>(1)
const funil = ref<FunilItem[]>(props.data ?? [])

const onUnidadeChange = async(unidadeId: number | null) => {
  unidadeSelecionada.value = unidadeId

  if (unidadeId === null) return

  try {
    funil.value = await getFunilByUnidade({
      unidade_negocio_id: unidadeId,
      status: ['Aberta', 'Ganha'],
    })
  } catch (error) {
    console.error(error)
  }
}

</script>

<style scoped>
.unit-selector {
  max-width: 180px;
  min-width: 140px;
}
</style>
<template>
  <v-card style="height: 100%;">
    <v-row dense>
      <v-col cols="12">
        <ProgressListCard
          title="Operadoras com mais contratos"
          :items="getOperadoras"
        />
      </v-col>
      <v-col cols="12">
        <ProgressListCard
          title="Planos mais contratados"
          :items="getPlanos"
        />
      </v-col>
    </v-row>
  </v-card>
</template>

<script setup lang="ts">
import ProgressListCard from '@/components/common/ProgressListCard.vue'
import { computed } from 'vue';

interface Props {
  title?: string,
  data?: any,
}

const props = defineProps<Props>()


const getOperadoras = computed(() => {
    const total = props.data.operadoras.value.reduce(
      (acc: number, item: any) => acc + Number(item.quantidade_contratacoes),
      0
    )

    return props.data.operadoras.value.map((v: any) => {
        return {
            label: v.operadora,
            value: v.quantidade_contratacoes,
            total: v.receita,
            percent: total > 0 ? Math.round((Number(v.quantidade_contratacoes) / total) * 100): 0
        }
    })
})

const getPlanos = computed(() => {
    const total = props.data.planos.value.reduce(
      (acc: number, item: any) => acc + Number(item.quantidade_contratacoes),
      0
    )
   return props.data.planos.value.map((v: any) => {
      return {
          label: v.plano,
          value: v.quantidade_contratacoes,
          total: v.receita,
          percent: total > 0 ? Math.round((Number(v.quantidade_contratacoes) / total) * 100): 0
      }
   })
})
</script>
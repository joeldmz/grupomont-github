<template>
    <v-data-table
      :headers="headers"
      :items="data"
      :search="search"
    >
    <template v-slot:item.probabilidade="{ item }">
        <span>{{ `${Number(item.probabilidade).toFixed(0)}%` }}</span>
    </template>

    <template v-slot:item.valor_estimado="{ item }">
        <span style="font-weight: bold;">{{ `R$${item.valor_estimado}`}}</span>
    </template>

    <template v-slot:item.consultor="{ item }">
        <v-icon color="grey" class="pr-3">mdi-comment-account-outline</v-icon>
        <span style="font-weight: bold;">{{ item.consultor }}</span>
    </template>
    </v-data-table>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
const search = ref('')


interface Props {
  title?: string,
  data?: any[],
}

const props = defineProps<Props>()

const headers: any[] = [
{
    align: 'start',
    key: 'cliente_id',
    sortable: false,
    title: 'Id',
},
{ key: 'cliente', title: 'Cliente' },
{ key: 'etapa', title: 'Etapa' },
{ key: 'valor_estimado', title: 'Valor Estimado' },
{ key: 'probabilidade', title: 'Probablidade(%)' },
{ key: 'status_cliente', title: 'Status' },
{ key: 'consultor', title: 'Consultor' },
]

</script>
<template>
  <v-card style="height: 100%;">
    <v-card-title>
        Resultado financeiro e comercial
    </v-card-title>

    <v-divider></v-divider>

    <v-data-table
        :headers="headers"
        :items="items"
        >

        <template v-slot:item.oportunidades_ganhas="{ item }">
            <span>{{ item.oportunidades_ganhas }} /
                <span 
                 :class="`text-${getColor(conversao(item.quantidade_oportunidades, item.oportunidades_ganhas))}`" style="font-weight: bold;">
                 ({{ conversao(item.quantidade_oportunidades, item.oportunidades_ganhas).toFixed(0) }}%)
                </span>
            </span>
        </template>

        <template v-slot:item.valor_total_oportunidades="{ item }">
            <span style="font-weight: bold;">R$ {{ item.valor_total_oportunidades }}</span>
        </template>

        <template v-slot:item.receita_realizada="{ item }">
            <span style="font-weight: bold;">R$ {{ item.receita_realizada }}</span>
        </template>

        <template v-slot:item.ticket_medio="{ item }">
            <span style="font-weight: bold;">R$ {{ Number(item.ticket_medio ).toFixed(2) }}</span>
        </template>

    </v-data-table>
  </v-card>
</template>
<script setup lang="ts">
import { computed } from 'vue';


interface Props {
  title?: string,
  items?: any[],
}

const props = defineProps<Props>()

const headers: any[] = [
{
    align: 'start',
    key: 'unidade_negocio_id',
    sortable: false,
    title: 'Id',
},
{ key: 'empresa', title: 'Unidade de negócio' },
{ key: 'receita_realizada', title: 'Receita' },
{ key: 'valor_total_oportunidades', title: 'Pipeline (Valor potencial)' },
{ key: 'quantidade_oportunidades', title: 'Oportunidades' },
{ key: 'oportunidades_ganhas', title: 'Ganhas / (%) Conversão' },
{ key: 'ticket_medio', title: 'Ticket médio' },
{ key: 'acoes', title: '' },
]

const conversao = (oportunidade: number, ganha: number) => {
    return ganha / oportunidade * 100
}


const getColor = (value: number) => {
  if (value >= 100) {
    return 'green'
  } else if (value >= 70) {
    return 'orange'
  } else {
    return 'red'
  }
}
</script>
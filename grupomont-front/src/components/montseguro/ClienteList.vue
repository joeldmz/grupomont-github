<template>
  <v-card
    title="Clientes Ativos"
    style="height: 100%;"
  >
    <!-- <template v-slot:text>
      <v-text-field
        v-model="search"
        label="Buscar"
        prepend-inner-icon="mdi-magnify"
        variant="outlined"
        hide-details
        single-line
      ></v-text-field>
    </template> -->

    <v-data-table
      :headers="headers"
      :items="data"
      :search="search"
    >
    
    <template v-slot:item.quantidade_vidas="{ item }">
        <span>{{ item.quantidade_vidas ? `${item.quantidade_vidas}` : '-'}}</span>
    </template>

    <template v-slot:item.pagamento>
        <v-chip color="green">Em dia</v-chip>
    </template>

    <template v-slot:item.valor_mensal_plano="{ item }">
        <span style="font-weight: bold;">{{ item.valor_mensal_plano ? `R$${item.valor_mensal_plano}` : '-'}}</span>
    </template>

    <!-- <template v-slot:item.status_contratacao="{ item }">
        <v-chip :color="item.status_contratacao === 'Ativa' ? 'green' : 'grey'" size="small" variant="tonal" class="font-weight-medium">
          <v-icon start size="12">{{ item.status_contratacao === 'Ativa' ? 'mdi-circle' : 'mdi-circle-outline' }}</v-icon>
          {{ item.status_contratacao }}
        </v-chip>
    </template> -->

    </v-data-table>
  </v-card>
</template>

<script setup lang="ts">
import { ref } from 'vue'
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
{ key: 'plano', title: 'Plano' },
{ key: 'quantidade_vidas', title: 'Quantidade de Vidas' },
{ key: 'etapa', title: 'Etapa' },
{ key: 'valor_mensal_plano', title: 'Valor/mês' },
{ key: 'pagamento', title: 'Status Pagamento' },
{ key: 'consultor', title: 'Consultor' },
]

</script>
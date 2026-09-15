<template>
  <v-card
    title="Operações"
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
        expand-strategy="single"
        item-value="cliente_id"
        hide-default-footer
        show-expand
        @update:opened="() => openInfo" 
        >

        <template v-slot:item.valor_total_operacoes="{ item }">
            <span style="font-weight: bold;">{{ `R$ ${item.valor_total_operacoes}`}}</span>
        </template>

        <template v-slot:item.valor_concluido="{ item }">
            <span style="font-weight: bold;">{{ item.valor_concluido > 0 ?  `R$ ${item.valor_concluido}` : ' - '}}</span>
        </template>

        <template v-slot:item.valor_em_andamento="{ item }">
            <span style="font-weight: bold;">{{ item.valor_em_andamento > 0 ? `R$ ${item.valor_em_andamento}` : ' - ' }}</span>
        </template>

        <template v-slot:item.valor_previsto="{ item }">
            <span style="font-weight: bold;">{{ item.valor_previsto > 0 ? `R$ ${item.valor_previsto}` : ' - '}}</span>
        </template>

        <template v-slot:item.comissao_total="{ item }">
            <span style="font-weight: bold;">{{ item.comissao_total > 0 ? `R$ ${item.comissao_total}` : ' - ' }}</span>
        </template>

        <template v-slot:item.data-table-expand="{ internalItem, isExpanded, toggleExpand }">
            <v-btn
                :append-icon="isExpanded(internalItem) ? 'mdi-chevron-up' : 'mdi-chevron-down'"
                class="text-none"
                color="medium-emphasis"
                size="small"
                variant="flat"
                slim
                @click="openInfo(internalItem.raw, isExpanded(internalItem)); toggleExpand(internalItem);"
            ></v-btn>
        </template>

        <template v-slot:expanded="{ item }">
            <v-sheet class="pa-2" rounded="lg" border>
                <v-table density="compact">
                <tbody class="bg-surface-light">
                    <tr>
                        <th>Tipo de operação</th>
                        <th>Valor</th>
                        <th>Status</th>
                        <th>Consultor</th>
                    </tr>
                </tbody>

                <tbody>
                    <tr v-for="value in operacoesByCliente">
                        <td class="py-2">{{ value.tipo_operacao }}</td>
                        <td class="py-2">{{ `R$ ${value.valor_operacao}` }}</td>
                        <td class="py-2">{{ value.status }}</td>
                        <td class="py-2">{{ value.consultor }}</td>
                    </tr>
                </tbody>
                </v-table>
            </v-sheet>
        </template>
    </v-data-table>
  </v-card>
</template>

<script setup lang="ts">
import { getOperacoesByCliente } from '@/services/operacaoService';
import { ref } from 'vue'
const search = ref('')


interface Props {
  title?: string,
  data?: any[],
}

const props = defineProps<Props>()
const operacoesByCliente = ref<any>([])

const headers: any[] = [
{
    align: 'start',
    key: 'cliente_id',
    sortable: false,
    title: 'Id',
},
{ key: 'cliente', title: 'Cliente' },
{ key: 'total_operacoes', title: 'Total de operacoes' },
{ key: 'valor_total_operacoes', title: 'Valor Total' },
{ key: 'valor_concluido', title: 'Concluido' },
{ key: 'valor_em_andamento', title: 'En Andamento' },
{ key: 'valor_previsto', title: 'Valor Previsto' },
{ key: 'comissao_total', title: 'Comissao' },
{ key: 'acoes', title: '' },
]

const openInfo = async(item : any, expanded: boolean) => {
    if(!expanded) console.log(item, expanded)
  try {
    if(!expanded) {
        operacoesByCliente.value = await getOperacoesByCliente({ id: item.cliente_id })
    }
  } catch (error) {
    console.error(error)
  }
    
}

</script>
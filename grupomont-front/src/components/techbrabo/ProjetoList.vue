<template>
  <v-card style="height: 100%;">
    <v-card-title>
        Projetos
    </v-card-title>

    <v-divider></v-divider>

    <v-data-table
        :headers="headers"
        :items="data"
        :search="search"
        >
        <template v-slot:item.status="{ item }">
            <div>
                <span style="font-weight: bold;">{{ item.status }}</span>   
            </div>
        </template>

        <template v-slot:item.saude="{ item }">
            <v-chip v-if="item.status !== 'Concluido'" 
                    :color="Number(progressoTemporal(item)) >= 80 ? 'orange' : 'success'" 
                    size="small"
                    >
                <v-icon class="pr-1">mdi-information-outline</v-icon>  {{ Number(progressoTemporal(item)) >= 80 ? 'Atencao' : 'Saudavel' }}
            </v-chip> 
        </template>

        <template v-slot:item.acoes="{ item }">
            <v-btn @click="openInfo(item)" icon="$vuetify" variant="tonal" size="small"></v-btn>
        </template>
    </v-data-table>
  </v-card>
</template>

<script setup lang="ts">
import { abrirDialog } from '@/composables/UseDialog';
import { getOperacoesByCliente } from '@/services/operacaoService';
import { computed, ref } from 'vue'
import ProjetoDethale from './ProjetoDethale.vue';
import { getDetalheProjeto } from '@/services/projetoService.ts';
const search = ref('')


interface Props {
  title?: string,
  data?: any[],
}

const props = defineProps<Props>()
const projeto = ref<any | null>({})
const headers: any[] = [
{
    align: 'start',
    key: 'id',
    sortable: false,
    title: 'Id',
},
{ key: 'nome', title: 'Nome' },
{ key: 'cliente', title: 'Cliente' },
{ key: 'equipe', title: 'Squad' },
{ key: 'status', title: 'Status' },
{ key: 'saude', title: 'Saude' },
{ key: 'acoes', title: '' },
]

const openInfo = async(item : any) => {
  try {
    projeto.value = await getDetalheProjeto({ id: item.id })
    abrirDialog(
        '',
        '',
        [ProjetoDethale],
        [{ projeto: projeto.value }],
        () => {
          console.log('Confirmado')
        }
    )
  } catch (error) {
    console.error(error)
  }
    
}

const diasPrevistos = (item: any) => {
  if (!item.data_inicio || !item.data_previsao_entrega) {
    return 0
  }

  const inicio = new Date(item.data_inicio)
  const previsao = new Date(item.data_previsao_entrega)

  return Math.ceil(
    (previsao.getTime() - inicio.getTime()) / (1000 * 60 * 60 * 24)
  )
}

const diasCorridos = (item: any) => {
  if (!item.data_inicio) {
    return 0
  }

  const inicio = new Date(item.data_inicio)

  const fim =
    item.status_projeto === 'Concluído' && item.data_entrega
      ? new Date(item.data_entrega)
      : new Date()

  return Math.max(
    0,
    Math.ceil(
      (fim.getTime() - inicio.getTime()) / (1000 * 60 * 60 * 24)
    )
  )
}

const progressoTemporal = computed(() => {
  return (item: any) => {
    if (!item) return 0

    return Math.min(
        100,
        Math.round(( diasCorridos(item) / diasPrevistos(item)) * 100)
    )
  }
})

</script>
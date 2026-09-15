<template>
  <v-card
    style="height: 100%;"
  >
    <v-card-title>
      Jornada
    </v-card-title>

    <v-divider></v-divider>

    <v-list
      class="pa-0 d-flex flex-column ga-1 pa-3"
      lines="one"
    >
      <v-list-item
        v-for="item in items"
        :key="item.label"
        class="px-3"
        :class="'bg-grey-lighten-4'"
        rounded="md"
        @click="setItem(item)"
      >
        <template #prepend>
          <v-icon
            color="grey-darken-1"
            icon="mdi-arrow-down-thin-circle-outline"
            size="20"
          />
        </template>

        <v-list-item-title
          class="text-body-2" style="font-size: 14px;"
        >
          {{ item.etapa }}
        </v-list-item-title>

        <template #append>
          <div v-if="item.quantidade_clientes > 0">
            <v-icon
                :color="Number(item.etapa_id) >= active ? 'green': 'orange'"
                :icon="Number(item.etapa_id) >= active ? 'mdi-account-check-outline': 'mdi-account-clock-outline'"
                size="18"
                class="pr-3"
            />
            <span style="font-weight: bold; font-size: 14px;">{{ item.quantidade_clientes }} Clientes</span>
          </div>
        </template>
      </v-list-item>
    </v-list>
  </v-card>
</template>

<script setup lang="ts">
import { abrirDialog } from '@/composables/UseDialog';
import { getOportunidadeAndEtapa } from '@/services/oportunidadeService';
import { ref } from 'vue';
import CommonList from './CommonList.vue';

const oportunidade = ref<any[]>([])

interface Props {
  title?: string
  items?: any[],
  active?: number,
  unidade_id: number
}

const props = withDefaults(defineProps<Props>(), {
  title: 'Jornada',
  items: () => [],
  active: 7,
  unidade_id: 0
})

const setItem = async(item: any) => {
    try {
        oportunidade.value = await getOportunidadeAndEtapa({ unidade_negocio_id: props.unidade_id , etapa_id: Number(item.etapa_id), status: ['Aberta', 'Ganha'] })
        abrirDialog(
        '',
        '',
        [CommonList],
        [{data: oportunidade.value}],
        1200,
        () => {
          console.log('Confirmado')
        }
    )
    } catch (error) {
        console.error(error)
    }
}
</script>
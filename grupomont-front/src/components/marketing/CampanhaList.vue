<template>
    <v-card style="height: 100%;">
          <v-card-title>
            Campanhas
          </v-card-title>
          <v-divider></v-divider>

          <v-card-text>
            <v-table>
              <thead>
                <tr>
                  <th>#ID</th>
                  <th>Campanha</th>
                  <th>Unidade de negocio</th>
                  <th>Status</th>
                  <th>Canais</th>
                  <th>periodo</th>
                  <th>Investimento</th>
                  <th></th>
                </tr>
              </thead>

              <tbody>
                <tr v-for="value in data">
                  <td>
                    {{ value.id }}
                  </td>
                  <td>{{ value.nome }} </td>
                  <td>
                    {{ value.unidade_negocio }}
                  </td>
                  <td>
                    <v-chip :color="value.status === 'Ativa' ? 'green' : 'grey'">
                       <v-icon start class="pr-3" size="12">mdi-circle</v-icon> {{ value.status }}
                    </v-chip>
                  </td>
                  <td>{{ value.canais ? value.canais : '-' }}</td>
                  <td>{{ formatDate(value.data_inicio )}} - {{ formatDate(value.data_fim)}}</td>
                  <td>R$ {{ value.investimento }}</td>
                  <td><v-btn @click="openInfo(value.id)" icon="$vuetify" variant="tonal" size="small"></v-btn></td>
                </tr>
              </tbody>
            </v-table>
          </v-card-text>
        </v-card>
</template>
<script setup lang="ts">
import { abrirDialog } from '@/composables/UseDialog';
import InfoCard from './InfoCard.vue';
import { ref, watch } from 'vue';
import { getInfo } from '@/services/campanhaService.ts';

interface Props {
  data?: any[]
}

const props = defineProps<Props>()

const campanha = ref<any>({})


const openInfo = async(id: number) => {
  try {
    campanha.value = await getInfo({ id })
    abrirDialog(
        '',
        '',
        [InfoCard],
        [{ data: campanha.value }],
        () => {
          console.log('Confirmado')
        }
    )
  } catch (error) {
    console.error(error)
  }
    
}

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('pt-BR')
}

</script>
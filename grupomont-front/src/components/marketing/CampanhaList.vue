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
                  <th>Saude</th>
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
                  <td style="font-weight: bold;">R$ {{ value.investimento }}</td>
                  <td>
                    <div v-if="value.status !== 'Encerrada'">
                      <v-chip
                          v-if="value.status !== 'Encerrada' && getAtencaoCampanha(
                            campanha.leads,
                            campanha.oportunidades,
                            campanha.metaLeads,
                            campanha.metaOportunidades
                          )"
                          color="warning"
                          size="small"
                        >
                          Atenção
                      </v-chip>

                      <v-chip
                          v-else
                          color="success"
                          size="small"
                        >
                          Saudavel
                      </v-chip>
                    </div>
                  </td>
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
        450,
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

const getAtencaoCampanha = (
  leads: number,
  oportunidades: number,
  metaLeads: number,
  metaOportunidades: number
) => {
  const conversao = leads > 0
    ? (oportunidades / leads) * 100
    : 0

  const alcanceLeads = metaLeads > 0
    ? (leads / metaLeads) * 100
    : 100

  const alcanceOportunidades = metaOportunidades > 0
    ? (oportunidades / metaOportunidades) * 100
    : 100

  return conversao < 15 ||
         alcanceLeads < 50 ||
         alcanceOportunidades < 50
}


</script>
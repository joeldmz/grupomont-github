<template>
    <v-list lines="two" class="py-0">
        <v-list-item title="Cliente" :subtitle="projeto?.razao_social" />
        <v-list-item title="Contrato" :subtitle="projeto?.numero_contrato" />
        <v-list-item>
            <template #title>
                <div class="d-flex justify-space-between align-center">
                    <span>Valor do contrato</span>
                    <span class="font-weight-medium" style="font-weight: bold;">R$ {{ projeto?.valor_contrato  }}</span>
                </div>
            </template>
        </v-list-item>

        <v-list-item title="Prazo" :subtitle="`${ formatDate(projeto?.data_inicio) } → ${ formatDate(projeto?.data_previsao_entrega) }`" />

        <v-list-item title="Equipe" :subtitle="projeto?.equipe" />

        <v-list-item>
            <template #title>
                <div class="d-flex justify-space-between align-center mb-2">
                    <span>Progresso temporal</span>
                    <span class="font-weight-medium">{{ progressoTemporal }}%</span>
                </div>
            </template>

            <v-progress-linear
                :model-value="progressoTemporal"
                :color="getColorStatus"
                height="8"
                rounded
                bg-color="grey-lighten-2"
            />

            <div class="d-flex justify-space-between mt-2">
                <span v-if="projeto?.status_projeto !== 'Concluido'">{{ diasCorridos }} de {{ diasPrevistos }} dias</span>
                <span style="font-weight: bold;">{{ getTextStatus }}</span>
            </div>
        </v-list-item>
    </v-list>
</template>

<script setup lang="ts">
import { computed, watch } from 'vue';

interface Props {
  projeto?: any
}

const props = withDefaults(defineProps<Props>(), {
  projeto: () => {}
})



const diasPrevistos = computed(() => {
  if (!props.projeto?.data_inicio || !props.projeto?.data_previsao_entrega) {
    return 0
  }

  const inicio = new Date(props.projeto.data_inicio)
  const previsao = new Date(props.projeto.data_previsao_entrega)

  return Math.ceil(
    (previsao.getTime() - inicio.getTime()) / (1000 * 60 * 60 * 24)
  )
})

const diasCorridos = computed(() => {
  if (!props.projeto?.data_inicio) {
    return 0
  }

  const inicio = new Date(props.projeto.data_inicio)

  const fim =
    props.projeto.status_projeto === 'Concluido' && props.projeto.data_entrega
      ? new Date(props.projeto.data_entrega)
      : new Date()

  return Math.max(
    0,
    Math.ceil(
      (fim.getTime() - inicio.getTime()) / (1000 * 60 * 60 * 24)
    )
  )
})

const progressoTemporal = computed(() => {
  if (!diasPrevistos.value) return 0

  return Math.min(
    100,
    Math.round((diasCorridos.value / diasPrevistos.value) * 100)
  )
})

const getColorStatus = computed(() => {
    if(!progressoTemporal.value) return 'grey'
    return (progressoTemporal.value <= 80 || props.projeto.status_projeto === 'Concluido') ? 'success' : progressoTemporal.value > 100 ? 'error' : 'orange'
})

const getTextStatus = computed(() => {
    if(!props.projeto.data_inicio && !props.projeto.data_previsao_entrega) return 'Sem Previsao'

    if(props.projeto.status_projeto === 'Concluido' && !props.projeto.data_entrega) return 'Sem data de entrega'

    if(props.projeto.status_projeto === 'Concluido' && (new Date(props.projeto.data_entrega) <= new Date(props.projeto.data_previsao_entrega))) return 'Entrege no prazo'

    if(props.projeto.status_projeto === 'Concluido' && (new Date(props.projeto.data_entrega) > new Date(props.projeto.data_previsao_entrega))) return 'Entrege no prazo'

    if(new Date() <= new Date(props.projeto.data_previsao_entrega)) return 'No prazo'

    return 'Atrasado'
})

const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('pt-BR')
}

</script>

<template>
  <v-card height="100%">
    <v-card-title class="d-flex align-center">
      Alertas e Gargalos
    </v-card-title>

    <v-card-text>
      <v-list>
        <v-list-item
          v-for="alerta in alertas"
          :key="alerta.descricao"
          :title="alerta.descricao"
          :subtitle="alerta.detalhe"
        >
          <template #append>
            <span class="font-weight-medium">
              {{ alerta.quantidade }}
            </span>
          </template>
        </v-list-item>
      </v-list>

      <v-divider class="my-4" />

      <v-list>
        <v-list-item
          title="Principal ponto de atenção"
          subtitle="Existem oportunidades no pipeline que precisam de atualização ou acompanhamento."
        />
      </v-list>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
interface Alerta {
  descricao: string
  detalhe?: string
  quantidade: number
}

const alertas: Alerta[] = [
  {
    descricao: 'Oportunidade sem probabilidade',
    detalhe: 'Negociação',
    quantidade: 1,
  },
  {
    descricao: 'Oportunidades com fechamento atrasado',
    quantidade: 2,
  },
  {
    descricao: 'Operação com prazo atrasado',
    quantidade: 1,
  },
]
</script>

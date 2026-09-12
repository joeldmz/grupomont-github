<template>
  <v-card height="100%">
    <v-card-title>
      Diagnóstico financeiro
    </v-card-title>

    <v-card-text>
      <v-list>
        <v-list-item
          v-for="item in items"
          :key="item.label"
          :title="item.label"
        >
          <template #append>
            <span class="font-weight-medium">
              {{ item.percentage }}%
            </span>
          </template>
        </v-list-item>
      </v-list>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
interface DiagnosticoItem {
  label: string
  percentage: number
}

const items: DiagnosticoItem[] = [
  { label: 'Construir patrimônio', percentage: 40 },
  { label: 'Gerar renda', percentage: 30 },
  { label: 'Diversificação', percentage: 20 },
  { label: 'Outros', percentage: 10 },
]
</script>

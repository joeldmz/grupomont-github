<template>
  <v-card
    class="opportunities-card"
  >
    <v-card-title>
      Resultados gerados
    </v-card-title>

    <v-card-text>
      <!-- Status -->
      <div class="py-3">

        <!-- Ganadas -->
        <div class="d-flex justify-space-between py-4">
          <div class="d-flex align-center">
              <v-icon
                class="px-6"
                color="grey"
                icon="mdi-notebook-heart-outline"
                size="22"
              />

            <div>
              <div class="text-body-1 font-bold">
                Contratações
              </div>

              <!-- <div class="text-caption text-medium-emphasis">
                {{ percentage(data.oportunidades_ganhas) }}% del total
              </div> -->
            </div>
          </div>

          <span class="text-h6 font-weight-bold">
            {{ data.total_contratacoes }}
          </span>
        </div>

        <!-- Abiertas -->
        <div class="status-item d-flex justify-space-between py-4">
          <div class="d-flex align-center">
              <v-icon
                color="grey"
                icon="mdi-finance"
                class="px-6"
                size="22"
              />
            <div>
              <div class="text-body-2 font-weight-bold">
                Operacoes Inmoveis
              </div>

              <!-- <div class="text-caption text-medium-emphasis">
                {{ percentage(data.oportunidades_abertas) }}% del total
              </div> -->

              <!-- <v-chip
                    class="ma-2"
                    color="gray"
                    size="small"
                    label
                    >
                    <v-icon icon="mdi-label" start></v-icon>
                    {{ data.probabilidade_media_abertas }}% probabilidade geral de fechamento
              </v-chip> -->
            </div>
          </div>

          <span class="text-h6 font-weight-bold">
            {{ data.total_operacoes }}
          </span>
        </div>

        <!-- Perdidas -->
        <div class="status-item d-flex justify-space-between py-4">
          <div class="d-flex align-center">
              <v-icon
                color="grey"
                class="px-6"
                icon="mdi-file-document-edit-outline"
                size="22"
              />

            <div>
              <div class="text-body-2 font-weight-medium">
                Contratos
              </div>

              <!-- <div class="text-caption text-medium-emphasis">
                {{ percentage(data.oportunidades_perdidas) }}% del total
              </div> -->
            </div>
          </div>

          <span class="text-h6 font-weight-bold">
            {{ data.total_contratos }}
          </span>
        </div>

        <div class="status-item d-flex justify-space-between py-4">
          <div class="d-flex align-center">
              <v-icon
                color="grey"
                class="px-6"
                icon="mdi-xml"
                size="22"
              />

            <div>
              <div class="text-body-2 font-weight-medium">
                Projetos
              </div>

              <!-- <div class="text-caption text-medium-emphasis">
                {{ percentage(data.oportunidades_perdidas) }}% del total
              </div> -->
            </div>
          </div>

          <span class="text-h6 font-weight-bold">
            {{ data.total_projetos }}
          </span>
        </div>

      </div>

      <!-- Pipeline ponderado -->
      <!-- <v-divider class="my-5" />

      <div class="d-flex justify-space-between align-center">
        <div>
          <div class="text-caption text-medium-emphasis">
            Pipeline ponderado
          </div>

          <div class="text-subtitle-1 font-weight-bold">
            R$ {{ formatCurrency(data.valor_ponderado_abertas) }}
          </div>
        </div>
      </div> -->
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
const props = defineProps({
  data: {
    type: Object,
    required: true
  }
})
</script>
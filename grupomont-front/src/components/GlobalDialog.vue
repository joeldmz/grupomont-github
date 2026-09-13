<template>

  <v-dialog
    v-model="dialogAberto"
    :max-width="dialogWidth"
  >

    <v-card>

      <v-card-title>
        {{ dialogTitulo }}
      </v-card-title>

      <v-card-text>
        {{ dialogMensagem }}
        <div
            v-for="(componente, index) in dialogComponentes"
            :key="index"
            class="py-1"
            >
            <component
                :is="componente"
                v-bind="dialogProps[index]"
            />
            </div>
      </v-card-text>

      <v-card-actions>

        <v-btn @click="fecharDialog">
          Cancelar
        </v-btn>

        <v-btn
          color="primary"
          variant="tonal"
          @click="confirmarDialog"
        >
          Confirmar
        </v-btn>

      </v-card-actions>

    </v-card>

  </v-dialog>

</template>

<script setup lang="ts">

import {
  dialogAberto,
  dialogTitulo,
  dialogMensagem,
  fecharDialog,
  confirmarDialog,
  dialogComponentes,
  dialogProps,
  dialogWidth
} from '../composables/UseDialog'

</script>
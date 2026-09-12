<template>
  <v-navigation-drawer
    v-model="drawer"
    :permanent="!mobile"
    :temporary="mobile"
    width="280"
  >
    <v-list>
      <v-list-item
        title="Grupo Mont"
        subtitle="Dashboard"
      />

      <v-divider />

      <v-list-item
        to="/"
        prepend-icon="mdi-view-dashboard"
        title="Dashboard"
      />

      <v-list-item
        to="/comercial"
        prepend-icon="mdi-chart-line"
        title="Comercial"
      />

      <v-list-item
        to="/marketing"
        prepend-icon="mdi-bullhorn"
        title="Marketing"
      />

      <v-list-group value="empresas">
        <template #activator="{ props: activatorProps }">
          <v-list-item
            v-bind="activatorProps"
            prepend-icon="mdi-domain"
            title="Empresas"
          />
        </template>

        <v-list-item
          to="/empresas/montseguro"
          prepend-icon="mdi-chevron-right"
          title="Montseguro"
        />

        <v-list-item
          to="/empresas/prop5"
          prepend-icon="mdi-chevron-right"
          title="Prop5"
        />

        <v-list-item
          to="/empresas/techbrabo"
          prepend-icon="mdi-chevron-right"
          title="Techbrabo"
        />
      </v-list-group>
    </v-list>
  </v-navigation-drawer>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useDisplay } from 'vuetify'

const props = defineProps<{
  modelValue: boolean
}>()

const emit = defineEmits<{
  'update:modelValue': [value: boolean]
}>()

const { mdAndUp } = useDisplay()
const mobile = computed(() => !mdAndUp.value)
const drawer = computed({
  get: () => props.modelValue,
  set: (value: boolean) => emit('update:modelValue', value)
})
</script>
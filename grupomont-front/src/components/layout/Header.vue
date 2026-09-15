<template>
  <v-app-bar elevation="1">
    <v-app-bar-nav-icon
      class="d-md-none"
      aria-label="Abrir menu de navegação"
      @click="$emit('toggleNavigation')"
    />

    <v-app-bar-title>
      Dashboard Executivo
    </v-app-bar-title>

    <v-spacer />

    <v-btn icon="mdi-bell-outline" />
  </v-app-bar>
</template>

<script setup lang="ts">
defineEmits<{
  toggleNavigation: []
}>()
</script>
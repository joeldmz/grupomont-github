<template>
  <v-app>
    <v-layout>
      <Sidebar v-model="drawer" />

      <v-main>
        <Header @toggle-navigation="drawer = !drawer" />

        <RouterView />
        <GlobalDialog />
      </v-main>
    </v-layout>
  </v-app>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import Sidebar from './components/layout/Sidebar.vue'
import Header from './components/layout/Header.vue'
import GlobalDialog from './components/GlobalDialog.vue'

const drawer = ref(true)
</script>

<style scoped></style>

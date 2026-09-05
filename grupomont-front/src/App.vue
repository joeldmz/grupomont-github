<template>
  <v-app>
    <v-layout>
      <Sidebar />

      <v-main>
        <Header />

        <RouterView />
        <GlobalDialog />
      </v-main>
    </v-layout>
  </v-app>
</template>

<script setup lang="ts">
import Sidebar from './components/layout/Sidebar.vue'
import Header from './components/layout/Header.vue'
import GlobalDialog from './components/GlobalDialog.vue'
</script>

<style scoped></style>

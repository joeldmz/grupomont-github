<template>
  <v-navigation-drawer permanent>
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

      <v-list-item
        to="/empresas"
        prepend-icon="mdi-domain"
        title="Empresas"
      />
    </v-list>
  </v-navigation-drawer>
</template>
<template>
  <v-container fluid>

    <!-- Header -->
    <div class="d-flex align-center mb-6">

      <v-btn
        icon="mdi-arrow-left"
        variant="text"
        class="mr-3"
        @click="voltar"
      />

      <div>
        <h1 class="text-h4">
          Prop5
        </h1>

        <p class="text-body-2 text-medium-emphasis">
          Visão detalhada da unidade de negócio
        </p>
      </div>

    </div>


    <!-- ========================= -->
    <!-- KPIs -->
    <!-- ========================= -->

    <v-row>

      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Clientes"
          :value="18"
          :target="25"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Volume Financeiro"
          :value="4200000"
          :target="5000000"
          type="currency"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Valor Transacionado"
          :value="2800000"
          :target="3500000"
          type="currency"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Receita"
          :value="95000"
          :target="120000"
          type="currency"
        />

      </v-col>

    </v-row>


    <!-- ========================= -->
    <!-- JORNADA CONSULTIVA -->
    <!-- ========================= -->

    <v-card class="mt-6">

      <v-card-title>
        Jornada Consultiva
      </v-card-title>

      <v-card-text>

        <v-row>

          <v-col
            v-for="(etapa, index) in jornada"
            :key="etapa.nome"
            cols="12"
            sm="6"
            md="3"
          >

            <div class="text-center">

              <v-avatar
                size="42"
                color="primary"
                variant="tonal"
                class="mb-2"
              >
                {{ index + 1 }}
              </v-avatar>

              <div class="font-weight-medium">
                {{ etapa.nome }}
              </div>

              <div class="text-caption text-medium-emphasis mt-1">
                {{ etapa.quantidade }} oportunidades
              </div>

            </div>

          </v-col>

        </v-row>

      </v-card-text>

    </v-card>


    <!-- ========================= -->
    <!-- PIPELINE + RECEITA -->
    <!-- ========================= -->

    <v-row class="mt-2">

      <!-- Pipeline -->

      <v-col cols="12" md="7">

        <v-card height="100%">

          <v-card-title>
            Pipeline Patrimonial
          </v-card-title>

          <v-card-text>

            <div class="text-caption text-medium-emphasis">
              Oportunidades em aberto
            </div>

            <div class="text-h4 font-weight-medium mb-4">
              9
            </div>

            <div class="text-caption text-medium-emphasis">
              Valor estimado do pipeline
            </div>

            <div class="text-h5 font-weight-medium">
              R$ 1,8M
            </div>

            <v-progress-linear
              model-value="72"
              height="10"
              rounded
              class="mt-6"
            />

            <div class="text-caption text-medium-emphasis mt-2">
              72% da meta do período
            </div>

          </v-card-text>

        </v-card>

      </v-col>


      <!-- Receita -->

      <v-col cols="12" md="5">

        <v-card height="100%">

          <v-card-title>
            Composição da Receita
          </v-card-title>

          <v-card-text>

            <div class="mb-4">

              <div class="text-caption text-medium-emphasis">
                Valor Transacionado
              </div>

              <div class="text-h6">
                R$ 2,8M
              </div>

            </div>


            <div class="mb-4">

              <div class="text-caption text-medium-emphasis">
                Comissão
              </div>

              <div class="text-h6">
                R$ 180K
              </div>

            </div>


            <div>

              <div class="text-caption text-medium-emphasis">
                Receita
              </div>

              <div class="text-h6">
                R$ 95K
              </div>

            </div>

          </v-card-text>

        </v-card>

      </v-col>

    </v-row>


    <!-- ========================= -->
    <!-- OBJETIVOS PATRIMONIAIS -->
    <!-- ========================= -->

    <v-card class="mt-6">

      <v-card-title>
        Objetivos Patrimoniais
      </v-card-title>

      <v-card-text>

        <v-row>

          <v-col cols="12" md="4">

            <div class="text-caption text-medium-emphasis">
              Preservação patrimonial
            </div>

            <v-progress-linear
              model-value="68"
              height="8"
              rounded
              class="mt-2"
            />

            <div class="text-caption mt-1">
              68%
            </div>

          </v-col>


          <v-col cols="12" md="4">

            <div class="text-caption text-medium-emphasis">
              Crescimento patrimonial
            </div>

            <v-progress-linear
              model-value="82"
              height="8"
              rounded
              class="mt-2"
            />

            <div class="text-caption mt-1">
              82%
            </div>

          </v-col>


          <v-col cols="12" md="4">

            <div class="text-caption text-medium-emphasis">
              Planejamento sucessório
            </div>

            <v-progress-linear
              model-value="54"
              height="8"
              rounded
              class="mt-2"
            />

            <div class="text-caption mt-1">
              54%
            </div>

          </v-col>

        </v-row>

      </v-card-text>

    </v-card>


  </v-container>
</template>


<script setup lang="ts">

import KpiCard from '../components/dashboard/KpiCard.vue'


const jornada = [

  {
    nome: 'Diagnóstico',
    quantidade: 4
  },

  {
    nome: 'Planejamento',
    quantidade: 3
  },

  {
    nome: 'Oportunidade',
    quantidade: 2
  },

  {
    nome: 'Fechamento',
    quantidade: 1
  }

]


function voltar() {

  window.history.back()

}

</script>

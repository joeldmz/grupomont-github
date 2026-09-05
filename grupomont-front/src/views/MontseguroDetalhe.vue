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
          Montseguro
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
          title="Empresas"
          :value="24"
          :target="30"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Vidas"
          :value="842"
          :target="1000"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Receita Mensal"
          :value="185000"
          :target="200000"
          type="currency"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Pipeline"
          :value="420000"
          :target="500000"
          type="currency"
        />

      </v-col>

    </v-row>


    <!-- ========================= -->
    <!-- PIPELINE -->
    <!-- ========================= -->

    <v-card class="mt-6">

      <v-card-title>
        Pipeline Comercial
      </v-card-title>

      <v-card-text>

        <Pipeline />

      </v-card-text>

    </v-card>


    <!-- ========================= -->
    <!-- PLANOS E OPERADORAS -->
    <!-- ========================= -->

    <v-row class="mt-2">


      <!-- Planos -->

      <v-col cols="12" md="7">

        <v-card height="100%">

          <v-card-title>
            Planos de Saúde
          </v-card-title>

          <v-divider />

          <v-table>

            <thead>

              <tr>

                <th>
                  Plano
                </th>

                <th>
                  Operadora
                </th>

                <th>
                  Empresas
                </th>

                <th>
                  Vidas
                </th>

              </tr>

            </thead>


            <tbody>

              <tr
                v-for="plano in planos"
                :key="plano.id"
              >

                <td>
                  {{ plano.nome }}
                </td>

                <td>
                  {{ plano.operadora }}
                </td>

                <td>
                  {{ plano.empresas }}
                </td>

                <td>
                  {{ plano.vidas }}
                </td>

              </tr>

            </tbody>

          </v-table>

        </v-card>

      </v-col>


      <!-- Operadoras -->

      <v-col cols="12" md="5">

        <v-card height="100%">

          <v-card-title>
            Operadoras
          </v-card-title>

          <v-card-text>

            <div
              v-for="operadora in operadoras"
              :key="operadora.nome"
              class="mb-4"
            >

              <div class="d-flex justify-space-between mb-1">

                <span>
                  {{ operadora.nome }}
                </span>

                <span class="font-weight-medium">
                  {{ operadora.vidas }} vidas
                </span>

              </div>


              <v-progress-linear
                :model-value="operadora.percentual"
                height="8"
                rounded
              />

            </div>

          </v-card-text>

        </v-card>

      </v-col>

    </v-row>


    <!-- ========================= -->
    <!-- IMPLANTAÇÃO E PÓS-VENDA -->
    <!-- ========================= -->

    <v-row class="mt-2">


      <v-col cols="12" md="6">

        <v-card>

          <v-card-title>
            Implantação
          </v-card-title>

          <v-card-text>

            <v-row>

              <v-col cols="4">

                <div class="text-caption text-medium-emphasis">
                  Em andamento
                </div>

                <div class="text-h5">
                  5
                </div>

              </v-col>


              <v-col cols="4">

                <div class="text-caption text-medium-emphasis">
                  Concluídas
                </div>

                <div class="text-h5">
                  18
                </div>

              </v-col>


              <v-col cols="4">

                <div class="text-caption text-medium-emphasis">
                  Pendentes
                </div>

                <div class="text-h5">
                  1
                </div>

              </v-col>

            </v-row>

          </v-card-text>

        </v-card>

      </v-col>


      <v-col cols="12" md="6">

        <v-card>

          <v-card-title>
            Pós-venda
          </v-card-title>

          <v-card-text>

            <v-row>

              <v-col cols="4">

                <div class="text-caption text-medium-emphasis">
                  Atendimentos
                </div>

                <div class="text-h5">
                  12
                </div>

              </v-col>


              <v-col cols="4">

                <div class="text-caption text-medium-emphasis">
                  Em aberto
                </div>

                <div class="text-h5">
                  4
                </div>

              </v-col>


              <v-col cols="4">

                <div class="text-caption text-medium-emphasis">
                  Concluídos
                </div>

                <div class="text-h5">
                  8
                </div>

              </v-col>

            </v-row>

          </v-card-text>

        </v-card>

      </v-col>

    </v-row>

  </v-container>
</template>


<script setup lang="ts">

import KpiCard from '../components/dashboard/KpiCard.vue'
import Pipeline from '../components/dashboard/Pipeline.vue'


// ============================
// PLANOS
// ============================

const planos = [

  {
    id: 1,
    nome: 'Plano Empresarial',
    operadora: 'Bradesco Saúde',
    empresas: 8,
    vidas: 280
  },

  {
    id: 2,
    nome: 'Plano Executivo',
    operadora: 'SulAmérica',
    empresas: 6,
    vidas: 210
  },

  {
    id: 3,
    nome: 'Plano Premium',
    operadora: 'Amil',
    empresas: 5,
    vidas: 180
  },

  {
    id: 4,
    nome: 'Plano Corporativo',
    operadora: 'Unimed',
    empresas: 5,
    vidas: 172
  }

]


// ============================
// OPERADORAS
// ============================

const operadoras = [

  {
    nome: 'Bradesco Saúde',
    vidas: 280,
    percentual: 33
  },

  {
    nome: 'SulAmérica',
    vidas: 210,
    percentual: 25
  },

  {
    nome: 'Amil',
    vidas: 180,
    percentual: 21
  },

  {
    nome: 'Unimed',
    vidas: 172,
    percentual: 21
  }

]


function voltar() {

  window.history.back()

}

</script>

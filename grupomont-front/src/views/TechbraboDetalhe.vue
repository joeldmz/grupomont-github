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
          TechBrabo
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
          :value="15"
          :target="20"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Contratos"
          :value="8"
          :target="10"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Receita Pontual"
          :value="320000"
          :target="400000"
          type="currency"
        />

      </v-col>


      <v-col cols="12" sm="6" md="3">

        <KpiCard
          title="Receita Recorrente"
          :value="85000"
          :target="100000"
          type="currency"
        />

      </v-col>

    </v-row>


    <!-- ========================= -->
    <!-- PIPELINE DE PROJETOS -->
    <!-- ========================= -->

    <v-card class="mt-6">

      <v-card-title>
        Pipeline de Projetos
      </v-card-title>

      <v-card-text>

        <v-row>

          <v-col
            v-for="(etapa, index) in etapasProjeto"
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
                {{ etapa.quantidade }} projetos
              </div>

              <div class="text-caption mt-1">
                {{ formatarMoeda(etapa.valor) }}
              </div>

            </div>

          </v-col>

        </v-row>

      </v-card-text>

    </v-card>


    <!-- ========================= -->
    <!-- RECEITA -->
    <!-- ========================= -->

    <v-row class="mt-2">

      <!-- Receita -->

      <v-col cols="12" md="7">

        <v-card height="100%">

          <v-card-title>
            Composição da Receita
          </v-card-title>

          <v-card-text>

            <div class="mb-6">

              <div class="d-flex justify-space-between mb-2">

                <span>
                  Receita Pontual
                </span>

                <span class="font-weight-medium">
                  R$ 320K
                </span>

              </div>

              <v-progress-linear
                model-value="79"
                height="10"
                rounded
              />

            </div>


            <div>

              <div class="d-flex justify-space-between mb-2">

                <span>
                  Receita Recorrente
                </span>

                <span class="font-weight-medium">
                  R$ 85K
                </span>

              </div>

              <v-progress-linear
                model-value="21"
                height="10"
                rounded
              />

            </div>

          </v-card-text>

        </v-card>

      </v-col>


      <!-- Saúde da operação -->

      <v-col cols="12" md="5">

        <v-card height="100%">

          <v-card-title>
            Saúde da Operação
          </v-card-title>

          <v-card-text>

            <div class="d-flex align-center mb-5">

              <v-avatar
                size="52"
                color="success"
                variant="tonal"
                class="mr-4"
              >
                <v-icon>
                  mdi-check
                </v-icon>
              </v-avatar>

              <div>

                <div class="text-h6">
                  Saudável
                </div>

                <div class="text-caption text-medium-emphasis">
                  Operação dentro do esperado
                </div>

              </div>

            </div>


            <div class="mb-3">

              <div class="d-flex justify-space-between">

                <span class="text-caption">
                  Projetos no prazo
                </span>

                <span class="text-caption">
                  85%
                </span>

              </div>

              <v-progress-linear
                model-value="85"
                height="8"
                rounded
              />

            </div>


            <div>

              <div class="d-flex justify-space-between">

                <span class="text-caption">
                  Capacidade da equipe
                </span>

                <span class="text-caption">
                  78%
                </span>

              </div>

              <v-progress-linear
                model-value="78"
                height="8"
                rounded
              />

            </div>

          </v-card-text>

        </v-card>

      </v-col>

    </v-row>


    <!-- ========================= -->
    <!-- IMPLANTAÇÃO E ENTREGA -->
    <!-- ========================= -->

    <v-card class="mt-6">

      <v-card-title>
        Implantação e Entrega
      </v-card-title>

      <v-card-text>

        <v-row>

          <v-col cols="12" sm="6" md="3">

            <div class="text-caption text-medium-emphasis">
              Projetos em implantação
            </div>

            <div class="text-h5">
              3
            </div>

          </v-col>


          <v-col cols="12" sm="6" md="3">

            <div class="text-caption text-medium-emphasis">
              Projetos entregues
            </div>

            <div class="text-h5">
              12
            </div>

          </v-col>


          <v-col cols="12" sm="6" md="3">

            <div class="text-caption text-medium-emphasis">
              Projetos atrasados
            </div>

            <div class="text-h5">
              1
            </div>

          </v-col>


          <v-col cols="12" sm="6" md="3">

            <div class="text-caption text-medium-emphasis">
              Prazo médio
            </div>

            <div class="text-h5">
              42 dias
            </div>

          </v-col>

        </v-row>

      </v-card-text>

    </v-card>

  </v-container>
</template>


<script setup lang="ts">

import KpiCard from '../components/dashboard/KpiCard.vue'


const etapasProjeto = [

  {
    nome: 'Prospecção',
    quantidade: 6,
    valor: 180000
  },

  {
    nome: 'Proposta',
    quantidade: 4,
    valor: 250000
  },

  {
    nome: 'Contrato',
    quantidade: 2,
    valor: 120000
  },

  {
    nome: 'Implantação',
    quantidade: 3,
    valor: 210000
  }

]


function formatarMoeda(valor: number) {

  return valor.toLocaleString('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  })

}


function voltar() {

  window.history.back()

}

</script>

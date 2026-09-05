<template>
  <v-container fluid class="pa-0">
    <v-row dense class="gx-4">
      <v-col
        v-for="metric in metrics"
        :key="metric.title"
        cols="12"
        sm="6"
        md="3"
      >
        <v-card 
          class="pa-5 metric-card" 
          :class="`border-${metric.color}`"
          @click="$emit('button-click', metric)"
        >
          <v-row align="center" class="mb-3">
            <v-col cols="auto">
              <v-icon 
                :size="28" 
                :color="metric.color"
                class="mr-3"
              >
                {{ metric.icon }}
              </v-icon>
            </v-col>
            <v-col>
              <span class="text-caption text-uppercase font-weight-medium text-medium-emphasis">
                {{ metric.title }}
              </span>
            </v-col>
          </v-row>

          <div class="text-h4 font-weight-bold mb-1">
            {{ metric.value }}
          </div>

          <div class="d-flex align-center gap-2">
            <v-icon 
              v-if="metric.trend"
              :color="metric.trend.positive ? 'success' : 'error'"
              size="16"
            >
              {{ metric.trend.positive ? 'mdi-trending-up' : 'mdi-trending-down' }}
            </v-icon>
            <span 
              :class="[
                'text-caption',
                metric.trend?.positive ? 'text-success' : 'text-error',
                'font-weight-medium'
              ]"
            >
              {{ metric.subtitle }}
            </span>
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">

interface Props {
  data?: any
}

const props = defineProps<Props>()

const metrics = [
  {
    id: 1,
    title: 'INVESTIMENTO',
    value: 'R$ 38.500',
    subtitle: '↑ 12% período',
    trend: { value: '12%', positive: true },
    icon: 'mdi-currency-brl',
    color: 'primary'
  },
  {
    id: 2,
    title: 'LEADS',
    value: '1.250',
    subtitle: '89% da meta',
    icon: 'mdi-account-group',
    color: 'secondary'
  },
  {
    id: 3,
    title: 'OPORTUNIDADES',
    value: '180',
    subtitle: '90% da meta',
    icon: 'mdi-briefcase-outline',
    color: 'success'
  },
  {
    id: 4,
    title: 'CONVERSÃO',
    value: '14,4%',
    subtitle: 'Lead → Oport.',
    icon: 'mdi-chart-line',
    color: 'warning'
  }
]
</script>

<style scoped>
.metric-card {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  height: 100%;
  min-height: 140px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.metric-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12) !important;
}

.border-primary { border-left: 4px solid var(--v-primary-base); }
.border-secondary { border-left: 4px solid var(--v-secondary-base); }
.border-success { border-left: 4px solid var(--v-success-base); }
.border-warning { border-left: 4px solid var(--v-warning-base); }

@media (max-width: 599px) {
  .metric-card {
    min-height: 120px;
  }
}
</style>
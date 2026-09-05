<template>
    <v-card 
          class="pa-3 metric-card" 
          :class="`border-error`"
          style="height: 100%;"
        >
          <v-row align="center" class="mb-3">
            <v-col>
              <span class="text-caption">
                {{ 'Conversao' }}
              </span>
            </v-col>
          </v-row>

          <div style="font-weight: bolder; font-size: 16px;">
            %{{ percentaje }}
          </div>

          <div class="d-flex align-center gap-2 pt-5">
            <v-icon
              :color="Number(percentaje) >= 70  ? 'text-success' : 'text-error'"
              size="16"
              class="pr-2"
            >
              {{ Number(percentaje) >= 70 ?  'mdi-trending-up' :'mdi-trending-down' }}
            </v-icon>
            <span 
              :class="[
                'text-caption',
                Number(percentaje) >= 70  ? 'text-success' : 'text-error',
                'font-weight-medium'
              ]"
            >
              {{ 'Lead → Oportunidade'}}
            </span>
            <!-- <span 
              v-else 
              class="text-caption text-medium-emphasis"
            >
              {{ metric.subtitle }}
            </span> -->
          </div>
        </v-card>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  data?: any
}

const props = defineProps<Props>()

const percentaje = computed(() => {
  if(!props.data) return 0
  return parseInt(((props.data.value / props.data.target) * 100).toString())
})

const getIcon = computed(() => {
  return Number(percentaje) >= 50 ?  'mdi-trending-up' :'mdi-trending-down'
})

</script>
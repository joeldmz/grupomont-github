<template>
  <v-card
    style="height: 100%;"  
    class="mx-auto pa-4"
  >
    <v-card-text>
      <div style="font-size: 16px;">{{ props.title }}</div>

      <div class="text-headline-large font-weight-black mb-4">
        <span>{{ props.format === 'currency' ? 'R$ ' : '' }}</span>
        {{ props.value }}
       <span>{{  props.format === 'percentage' ? '%' : '' }}</span>
      </div>

      <div v-if="$slots.info || props.info" class="text-medium-emphasis">
        <slot name="info">
          <span v-if="typeof props.info === 'string'">{{ props.info }}</span>
          <component v-else-if="props.info" :is="props.info" />
        </slot>
      </div>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
import type { Component } from 'vue'

interface Props {
  title?: string,
  value?: number | string,
  info?: string | Component,
  format?: 'number' | 'currency' | 'percentage'
}

const props = defineProps<Props>()

</script>

<style scoped>
</style>

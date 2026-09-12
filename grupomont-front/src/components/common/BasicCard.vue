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

      <div v-if="props.info" class="text-medium-emphasis">
        {{ props.info }}
      </div>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">

interface Props {
  title?: string,
  value?: number,
  info?: string,
  format?: 'number' | 'currency' | 'percentage'
}

const props = defineProps<Props>()

</script>

<style scoped>
</style>

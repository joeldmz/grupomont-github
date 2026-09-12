<template>
  <v-card class="px-2" flat>
    <v-list density="compact" nav>
      <v-list-subheader class="text-subtitle-2 font-weight-bold" style="font-size: 20px; font-weight: bold;">
        {{ title }}
      </v-list-subheader>

      <template v-for="(item, index) in items" :key="item.label">
        <v-list-item class="px-2 py-1" density="compact">
          <template #default>
            <div class="w-100">
              <div class="d-flex justify-space-between align-center mb-1">
                <span class="text-body-2 font-weight-medium text-truncate">
                  {{ index + 1 }}. {{ item.label }}
                </span>
                <span class="text-body-2 text-medium-emphasis">
                  {{ item.value }}
                </span>
              </div>

              <v-progress-linear
                :model-value="item.percent"
                color="success"
                height="8"
                rounded
                bg-color="grey-lighten-1"
              />

              <div class="d-flex justify-space-between">
                <div></div>
                <div>R${{ item.total }}</div>
              </div>
            </div>
          </template>
        </v-list-item>
      </template>
    </v-list>
  </v-card>
</template>

<script setup lang="ts">
interface ListItem {
  label: string
  value: number
  percent: number
  total?: number
}

interface Props {
  title: string
  items: ListItem[]
}

withDefaults(defineProps<Props>(), {
  title: 'Lista'
})
</script>

<template>
  <v-card
    class="pa-3"
  >
    <div class="d-flex align-center justify-space-between px-1 pb-3">
      <div class="d-flex align-center ga-2">
        <span class="text-body-1 font-weight-medium">{{ title }}</span>

        <v-chip
          class="text-caption font-weight-medium"
          color="grey-darken-1"
          label
          size="small"
          variant="tonal"
        >
          {{ completedCount }}/{{ items.length }}
        </v-chip>
      </div>

      <v-btn
        aria-label="Expandir lista"
        icon="mdi-arrow-expand"
        size="x-small"
        variant="text"
      />
    </div>

    <v-list
      class="pa-0 d-flex flex-column ga-1"
      lines="one"
    >
      <v-list-item
        v-for="item in items"
        :key="item.label"
        class="px-3"
        :class="itemClass(item)"
        :disabled="item.disabled"
        rounded="md"
        @click="emit('select', item)"
      >
        <template #prepend>
          <v-icon
            :color="item.disabled ? undefined : item.completed ? 'primary' : 'grey-darken-1'"
            :icon="item.icon || 'mdi-checkbox-blank-circle-outline'"
            size="20"
          />
        </template>

        <v-list-item-title
          class="text-body-2"
          :class="{ 'text-decoration-line-through': item.completed }"
        >
          {{ item.label }}
        </v-list-item-title>

        <template #append>
          <v-icon
            v-if="item.completed"
            color="primary"
            icon="mdi-check"
            size="20"
          />
        </template>
      </v-list-item>
    </v-list>
  </v-card>
</template>

<script setup lang="ts">
import { computed } from 'vue'

export interface StatusListItem {
  label: string
  completed?: boolean
  disabled?: boolean
  icon?: string
}

interface Props {
  title?: string
  items?: StatusListItem[]
}

const props = withDefaults(defineProps<Props>(), {
  title: 'Production Checklist',
  items: () => [
    {
      label: 'Conectar repositório Git',
      icon: 'mdi-source-branch',
      completed: true,
    },
    {
      label: 'Adicionar domínio personalizado',
      icon: 'mdi-web',
    },
    {
      label: 'Preview do deployment',
      icon: 'mdi-cloud-search-outline',
      completed: true,
    },
    {
      label: 'Habilitar web analytics',
      icon: 'mdi-chart-line',
    },
    {
      label: 'Atualizar para Speed Insights Plus',
      icon: 'mdi-speedometer',
      disabled: true,
    },
  ],
})

const emit = defineEmits<{
  select: [item: StatusListItem]
}>()

const items = computed(() => props.items)
const completedCount = computed(() => items.value.filter((item) => item.completed).length)

const itemClass = (item: StatusListItem) => {
  if (item.disabled) return 'text-disabled'
  if (item.completed) return 'bg-blue-lighten-5 text-primary'
  return 'bg-grey-lighten-4'
}
</script>
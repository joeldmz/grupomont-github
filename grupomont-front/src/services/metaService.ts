import api from './api'
import type { MetaSummary } from '@/types/api'

export async function getMeta(params?: Record<string, unknown>): Promise<MetaSummary[]> {
  const response = await api.get<MetaSummary[]>('/meta', { params })
  return response.data
}
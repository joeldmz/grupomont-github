import api from './api'
import type { MontseguroClients } from '@/types/api'

export async function getTotalClientes(params?: Record<string, unknown>): Promise<MontseguroClients> {
  const response = await api.get<MontseguroClients>('/cliente/total', { params })
  return response.data
}

export async function getClientes(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/cliente', { params })
  return response.data
}
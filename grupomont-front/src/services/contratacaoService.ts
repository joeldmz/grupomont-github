import api from './api'
import type { ContractPeriod } from '@/types/api'

export async function getContratacaoByperiodo(params?: Record<string, unknown>): Promise<ContractPeriod[]> {
  const response = await api.get<ContractPeriod[]>('/contratacao/periodo', { params })
  return response.data
}

export async function getContratacaoByPlano(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/contratacao/plano', { params })
  return response.data
}

export async function getContratacaoByOperadora(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/contratacao/operadora', { params })
  return response.data
}
import api from './api'
import type { Prop5MainData } from '@/types/api'

export async function getMainData(params?: Record<string, unknown>): Promise<Prop5MainData> {
  const response = await api.get<Prop5MainData>('/operacao/main', { params })
  return response.data
}

export async function getOperacoes(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/operacao', { params })
  return response.data
}

export async function getOperacoesByCliente(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/operacao/cliente', { params })
  return response.data
}
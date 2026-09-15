import api from './api'
import type { FunilItem, HistoricoFunilItem } from '@/types/api'

export async function getFunilConsolidado(params?: Record<string, unknown>): Promise<FunilItem[]> {
  const response = await api.get<FunilItem[]>('/funil/consolidado', { params })
  return response.data
}

export async function getHistoricoFunilConsolidado(params?: Record<string, unknown>): Promise<HistoricoFunilItem[]> {
  const response = await api.get<HistoricoFunilItem[]>('/funil/consolidado/historico', { params })
  return response.data
}

export async function getHistoricoFunilByUnidade(params?: Record<string, unknown>): Promise<HistoricoFunilItem[]> {
  const response = await api.get<HistoricoFunilItem[]>('/funil/historico/unidade', { params })
  return response.data
}


/* export async function getLeadUnidade(): Promise<any[]> {
  const response = await api.get<any[]>('/leads/unidade')
  return response.data
} */

export async function getFunilByUnidade(params?: Record<string, unknown>): Promise<FunilItem[]> {
  const response = await api.get<FunilItem[]>('/funil/unidade', { params })
  return response.data
}
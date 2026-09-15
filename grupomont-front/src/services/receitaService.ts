import api from './api'
import type { ContractPeriod, RevenueByUnit } from '@/types/api'

export async function getTotalReceita(params?: Record<string, unknown>): Promise<RevenueByUnit[]> {
  const response = await api.get<RevenueByUnit[]>(`/receita/total`, { params })
  return response.data
}

export async function getTotalReceitaByUnidade(params?: Record<string, unknown>): Promise<RevenueByUnit> {
  const response = await api.get<RevenueByUnit>(`/receita/unidade`, { params })
  return response.data
}

export async function getValorMensalCarteria(params?: Record<string, unknown>): Promise<{ valor_mensal_carteira?: number | string | null }> {
  const response = await api.get<{ valor_mensal_carteira?: number | string | null }>(`/receita/carteira`, { params })
  return response.data
}

export async function getReceitaByPeriodo(params?: Record<string, unknown>): Promise<ContractPeriod[]> {
  const response = await api.get<ContractPeriod[]>(`/receita/periodo`, { params })
  return response.data
}
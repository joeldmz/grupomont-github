import api from './api'
import type { PipelineSummary } from '@/types/api'

export async function getReceitaOverview(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/receita')
  return response.data
}

export async function getReceitaUnidadeOverview(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/receita/unidade')
  return response.data
}

export async function getTaixaConversao(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/conversao')
  return response.data
}

//mantener
export async function getPipelineOportunidade(params?: Record<string, unknown>): Promise<PipelineSummary> {
  const response = await api.get<PipelineSummary>('/overview/pipeline', { params })
  return response.data
}


export async function getResultadosGerados(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/resultados')
  return response.data
}

//mantener
export async function getMarketingPerformance(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/overview/marketing/performance', { params })
  return response.data
}

//mantener
export async function getPipelineOportunidadeByUnidade(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/overview/pipeline/unidade', { params })
  return response.data
}
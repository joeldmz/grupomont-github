import api from './api'
import type { OportunidadeEquipe, PipelineSummary } from '@/types/api'


export async function getPipelineByUnidade(params?: Record<string, unknown>): Promise<PipelineSummary[]> {
  const response = await api.get<PipelineSummary[]>('/oportunidade/pipeline', { params })
  return response.data
}

export async function getTotalOportunidade(params?: Record<string, unknown>): Promise<PipelineSummary> {
  const response = await api.get<PipelineSummary>('/oportunidade/total', { params })
  return response.data
}

export async function getOportunidadeByUnidade(): Promise<OportunidadeEquipe[]> {
  const response = await api.get<OportunidadeEquipe[]>('/oportunidade/unidade')
  return response.data
}

export async function getOportunidadeByEquipe(params?: Record<string, unknown>): Promise<OportunidadeEquipe[]> {
  const response = await api.get<OportunidadeEquipe[]>('/oportunidade/equipe', { params })
  return response.data
}

export async function getOportunidadeAndEtapa(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/oportunidade/etapa', { params })
  return response.data
}
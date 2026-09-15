import api from './api'
import type { CampaignSummary } from '@/types/api'

export async function getTotalCampanhas(params?: Record<string, unknown>): Promise<CampaignSummary[]> {
  const response = await api.get<CampaignSummary[]>('/campanha/total', { params })
  return response.data
}

export async function getCampanhas(params?: Record<string, unknown>): Promise<CampaignSummary[]> {
  const response = await api.get<CampaignSummary[]>('/campanha', { params })
  return response.data
}

export async function getInfo(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/campanha/info', { params })
  return response.data
}

export async function getInvestimento(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/campanha/investimento', { params })
  return response.data
}

export async function getResultadoByCanal(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/campanha/canal', { params })
  return response.data
}
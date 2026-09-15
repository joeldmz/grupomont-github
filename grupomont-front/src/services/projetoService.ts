import api from './api'
import type { TechbraboMainKpis } from '@/types/api'

export async function getMainKpis(params?: Record<string, unknown>): Promise<TechbraboMainKpis> {
  const response = await api.get<TechbraboMainKpis>('/projeto/main', { params })
  return response.data
}

export async function getProjetos(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/projeto', { params })
  return response.data
}

export async function getDetalheProjeto(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/projeto/detalhe', { params })
  return response.data
}

export async function getProgresso(params?: Record<string, unknown>): Promise<Record<string, unknown>[]> {
  const response = await api.get<Record<string, unknown>[]>('/projeto/progresso', { params })
  return response.data
}
import api from './api'

export async function getMainKpis(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/projeto/main', { params })
  return response.data
}

export async function getProjetos(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/projeto', { params })
  return response.data
}

export async function getDetalheProjeto(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/projeto/detalhe', { params })
  return response.data
}
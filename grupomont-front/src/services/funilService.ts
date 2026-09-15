import api from './api'

export async function getFunilConsolidado(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/funil/consolidado', { params })
  return response.data
}

export async function getHistoricoFunilConsolidado(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/funil/consolidado/historico', { params })
  return response.data
}

export async function getHistoricoFunilByUnidade(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/funil/historico/unidade', { params })
  return response.data
}


/* export async function getLeadUnidade(): Promise<any[]> {
  const response = await api.get<any[]>('/leads/unidade')
  return response.data
} */

export async function getFunilByUnidade(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/funil/unidade', { params })
  return response.data
}
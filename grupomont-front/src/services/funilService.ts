import api from './api'

export async function getFunilConsolidado(): Promise<any[]> {
  const response = await api.get<any[]>('/funil/consolidado')
  return response.data
}

export async function getHistoricoFunilConsolidado(): Promise<any[]> {
  const response = await api.get<any[]>('/funil/consolidado/historico')
  return response.data
}

export async function getLeadUnidade(): Promise<any[]> {
  const response = await api.get<any[]>('/leads/unidade')
  return response.data
}
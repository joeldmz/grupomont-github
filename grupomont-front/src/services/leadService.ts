import api from './api'

export async function getTotalLead(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/leads/total', { params: params })
  return response.data
}

export async function getLeadUnidade(): Promise<any[]> {
  const response = await api.get<any[]>('/leads/unidade')
  return response.data
}
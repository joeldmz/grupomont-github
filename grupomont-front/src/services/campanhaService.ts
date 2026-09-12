import api from './api'

export async function getTotalCampanhas(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/campanha/total', { params: params })
  return response.data
}

export async function getCampanhas(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/campanha', { params: params })
  return response.data
}

export async function getInfo(params?: object): Promise<any[]> {
  const response = await api.get<any[]>('/campanha/info', { params: params })
  return response.data
}

export async function getInvestimento(params?: object): Promise<any[]> {
  const response = await api.get<any[]>('/campanha/investimento', { params: params })
  return response.data
}

export async function getResultadoByCanal(params?: object): Promise<any[]> {
  const response = await api.get<any[]>('/campanha/canal', { params: params })
  return response.data
}
import api from './api'


export async function getPipelineByUnidade(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/oportunidade/pipeline', { params: params })
  return response.data
}

export async function getTotalOportunidade(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/oportunidade/total', { params: params })
  return response.data
}

export async function getOportunidadeByUnidade(): Promise<any[]> {
  const response = await api.get<any[]>('/oportunidade/unidade')
  return response.data
}

export async function getOportunidadeByEquipe(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/oportunidade/equipe')
  return response.data
}
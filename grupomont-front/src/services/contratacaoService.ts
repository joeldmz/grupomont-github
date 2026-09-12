import api from './api'

export async function getContratacaoByperiodo(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/contratacao/periodo', { params })
  return response.data
}

export async function getContratacaoByPlano(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/contratacao/plano', { params })
  return response.data
}

export async function getContratacaoByOperadora(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/contratacao/operadora', { params })
  return response.data
}
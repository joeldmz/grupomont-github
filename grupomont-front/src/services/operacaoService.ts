import api from './api'

export async function getMainData(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/operacao/main', { params: params })
  return response.data
}

export async function getOperacoes(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/operacao', { params: params })
  return response.data
}

export async function getOperacoesByCliente(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/operacao/cliente', { params: params })
  return response.data
}
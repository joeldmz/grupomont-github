import api from './api'

export async function getTotalClientes(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/cliente/total', { params })
  return response.data
}

export async function getClientes(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/cliente', { params })
  return response.data
}
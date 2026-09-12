import api from './api'

export async function getMeta(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/meta', { params: params })
  return response.data
}
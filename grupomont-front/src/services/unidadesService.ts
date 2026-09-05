import api from './api'

export async function getOverview(): Promise<any[]> {

  const response = await api.get<any[]>('/overview/recita')

  return response.data

}

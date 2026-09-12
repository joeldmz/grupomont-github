import api from './api'

export async function getTotalReceita(params?: any): Promise<any> {
  const response = await api.get<any>(`/receita/total`, { params })
  return response.data
}

export async function getTotalReceitaByUnidade(params?: any): Promise<any> {
  const response = await api.get<any>(`/receita/unidade`, { params })
  return response.data
}

export async function getValorMensalCarteria(params?: any): Promise<any> {
  const response = await api.get<any>(`/receita/carteira`, { params })
  return response.data
}

export async function getReceitaByPeriodo(params?: any): Promise<any> {
  const response = await api.get<any>(`/receita/periodo`, { params })
  return response.data
}
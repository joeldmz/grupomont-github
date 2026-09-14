import api from './api'

export async function getReceitaOverview(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/receita')
  return response.data
}

export async function getReceitaUnidadeOverview(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/receita/unidade')
  return response.data
}

export async function getTaixaConversao(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/conversao')
  return response.data
}

//mantener
export async function getPipelineOportunidade(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/overview/pipeline', { params })
  return response.data
}


export async function getResultadosGerados(): Promise<any[]> {
  const response = await api.get<any[]>('/overview/resultados')
  return response.data
}

//mantener
export async function getMarketingPerformance(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/overview/marketing/performance', { params })
  return response.data
}

//mantener
export async function getPipelineOportunidadeByUnidade(params?: any): Promise<any[]> {
  const response = await api.get<any[]>('/overview/pipeline/unidade', { params })
  return response.data
}
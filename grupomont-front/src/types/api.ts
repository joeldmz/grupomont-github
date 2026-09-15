export type NumericValue = number | string | null

export interface DateRange {
  start_date: string
  end_date: string
}

export interface RevenueByUnit {
  receita_realizada?: NumericValue
  unidade_negocio?: string
  unidade_negocio_id?: number
  valor_total_oportunidades?: NumericValue
  quantidade_oportunidades?: NumericValue
  oportunidades_ganhas?: NumericValue
}

export interface CampaignSummary {
  investimento?: NumericValue
  leads?: NumericValue
  oportunidades?: NumericValue
  oportunidades_ganhas?: NumericValue
  unidade_negocio?: string
}

export interface PipelineSummary {
  pipeline?: NumericValue
  pipeline_ponderado?: NumericValue
  valor_potencial?: NumericValue
  valor_ponderado_abertas?: NumericValue
  valor_realizado?: NumericValue
  probabilidade_media_abertas?: NumericValue
  total_oportunidades?: NumericValue
  oportunidades_ganhas?: NumericValue
}

export interface MetaSummary {
  valor_meta?: NumericValue
}

export interface FunilItem {
  name?: string
  etapa?: string
  total?: NumericValue
  quantidade_clientes?: NumericValue
  probabilidade_media?: NumericValue
  ordem?: number
  unidade_negocio?: string
}

export interface HistoricoFunilItem extends FunilItem {
  total_oportunidades?: NumericValue
  oportunidades_ganhas?: NumericValue
  valor_ponderado?: NumericValue
  taxa_conversao?: NumericValue
  media_dias?: NumericValue
}

export interface OportunidadeEquipe {
  oportunidades?: NumericValue
  oportunidades_ganhas?: NumericValue
  [key: string]: unknown
}

export interface Prop5MainData {
  quantidade_clientes?: NumericValue
  pipeline_patrimonial?: NumericValue
  volume_transacionado?: NumericValue
  receita_realizada?: NumericValue
}

export interface TechbraboMainKpis {
  quantidade_clientes?: NumericValue
  quantidade_projetos?: NumericValue
  receita_pontual?: NumericValue
  receita_recorrente?: NumericValue
}

export interface MontseguroClients {
  clientes_ativos?: NumericValue
  vidas_ativas?: NumericValue
}

export interface MontseguroPortfolio {
  valor_mensal_carteira?: NumericValue
}

export interface ContractPeriod {
  mes?: string
  contratacoes?: NumericValue
  [key: string]: unknown
}

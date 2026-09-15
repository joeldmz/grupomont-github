# Grupo Mont — Executive Dashboard

Dashboard executivo desenvolvido como parte do desafio técnico do Grupo Mont.

O projeto tem como objetivo consolidar informações comerciais, financeiras e de marketing das três unidades de negócio do grupo — Montseguro, Prop5 Investimentos e TechBrabo — em uma visão executiva única.

A aplicação foi desenvolvida com foco em acompanhamento de resultados, análise do pipeline comercial, desempenho de marketing e comparação entre as unidades de negócio.

## Objetivo

O objetivo do projeto é disponibilizar uma visão centralizada dos principais indicadores do Grupo Mont, permitindo acompanhar:

- resultados financeiros e comerciais;
- desempenho em relação às metas;
- pipeline e oportunidades comerciais;
- taxas de conversão;
- desempenho das unidades de negócio;
- indicadores de Marketing;
- evolução dos resultados ao longo do tempo;
- principais pontos de atenção.

## Escopo

O dashboard contempla uma visão consolidada do grupo e visões específicas para cada unidade de negócio:

- **Montseguro** — comercialização e consultoria de planos de saúde corporativos;
- **Prop5 Investimentos** — consultoria de investimentos e operações patrimoniais;
- **TechBrabo** — projetos e serviços de tecnologia B2B.

A solução foi desenvolvida como um MVP, priorizando os principais indicadores e fluxos necessários para demonstrar a proposta do dashboard executivo.

## Visão geral

O dashboard está organizado em diferentes perspectivas de análise:

- **Visão Executiva** — acompanhamento consolidado do grupo;
- **Comercial** — análise do funil, oportunidades e pipeline;
- **Marketing** — acompanhamento de investimentos, leads e oportunidades;
- **Empresas** — detalhamento individual das unidades de negócio;
- **Insights** — identificação de pontos de atenção e informações relevantes para análise.

## Tecnologias utilizadas

### Frontend

- Vue 3
- TypeScript
- Vuetify
- Axios
- ApexCharts
- Vite

### Backend

- Node.js
- Express
- PostgreSQL

### Banco de dados

- Supabase
- PostgreSQL

### Desenvolvimento

- Git
- GitHub

## Arquitetura

A aplicação utiliza uma arquitetura simples, separando a camada de apresentação, a API e o banco de dados.

```text
┌─────────────────────────────┐
│        Frontend             │
│     Vue 3 + Vuetify         │
│     TypeScript + Vite       │
└──────────────┬──────────────┘
               │
             Axios
               │
               ▼
┌─────────────────────────────┐
│         Backend             │
│       Node.js + Express     │
│          API REST           │
└──────────────┬──────────────┘
               │
              SQL
               │
               ▼
┌─────────────────────────────┐
│       Banco de dados        │
│    PostgreSQL / Supabase    │
└─────────────────────────────┘
```

### Estrutura do projeto

O projeto está dividido em duas aplicações independentes: frontend e backend.

```text
grupomont/
│
├── grupomont-front/
│   ├── src/
│   │   ├── assets/
│   │   ├── components/
│   │   ├── composables/
│   │   ├── router/
│   │   ├── services/
│   │   ├── types/
│   │   ├── views/
│   │   ├── App.vue
│   │   └── main.ts
│   │
│   ├── public/
│   ├── index.html
│   ├── vite.config.ts
│   ├── tsconfig.json
│   └── package.json
│
├── grupomont-back/
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── routes/
│   │   ├── app.js
│   │   └── server.js
│   │
│   ├── package.json
│   └── package-lock.json
│
├── database/
│   ├── schema.sql
│   ├── views.sql
│   └── seed.sql
│
└── README.md
```

## Banco de dados

O projeto utiliza PostgreSQL, hospedado através do Supabase.

O banco de dados foi estruturado para suportar os diferentes modelos de negócio do Grupo Mont, contemplando informações de clientes, leads, campanhas, oportunidades, etapas do funil, metas e resultados.

Também foram criadas views para facilitar a consolidação e consulta dos dados utilizados pelo dashboard.

As principais views utilizadas são:

- `vw_funil_consolidado`
- `vw_funil_historico`
- `vw_oportunidade_receita`

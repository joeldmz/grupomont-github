--
-- PostgreSQL database dump
--

\restrict hfHmT810c3gJQwEi7OEUKIIQqAdco0b6hC78fYkTb3gwsI1pw8zOjpPZRR1lzVU

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: atendimento_pos_venda; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.atendimento_pos_venda (
    id bigint NOT NULL,
    contratacao_id bigint NOT NULL,
    consultor_id bigint,
    tipo character varying(50) NOT NULL,
    descricao text,
    status character varying(30) NOT NULL,
    data_abertura timestamp without time zone NOT NULL,
    data_conclusao timestamp without time zone
);


--
-- Name: atendimento_pos_venda_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.atendimento_pos_venda_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: atendimento_pos_venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.atendimento_pos_venda_id_seq OWNED BY public.atendimento_pos_venda.id;


--
-- Name: campanha; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campanha (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    data_inicio date,
    data_fim date,
    investimento numeric(14,2) DEFAULT 0 NOT NULL,
    status character varying(30) DEFAULT 'Ativa'::character varying NOT NULL,
    unidade_negocio_id bigint,
    CONSTRAINT chk_campanha_investimento CHECK ((investimento >= (0)::numeric))
);


--
-- Name: campanha_canal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campanha_canal (
    campanha_id bigint NOT NULL,
    canal_id bigint NOT NULL
);


--
-- Name: campanha_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campanha_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campanha_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campanha_id_seq OWNED BY public.campanha.id;


--
-- Name: canal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canal (
    id bigint NOT NULL,
    nome character varying(100) NOT NULL,
    tipo character varying(50),
    status character varying(30) DEFAULT 'Ativo'::character varying NOT NULL
);


--
-- Name: canal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.canal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: canal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.canal_id_seq OWNED BY public.canal.id;


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cliente (
    id bigint NOT NULL,
    cnpj character varying(18),
    razao_social character varying(150) NOT NULL,
    segmento character varying(100),
    quantidade_funcionarios integer,
    cidade character varying(100),
    estado character(2),
    data_cadastro date NOT NULL,
    status character varying(30) DEFAULT 'Ativa'::character varying NOT NULL,
    tipo_cliente character varying(2) DEFAULT 'PJ'::character varying NOT NULL,
    cpf character varying(14),
    data_nascimento date,
    pais_residencia character varying(100),
    CONSTRAINT chk_empresa_funcionarios CHECK ((quantidade_funcionarios >= 0))
);


--
-- Name: consultor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.consultor (
    id bigint NOT NULL,
    equipe_id bigint,
    nome character varying(150) NOT NULL,
    email character varying(150),
    status character varying(30) DEFAULT 'Ativo'::character varying NOT NULL,
    data_entrada date
);


--
-- Name: consultor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.consultor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: consultor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.consultor_id_seq OWNED BY public.consultor.id;


--
-- Name: contratacao; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contratacao (
    id bigint NOT NULL,
    oportunidade_id bigint NOT NULL,
    plano_id bigint NOT NULL,
    data_contratacao date NOT NULL,
    quantidade_vidas integer NOT NULL,
    valor_mensal_plano numeric(14,2) NOT NULL,
    status character varying(30) DEFAULT 'Ativa'::character varying NOT NULL,
    cliente_id bigint NOT NULL,
    CONSTRAINT chk_contratacao_valor CHECK ((valor_mensal_plano >= (0)::numeric)),
    CONSTRAINT chk_contratacao_vidas CHECK ((quantidade_vidas > 0))
);


--
-- Name: contratacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contratacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contratacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contratacao_id_seq OWNED BY public.contratacao.id;


--
-- Name: contrato; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contrato (
    id bigint NOT NULL,
    oportunidade_id bigint NOT NULL,
    numero_contrato character varying(50),
    valor_contrato numeric(14,2) NOT NULL,
    tipo_contrato character varying(50) NOT NULL,
    data_assinatura date,
    data_inicio date,
    data_fim date,
    status character varying(30) DEFAULT 'Ativo'::character varying,
    tipo_cobranca character varying,
    cliente_id bigint NOT NULL
);


--
-- Name: contrato_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contrato_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contrato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contrato_id_seq OWNED BY public.contrato.id;


--
-- Name: empresa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.empresa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: empresa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.empresa_id_seq OWNED BY public.cliente.id;


--
-- Name: equipe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipe (
    id bigint NOT NULL,
    nome character varying(100) NOT NULL,
    status character varying(30) DEFAULT 'Ativa'::character varying NOT NULL
);


--
-- Name: equipe_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.equipe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.equipe_id_seq OWNED BY public.equipe.id;


--
-- Name: etapa_funil; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.etapa_funil (
    id bigint NOT NULL,
    nome character varying(100) NOT NULL,
    ordem integer NOT NULL,
    unidade_negocio_id bigint,
    tempo_estimado bigint,
    CONSTRAINT chk_etapa_ordem CHECK ((ordem > 0))
);


--
-- Name: etapa_funil_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.etapa_funil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: etapa_funil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.etapa_funil_id_seq OWNED BY public.etapa_funil.id;


--
-- Name: historico_oportunidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.historico_oportunidade (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    data_entrada timestamp without time zone,
    data_saida timestamp without time zone,
    oportunidade_id bigint,
    etapa_id bigint
);


--
-- Name: historico_oportunidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.historico_oportunidade ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.historico_oportunidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: lead; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lead (
    id bigint NOT NULL,
    cliente_id bigint,
    campanha_id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    email character varying(150),
    telefone character varying(30),
    data_entrada date NOT NULL,
    status character varying(30) DEFAULT 'Novo'::character varying NOT NULL,
    unidade_negocio_id bigint,
    canal_id bigint
);


--
-- Name: lead_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lead_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lead_id_seq OWNED BY public.lead.id;


--
-- Name: meta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meta (
    id bigint NOT NULL,
    unidade_negocio_id bigint NOT NULL,
    tipo_meta character varying(50) NOT NULL,
    periodo_inicio date NOT NULL,
    periodo_fim date NOT NULL,
    valor_meta numeric(14,2) NOT NULL,
    campanha_id bigint
);


--
-- Name: meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meta_id_seq OWNED BY public.meta.id;


--
-- Name: objetivo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.objetivo (
    id bigint NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text
);


--
-- Name: objetivo_patrimonial_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.objetivo_patrimonial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: objetivo_patrimonial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.objetivo_patrimonial_id_seq OWNED BY public.objetivo.id;


--
-- Name: operacao_patrimonial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.operacao_patrimonial (
    id bigint NOT NULL,
    oportunidade_id bigint NOT NULL,
    tipo_operacao character varying(100) NOT NULL,
    valor_operacao numeric(14,2) NOT NULL,
    data_inicio date,
    data_conclusao date,
    status character varying(30) DEFAULT 'Em andamento'::character varying,
    data_previsao_conclusao date,
    cliente_id bigint NOT NULL,
    comissao numeric,
    CONSTRAINT chk_operacao_comissao CHECK (((comissao IS NULL) OR (comissao >= (0)::numeric)))
);


--
-- Name: TABLE operacao_patrimonial; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.operacao_patrimonial IS 'Refiere a la operacion que realiza despues de avanzar/cerrar la oportunidad';


--
-- Name: operacao_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.operacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: operacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.operacao_id_seq OWNED BY public.operacao_patrimonial.id;


--
-- Name: operadora; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.operadora (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    status character varying(30) DEFAULT 'Ativa'::character varying NOT NULL
);


--
-- Name: operadora_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.operadora_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: operadora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.operadora_id_seq OWNED BY public.operadora.id;


--
-- Name: oportunidade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oportunidade (
    id bigint NOT NULL,
    cliente_id bigint NOT NULL,
    consultor_id bigint,
    campanha_id bigint,
    plano_id bigint,
    etapa_id bigint NOT NULL,
    status character varying(30) DEFAULT 'Aberta'::character varying NOT NULL,
    valor_estimado numeric(14,2),
    probabilidade numeric(5,2),
    data_criacao date NOT NULL,
    data_previsao_fechamento date,
    data_fechamento date,
    lead_id bigint,
    quantidade_vidas_estimada integer,
    objetivo_patrimonial_id bigint,
    estrategia character varying(100),
    tipo_solucao character varying(100),
    escopo text,
    unidade_negocio_id bigint,
    CONSTRAINT chk_oportunidade_probabilidade CHECK (((probabilidade IS NULL) OR ((probabilidade >= (0)::numeric) AND (probabilidade <= (100)::numeric)))),
    CONSTRAINT chk_oportunidade_valor CHECK (((valor_estimado IS NULL) OR (valor_estimado >= (0)::numeric)))
);


--
-- Name: oportunidade_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oportunidade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oportunidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oportunidade_id_seq OWNED BY public.oportunidade.id;


--
-- Name: plano_saude; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plano_saude (
    id bigint NOT NULL,
    operadora_id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    tipo character varying(50),
    acomodacao character varying(50),
    coparticipacao boolean,
    abrangencia character varying(100)
);


--
-- Name: plano_saude_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plano_saude_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plano_saude_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plano_saude_id_seq OWNED BY public.plano_saude.id;


--
-- Name: projeto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projeto (
    id bigint NOT NULL,
    contrato_id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    descricao text,
    data_inicio date,
    data_previsao_entrega date,
    data_entrega date,
    valor_projeto numeric(14,2),
    status character varying(30) DEFAULT 'Planejado'::character varying,
    equipe_id bigint
);


--
-- Name: projeto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projeto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projeto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projeto_id_seq OWNED BY public.projeto.id;


--
-- Name: receita; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.receita (
    id bigint NOT NULL,
    contratacao_id bigint,
    data date NOT NULL,
    valor numeric(14,2) NOT NULL,
    tipo character varying(50) NOT NULL,
    status character varying(30) DEFAULT 'Prevista'::character varying NOT NULL,
    contrato_id bigint,
    unidade_negocio_id bigint,
    operacao_id bigint,
    oportunidade_id bigint,
    CONSTRAINT chk_receita_valor CHECK ((valor >= (0)::numeric))
);


--
-- Name: receita_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.receita_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receita_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.receita_id_seq OWNED BY public.receita.id;


--
-- Name: unidade_negocio; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unidade_negocio (
    id bigint NOT NULL,
    nome character varying(100) NOT NULL
);


--
-- Name: unidade_negocio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unidade_negocio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unidade_negocio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unidade_negocio_id_seq OWNED BY public.unidade_negocio.id;


--
-- Name: vw_funil_consolidado; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_funil_consolidado AS
 SELECT o.id AS oportunidade_id,
    o.unidade_negocio_id,
    o.etapa_id,
    ef.nome AS etapa_original,
    ef.tempo_estimado,
        CASE
            WHEN (ef.id = ANY (ARRAY[(1)::bigint, (9)::bigint, (18)::bigint])) THEN 'Qualificação'::text
            WHEN (ef.id = ANY (ARRAY[(2)::bigint, (10)::bigint, (11)::bigint, (19)::bigint, (20)::bigint])) THEN 'Diagnóstico'::text
            WHEN (ef.id = ANY (ARRAY[(3)::bigint, (4)::bigint, (12)::bigint, (13)::bigint, (21)::bigint])) THEN 'Proposta'::text
            WHEN (ef.id = ANY (ARRAY[(14)::bigint, (22)::bigint])) THEN 'Negociação'::text
            WHEN (ef.id = ANY (ARRAY[(5)::bigint, (16)::bigint, (23)::bigint])) THEN 'Fechamento'::text
            WHEN (ef.id = ANY (ARRAY[(6)::bigint, (7)::bigint, (15)::bigint, (24)::bigint, (25)::bigint])) THEN 'Entrega / Ativação'::text
            WHEN (ef.id = ANY (ARRAY[(8)::bigint, (17)::bigint, (26)::bigint])) THEN 'Pós-venda'::text
            ELSE 'Outros'::text
        END AS etapa_consolidada,
        CASE
            WHEN (ef.id = ANY (ARRAY[(1)::bigint, (9)::bigint, (18)::bigint])) THEN 1
            WHEN (ef.id = ANY (ARRAY[(2)::bigint, (10)::bigint, (11)::bigint, (19)::bigint, (20)::bigint])) THEN 2
            WHEN (ef.id = ANY (ARRAY[(3)::bigint, (4)::bigint, (12)::bigint, (13)::bigint, (21)::bigint])) THEN 3
            WHEN (ef.id = ANY (ARRAY[(14)::bigint, (22)::bigint])) THEN 4
            WHEN (ef.id = ANY (ARRAY[(5)::bigint, (16)::bigint, (23)::bigint])) THEN 5
            WHEN (ef.id = ANY (ARRAY[(6)::bigint, (7)::bigint, (15)::bigint, (24)::bigint, (25)::bigint])) THEN 6
            WHEN (ef.id = ANY (ARRAY[(8)::bigint, (17)::bigint, (26)::bigint])) THEN 7
            ELSE 99
        END AS ordem_consolidada,
    o.status,
    o.valor_estimado,
    o.probabilidade,
    o.data_criacao,
    o.data_previsao_fechamento,
    o.data_fechamento
   FROM (public.oportunidade o
     JOIN public.etapa_funil ef ON ((ef.id = o.etapa_id)));


--
-- Name: vw_funil_historico; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_funil_historico AS
 SELECT h.id AS historico_id,
    h.oportunidade_id,
    o.unidade_negocio_id,
    o.campanha_id,
    h.etapa_id,
    ef.nome AS etapa_original,
    ef.tempo_estimado,
        CASE
            WHEN (ef.id = ANY (ARRAY[(1)::bigint, (9)::bigint, (18)::bigint])) THEN 'Qualificação'::text
            WHEN (ef.id = ANY (ARRAY[(2)::bigint, (10)::bigint, (11)::bigint, (19)::bigint, (20)::bigint])) THEN 'Diagnóstico'::text
            WHEN (ef.id = ANY (ARRAY[(3)::bigint, (4)::bigint, (12)::bigint, (13)::bigint, (21)::bigint])) THEN 'Proposta'::text
            WHEN (ef.id = ANY (ARRAY[(14)::bigint, (22)::bigint])) THEN 'Negociação'::text
            WHEN (ef.id = ANY (ARRAY[(5)::bigint, (16)::bigint, (23)::bigint])) THEN 'Fechamento'::text
            WHEN (ef.id = ANY (ARRAY[(6)::bigint, (7)::bigint, (15)::bigint, (24)::bigint, (25)::bigint])) THEN 'Entrega / Ativação'::text
            WHEN (ef.id = ANY (ARRAY[(8)::bigint, (17)::bigint, (26)::bigint])) THEN 'Pós-venda'::text
            ELSE 'Outros'::text
        END AS etapa_consolidada,
        CASE
            WHEN (ef.id = ANY (ARRAY[(1)::bigint, (9)::bigint, (18)::bigint])) THEN 1
            WHEN (ef.id = ANY (ARRAY[(2)::bigint, (10)::bigint, (11)::bigint, (19)::bigint, (20)::bigint])) THEN 2
            WHEN (ef.id = ANY (ARRAY[(3)::bigint, (4)::bigint, (12)::bigint, (13)::bigint, (21)::bigint])) THEN 3
            WHEN (ef.id = ANY (ARRAY[(14)::bigint, (22)::bigint])) THEN 4
            WHEN (ef.id = ANY (ARRAY[(5)::bigint, (16)::bigint, (23)::bigint])) THEN 5
            WHEN (ef.id = ANY (ARRAY[(6)::bigint, (7)::bigint, (15)::bigint, (24)::bigint, (25)::bigint])) THEN 6
            WHEN (ef.id = ANY (ARRAY[(8)::bigint, (17)::bigint, (26)::bigint])) THEN 7
            ELSE 99
        END AS ordem_consolidada,
    h.data_entrada,
    h.data_saida,
        CASE
            WHEN (h.data_saida IS NOT NULL) THEN (EXTRACT(epoch FROM (h.data_saida - h.data_entrada)) / (86400)::numeric)
            ELSE NULL::numeric
        END AS dias_na_etapa
   FROM ((public.historico_oportunidade h
     JOIN public.oportunidade o ON ((o.id = h.oportunidade_id)))
     JOIN public.etapa_funil ef ON ((ef.id = h.etapa_id)));


--
-- Name: vw_oportunidade_receita; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_oportunidade_receita AS
 SELECT o.id AS oportunidade_id,
    o.unidade_negocio_id,
    o.campanha_id,
    'Contratação'::text AS origem,
    c.id AS origem_id,
    c.valor_mensal_plano,
    c.data_contratacao
   FROM (public.oportunidade o
     JOIN public.contratacao c ON ((c.oportunidade_id = o.id)))
UNION ALL
 SELECT o.id AS oportunidade_id,
    o.unidade_negocio_id,
    o.campanha_id,
    'Operação Patrimonial'::text AS origem,
    op.id AS origem_id,
    op.valor_operacao AS valor_mensal_plano,
    op.data_inicio AS data_contratacao
   FROM (public.oportunidade o
     JOIN public.operacao_patrimonial op ON ((op.oportunidade_id = o.id)))
UNION ALL
 SELECT o.id AS oportunidade_id,
    o.unidade_negocio_id,
    o.campanha_id,
    'Projeto'::text AS origem,
    p.id AS origem_id,
    p.valor_projeto AS valor_mensal_plano,
    p.data_inicio AS data_contratacao
   FROM ((public.oportunidade o
     JOIN public.contrato ct ON ((ct.oportunidade_id = o.id)))
     JOIN public.projeto p ON ((p.contrato_id = ct.id)));


--
-- Name: atendimento_pos_venda id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimento_pos_venda ALTER COLUMN id SET DEFAULT nextval('public.atendimento_pos_venda_id_seq'::regclass);


--
-- Name: campanha id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanha ALTER COLUMN id SET DEFAULT nextval('public.campanha_id_seq'::regclass);


--
-- Name: canal id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canal ALTER COLUMN id SET DEFAULT nextval('public.canal_id_seq'::regclass);


--
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.empresa_id_seq'::regclass);


--
-- Name: consultor id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consultor ALTER COLUMN id SET DEFAULT nextval('public.consultor_id_seq'::regclass);


--
-- Name: contratacao id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contratacao ALTER COLUMN id SET DEFAULT nextval('public.contratacao_id_seq'::regclass);


--
-- Name: contrato id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contrato ALTER COLUMN id SET DEFAULT nextval('public.contrato_id_seq'::regclass);


--
-- Name: equipe id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipe ALTER COLUMN id SET DEFAULT nextval('public.equipe_id_seq'::regclass);


--
-- Name: etapa_funil id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etapa_funil ALTER COLUMN id SET DEFAULT nextval('public.etapa_funil_id_seq'::regclass);


--
-- Name: lead id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead ALTER COLUMN id SET DEFAULT nextval('public.lead_id_seq'::regclass);


--
-- Name: meta id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meta ALTER COLUMN id SET DEFAULT nextval('public.meta_id_seq'::regclass);


--
-- Name: objetivo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.objetivo ALTER COLUMN id SET DEFAULT nextval('public.objetivo_patrimonial_id_seq'::regclass);


--
-- Name: operacao_patrimonial id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operacao_patrimonial ALTER COLUMN id SET DEFAULT nextval('public.operacao_id_seq'::regclass);


--
-- Name: operadora id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operadora ALTER COLUMN id SET DEFAULT nextval('public.operadora_id_seq'::regclass);


--
-- Name: oportunidade id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade ALTER COLUMN id SET DEFAULT nextval('public.oportunidade_id_seq'::regclass);


--
-- Name: plano_saude id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_saude ALTER COLUMN id SET DEFAULT nextval('public.plano_saude_id_seq'::regclass);


--
-- Name: projeto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projeto ALTER COLUMN id SET DEFAULT nextval('public.projeto_id_seq'::regclass);


--
-- Name: receita id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita ALTER COLUMN id SET DEFAULT nextval('public.receita_id_seq'::regclass);


--
-- Name: unidade_negocio id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade_negocio ALTER COLUMN id SET DEFAULT nextval('public.unidade_negocio_id_seq'::regclass);


--
-- Name: atendimento_pos_venda atendimento_pos_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimento_pos_venda
    ADD CONSTRAINT atendimento_pos_venda_pkey PRIMARY KEY (id);


--
-- Name: campanha_canal campanha_canal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanha_canal
    ADD CONSTRAINT campanha_canal_pkey PRIMARY KEY (campanha_id, canal_id);


--
-- Name: campanha campanha_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanha
    ADD CONSTRAINT campanha_pkey PRIMARY KEY (id);


--
-- Name: canal canal_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT canal_nome_key UNIQUE (nome);


--
-- Name: canal canal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT canal_pkey PRIMARY KEY (id);


--
-- Name: consultor consultor_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consultor
    ADD CONSTRAINT consultor_email_key UNIQUE (email);


--
-- Name: consultor consultor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consultor
    ADD CONSTRAINT consultor_pkey PRIMARY KEY (id);


--
-- Name: contratacao contratacao_oportunidade_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contratacao
    ADD CONSTRAINT contratacao_oportunidade_id_key UNIQUE (oportunidade_id);


--
-- Name: contratacao contratacao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contratacao
    ADD CONSTRAINT contratacao_pkey PRIMARY KEY (id);


--
-- Name: contrato contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT contrato_pkey PRIMARY KEY (id);


--
-- Name: cliente empresa_cnpj_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT empresa_cnpj_key UNIQUE (cnpj);


--
-- Name: cliente empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id);


--
-- Name: equipe equipe_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipe
    ADD CONSTRAINT equipe_pkey PRIMARY KEY (id);


--
-- Name: etapa_funil etapa_funil_funil_ordem_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etapa_funil
    ADD CONSTRAINT etapa_funil_funil_ordem_key UNIQUE (unidade_negocio_id, ordem);


--
-- Name: etapa_funil etapa_funil_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etapa_funil
    ADD CONSTRAINT etapa_funil_pkey PRIMARY KEY (id);


--
-- Name: historico_oportunidade historico_oportunidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historico_oportunidade
    ADD CONSTRAINT historico_oportunidade_pkey PRIMARY KEY (id);


--
-- Name: lead lead_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT lead_pkey PRIMARY KEY (id);


--
-- Name: meta meta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meta
    ADD CONSTRAINT meta_pkey PRIMARY KEY (id);


--
-- Name: objetivo objetivo_patrimonial_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.objetivo
    ADD CONSTRAINT objetivo_patrimonial_pkey PRIMARY KEY (id);


--
-- Name: operacao_patrimonial operacao_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operacao_patrimonial
    ADD CONSTRAINT operacao_pkey PRIMARY KEY (id);


--
-- Name: operadora operadora_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operadora
    ADD CONSTRAINT operadora_nome_key UNIQUE (nome);


--
-- Name: operadora operadora_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operadora
    ADD CONSTRAINT operadora_pkey PRIMARY KEY (id);


--
-- Name: oportunidade oportunidade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT oportunidade_pkey PRIMARY KEY (id);


--
-- Name: plano_saude plano_saude_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_saude
    ADD CONSTRAINT plano_saude_pkey PRIMARY KEY (id);


--
-- Name: projeto projeto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projeto
    ADD CONSTRAINT projeto_pkey PRIMARY KEY (id);


--
-- Name: receita receita_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT receita_pkey PRIMARY KEY (id);


--
-- Name: unidade_negocio unidade_negocio_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade_negocio
    ADD CONSTRAINT unidade_negocio_nome_key UNIQUE (nome);


--
-- Name: unidade_negocio unidade_negocio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unidade_negocio
    ADD CONSTRAINT unidade_negocio_pkey PRIMARY KEY (id);


--
-- Name: idx_contratacao_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_contratacao_data ON public.contratacao USING btree (data_contratacao);


--
-- Name: idx_lead_campanha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lead_campanha ON public.lead USING btree (campanha_id);


--
-- Name: idx_lead_empresa; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lead_empresa ON public.lead USING btree (cliente_id);


--
-- Name: idx_operacao_cliente; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_operacao_cliente ON public.operacao_patrimonial USING btree (cliente_id);


--
-- Name: idx_operacao_oportunidade; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_operacao_oportunidade ON public.operacao_patrimonial USING btree (oportunidade_id);


--
-- Name: idx_oportunidade_campanha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oportunidade_campanha ON public.oportunidade USING btree (campanha_id);


--
-- Name: idx_oportunidade_consultor; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oportunidade_consultor ON public.oportunidade USING btree (consultor_id);


--
-- Name: idx_oportunidade_empresa; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oportunidade_empresa ON public.oportunidade USING btree (cliente_id);


--
-- Name: idx_oportunidade_etapa; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oportunidade_etapa ON public.oportunidade USING btree (etapa_id);


--
-- Name: idx_oportunidade_lead; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oportunidade_lead ON public.oportunidade USING btree (lead_id);


--
-- Name: idx_oportunidade_unidade_negocio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oportunidade_unidade_negocio ON public.oportunidade USING btree (unidade_negocio_id);


--
-- Name: idx_receita_contratacao; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_receita_contratacao ON public.receita USING btree (contratacao_id);


--
-- Name: idx_receita_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_receita_data ON public.receita USING btree (data);


--
-- Name: campanha campanha_unidade_negocio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanha
    ADD CONSTRAINT campanha_unidade_negocio_id_fkey FOREIGN KEY (unidade_negocio_id) REFERENCES public.unidade_negocio(id);


--
-- Name: contratacao contratacao_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contratacao
    ADD CONSTRAINT contratacao_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: contrato contrato_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT contrato_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: etapa_funil etapa_funil_unidade_negocio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.etapa_funil
    ADD CONSTRAINT etapa_funil_unidade_negocio_id_fkey FOREIGN KEY (unidade_negocio_id) REFERENCES public.unidade_negocio(id);


--
-- Name: campanha_canal fk_campanha_canal_campanha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanha_canal
    ADD CONSTRAINT fk_campanha_canal_campanha FOREIGN KEY (campanha_id) REFERENCES public.campanha(id);


--
-- Name: campanha_canal fk_campanha_canal_canal; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanha_canal
    ADD CONSTRAINT fk_campanha_canal_canal FOREIGN KEY (canal_id) REFERENCES public.canal(id);


--
-- Name: consultor fk_consultor_equipe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consultor
    ADD CONSTRAINT fk_consultor_equipe FOREIGN KEY (equipe_id) REFERENCES public.equipe(id);


--
-- Name: contratacao fk_contratacao_oportunidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contratacao
    ADD CONSTRAINT fk_contratacao_oportunidade FOREIGN KEY (oportunidade_id) REFERENCES public.oportunidade(id);


--
-- Name: contratacao fk_contratacao_plano; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contratacao
    ADD CONSTRAINT fk_contratacao_plano FOREIGN KEY (plano_id) REFERENCES public.plano_saude(id);


--
-- Name: contrato fk_contrato_oportunidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT fk_contrato_oportunidade FOREIGN KEY (oportunidade_id) REFERENCES public.oportunidade(id);


--
-- Name: lead fk_lead_campanha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT fk_lead_campanha FOREIGN KEY (campanha_id) REFERENCES public.campanha(id);


--
-- Name: lead fk_lead_canal; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT fk_lead_canal FOREIGN KEY (canal_id) REFERENCES public.canal(id);


--
-- Name: lead fk_lead_empresa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT fk_lead_empresa FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: meta fk_meta_unidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meta
    ADD CONSTRAINT fk_meta_unidade FOREIGN KEY (unidade_negocio_id) REFERENCES public.unidade_negocio(id);


--
-- Name: operacao_patrimonial fk_operacao_oportunidade; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operacao_patrimonial
    ADD CONSTRAINT fk_operacao_oportunidade FOREIGN KEY (oportunidade_id) REFERENCES public.oportunidade(id);


--
-- Name: oportunidade fk_oportunidade_campanha; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT fk_oportunidade_campanha FOREIGN KEY (campanha_id) REFERENCES public.campanha(id);


--
-- Name: oportunidade fk_oportunidade_consultor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT fk_oportunidade_consultor FOREIGN KEY (consultor_id) REFERENCES public.consultor(id);


--
-- Name: oportunidade fk_oportunidade_empresa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT fk_oportunidade_empresa FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: oportunidade fk_oportunidade_etapa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT fk_oportunidade_etapa FOREIGN KEY (etapa_id) REFERENCES public.etapa_funil(id);


--
-- Name: oportunidade fk_oportunidade_lead; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT fk_oportunidade_lead FOREIGN KEY (lead_id) REFERENCES public.lead(id);


--
-- Name: oportunidade fk_oportunidade_plano; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT fk_oportunidade_plano FOREIGN KEY (plano_id) REFERENCES public.plano_saude(id);


--
-- Name: plano_saude fk_plano_operadora; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plano_saude
    ADD CONSTRAINT fk_plano_operadora FOREIGN KEY (operadora_id) REFERENCES public.operadora(id);


--
-- Name: atendimento_pos_venda fk_pos_venda_consultor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimento_pos_venda
    ADD CONSTRAINT fk_pos_venda_consultor FOREIGN KEY (consultor_id) REFERENCES public.consultor(id);


--
-- Name: atendimento_pos_venda fk_pos_venda_contratacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atendimento_pos_venda
    ADD CONSTRAINT fk_pos_venda_contratacao FOREIGN KEY (contratacao_id) REFERENCES public.contratacao(id);


--
-- Name: projeto fk_projeto_contrato; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projeto
    ADD CONSTRAINT fk_projeto_contrato FOREIGN KEY (contrato_id) REFERENCES public.contrato(id);


--
-- Name: receita fk_receita_contratacao; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT fk_receita_contratacao FOREIGN KEY (contratacao_id) REFERENCES public.contratacao(id);


--
-- Name: receita fk_receita_contrato; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT fk_receita_contrato FOREIGN KEY (contrato_id) REFERENCES public.contrato(id);


--
-- Name: receita fk_receita_unidade_negocio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT fk_receita_unidade_negocio FOREIGN KEY (unidade_negocio_id) REFERENCES public.unidade_negocio(id);


--
-- Name: historico_oportunidade historico_oportunidade_etapa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historico_oportunidade
    ADD CONSTRAINT historico_oportunidade_etapa_id_fkey FOREIGN KEY (etapa_id) REFERENCES public.etapa_funil(id);


--
-- Name: historico_oportunidade historico_oportunidade_oportunidade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historico_oportunidade
    ADD CONSTRAINT historico_oportunidade_oportunidade_id_fkey FOREIGN KEY (oportunidade_id) REFERENCES public.oportunidade(id);


--
-- Name: lead lead_unidade_negocio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lead
    ADD CONSTRAINT lead_unidade_negocio_id_fkey FOREIGN KEY (unidade_negocio_id) REFERENCES public.unidade_negocio(id);


--
-- Name: meta meta_campanha_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meta
    ADD CONSTRAINT meta_campanha_id_fkey FOREIGN KEY (campanha_id) REFERENCES public.campanha(id);


--
-- Name: operacao_patrimonial operacao_patrimonial_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operacao_patrimonial
    ADD CONSTRAINT operacao_patrimonial_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: oportunidade oportunidade_objetivo_patrimonial_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT oportunidade_objetivo_patrimonial_id_fkey FOREIGN KEY (objetivo_patrimonial_id) REFERENCES public.objetivo(id);


--
-- Name: oportunidade oportunidade_unidade_negocio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidade
    ADD CONSTRAINT oportunidade_unidade_negocio_id_fkey FOREIGN KEY (unidade_negocio_id) REFERENCES public.unidade_negocio(id);


--
-- Name: projeto projeto_equipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projeto
    ADD CONSTRAINT projeto_equipe_id_fkey FOREIGN KEY (equipe_id) REFERENCES public.equipe(id);


--
-- Name: receita receita_operacao_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT receita_operacao_id_fkey FOREIGN KEY (operacao_id) REFERENCES public.operacao_patrimonial(id);


--
-- Name: receita receita_oportunidade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receita
    ADD CONSTRAINT receita_oportunidade_id_fkey FOREIGN KEY (oportunidade_id) REFERENCES public.oportunidade(id);


--
-- Name: atendimento_pos_venda; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.atendimento_pos_venda ENABLE ROW LEVEL SECURITY;

--
-- Name: campanha; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.campanha ENABLE ROW LEVEL SECURITY;

--
-- Name: campanha_canal; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.campanha_canal ENABLE ROW LEVEL SECURITY;

--
-- Name: canal; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.canal ENABLE ROW LEVEL SECURITY;

--
-- Name: cliente; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.cliente ENABLE ROW LEVEL SECURITY;

--
-- Name: consultor; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.consultor ENABLE ROW LEVEL SECURITY;

--
-- Name: contratacao; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.contratacao ENABLE ROW LEVEL SECURITY;

--
-- Name: contrato; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.contrato ENABLE ROW LEVEL SECURITY;

--
-- Name: equipe; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.equipe ENABLE ROW LEVEL SECURITY;

--
-- Name: etapa_funil; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.etapa_funil ENABLE ROW LEVEL SECURITY;

--
-- Name: historico_oportunidade; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.historico_oportunidade ENABLE ROW LEVEL SECURITY;

--
-- Name: lead; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.lead ENABLE ROW LEVEL SECURITY;

--
-- Name: meta; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.meta ENABLE ROW LEVEL SECURITY;

--
-- Name: objetivo; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.objetivo ENABLE ROW LEVEL SECURITY;

--
-- Name: operacao_patrimonial; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.operacao_patrimonial ENABLE ROW LEVEL SECURITY;

--
-- Name: operadora; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.operadora ENABLE ROW LEVEL SECURITY;

--
-- Name: oportunidade; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.oportunidade ENABLE ROW LEVEL SECURITY;

--
-- Name: plano_saude; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.plano_saude ENABLE ROW LEVEL SECURITY;

--
-- Name: projeto; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.projeto ENABLE ROW LEVEL SECURITY;

--
-- Name: receita; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.receita ENABLE ROW LEVEL SECURITY;

--
-- Name: unidade_negocio; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.unidade_negocio ENABLE ROW LEVEL SECURITY;

--
-- PostgreSQL database dump complete
--

\unrestrict hfHmT810c3gJQwEi7OEUKIIQqAdco0b6hC78fYkTb3gwsI1pw8zOjpPZRR1lzVU


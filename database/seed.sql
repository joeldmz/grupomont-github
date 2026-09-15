--
-- PostgreSQL database dump
--

\restrict 4GMZCPq77cJDqCRyT2ApB1VuAq3oXDrix5wCZb56KHcVrWV8h7ujhxqFcycdNlk

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
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at, custom_claims_allowlist) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
20260625000000
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: unidade_negocio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unidade_negocio (id, nome) FROM stdin;
1	Montseguro
2	Prop5 Investimentos
3	TechBrabo
\.


--
-- Data for Name: campanha; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campanha (id, nome, data_inicio, data_fim, investimento, status, unidade_negocio_id) FROM stdin;
1	Plano Empresarial - Junho	2026-06-01	2026-06-30	8200.00	Encerrada	1
2	Plano Empresarial - Julho	2026-07-01	2026-07-31	9700.00	Encerrada	1
3	Plano Empresarial - Agosto	2026-08-01	2026-08-31	11800.00	Encerrada	1
4	Plano Empresarial - Setembro	2026-09-01	2026-09-30	14200.00	Ativa	1
5	Diagnóstico Patrimonial - Junho	2026-06-01	2026-06-30	6100.00	Encerrada	2
6	Diagnóstico Patrimonial - Julho	2026-07-01	2026-07-31	7300.00	Encerrada	2
7	Diagnóstico Patrimonial - Agosto	2026-08-01	2026-08-31	8900.00	Encerrada	2
8	Diagnóstico Patrimonial - Setembro	2026-09-01	2026-09-30	10400.00	Ativa	2
9	Soluções B2B - Junho	2026-06-01	2026-06-30	7600.00	Encerrada	3
10	Soluções B2B - Julho	2026-07-01	2026-07-31	8400.00	Encerrada	3
11	Soluções B2B - Agosto	2026-08-01	2026-08-31	10100.00	Encerrada	3
12	Soluções B2B - Setembro	2026-09-01	2026-09-30	12700.00	Ativa	3
\.


--
-- Data for Name: canal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.canal (id, nome, tipo, status) FROM stdin;
1	Google Ads	Pago	Ativo
2	Meta Ads	Pago	Ativo
3	Instagram	Orgânico	Ativo
4	Indicação	Indicação	Ativo
5	LinkedIn	Orgânico	Ativo
6	Site	Orgânico	Ativo
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (id, cnpj, razao_social, segmento, quantidade_funcionarios, cidade, estado, data_cadastro, status, tipo_cliente, cpf, data_nascimento, pais_residencia) FROM stdin;
1	12.345.678/0001-01	Alvorada Tecnologia Ltda	Tecnologia	85	Brasília	DF	2026-05-20	Ativa	PJ	\N	\N	\N
2	23.456.789/0001-02	Horizonte Logística Ltda	Logística	140	Brasília	DF	2026-05-25	Ativa	PJ	\N	\N	\N
3	34.567.890/0001-03	Verde Engenharia Ltda	Engenharia	60	Goiânia	GO	2026-06-02	Ativa	PJ	\N	\N	\N
4	45.678.901/0001-04	Planalto Distribuição S.A.	Comércio	180	Brasília	DF	2026-06-15	Ativa	PJ	\N	\N	\N
5	56.789.012/0001-05	Norte Saúde Empresarial Ltda	Saúde	220	Brasília	DF	2026-07-01	Ativa	PJ	\N	\N	\N
6	67.890.123/0001-06	Cerrado Alimentos Ltda	Alimentos	95	Brasília	DF	2026-07-12	Ativa	PJ	\N	\N	\N
7	78.901.234/0001-07	Nexa Serviços Corporativos Ltda	Serviços	45	Brasília	DF	2026-08-05	Ativa	PJ	\N	\N	\N
8	89.012.345/0001-08	Capital Construções Ltda	Construção	120	Brasília	DF	2026-08-18	Ativa	PJ	\N	\N	\N
9	90.123.456/0001-09	DataVale Analytics Ltda	Tecnologia	70	São Paulo	SP	2026-09-02	Ativa	PJ	\N	\N	\N
10	01.234.567/0001-10	Águas Claras Comércio Ltda	Comércio	35	Brasília	DF	2026-09-05	Ativa	PJ	\N	\N	\N
11	\N	Mariana Oliveira	Investimentos	\N	Lisboa	PT	2026-05-18	Ativa	PF	000.000.001-11	1982-04-12	Portugal
12	\N	Ricardo Almeida	Investimentos	\N	Porto	PT	2026-06-10	Ativa	PF	000.000.001-12	1979-09-23	Portugal
13	\N	Camila Rodrigues	Investimentos	\N	São Paulo	SP	2026-07-08	Ativa	PF	000.000.001-13	1986-02-18	Portugal
14	\N	Felipe Martins	Investimentos	\N	Rio de Janeiro	RJ	2026-08-03	Ativa	PF	000.000.001-14	1981-11-05	Portugal
15	\N	Renata Costa	Investimentos	\N	Lisboa	PT	2026-09-01	Ativa	PF	000.000.001-15	1984-06-27	Portugal
\.


--
-- Data for Name: equipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipe (id, nome, status) FROM stdin;
1	Equipe Montseguro	Ativa
2	Equipe Prop5	Ativa
3	Equipe TechBrabo Comercial	Ativa
4	Equipe TechBrabo Projetos	Ativa
\.


--
-- Data for Name: consultor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultor (id, equipe_id, nome, email, status, data_entrada) FROM stdin;
1	1	Ana Martins	ana.martins@grupomont.example	Ativo	2025-02-10
2	1	Bruno Lima	bruno.lima@grupomont.example	Ativo	2025-05-10
3	2	Marina Costa	marina.costa@grupomont.example	Ativo	2025-06-10
4	2	Rafael Nunes	rafael.nunes@grupomont.example	Ativo	2025-07-10
5	3	Lucas Rocha	lucas.rocha@grupomont.example	Ativo	2025-08-10
6	3	Fernanda Reis	fernanda.reis@grupomont.example	Ativo	2025-09-10
7	4	Gustavo Melo	gustavo.melo@grupomont.example	Ativo	2025-10-10
8	3	Juliana Alves	juliana.alves@grupomont.example	Ativo	2026-01-10
\.


--
-- Data for Name: etapa_funil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etapa_funil (id, nome, ordem, unidade_negocio_id, tempo_estimado) FROM stdin;
1	Qualificação	1	1	5
2	Simulação ou Cotação	2	1	5
3	Apresentação da solução	3	1	2
4	Proposta	4	1	2
5	Contratação	5	1	2
6	Implantação	6	1	5
7	Cliente ativo	7	1	2
8	Pós-venda	8	1	\N
9	Qualificação	1	2	5
10	Diagnóstico financeiro	2	2	15
11	Reunião consultiva	3	2	1
12	Estratégia	4	2	10
13	Oportunidade	5	2	6
14	Negociação	6	2	2
15	Estruturação	7	2	15
16	Aquisição ou Fechamento	8	2	2
17	Acompanhamento	9	2	\N
18	Qualificação	1	3	5
19	Reunião	2	3	2
20	Diagnóstico	3	3	10
21	Proposta	4	3	2
22	Negociação	5	3	5
23	Contrato	6	3	2
24	Desenvolvimento ou Implantação	7	3	\N
25	Entrega	8	3	\N
26	Operação e Evolução	9	3	\N
\.


--
-- Data for Name: lead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lead (id, cliente_id, campanha_id, nome, email, telefone, data_entrada, status, unidade_negocio_id, canal_id) FROM stdin;
63	9	11	Isabela Monteiro	isabela.monteiro@email.com	61991010023	2026-08-22	Convertido	3	1
64	5	3	Daniel Correia	daniel.correia@email.com	61991010024	2026-08-26	Convertido	1	2
65	11	7	Natália Ramos	natalia.ramos@email.com	61991010025	2026-08-29	Convertido	2	1
66	10	4	Rodrigo Azevedo	rodrigo.azevedo@email.com	61991010026	2026-09-01	Convertido	1	1
67	12	8	Sabrina Castro	sabrina.castro@email.com	61991010027	2026-09-02	Convertido	2	2
68	7	12	Henrique Lopes	henrique.lopes@email.com	61991010028	2026-09-03	Convertido	3	3
69	1	4	Carolina Mendes	carolina.mendes@email.com	61991010029	2026-09-04	Convertido	1	2
71	3	12	Ana Paula Souza	ana.paula.souza@email.com	61991010031	2026-09-06	Convertido	3	3
74	2	12	Paulo Henrique	paulo.henrique@email.com	61991010034	2026-09-09	Convertido	3	1
41	1	1	Mariana Alves	mariana.alves@email.com	61991010001	2026-06-04	Convertido	1	1
42	12	5	Ricardo Almeida	ricardo.almeida@email.com	61991010002	2026-06-09	Convertido	2	2
43	3	9	Fernanda Costa	fernanda.costa@email.com	61991010003	2026-06-13	Convertido	3	3
44	4	1	Carlos Eduardo Lima	carlos.lima@email.com	61991010004	2026-06-18	Convertido	1	2
45	13	5	Camila Rodrigues	camila.rodrigues@email.com	61991010005	2026-06-23	Convertido	2	1
46	6	9	André Ribeiro	andre.ribeiro@email.com	61991010006	2026-06-27	Convertido	3	3
47	7	2	Patrícia Oliveira	patricia.oliveira@email.com	61991010007	2026-07-03	Convertido	1	1
48	14	6	Felipe Martins	felipe.martins@email.com	61991010008	2026-07-07	Convertido	2	2
49	9	10	Beatriz Nunes	beatriz.nunes@email.com	61991010009	2026-07-10	Convertido	3	3
50	2	2	Eduardo Ferreira	eduardo.ferreira@email.com	61991010010	2026-07-14	Convertido	1	3
51	11	6	Mariana Oliveira	mariana.oliveira@email.com	61991010011	2026-07-18	Convertido	2	1
52	5	10	Lucas Almeida	lucas.almeida@email.com	61991010012	2026-07-21	Convertido	3	2
53	10	2	Renata Carvalho	renata.carvalho@email.com	61991010013	2026-07-25	Convertido	1	2
54	12	6	Gustavo Santos	gustavo.santos@email.com	61991010014	2026-07-29	Convertido	2	3
55	8	3	Aline Souza	aline.souza@email.com	61991010015	2026-08-02	Convertido	1	1
56	13	7	Camila Rodrigues	camila.rodrigues2@email.com	61991010016	2026-08-04	Convertido	2	2
57	3	11	Larissa Gomes	larissa.gomes@email.com	61991010017	2026-08-06	Convertido	3	3
58	1	3	Rafael Teixeira	rafael.teixeira@email.com	61991010018	2026-08-09	Convertido	1	3
70	15	8	Marcelo Vieira	marcelo.vieira@email.com	61991010030	2026-09-05	Qualificado	2	1
72	6	4	Diego Fernandes	diego.fernandes@email.com	61991010032	2026-09-07	Novo	1	3
73	13	8	Luciana Reis	luciana.reis@email.com	61991010033	2026-09-08	Qualificado	2	2
75	8	4	Amanda Nascimento	amanda.nascimento@email.com	61991010035	2026-09-10	Novo	1	1
76	14	8	Leonardo Batista	leonardo.batista@email.com	61991010036	2026-09-11	Novo	2	3
59	15	7	Renata Costa	renata.costa@email.com	61991010019	2026-08-11	Convertido	2	1
60	6	11	Felipe Martins	felipe.martins2@email.com	61991010020	2026-08-14	Convertido	3	2
61	4	3	Vanessa Freitas	vanessa.freitas@email.com	61991010021	2026-08-17	Convertido	1	2
62	14	7	Bruno Cardoso	bruno.cardoso@email.com	61991010022	2026-08-19	Convertido	2	3
78	9	4	Vinícius Moraes	vinicius.moraes@email.com	61991010038	2026-09-13	Novo	1	2
79	11	8	Gabriela Pinto	gabriela.pinto@email.com	61991010039	2026-09-14	Novo	2	1
80	4	12	João Victor Silva	joao.victor.silva@email.com	61991010040	2026-09-15	Novo	3	3
77	5	12	Marina Fonseca	marina.fonseca@email.com	61991010037	2026-09-12	Convertido	3	2
\.


--
-- Data for Name: objetivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.objetivo (id, nome, descricao) FROM stdin;
1	Crescimento patrimonial	Construção e diversificação do patrimônio.
2	Renda e proteção	Geração de renda e proteção patrimonial.
3	Aquisição de imóvel	Planejamento para aquisição de imóvel.
\.


--
-- Data for Name: operadora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operadora (id, nome, status) FROM stdin;
1	Amil	Ativa
2	SulAmérica	Ativa
3	Bradesco Saúde	Ativa
\.


--
-- Data for Name: plano_saude; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plano_saude (id, operadora_id, nome, tipo, acomodacao, coparticipacao, abrangencia) FROM stdin;
1	1	Amil PME	Empresarial	Enfermaria	t	Nacional
2	2	SulAmérica Executivo	Empresarial	Apartamento	f	Nacional
3	3	Bradesco Nacional	Empresarial	Apartamento	t	Nacional
\.


--
-- Data for Name: oportunidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oportunidade (id, cliente_id, consultor_id, campanha_id, plano_id, etapa_id, status, valor_estimado, probabilidade, data_criacao, data_previsao_fechamento, data_fechamento, lead_id, quantidade_vidas_estimada, objetivo_patrimonial_id, estrategia, tipo_solucao, escopo, unidade_negocio_id) FROM stdin;
1	1	1	1	\N	1	Aberta	40809.41	15.00	2026-06-04	2026-07-19	\N	41	\N	\N	\N	\N	\N	1
2	4	2	1	\N	1	Aberta	22429.93	15.00	2026-06-18	2026-08-02	\N	44	\N	\N	\N	\N	\N	1
3	7	1	2	\N	2	Aberta	45379.42	15.00	2026-07-03	2026-08-17	\N	47	\N	\N	\N	\N	\N	1
4	2	2	2	\N	2	Aberta	22236.93	15.00	2026-07-14	2026-08-28	\N	50	\N	\N	\N	\N	\N	1
5	10	1	2	\N	3	Aberta	45730.17	15.00	2026-07-25	2026-09-08	\N	53	\N	\N	\N	\N	\N	1
6	8	2	3	\N	4	Aberta	29298.92	15.00	2026-08-02	2026-09-16	\N	55	\N	\N	\N	\N	\N	1
7	1	1	3	1	7	Ganha	35636.61	15.00	2026-08-09	2026-09-23	\N	58	\N	\N	\N	\N	\N	1
8	4	2	2	2	7	Ganha	31140.82	15.00	2026-08-17	2026-10-01	\N	61	\N	\N	\N	\N	\N	1
10	10	2	10	\N	2	Perdida	21323.70	15.00	2026-09-01	2026-10-16	\N	66	\N	\N	\N	\N	\N	1
11	1	1	10	\N	3	Perdida	26331.73	15.00	2026-09-04	2026-10-19	\N	69	\N	\N	\N	\N	\N	1
12	12	3	4	\N	9	Aberta	545543.62	15.00	2026-06-09	2026-07-24	\N	42	\N	\N	\N	\N	\N	2
13	13	4	5	\N	9	Aberta	343921.36	15.00	2026-06-23	2026-08-07	\N	45	\N	\N	\N	\N	\N	2
14	14	3	5	\N	10	Aberta	210459.73	15.00	2026-07-07	2026-08-21	\N	48	\N	\N	\N	\N	\N	2
15	11	4	6	\N	11	Aberta	186995.58	15.00	2026-07-18	2026-09-01	\N	51	\N	\N	\N	\N	\N	2
16	12	3	4	\N	12	Aberta	228454.98	15.00	2026-07-29	2026-09-12	\N	54	\N	\N	\N	\N	\N	2
17	13	4	6	\N	16	Ganha	632599.95	15.00	2026-08-04	2026-09-18	\N	56	\N	\N	\N	\N	\N	2
18	15	3	6	\N	16	Ganha	404203.96	15.00	2026-08-11	2026-09-25	\N	59	\N	\N	\N	\N	\N	2
19	14	4	6	\N	16	Ganha	231334.40	15.00	2026-08-19	2026-10-03	\N	62	\N	\N	\N	\N	\N	2
20	11	3	4	\N	10	Perdida	307800.25	15.00	2026-08-29	2026-10-13	\N	65	\N	\N	\N	\N	\N	2
21	12	4	11	\N	13	Perdida	256149.90	15.00	2026-09-02	2026-10-17	\N	67	\N	\N	\N	\N	\N	2
22	3	5	7	\N	18	Aberta	51803.90	15.00	2026-06-13	2026-07-28	\N	43	\N	\N	\N	\N	\N	3
23	6	6	7	\N	18	Aberta	196236.03	15.00	2026-06-27	2026-08-11	\N	46	\N	\N	\N	\N	\N	3
24	9	8	8	\N	19	Aberta	185156.54	15.00	2026-07-10	2026-08-24	\N	49	\N	\N	\N	\N	\N	3
25	5	5	9	\N	20	Aberta	109527.01	15.00	2026-07-21	2026-09-04	\N	52	\N	\N	\N	\N	\N	3
26	3	6	9	\N	21	Aberta	101385.32	15.00	2026-08-06	2026-09-20	\N	57	\N	\N	\N	\N	\N	3
31	2	5	12	\N	19	Perdida	169070.17	15.00	2026-09-09	2026-10-24	\N	74	\N	\N	\N	\N	\N	3
32	5	6	12	\N	21	Perdida	91795.47	15.00	2026-09-12	2026-10-27	\N	77	\N	\N	\N	\N	\N	3
27	6	8	8	\N	24	Ganha	208519.85	15.00	2026-08-14	2026-09-28	\N	60	\N	\N	\N	\N	\N	3
28	9	5	7	\N	24	Ganha	129769.25	15.00	2026-08-22	2026-10-06	\N	63	\N	\N	\N	\N	\N	3
29	7	6	12	\N	25	Ganha	63263.39	15.00	2026-09-03	2026-10-18	\N	68	\N	\N	\N	\N	\N	3
30	3	8	12	\N	25	Ganha	76010.72	15.00	2026-09-06	2026-10-21	\N	71	\N	\N	\N	\N	\N	3
9	5	1	3	3	7	Ganha	49763.26	15.00	2026-08-26	2026-10-10	\N	64	\N	\N	\N	\N	\N	1
\.


--
-- Data for Name: contratacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contratacao (id, oportunidade_id, plano_id, data_contratacao, quantidade_vidas, valor_mensal_plano, status, cliente_id) FROM stdin;
2	7	1	2026-08-09	10	2969.72	Ativa	1
3	8	2	2026-08-17	10	2595.07	Ativa	4
4	9	3	2026-08-26	10	4146.94	Ativa	5
\.


--
-- Data for Name: atendimento_pos_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atendimento_pos_venda (id, contratacao_id, consultor_id, tipo, descricao, status, data_abertura, data_conclusao) FROM stdin;
\.


--
-- Data for Name: campanha_canal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campanha_canal (campanha_id, canal_id) FROM stdin;
\.


--
-- Data for Name: contrato; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contrato (id, oportunidade_id, numero_contrato, valor_contrato, tipo_contrato, data_assinatura, data_inicio, data_fim, status, tipo_cobranca, cliente_id) FROM stdin;
1	27	TB-00027	208519.85	Prestação de Serviços	\N	2026-08-14	2027-08-14	Ativo	Mensal	6
2	28	TB-00028	129769.25	Prestação de Serviços	\N	2026-08-22	2027-08-22	Ativo	Mensal	9
3	29	TB-00029	63263.39	Prestação de Serviços	\N	2026-09-03	2027-09-03	Ativo	Mensal	7
4	30	TB-00030	76010.72	Prestação de Serviços	\N	2026-09-06	2027-09-06	Ativo	Mensal	3
\.


--
-- Data for Name: historico_oportunidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico_oportunidade (id, created_at, data_entrada, data_saida, oportunidade_id, etapa_id) FROM stdin;
1	2026-09-15 13:26:40.969205+00	2026-07-01 00:00:00	2026-07-03 00:00:00	7	1
2	2026-09-15 13:26:40.969205+00	2026-07-03 00:00:00	2026-07-07 00:00:00	7	2
3	2026-09-15 13:26:40.969205+00	2026-07-07 00:00:00	2026-07-10 00:00:00	7	3
4	2026-09-15 13:26:40.969205+00	2026-07-10 00:00:00	2026-07-15 00:00:00	7	4
5	2026-09-15 13:26:40.969205+00	2026-07-15 00:00:00	2026-07-18 00:00:00	7	5
6	2026-09-15 13:32:59.13874+00	2026-06-05 00:00:00	\N	1	1
7	2026-09-15 13:32:59.13874+00	2026-06-12 00:00:00	\N	2	1
8	2026-09-15 13:32:59.13874+00	2026-07-03 00:00:00	2026-07-06 00:00:00	3	1
9	2026-09-15 13:32:59.13874+00	2026-07-06 00:00:00	\N	3	2
10	2026-09-15 13:32:59.13874+00	2026-07-10 00:00:00	2026-07-13 00:00:00	4	1
11	2026-09-15 13:32:59.13874+00	2026-07-13 00:00:00	\N	4	2
12	2026-09-15 13:32:59.13874+00	2026-07-20 00:00:00	2026-07-23 00:00:00	5	1
13	2026-09-15 13:32:59.13874+00	2026-07-23 00:00:00	2026-07-28 00:00:00	5	2
14	2026-09-15 13:32:59.13874+00	2026-07-28 00:00:00	\N	5	3
15	2026-09-15 13:32:59.13874+00	2026-08-03 00:00:00	2026-08-06 00:00:00	6	1
16	2026-09-15 13:32:59.13874+00	2026-08-06 00:00:00	2026-08-10 00:00:00	6	2
17	2026-09-15 13:32:59.13874+00	2026-08-10 00:00:00	2026-08-14 00:00:00	6	3
18	2026-09-15 13:32:59.13874+00	2026-08-14 00:00:00	\N	6	4
19	2026-09-15 13:32:59.13874+00	2026-07-08 00:00:00	2026-07-11 00:00:00	8	1
20	2026-09-15 13:32:59.13874+00	2026-07-11 00:00:00	2026-07-15 00:00:00	8	2
21	2026-09-15 13:32:59.13874+00	2026-07-15 00:00:00	2026-07-18 00:00:00	8	3
22	2026-09-15 13:32:59.13874+00	2026-07-18 00:00:00	2026-07-23 00:00:00	8	4
23	2026-09-15 13:32:59.13874+00	2026-07-23 00:00:00	2026-07-26 00:00:00	8	5
24	2026-09-15 13:32:59.13874+00	2026-08-05 00:00:00	2026-08-08 00:00:00	9	1
25	2026-09-15 13:32:59.13874+00	2026-08-08 00:00:00	2026-08-12 00:00:00	9	2
26	2026-09-15 13:32:59.13874+00	2026-08-12 00:00:00	2026-08-16 00:00:00	9	3
27	2026-09-15 13:32:59.13874+00	2026-08-16 00:00:00	2026-08-21 00:00:00	9	4
28	2026-09-15 13:32:59.13874+00	2026-08-21 00:00:00	2026-08-25 00:00:00	9	5
29	2026-09-15 13:32:59.13874+00	2026-09-03 00:00:00	2026-09-06 00:00:00	10	1
30	2026-09-15 13:32:59.13874+00	2026-09-06 00:00:00	2026-09-09 00:00:00	10	2
31	2026-09-15 13:32:59.13874+00	2026-09-05 00:00:00	2026-09-08 00:00:00	11	1
32	2026-09-15 13:32:59.13874+00	2026-09-08 00:00:00	2026-09-12 00:00:00	11	2
33	2026-09-15 13:32:59.13874+00	2026-09-12 00:00:00	2026-09-15 00:00:00	11	3
34	2026-09-15 13:35:16.472007+00	2026-06-08 00:00:00	\N	12	9
35	2026-09-15 13:35:16.472007+00	2026-06-18 00:00:00	\N	13	9
36	2026-09-15 13:35:16.472007+00	2026-07-04 00:00:00	2026-07-07 00:00:00	14	9
37	2026-09-15 13:35:16.472007+00	2026-07-07 00:00:00	\N	14	10
38	2026-09-15 13:35:16.472007+00	2026-07-12 00:00:00	2026-07-15 00:00:00	15	9
39	2026-09-15 13:35:16.472007+00	2026-07-15 00:00:00	2026-07-20 00:00:00	15	10
40	2026-09-15 13:35:16.472007+00	2026-07-20 00:00:00	\N	15	11
41	2026-09-15 13:35:16.472007+00	2026-08-04 00:00:00	2026-08-07 00:00:00	16	9
42	2026-09-15 13:35:16.472007+00	2026-08-07 00:00:00	2026-08-11 00:00:00	16	10
43	2026-09-15 13:35:16.472007+00	2026-08-11 00:00:00	2026-08-14 00:00:00	16	11
44	2026-09-15 13:35:16.472007+00	2026-08-14 00:00:00	\N	16	12
45	2026-09-15 13:35:16.472007+00	2026-07-06 00:00:00	2026-07-09 00:00:00	17	9
46	2026-09-15 13:35:16.472007+00	2026-07-09 00:00:00	2026-07-13 00:00:00	17	10
47	2026-09-15 13:35:16.472007+00	2026-07-13 00:00:00	2026-07-17 00:00:00	17	11
48	2026-09-15 13:35:16.472007+00	2026-07-17 00:00:00	2026-07-21 00:00:00	17	12
49	2026-09-15 13:35:16.472007+00	2026-07-21 00:00:00	2026-07-25 00:00:00	17	13
50	2026-09-15 13:35:16.472007+00	2026-07-25 00:00:00	2026-07-29 00:00:00	17	14
51	2026-09-15 13:35:16.472007+00	2026-07-29 00:00:00	2026-08-03 00:00:00	17	15
52	2026-09-15 13:35:16.472007+00	2026-08-03 00:00:00	2026-08-07 00:00:00	17	16
53	2026-09-15 13:35:16.472007+00	2026-08-06 00:00:00	2026-08-09 00:00:00	18	9
54	2026-09-15 13:35:16.472007+00	2026-08-09 00:00:00	2026-08-13 00:00:00	18	10
55	2026-09-15 13:35:16.472007+00	2026-08-13 00:00:00	2026-08-17 00:00:00	18	11
56	2026-09-15 13:35:16.472007+00	2026-08-17 00:00:00	2026-08-21 00:00:00	18	12
57	2026-09-15 13:35:16.472007+00	2026-08-21 00:00:00	2026-08-25 00:00:00	18	13
58	2026-09-15 13:35:16.472007+00	2026-08-25 00:00:00	2026-08-29 00:00:00	18	14
59	2026-09-15 13:35:16.472007+00	2026-08-29 00:00:00	2026-09-03 00:00:00	18	15
60	2026-09-15 13:35:16.472007+00	2026-09-03 00:00:00	2026-09-08 00:00:00	18	16
61	2026-09-15 13:35:16.472007+00	2026-08-10 00:00:00	2026-08-13 00:00:00	19	9
62	2026-09-15 13:35:16.472007+00	2026-08-13 00:00:00	2026-08-17 00:00:00	19	10
63	2026-09-15 13:35:16.472007+00	2026-08-17 00:00:00	2026-08-20 00:00:00	19	11
64	2026-09-15 13:35:16.472007+00	2026-08-20 00:00:00	2026-08-25 00:00:00	19	12
65	2026-09-15 13:35:16.472007+00	2026-08-25 00:00:00	2026-08-30 00:00:00	19	13
66	2026-09-15 13:35:16.472007+00	2026-08-30 00:00:00	2026-09-04 00:00:00	19	14
67	2026-09-15 13:35:16.472007+00	2026-09-04 00:00:00	2026-09-09 00:00:00	19	15
68	2026-09-15 13:35:16.472007+00	2026-09-09 00:00:00	2026-09-14 00:00:00	19	16
69	2026-09-15 13:35:16.472007+00	2026-09-02 00:00:00	2026-09-06 00:00:00	20	9
70	2026-09-15 13:35:16.472007+00	2026-09-06 00:00:00	2026-09-10 00:00:00	20	10
71	2026-09-15 13:35:16.472007+00	2026-09-03 00:00:00	2026-09-06 00:00:00	21	9
72	2026-09-15 13:35:16.472007+00	2026-09-06 00:00:00	2026-09-10 00:00:00	21	10
73	2026-09-15 13:35:16.472007+00	2026-09-10 00:00:00	2026-09-13 00:00:00	21	11
74	2026-09-15 13:35:16.472007+00	2026-09-13 00:00:00	2026-09-15 00:00:00	21	12
75	2026-09-15 13:35:16.472007+00	2026-09-15 00:00:00	2026-09-15 00:00:00	21	13
76	2026-09-15 13:37:23.795614+00	2026-06-10 00:00:00	\N	22	18
77	2026-09-15 13:37:23.795614+00	2026-06-20 00:00:00	\N	23	18
78	2026-09-15 13:37:23.795614+00	2026-07-05 00:00:00	2026-07-08 00:00:00	24	18
79	2026-09-15 13:37:23.795614+00	2026-07-08 00:00:00	\N	24	19
80	2026-09-15 13:37:23.795614+00	2026-07-14 00:00:00	2026-07-17 00:00:00	25	18
81	2026-09-15 13:37:23.795614+00	2026-07-17 00:00:00	2026-07-21 00:00:00	25	19
82	2026-09-15 13:37:23.795614+00	2026-07-21 00:00:00	\N	25	20
83	2026-09-15 13:37:23.795614+00	2026-08-05 00:00:00	2026-08-08 00:00:00	26	18
84	2026-09-15 13:37:23.795614+00	2026-08-08 00:00:00	2026-08-12 00:00:00	26	19
85	2026-09-15 13:37:23.795614+00	2026-08-12 00:00:00	2026-08-16 00:00:00	26	20
86	2026-09-15 13:37:23.795614+00	2026-08-16 00:00:00	\N	26	21
87	2026-09-15 13:37:23.795614+00	2026-07-07 00:00:00	2026-07-10 00:00:00	27	18
88	2026-09-15 13:37:23.795614+00	2026-07-10 00:00:00	2026-07-14 00:00:00	27	19
89	2026-09-15 13:37:23.795614+00	2026-07-14 00:00:00	2026-07-18 00:00:00	27	20
90	2026-09-15 13:37:23.795614+00	2026-07-18 00:00:00	2026-07-23 00:00:00	27	21
91	2026-09-15 13:37:23.795614+00	2026-07-23 00:00:00	2026-07-28 00:00:00	27	22
92	2026-09-15 13:37:23.795614+00	2026-07-28 00:00:00	2026-08-03 00:00:00	27	23
93	2026-09-15 13:37:23.795614+00	2026-08-07 00:00:00	2026-08-10 00:00:00	28	18
94	2026-09-15 13:37:23.795614+00	2026-08-10 00:00:00	2026-08-14 00:00:00	28	19
95	2026-09-15 13:37:23.795614+00	2026-08-14 00:00:00	2026-08-18 00:00:00	28	20
96	2026-09-15 13:37:23.795614+00	2026-08-18 00:00:00	2026-08-23 00:00:00	28	21
97	2026-09-15 13:37:23.795614+00	2026-08-23 00:00:00	2026-08-28 00:00:00	28	22
98	2026-09-15 13:37:23.795614+00	2026-08-28 00:00:00	2026-09-03 00:00:00	28	23
99	2026-09-15 13:37:23.795614+00	2026-08-12 00:00:00	2026-08-15 00:00:00	29	18
100	2026-09-15 13:37:23.795614+00	2026-08-15 00:00:00	2026-08-19 00:00:00	29	19
101	2026-09-15 13:37:23.795614+00	2026-08-19 00:00:00	2026-08-23 00:00:00	29	20
102	2026-09-15 13:37:23.795614+00	2026-08-23 00:00:00	2026-08-28 00:00:00	29	21
103	2026-09-15 13:37:23.795614+00	2026-08-28 00:00:00	2026-09-02 00:00:00	29	22
104	2026-09-15 13:37:23.795614+00	2026-09-02 00:00:00	2026-09-07 00:00:00	29	23
105	2026-09-15 13:37:23.795614+00	2026-08-15 00:00:00	2026-08-18 00:00:00	30	18
106	2026-09-15 13:37:23.795614+00	2026-08-18 00:00:00	2026-08-22 00:00:00	30	19
107	2026-09-15 13:37:23.795614+00	2026-08-22 00:00:00	2026-08-26 00:00:00	30	20
108	2026-09-15 13:37:23.795614+00	2026-08-26 00:00:00	2026-08-31 00:00:00	30	21
109	2026-09-15 13:37:23.795614+00	2026-08-31 00:00:00	2026-09-05 00:00:00	30	22
110	2026-09-15 13:37:23.795614+00	2026-09-05 00:00:00	2026-09-10 00:00:00	30	23
111	2026-09-15 13:37:23.795614+00	2026-09-04 00:00:00	2026-09-07 00:00:00	31	18
112	2026-09-15 13:37:23.795614+00	2026-09-07 00:00:00	2026-09-11 00:00:00	31	19
113	2026-09-15 13:37:23.795614+00	2026-09-05 00:00:00	2026-09-08 00:00:00	32	18
114	2026-09-15 13:37:23.795614+00	2026-09-08 00:00:00	2026-09-11 00:00:00	32	19
115	2026-09-15 13:37:23.795614+00	2026-09-11 00:00:00	2026-09-14 00:00:00	32	20
116	2026-09-15 13:37:23.795614+00	2026-09-14 00:00:00	2026-09-15 00:00:00	32	21
117	2026-09-15 14:55:26.059334+00	2026-08-03 00:00:00	\N	27	24
118	2026-09-15 14:55:26.059334+00	2026-09-03 00:00:00	\N	28	24
119	2026-09-15 14:55:26.059334+00	2026-09-07 00:00:00	\N	29	25
120	2026-09-15 14:55:26.059334+00	2026-09-10 00:00:00	\N	30	25
121	2026-09-15 14:58:29.609328+00	2026-08-09 00:00:00	2026-08-14 00:00:00	7	6
122	2026-09-15 14:58:29.609328+00	2026-08-14 00:00:00	\N	7	7
123	2026-09-15 14:58:29.609328+00	2026-08-17 00:00:00	2026-08-22 00:00:00	8	6
124	2026-09-15 14:58:29.609328+00	2026-08-22 00:00:00	\N	8	7
125	2026-09-15 14:58:29.609328+00	2026-08-26 00:00:00	2026-08-31 00:00:00	9	6
126	2026-09-15 14:58:29.609328+00	2026-08-31 00:00:00	\N	9	7
\.


--
-- Data for Name: meta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meta (id, unidade_negocio_id, tipo_meta, periodo_inicio, periodo_fim, valor_meta, campanha_id) FROM stdin;
1	1	Receita	2026-06-01	2026-06-30	60000.00	1
2	1	Leads	2026-06-01	2026-06-30	3.00	1
3	1	Oportunidades	2026-06-01	2026-06-30	2.00	1
4	1	Receita	2026-07-01	2026-07-31	75000.00	2
5	1	Leads	2026-07-01	2026-07-31	4.00	2
6	1	Oportunidades	2026-07-01	2026-07-31	3.00	2
7	1	Receita	2026-08-01	2026-08-31	100000.00	3
8	1	Leads	2026-08-01	2026-08-31	5.00	3
9	1	Oportunidades	2026-08-01	2026-08-31	4.00	3
10	1	Receita	2026-09-01	2026-09-30	130000.00	4
11	1	Leads	2026-09-01	2026-09-30	7.00	4
12	1	Oportunidades	2026-09-01	2026-09-30	5.00	4
13	2	Receita	2026-06-01	2026-06-30	400000.00	5
14	2	Leads	2026-06-01	2026-06-30	3.00	5
15	2	Oportunidades	2026-06-01	2026-06-30	2.00	5
16	2	Receita	2026-07-01	2026-07-31	500000.00	6
17	2	Leads	2026-07-01	2026-07-31	4.00	6
18	2	Oportunidades	2026-07-01	2026-07-31	3.00	6
19	2	Receita	2026-08-01	2026-08-31	650000.00	7
20	2	Leads	2026-08-01	2026-08-31	5.00	7
21	2	Oportunidades	2026-08-01	2026-08-31	4.00	7
22	2	Receita	2026-09-01	2026-09-30	800000.00	8
23	2	Leads	2026-09-01	2026-09-30	7.00	8
24	2	Oportunidades	2026-09-01	2026-09-30	5.00	8
25	3	Receita	2026-06-01	2026-06-30	120000.00	9
26	3	Leads	2026-06-01	2026-06-30	3.00	9
27	3	Oportunidades	2026-06-01	2026-06-30	2.00	9
28	3	Receita	2026-07-01	2026-07-31	150000.00	10
29	3	Leads	2026-07-01	2026-07-31	3.00	10
30	3	Oportunidades	2026-07-01	2026-07-31	2.00	10
31	3	Receita	2026-08-01	2026-08-31	200000.00	11
32	3	Leads	2026-08-01	2026-08-31	5.00	11
33	3	Oportunidades	2026-08-01	2026-08-31	4.00	11
34	3	Receita	2026-09-01	2026-09-30	250000.00	12
35	3	Leads	2026-09-01	2026-09-30	7.00	12
36	3	Oportunidades	2026-09-01	2026-09-30	5.00	12
37	1	Receita	2026-09-01	2026-09-30	13000.00	\N
40	2	Receita	2026-09-01	2026-09-30	80000.00	\N
43	3	Receita	2026-09-01	2026-09-30	25000.00	\N
44	3	Leads	2026-09-01	2026-09-30	20.00	\N
41	2	Leads	2026-09-01	2026-09-30	20.00	\N
38	1	Leads	2026-09-01	2026-09-30	20.00	\N
39	1	Oportunidades	2026-09-01	2026-09-30	15.00	\N
42	2	Oportunidades	2026-09-01	2026-09-30	10.00	\N
45	3	Oportunidades	2026-09-01	2026-09-30	15.00	\N
\.


--
-- Data for Name: operacao_patrimonial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operacao_patrimonial (id, oportunidade_id, tipo_operacao, valor_operacao, data_inicio, data_conclusao, status, data_previsao_conclusao, cliente_id, comissao) FROM stdin;
1	17	Aquisição	632599.95	2026-08-04	2026-08-04	Concluída	2026-08-04	13	18978.00
2	18	Venda	404203.96	2026-08-11	2026-08-11	Concluída	2026-08-11	15	12126.12
3	19	Permuta	231334.40	2026-08-19	2026-08-19	Concluída	2026-08-19	14	6940.03
4	12	Aquisição	545543.62	2026-06-09	\N	Em andamento	2026-10-15	12	16366.31
5	13	Venda	343921.36	2026-06-23	\N	Prevista	2026-11-10	13	10317.64
6	14	Permuta	210459.73	2026-07-07	\N	Em andamento	2026-10-25	14	6313.79
7	15	Aquisição	186995.58	2026-07-18	\N	Prevista	2026-11-20	11	5609.87
8	16	Venda	228454.98	2026-07-29	\N	Em andamento	2026-10-30	12	6853.65
\.


--
-- Data for Name: projeto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projeto (id, contrato_id, nome, descricao, data_inicio, data_previsao_entrega, data_entrega, valor_projeto, status, equipe_id) FROM stdin;
1	2	Projeto Analytics B2B	Implementação de solução de analytics e indicadores para operação B2B.	2026-08-22	2026-11-05	\N	129769.25	Em andamento	4
3	1	Projeto Plataforma de Gestão	Desenvolvimento de plataforma personalizada para gestão empresarial.	2026-08-14	2026-09-20	\N	208519.85	Em andamento	4
2	4	Projeto Integração de Sistemas	Integração de sistemas e APIs para centralização de operações.	2026-09-06	2026-12-05	2026-09-10	76010.72	Entregue	4
4	3	Projeto Automação de Processos	Automação de processos internos e integração de fluxos operacionais.	2026-09-03	2026-11-02	2026-09-07	63263.39	Entregue	4
\.


--
-- Data for Name: receita; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receita (id, contratacao_id, data, valor, tipo, status, contrato_id, unidade_negocio_id, operacao_id, oportunidade_id) FROM stdin;
1	2	2026-08-09	2969.72	Recorrente	Realizada	\N	1	\N	7
2	3	2026-08-17	2595.07	Recorrente	Realizada	\N	1	\N	8
3	4	2026-08-26	4146.94	Recorrente	Realizada	\N	1	\N	9
4	\N	2026-08-11	12126.12	Comissão	Realizada	\N	2	2	18
5	\N	2026-08-04	18978.00	Comissão	Realizada	\N	2	1	17
6	\N	2026-08-19	6940.03	Comissão	Realizada	\N	2	3	19
8	\N	2026-09-06	76010.72	Projeto	Realizada	4	3	\N	30
10	\N	2026-09-03	63263.39	Projeto	Realizada	3	3	\N	29
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-08-27 20:22:02
20211116045059	2026-08-27 20:22:02
20211116050929	2026-08-27 20:22:02
20211116051442	2026-08-27 20:22:02
20211116212300	2026-08-27 20:22:02
20211116213355	2026-08-27 20:22:02
20211116213934	2026-08-27 20:22:02
20211116214523	2026-08-27 20:22:02
20211122062447	2026-08-27 20:22:02
20211124070109	2026-08-27 20:22:02
20211202204204	2026-08-27 20:22:02
20211202204605	2026-08-27 20:22:02
20211210212804	2026-08-27 20:22:02
20211228014915	2026-08-27 20:22:02
20220107221237	2026-08-27 20:22:02
20220228202821	2026-08-27 20:22:02
20220312004840	2026-08-27 20:22:02
20220603231003	2026-08-27 20:22:02
20220603232444	2026-08-27 20:22:02
20220615214548	2026-08-27 20:22:02
20220712093339	2026-08-27 20:22:02
20220908172859	2026-08-27 20:22:02
20220916233421	2026-08-27 20:22:02
20230119133233	2026-08-27 20:22:02
20230128025114	2026-08-27 20:22:02
20230128025212	2026-08-27 20:22:02
20230227211149	2026-08-27 20:22:02
20230228184745	2026-08-27 20:22:02
20230308225145	2026-08-27 20:22:02
20230328144023	2026-08-27 20:22:02
20231018144023	2026-08-27 20:22:02
20231204144023	2026-08-27 20:22:02
20231204144024	2026-08-27 20:22:02
20231204144025	2026-08-27 20:22:02
20240108234812	2026-08-27 20:22:02
20240109165339	2026-08-27 20:22:02
20240227174441	2026-08-27 20:22:02
20240311171622	2026-08-27 20:22:02
20240321100241	2026-08-27 20:22:02
20240401105812	2026-08-27 20:22:02
20240418121054	2026-08-27 20:22:02
20240523004032	2026-08-27 20:22:02
20240618124746	2026-08-27 20:22:02
20240801235015	2026-08-27 20:22:02
20240805133720	2026-08-27 20:22:02
20240827160934	2026-08-27 20:22:02
20240919163303	2026-08-27 20:22:02
20240919163305	2026-08-27 20:22:02
20241019105805	2026-08-27 20:22:02
20241030150047	2026-08-27 20:22:02
20241108114728	2026-08-27 20:22:02
20241121104152	2026-08-27 20:22:02
20241130184212	2026-08-27 20:22:02
20241220035512	2026-08-27 20:22:02
20241220123912	2026-08-27 20:22:02
20241224161212	2026-08-27 20:22:02
20250107150512	2026-08-27 20:22:02
20250110162412	2026-08-27 20:22:02
20250123174212	2026-08-27 20:22:02
20250128220012	2026-08-27 20:22:02
20250506224012	2026-08-27 20:22:02
20250523164012	2026-08-27 20:22:02
20250714121412	2026-08-27 20:22:02
20250905041441	2026-08-27 20:22:02
20251103001201	2026-08-27 20:22:02
20251120212548	2026-08-27 20:22:02
20251120215549	2026-08-27 20:22:02
20260218120000	2026-08-27 20:22:02
20260326120000	2026-08-27 20:22:02
20260514120000	2026-08-27 20:22:02
20260527120000	2026-08-27 20:22:02
20260528120000	2026-08-27 20:22:02
20260603120000	2026-08-27 20:22:02
20260605120000	2026-08-27 20:22:02
20260606110000	2026-08-27 20:22:02
20260616120000	2026-08-27 20:22:02
20260624120000	2026-08-27 20:22:02
20260626120000	2026-08-27 20:22:02
20260706120000	2026-08-27 20:22:02
20260707120000	2026-08-27 20:22:02
20260709120000	2026-08-27 20:22:02
20260714120000	2026-09-04 19:51:25
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type, versioning_status) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-08-27 19:29:07.612422
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-08-27 19:29:07.684411
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-08-27 19:29:07.739249
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-08-27 19:29:07.81093
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-08-27 19:29:07.830232
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-08-27 19:29:07.833801
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-08-27 19:29:07.837557
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-08-27 19:29:07.84151
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-08-27 19:29:07.844879
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-08-27 19:29:07.848663
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-08-27 19:29:07.852828
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-08-27 19:29:07.857721
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-08-27 19:29:07.861636
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-08-27 19:29:07.86501
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-08-27 19:29:07.87038
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-08-27 19:29:07.896176
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-08-27 19:29:07.901151
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-08-27 19:29:07.904866
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-08-27 19:29:07.908446
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-08-27 19:29:07.913585
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-08-27 19:29:07.918467
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-08-27 19:29:07.923672
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-08-27 19:29:07.936194
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-08-27 19:29:07.947403
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-08-27 19:29:07.950971
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-08-27 19:29:07.954769
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-08-27 19:29:07.958551
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-08-27 19:29:07.961613
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-08-27 19:29:07.964643
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-08-27 19:29:07.967765
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-08-27 19:29:07.970938
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-08-27 19:29:07.973934
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-08-27 19:29:07.977053
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-08-27 19:29:07.980682
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-08-27 19:29:07.983632
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-08-27 19:29:07.986708
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-08-27 19:29:07.99334
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-08-27 19:29:07.99666
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-08-27 19:29:08.000809
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-08-27 19:29:08.01343
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-08-27 19:29:08.016823
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-08-27 19:29:08.020517
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-08-27 19:29:08.023853
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-08-27 19:29:08.027194
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-08-27 19:29:08.030495
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-08-27 19:29:08.035654
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-08-27 19:29:08.046311
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-08-27 19:29:08.050294
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-08-27 19:29:08.053354
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-08-27 19:29:08.069385
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-08-27 19:29:08.073459
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-08-27 19:29:08.096683
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-08-27 19:29:08.098627
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-08-27 19:29:08.112938
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-08-27 19:29:08.117305
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-08-27 19:29:08.120719
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-08-27 19:29:08.128427
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-08-27 19:29:08.134804
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-08-27 19:29:08.13869
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-08-27 19:29:08.145839
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-08-27 19:29:08.150936
61	mark-filename-immutable	fe0096517ae9d60aaec1d110172ba9036dc66bb7	2026-08-27 19:29:08.155314
62	object-versioning-core	0b855f00ff3be0bfca91efee02a9858912491a9a	2026-08-27 19:29:08.159119
63	fix-search-name-relative-to-prefix	c7485e417624f795ce8bb2da21927f48e088904d	2026-08-27 19:29:08.165636
64	fix-search-by-timestamp-sqli	0af424ecd388a39bb1645184b222185a12149675	2026-08-27 19:29:08.17011
65	objects-key-version-index	603c1c55658e982d35839001e2c2b59a50703904	2026-09-07 21:57:35.064807
66	objects-current-version-index	191466c93aa2c46a00e36505577c5fcab8d7cb4b	2026-09-07 21:57:35.079471
67	objects-null-version-index	15bfe8c35b66642b6c78ba60060fa8793bd2207a	2026-09-07 21:57:35.09265
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, archived_at, is_delete_marker, is_versioned) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: atendimento_pos_venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atendimento_pos_venda_id_seq', 1, false);


--
-- Name: campanha_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campanha_id_seq', 12, true);


--
-- Name: canal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canal_id_seq', 6, true);


--
-- Name: consultor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultor_id_seq', 8, true);


--
-- Name: contratacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contratacao_id_seq', 4, true);


--
-- Name: contrato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contrato_id_seq', 4, true);


--
-- Name: empresa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_id_seq', 15, true);


--
-- Name: equipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipe_id_seq', 4, true);


--
-- Name: etapa_funil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etapa_funil_id_seq', 26, true);


--
-- Name: historico_oportunidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_oportunidade_id_seq', 126, true);


--
-- Name: lead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lead_id_seq', 80, true);


--
-- Name: meta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meta_id_seq', 45, true);


--
-- Name: objetivo_patrimonial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.objetivo_patrimonial_id_seq', 3, true);


--
-- Name: operacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operacao_id_seq', 8, true);


--
-- Name: operadora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operadora_id_seq', 3, true);


--
-- Name: oportunidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.oportunidade_id_seq', 32, true);


--
-- Name: plano_saude_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plano_saude_id_seq', 3, true);


--
-- Name: projeto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projeto_id_seq', 4, true);


--
-- Name: receita_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.receita_id_seq', 10, true);


--
-- Name: unidade_negocio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unidade_negocio_id_seq', 3, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

\unrestrict 4GMZCPq77cJDqCRyT2ApB1VuAq3oXDrix5wCZb56KHcVrWV8h7ujhxqFcycdNlk


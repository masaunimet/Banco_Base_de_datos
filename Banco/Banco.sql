--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: genero; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.genero AS ENUM (
    'Hombre',
    'Mujer',
    'Otro'
);


ALTER TYPE public.genero OWNER TO postgres;

--
-- Name: nacionalidad; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.nacionalidad AS ENUM (
    'V',
    'E'
);


ALTER TYPE public.nacionalidad OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: beneficio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.beneficio (
    id integer NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE public.beneficio OWNER TO postgres;

--
-- Name: beneficio_hijo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.beneficio_hijo (
    id_beneficio integer NOT NULL,
    id_hijo integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL
);


ALTER TABLE public.beneficio_hijo OWNER TO postgres;

--
-- Name: beneficio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.beneficio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beneficio_id_seq OWNER TO postgres;

--
-- Name: beneficio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.beneficio_id_seq OWNED BY public.beneficio.id;


--
-- Name: cuenta_ahorro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_ahorro (
    id_cuenta integer NOT NULL,
    porcentaje_retorno integer NOT NULL,
    mes_retorno integer NOT NULL,
    CONSTRAINT cuenta_ahorro_mes_retorno_check CHECK (((mes_retorno > 0) AND (mes_retorno < 13))),
    CONSTRAINT cuenta_ahorro_porcentaje_retorno_check CHECK (((porcentaje_retorno > 0) AND (porcentaje_retorno < 50)))
);


ALTER TABLE public.cuenta_ahorro OWNER TO postgres;

--
-- Name: cuenta_bancaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_bancaria (
    id integer NOT NULL,
    id_sede integer NOT NULL,
    id_persona integer NOT NULL,
    saldo integer NOT NULL,
    CONSTRAINT cuenta_bancaria_saldo_check CHECK ((saldo > 0))
);


ALTER TABLE public.cuenta_bancaria OWNER TO postgres;

--
-- Name: cuenta_bancaria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_bancaria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuenta_bancaria_id_seq OWNER TO postgres;

--
-- Name: cuenta_bancaria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_bancaria_id_seq OWNED BY public.cuenta_bancaria.id;


--
-- Name: cuenta_corriente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_corriente (
    id_cuenta integer NOT NULL,
    id_instrumento_cuenta_corriente integer NOT NULL
);


ALTER TABLE public.cuenta_corriente OWNER TO postgres;

--
-- Name: cuenta_inversion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_inversion (
    id_cuenta integer NOT NULL,
    retorno integer NOT NULL
);


ALTER TABLE public.cuenta_inversion OWNER TO postgres;

--
-- Name: cuenta_receptor_transicion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_receptor_transicion (
    id integer NOT NULL,
    id_cuenta_emisor integer NOT NULL,
    id_cuenta_receptor integer NOT NULL
);


ALTER TABLE public.cuenta_receptor_transicion OWNER TO postgres;

--
-- Name: cuenta_receptor_transicion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_receptor_transicion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuenta_receptor_transicion_id_seq OWNER TO postgres;

--
-- Name: cuenta_receptor_transicion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_receptor_transicion_id_seq OWNED BY public.cuenta_receptor_transicion.id;


--
-- Name: departamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamentos (
    id integer NOT NULL,
    nombre character varying(30) NOT NULL,
    id_sede integer NOT NULL
);


ALTER TABLE public.departamentos OWNER TO postgres;

--
-- Name: departamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departamentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departamentos_id_seq OWNER TO postgres;

--
-- Name: departamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departamentos_id_seq OWNED BY public.departamentos.id;


--
-- Name: deuda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deuda (
    id_cuenta integer NOT NULL,
    monto integer NOT NULL,
    interes integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    CONSTRAINT deuda_interes_check CHECK (((interes > 0) AND (interes < 100))),
    CONSTRAINT deuda_monto_check CHECK ((monto > 0))
);


ALTER TABLE public.deuda OWNER TO postgres;

--
-- Name: direccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direccion (
    id_persona integer NOT NULL,
    pais character varying(20),
    estado character varying(20),
    municipio character varying(20),
    parroquia character varying(20),
    calle character varying(20),
    residencia character varying(20)
);


ALTER TABLE public.direccion OWNER TO postgres;

--
-- Name: direccion_sede; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direccion_sede (
    id_sede integer NOT NULL,
    pais character varying(20),
    estado character varying(20),
    municipio character varying(20),
    parroquia character varying(20),
    calle character varying(20),
    residencia character varying(20)
);


ALTER TABLE public.direccion_sede OWNER TO postgres;

--
-- Name: emp_con_contrato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emp_con_contrato (
    id_persona integer NOT NULL,
    id_departamento integer NOT NULL,
    id_puesto_de_trabajo integer NOT NULL
);


ALTER TABLE public.emp_con_contrato OWNER TO postgres;

--
-- Name: emp_sin_contrato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emp_sin_contrato (
    id_persona integer NOT NULL,
    nombre_cargo character varying(20) NOT NULL,
    dinero_por_hora integer NOT NULL,
    id_departamento integer NOT NULL,
    CONSTRAINT emp_sin_contrato_dinero_por_hora_check CHECK ((dinero_por_hora > 0))
);


ALTER TABLE public.emp_sin_contrato OWNER TO postgres;

--
-- Name: hijo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hijo (
    id integer NOT NULL,
    id_padre integer NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido character varying(20) NOT NULL,
    fecha_nacimiento date NOT NULL,
    CONSTRAINT hijo_fecha_nacimiento_check CHECK ((date_part('year'::text, age((fecha_nacimiento)::timestamp with time zone)) < (8)::double precision))
);


ALTER TABLE public.hijo OWNER TO postgres;

--
-- Name: hijo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hijo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hijo_id_seq OWNER TO postgres;

--
-- Name: hijo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hijo_id_seq OWNED BY public.hijo.id;


--
-- Name: instrumento_cuenta_corriente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instrumento_cuenta_corriente (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.instrumento_cuenta_corriente OWNER TO postgres;

--
-- Name: instrumento_cuenta_corriente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instrumento_cuenta_corriente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instrumento_cuenta_corriente_id_seq OWNER TO postgres;

--
-- Name: instrumento_cuenta_corriente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instrumento_cuenta_corriente_id_seq OWNED BY public.instrumento_cuenta_corriente.id;


--
-- Name: jefe_departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jefe_departamento (
    id_departamento integer NOT NULL,
    id_persona integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL
);


ALTER TABLE public.jefe_departamento OWNER TO postgres;

--
-- Name: jefe_sede; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jefe_sede (
    id_sede integer NOT NULL,
    id_persona integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL
);


ALTER TABLE public.jefe_sede OWNER TO postgres;

--
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    id integer NOT NULL,
    cedula integer NOT NULL,
    primer_nombre character varying(15) NOT NULL,
    segundo_nombre character varying(15),
    primer_apellido character varying(15) NOT NULL,
    segundo_apellido character varying(15),
    nacionalidad public.nacionalidad NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero public.genero NOT NULL
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- Name: persona_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.persona_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.persona_id_seq OWNER TO postgres;

--
-- Name: persona_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.persona_id_seq OWNED BY public.persona.id;


--
-- Name: puesto_de_trabajo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.puesto_de_trabajo (
    id integer NOT NULL,
    id_departamento integer NOT NULL,
    nombre character varying(30) NOT NULL,
    salario integer NOT NULL,
    CONSTRAINT puesto_de_trabajo_salario_check CHECK ((salario > 0))
);


ALTER TABLE public.puesto_de_trabajo OWNER TO postgres;

--
-- Name: puesto_de_trabajo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.puesto_de_trabajo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.puesto_de_trabajo_id_seq OWNER TO postgres;

--
-- Name: puesto_de_trabajo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.puesto_de_trabajo_id_seq OWNED BY public.puesto_de_trabajo.id;


--
-- Name: sede; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sede (
    id integer NOT NULL,
    num_cajeros integer,
    CONSTRAINT sede_num_cajeros_check CHECK ((num_cajeros > 2))
);


ALTER TABLE public.sede OWNER TO postgres;

--
-- Name: sede_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sede_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sede_id_seq OWNER TO postgres;

--
-- Name: sede_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sede_id_seq OWNED BY public.sede.id;


--
-- Name: telefonos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefonos (
    id_persona integer NOT NULL,
    casa integer,
    movil integer,
    movil_2 integer
);


ALTER TABLE public.telefonos OWNER TO postgres;

--
-- Name: transacciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transacciones (
    id integer NOT NULL,
    id_partes_involucradas integer NOT NULL,
    monto integer NOT NULL,
    motivo character varying(100),
    fecha date NOT NULL,
    CONSTRAINT transacciones_monto_check CHECK ((monto < 0))
);


ALTER TABLE public.transacciones OWNER TO postgres;

--
-- Name: transacciones_con_comision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transacciones_con_comision (
    id_transaccion integer NOT NULL,
    porcentaje_comision integer NOT NULL,
    CONSTRAINT transacciones_con_comision_porcentaje_comision_check CHECK (((porcentaje_comision > 0) AND (porcentaje_comision < 30)))
);


ALTER TABLE public.transacciones_con_comision OWNER TO postgres;

--
-- Name: transacciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transacciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transacciones_id_seq OWNER TO postgres;

--
-- Name: transacciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transacciones_id_seq OWNED BY public.transacciones.id;


--
-- Name: beneficio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficio ALTER COLUMN id SET DEFAULT nextval('public.beneficio_id_seq'::regclass);


--
-- Name: cuenta_bancaria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria ALTER COLUMN id SET DEFAULT nextval('public.cuenta_bancaria_id_seq'::regclass);


--
-- Name: cuenta_receptor_transicion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_receptor_transicion ALTER COLUMN id SET DEFAULT nextval('public.cuenta_receptor_transicion_id_seq'::regclass);


--
-- Name: departamentos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos ALTER COLUMN id SET DEFAULT nextval('public.departamentos_id_seq'::regclass);


--
-- Name: hijo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hijo ALTER COLUMN id SET DEFAULT nextval('public.hijo_id_seq'::regclass);


--
-- Name: instrumento_cuenta_corriente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrumento_cuenta_corriente ALTER COLUMN id SET DEFAULT nextval('public.instrumento_cuenta_corriente_id_seq'::regclass);


--
-- Name: persona id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona ALTER COLUMN id SET DEFAULT nextval('public.persona_id_seq'::regclass);


--
-- Name: puesto_de_trabajo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puesto_de_trabajo ALTER COLUMN id SET DEFAULT nextval('public.puesto_de_trabajo_id_seq'::regclass);


--
-- Name: sede id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sede ALTER COLUMN id SET DEFAULT nextval('public.sede_id_seq'::regclass);


--
-- Name: transacciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones ALTER COLUMN id SET DEFAULT nextval('public.transacciones_id_seq'::regclass);


--
-- Data for Name: beneficio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.beneficio (id, nombre) FROM stdin;
\.


--
-- Data for Name: beneficio_hijo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.beneficio_hijo (id_beneficio, id_hijo, fecha_inicio, fecha_fin) FROM stdin;
\.


--
-- Data for Name: cuenta_ahorro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_ahorro (id_cuenta, porcentaje_retorno, mes_retorno) FROM stdin;
\.


--
-- Data for Name: cuenta_bancaria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_bancaria (id, id_sede, id_persona, saldo) FROM stdin;
\.


--
-- Data for Name: cuenta_corriente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_corriente (id_cuenta, id_instrumento_cuenta_corriente) FROM stdin;
\.


--
-- Data for Name: cuenta_inversion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_inversion (id_cuenta, retorno) FROM stdin;
\.


--
-- Data for Name: cuenta_receptor_transicion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_receptor_transicion (id, id_cuenta_emisor, id_cuenta_receptor) FROM stdin;
\.


--
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departamentos (id, nombre, id_sede) FROM stdin;
\.


--
-- Data for Name: deuda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deuda (id_cuenta, monto, interes, fecha_inicio, fecha_fin) FROM stdin;
\.


--
-- Data for Name: direccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direccion (id_persona, pais, estado, municipio, parroquia, calle, residencia) FROM stdin;
\.


--
-- Data for Name: direccion_sede; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direccion_sede (id_sede, pais, estado, municipio, parroquia, calle, residencia) FROM stdin;
\.


--
-- Data for Name: emp_con_contrato; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emp_con_contrato (id_persona, id_departamento, id_puesto_de_trabajo) FROM stdin;
\.


--
-- Data for Name: emp_sin_contrato; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emp_sin_contrato (id_persona, nombre_cargo, dinero_por_hora, id_departamento) FROM stdin;
\.


--
-- Data for Name: hijo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hijo (id, id_padre, nombre, apellido, fecha_nacimiento) FROM stdin;
\.


--
-- Data for Name: instrumento_cuenta_corriente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrumento_cuenta_corriente (id, nombre) FROM stdin;
\.


--
-- Data for Name: jefe_departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jefe_departamento (id_departamento, id_persona, fecha_inicio, fecha_fin) FROM stdin;
\.


--
-- Data for Name: jefe_sede; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jefe_sede (id_sede, id_persona, fecha_inicio, fecha_fin) FROM stdin;
\.


--
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona (id, cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, nacionalidad, fecha_nacimiento, genero) FROM stdin;
\.


--
-- Data for Name: puesto_de_trabajo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.puesto_de_trabajo (id, id_departamento, nombre, salario) FROM stdin;
\.


--
-- Data for Name: sede; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sede (id, num_cajeros) FROM stdin;
\.


--
-- Data for Name: telefonos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefonos (id_persona, casa, movil, movil_2) FROM stdin;
\.


--
-- Data for Name: transacciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transacciones (id, id_partes_involucradas, monto, motivo, fecha) FROM stdin;
\.


--
-- Data for Name: transacciones_con_comision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transacciones_con_comision (id_transaccion, porcentaje_comision) FROM stdin;
\.


--
-- Name: beneficio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.beneficio_id_seq', 1, false);


--
-- Name: cuenta_bancaria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_bancaria_id_seq', 1, false);


--
-- Name: cuenta_receptor_transicion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_receptor_transicion_id_seq', 1, false);


--
-- Name: departamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departamentos_id_seq', 1, false);


--
-- Name: hijo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hijo_id_seq', 1, false);


--
-- Name: instrumento_cuenta_corriente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrumento_cuenta_corriente_id_seq', 1, false);


--
-- Name: persona_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.persona_id_seq', 1, false);


--
-- Name: puesto_de_trabajo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.puesto_de_trabajo_id_seq', 1, false);


--
-- Name: sede_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sede_id_seq', 1, false);


--
-- Name: transacciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transacciones_id_seq', 1, false);


--
-- Name: cuenta_ahorro ahorro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_ahorro
    ADD CONSTRAINT ahorro_pkey PRIMARY KEY (id_cuenta);


--
-- Name: beneficio_hijo beneficio_hijo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficio_hijo
    ADD CONSTRAINT beneficio_hijo_pkey PRIMARY KEY (id_beneficio, id_hijo, fecha_inicio);


--
-- Name: beneficio beneficio_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficio
    ADD CONSTRAINT beneficio_nombre_key UNIQUE (nombre);


--
-- Name: beneficio beneficio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficio
    ADD CONSTRAINT beneficio_pkey PRIMARY KEY (id);


--
-- Name: cuenta_corriente corriente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_corriente
    ADD CONSTRAINT corriente_pkey PRIMARY KEY (id_cuenta, id_instrumento_cuenta_corriente);


--
-- Name: cuenta_receptor_transicion crt__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_receptor_transicion
    ADD CONSTRAINT crt__pkey PRIMARY KEY (id);


--
-- Name: cuenta_bancaria cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (id);


--
-- Name: departamentos departamentos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_nombre_key UNIQUE (nombre);


--
-- Name: departamentos departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id);


--
-- Name: deuda deuda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deuda
    ADD CONSTRAINT deuda_pkey PRIMARY KEY (id_cuenta);


--
-- Name: direccion_sede dir_sede_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion_sede
    ADD CONSTRAINT dir_sede_pkey PRIMARY KEY (id_sede);


--
-- Name: direccion direccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_pkey PRIMARY KEY (id_persona);


--
-- Name: emp_con_contrato emp_con_contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emp_con_contrato
    ADD CONSTRAINT emp_con_contrato_pkey PRIMARY KEY (id_persona);


--
-- Name: emp_sin_contrato emp_sin_contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emp_sin_contrato
    ADD CONSTRAINT emp_sin_contrato_pkey PRIMARY KEY (id_persona);


--
-- Name: hijo hijo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hijo
    ADD CONSTRAINT hijo_pkey PRIMARY KEY (id);


--
-- Name: instrumento_cuenta_corriente instrumento_cuenta_corriente_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrumento_cuenta_corriente
    ADD CONSTRAINT instrumento_cuenta_corriente_nombre_key UNIQUE (nombre);


--
-- Name: instrumento_cuenta_corriente instrumento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrumento_cuenta_corriente
    ADD CONSTRAINT instrumento_pkey PRIMARY KEY (id);


--
-- Name: cuenta_inversion inversion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_inversion
    ADD CONSTRAINT inversion_pkey PRIMARY KEY (id_cuenta);


--
-- Name: jefe_departamento jefe_departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jefe_departamento
    ADD CONSTRAINT jefe_departamento_pkey PRIMARY KEY (id_departamento, id_persona, fecha_inicio);


--
-- Name: jefe_sede jefe_sede_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jefe_sede
    ADD CONSTRAINT jefe_sede_pkey PRIMARY KEY (id_sede, id_persona, fecha_inicio);


--
-- Name: persona persona_cedula_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_cedula_key UNIQUE (cedula);


--
-- Name: persona persona_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pk PRIMARY KEY (id);


--
-- Name: puesto_de_trabajo puesto_de_trabajo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puesto_de_trabajo
    ADD CONSTRAINT puesto_de_trabajo_pkey PRIMARY KEY (id);


--
-- Name: sede sedes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sede
    ADD CONSTRAINT sedes_pkey PRIMARY KEY (id);


--
-- Name: transacciones_con_comision tcc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_con_comision
    ADD CONSTRAINT tcc_pkey PRIMARY KEY (id_transaccion);


--
-- Name: telefonos telefono_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefonos
    ADD CONSTRAINT telefono_pkey PRIMARY KEY (id_persona);


--
-- Name: transacciones transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id);


--
-- Name: cuenta_ahorro ahorro_id_cuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_ahorro
    ADD CONSTRAINT ahorro_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuenta_bancaria(id) ON DELETE CASCADE;


--
-- Name: beneficio_hijo beneficio_hijo_id_beneficio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficio_hijo
    ADD CONSTRAINT beneficio_hijo_id_beneficio_fkey FOREIGN KEY (id_beneficio) REFERENCES public.beneficio(id) ON DELETE CASCADE;


--
-- Name: beneficio_hijo beneficio_hijo_id_hijo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficio_hijo
    ADD CONSTRAINT beneficio_hijo_id_hijo_fkey FOREIGN KEY (id_hijo) REFERENCES public.hijo(id) ON DELETE CASCADE;


--
-- Name: cuenta_corriente corriente_id_cuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_corriente
    ADD CONSTRAINT corriente_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuenta_bancaria(id) ON DELETE CASCADE;


--
-- Name: cuenta_corriente corriente_id_instrumento_cuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_corriente
    ADD CONSTRAINT corriente_id_instrumento_cuenta_fkey FOREIGN KEY (id_instrumento_cuenta_corriente) REFERENCES public.instrumento_cuenta_corriente(id) ON DELETE CASCADE;


--
-- Name: cuenta_receptor_transicion crt_id_cuenta_emisor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_receptor_transicion
    ADD CONSTRAINT crt_id_cuenta_emisor_fkey FOREIGN KEY (id_cuenta_emisor) REFERENCES public.cuenta_bancaria(id) ON DELETE CASCADE;


--
-- Name: cuenta_receptor_transicion crt_id_cuenta_receptor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_receptor_transicion
    ADD CONSTRAINT crt_id_cuenta_receptor_fkey FOREIGN KEY (id_cuenta_receptor) REFERENCES public.cuenta_bancaria(id) ON DELETE CASCADE;


--
-- Name: cuenta_bancaria cuenta_id_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_id_persona FOREIGN KEY (id_persona) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: cuenta_bancaria cuenta_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sede(id) ON DELETE CASCADE;


--
-- Name: departamentos departamentos_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sede(id) ON DELETE CASCADE;


--
-- Name: emp_sin_contrato dept_emp_dept_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emp_sin_contrato
    ADD CONSTRAINT dept_emp_dept_no_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id) ON DELETE CASCADE;


--
-- Name: deuda deuda_id_cuenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deuda
    ADD CONSTRAINT deuda_id_cuenta FOREIGN KEY (id_cuenta) REFERENCES public.cuenta_bancaria(id) ON DELETE CASCADE;


--
-- Name: direccion_sede dir_sede_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion_sede
    ADD CONSTRAINT dir_sede_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sede(id) ON DELETE CASCADE;


--
-- Name: direccion direccion_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: emp_con_contrato emp_con_contrato_dept_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emp_con_contrato
    ADD CONSTRAINT emp_con_contrato_dept_no_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id) ON DELETE CASCADE;


--
-- Name: emp_con_contrato emp_con_contrato_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emp_con_contrato
    ADD CONSTRAINT emp_con_contrato_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: emp_con_contrato emp_con_contrato_puesto_trabajo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emp_con_contrato
    ADD CONSTRAINT emp_con_contrato_puesto_trabajo_fkey FOREIGN KEY (id_puesto_de_trabajo) REFERENCES public.puesto_de_trabajo(id) ON DELETE CASCADE;


--
-- Name: emp_sin_contrato emp_sin_contrato_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emp_sin_contrato
    ADD CONSTRAINT emp_sin_contrato_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: hijo hijo_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hijo
    ADD CONSTRAINT hijo_id_persona_fkey FOREIGN KEY (id_padre) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: cuenta_inversion inversion_id_cuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_inversion
    ADD CONSTRAINT inversion_id_cuenta_fkey FOREIGN KEY (id_cuenta) REFERENCES public.cuenta_bancaria(id) ON DELETE CASCADE;


--
-- Name: jefe_departamento jefe_departamento_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jefe_departamento
    ADD CONSTRAINT jefe_departamento_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: jefe_departamento jefe_departamento_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jefe_departamento
    ADD CONSTRAINT jefe_departamento_id_sede_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id) ON DELETE CASCADE;


--
-- Name: jefe_sede jefe_sede_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jefe_sede
    ADD CONSTRAINT jefe_sede_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: jefe_sede jefe_sede_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jefe_sede
    ADD CONSTRAINT jefe_sede_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sede(id) ON DELETE CASCADE;


--
-- Name: puesto_de_trabajo puesto_de_trabajo_dept_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puesto_de_trabajo
    ADD CONSTRAINT puesto_de_trabajo_dept_no_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id) ON DELETE CASCADE;


--
-- Name: transacciones_con_comision tcc_id_transacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones_con_comision
    ADD CONSTRAINT tcc_id_transacion_fkey FOREIGN KEY (id_transaccion) REFERENCES public.transacciones(id) ON DELETE CASCADE;


--
-- Name: telefonos telefono_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefonos
    ADD CONSTRAINT telefono_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.persona(id) ON DELETE CASCADE;


--
-- Name: transacciones transacciones_id_crt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacciones
    ADD CONSTRAINT transacciones_id_crt_fkey FOREIGN KEY (id_partes_involucradas) REFERENCES public.cuenta_receptor_transicion(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--TABLAS DE DIMENSIONES
CREATE TABLE dim_sede (
    sk_sede NUMERIC NOT NULL CONSTRAINT sk_dim_sede PRIMARY KEY,
    cod_pais NUMERIC NOT NULL,
    nb_pais CHARACTER VARYING(50) NOT NULL,
    cod_ciudad NUMERIC NOT NULL,   
    nb_ciudad CHARACTER VARYING(50) NOT NULL,
    cod_sede NUMERIC NOT NULL,
    nb_sede CHARACTER VARYING(50) NOT NULL
);

CREATE TABLE dim_leyenda(
    sk_leyenda NUMERIC NOT NULL CONSTRAINT sk_dim_leyenda PRIMARY KEY,
    cod_leyenda NUMERIC NOT NULL,
    nb_leyenda CHARACTER VARYING(50) NOT NULL
);

CREATE TABLE dim_visitante(
    sk_visitante NUMERIC NOT NULL CONSTRAINT sk_dim_visitante PRIMARY KEY,
    cod_visitante NUMERIC NOT NULL,
    cedula CHARACTER VARYING(50) NOT NULL,
    nb_visitante CHARACTER VARYING(50) NOT NULL,
    sexo CHARACTER VARYING(12) NOT NULL,
    email CHARACTER VARYING(50) NOT NULL
);

CREATE TABLE dim_evento(
    sk_evento NUMERIC NOT NULL CONSTRAINT sk_dim_evento PRIMARY KEY,
    cod_tipo_evento NUMERIC NOT NULL,
    nb_tipo_evento CHARACTER VARYING(50) NOT NULL,
    cod_evento NUMERIC NOT NULL,
    nb_evento CHARACTER VARYING(200),
    descripcion CHARACTER VARYING(500)
);

CREATE TABLE dim_tipo_stand(
    sk_tipo_stand NUMERIC NOT NULL CONSTRAINT sk_dim_tipo_stand PRIMARY KEY,
    cod_tipo_stand NUMERIC NOT NULL,
    nb_tipo_stand  CHARACTER VARYING(50)
);

CREATE TABLE dim_cliente(
    sk_cliente NUMERIC NOT NULL CONSTRAINT sk_dim_cliente PRIMARY KEY,
    cod_cliente NUMERIC NOT NULL,
    cl_rif CHARACTER VARYING(12) NOT NULL,
    nb_cliente CHARACTER VARYING(50) NOT NULL,
    telefono CHARACTER VARYING(12) NOT NULL,
    direccion CHARACTER VARYING(200) NOT NULL,
    email CHARACTER VARYING(50) NOT NULL
);

CREATE TABLE dim_categoria (
    sk_categoria NUMERIC NOT NULL CONSTRAINT sk_dim_categoria PRIMARY KEY,
    cod_subcategoria NUMERIC NOT NULL,
    nb_subcategoria CHARACTER VARYING(50) NOT NULL,
    cod_categoria NUMERIC NOT NULL,
    nb_categoria CHARACTER VARYING(50) NOT NULL
);

CREATE TABLE dim_tiempo(
    sk_tiempo NUMERIC NOT NULL CONSTRAINT sk_dim_tiempo PRIMARY KEY,
    fecha DATE NOT NULL,
    cod_anio NUMERIC NOT NULL,
    cod_mes NUMERIC NOT NULL,
    cod_dia_anio NUMERIC NOT NULL,
    cod_dia_mes NUMERIC NOT NULL,
    cod_dia_semana NUMERIC NOT NULL,
    cod_semana NUMERIC NOT NULL,
    desc_dia_semana CHARACTER VARYING(50) NOT NULL,
    desc_dia_semana_corta CHARACTER VARYING(50) NOT  NULL,
    desc_mes CHARACTER VARYING(50) NOT NULL,
    desc_mes_corta CHARACTER VARYING(50) NOT NULL,
    desc_trimestre CHARACTER VARYING(50) NOT NULL
);

-- TABLAS DE HECHOS


CREATE TABLE IF NOT EXISTS public.fact_evento
(
    sk_evento numeric NOT NULL,
    sk_sede numeric NOT NULL,
    sk_fec_evento numeric NOT NULL,
    cantidad_evento numeric NOT NULL,
    cantidad_estim_visitantes numeric NOT NULL,
    meta_ingreso numeric NOT NULL,
    CONSTRAINT fact_evento_pkey PRIMARY KEY (sk_evento, sk_sede, sk_fec_evento),
    CONSTRAINT sk_dim_evento FOREIGN KEY (sk_evento)
        REFERENCES public.dim_evento (sk_evento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_sede FOREIGN KEY (sk_sede)
        REFERENCES public.dim_sede (sk_sede) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_tiempo FOREIGN KEY (sk_fec_evento)
        REFERENCES public.dim_tiempo (sk_tiempo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fact_evento
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.fact_visita
(
    sk_evento numeric NOT NULL,
    sk_visitante numeric NOT NULL,
    sk_fec_entrada numeric NOT NULL,
    sk_leyenda numeric NOT NULL,
    num_entrada numeric NOT NULL,
    hora_entrada time without time zone NOT NULL,
    cantidad_visita numeric NOT NULL,
    calificacion numeric COLLATE pg_catalog."default",
    recomienda_amigo character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT fact_visita_pkey PRIMARY KEY (sk_evento, sk_visitante, sk_fec_entrada, sk_leyenda, num_entrada),
    CONSTRAINT sk_dim_evento FOREIGN KEY (sk_evento)
        REFERENCES public.dim_evento (sk_evento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_leyenda FOREIGN KEY (sk_leyenda)
        REFERENCES public.dim_leyenda (sk_leyenda) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_tiempo FOREIGN KEY (sk_fec_entrada)
        REFERENCES public.dim_tiempo (sk_tiempo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_visitante FOREIGN KEY (sk_visitante)
        REFERENCES public.dim_visitante (sk_visitante) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fact_visita
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.fact_evento_stand
(
    sk_evento numeric NOT NULL,
    sk_tipo_stand numeric NOT NULL,
    cantidad_estimada numeric NOT NULL,
    mt2 numeric NOT NULL,
    precio numeric NOT NULL,
    CONSTRAINT fact_evento_stand_pkey PRIMARY KEY (sk_evento, sk_tipo_stand),
    CONSTRAINT sk_dim_evento FOREIGN KEY (sk_evento)
        REFERENCES public.dim_evento (sk_evento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_tipo_stand FOREIGN KEY (sk_tipo_stand)
        REFERENCES public.dim_tipo_stand (sk_tipo_stand) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fact_evento_stand
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.fact_alquiler
(
    sk_evento numeric NOT NULL,
    sk_tipo_stand numeric NOT NULL,
    sk_fec_alquiler numeric NOT NULL,
    sk_cliente numeric NOT NULL,
    sk_categoria numeric NOT NULL,
    num_contrato numeric NOT NULL,
    num_stand numeric NOT NULL,
    mt2 numeric NOT NULL,
    monto numeric NOT NULL,
    cantidad numeric NOT NULL,
    CONSTRAINT fact_alquiler_pkey PRIMARY KEY (sk_evento, sk_tipo_stand, sk_fec_alquiler, sk_cliente, sk_categoria, num_contrato, num_stand),
    CONSTRAINT sk_dim_categoria FOREIGN KEY (sk_categoria)
        REFERENCES public.dim_categoria (sk_categoria) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_cliente FOREIGN KEY (sk_cliente)
        REFERENCES public.dim_cliente (sk_cliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_evento FOREIGN KEY (sk_evento)
        REFERENCES public.dim_evento (sk_evento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_tiempo FOREIGN KEY (sk_fec_alquiler)
        REFERENCES public.dim_tiempo (sk_tiempo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sk_dim_tipo_stand FOREIGN KEY (sk_tipo_stand)
        REFERENCES public.dim_tipo_stand (sk_tipo_stand) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.fact_alquiler
    OWNER to postgres;
CREATE TABLE pais(
    cod_pais INTEGER PRIMARY KEY,
    nb_pais VARCHAR(50) NOT NULL
);

CREATE TABLE ciudad(
    cod_ciudad INTEGER PRIMARY KEY,
    nb_ciudad VARCHAR(50) NOT NULL,
    cod_pais INTEGER NOT NULL,
    CONSTRAINT fk_pais FOREIGN KEY(cod_pais) REFERENCES pais(cod_pais)
);

CREATE TABLE sede(
    cod_sede INTEGER PRIMARY KEY,
    nb_sede VARCHAR(50) NOT NULL,
    cod_ciudad INTEGER NOT NULL,
    CONSTRAINT fk_ciudad FOREIGN KEY(cod_ciudad) REFERENCES ciudad(cod_ciudad)
);

CREATE TABLE tipo_evento(
    cod_tipo_evento INTEGER PRIMARY KEY,
    nb_tipo_evento  VARCHAR(15) NOT NULL CHECK (nb_tipo_evento IN ('Feria', 'Bazar', 'Exposicion'))
);

CREATE TABLE evento(
    cod_evento INTEGER PRIMARY KEY,
    nb_evento VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    descripcion VARCHAR(500) NOT NULL,
    email VARCHAR(200) NOT NULL,
    cod_sede INTEGER NOT NULL,
    cod_tipo_evento INTEGER NOT NULL,
    CONSTRAINT fk_sede FOREIGN KEY(cod_sede) REFERENCES sede(cod_sede),
    CONSTRAINT fk_tipo_evento FOREIGN KEY(cod_tipo_evento) REFERENCES tipo_evento(cod_tipo_evento)
);

CREATE TABLE tipo_stand(
    cod_tipo_stand INTEGER PRIMARY KEY,
    nb_tipo_stand VARCHAR(50) NOT NULL
);

CREATE TABLE evento_stand(
    cod_evento INTEGER NOT NULL,
    cod_tipo_stand INTEGER NOT NULL,
    cantidad_estimada INTEGER NOT NULL,
    mts2 FLOAT NOT NULL,
    precio FLOAT NOT NULL,
    CONSTRAINT pk_evento_stand PRIMARY KEY(cod_evento, cod_tipo_stand)
);

CREATE TABLE categoria(
    cod_categoria INTEGER PRIMARY KEY,
    nb_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE subcategoria(
    cod_sub_categoria INTEGER PRIMARY KEY,
    nb_sub_categoria VARCHAR(50) NOT NULL,
    cod_categoria INTEGER NOT NULL,
    CONSTRAINT fk_categoria FOREIGN KEY(cod_categoria) REFERENCES categoria(cod_categoria)
);

CREATE TABLE cliente(
    cod_cliente INTEGER PRIMARY KEY,
    nb_cliente VARCHAR(50) NOT NULL,
    ci_rif VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL
);

CREATE TABLE contrato(
    nro_stand INTEGER NOT NULL,
    cod_evento INTEGER NOT NULL,
    cod_tipo_stand INTEGER NOT NULL,
    fecha_alquiler DATE NOT NULL,
    mts2 FLOAT NOT NULL,
    monto FLOAT NOT NULL,
    cod_sub_categoria INTEGER NOT NULL,
    cod_cliente INTEGER NOT NULL,
    CONSTRAINT pk_contrato PRIMARY KEY(nro_stand, cod_evento),
    CONSTRAINT fk_sub_categoria FOREIGN KEY(cod_sub_categoria) REFERENCES subcategoria(cod_sub_categoria),
    CONSTRAINT fk_cliente FOREIGN KEY(cod_cliente) REFERENCES cliente(cod_cliente)
);

CREATE TABLE visitante(
    cod_visitante INTEGER PRIMARY KEY,
    cedula VARCHAR(50) NOT NULL,
    nb_visitante VARCHAR(50) NOT NULL,
    sexo VARCHAR(10) NOT NULL CHECK(sexo IN ('Femenino', 'Masculino')),
    email VARCHAR(50) NOT NULL
);

CREATE TABLE leyenda_estrella(
    cod_leyenda_estrellas INTEGER PRIMARY KEY,
    nb_descripcion VARCHAR(30) NOT NULL CHECK(nb_descripcion IN ('Malo','Regular','Bueno','Muy Bueno','Excelente'))
);


CREATE TABLE entrada(
    nro_entrada INTEGER NOT NULL,
    cod_evento INTEGER NOT NULL,
    fecha_entrada DATE NOT NULL,
    hora_entrada DATE NOT NULL,
    recomienda_amigo VARCHAR(30) NOT NULL CHECK(recomienda_amigo IN ('Recomienda', 'No recomienda')),
    calificacion INTEGER NOT NULL,
    cod_leyenda_estrellas INTEGER NOT NULL,
    cod_visitante INTEGER NOT NULL,
    CONSTRAINT pk_entrada PRIMARY KEY(nro_entrada,cod_evento),
    CONSTRAINT fk_leyenda FOREIGN KEY(cod_leyenda_estrellas) REFERENCES leyenda_estrella(cod_leyenda_estrellas),
    CONSTRAINT fk_visitante FOREIGN KEY(cod_visitante) REFERENCES visitante(cod_visitante)
);

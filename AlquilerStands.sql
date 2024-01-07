CREATE DATABASE AlquilerStands;

-- CREATES

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
    email VARCHAR(200) NOT NULL UNIQUE,
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
    ci_rif VARCHAR(50) NOT NULL UNIQUE,
    telefono VARCHAR(50) NOT NULL UNIQUE,
    direccion VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE
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


-- INSERTS

INSERT INTO pais (cod_pais, nb_pais) VALUES('1','Venezuela');


INSERT INTO ciudad (cod_ciudad, nb_ciudad, cod_pais) VALUES('1','Caracas','1');


INSERT INTO sede (cod_sede, nb_sede, cod_ciudad) VALUES('1','Universidad Catolica Andres Bello','1');


INSERT INTO tipo_evento (cod_tipo_evento, nb_tipo_evento) VALUES('1','Feria');
INSERT INTO tipo_evento (cod_tipo_evento, nb_tipo_evento) VALUES('2','Exposicion');
INSERT INTO tipo_evento (cod_tipo_evento, nb_tipo_evento) VALUES('3','Bazar');


INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('1','Feria de Artesanía y Diseño','2023-02-15','2023-02-17','Una feria que reúne a artesanos y diseñadores locales para exhibir y vender sus productos únicos y creativos.','art_dis@gmail.com','1','1');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('2','Feria Gastronómico','2023-03-21','2023-03-28','Una feria donde los amantes de la gastronomía podrán disfrutar de una amplia variedad de alimentos y bebidas preparados por chefs y emprendedores locales.','gastronomiavzla@gmail.com','1','1');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('3','Bazar de Tecnología','2023-04-12','2023-04-21','Un bazar que muestra las últimas innovaciones tecnológicas en diferentes industrias, como la electrónica, la inteligencia artificial y la realidad virtual.','tecnologia_ciencia@hotmail.com','1','3');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('4','Exposicion del Libro','2023-05-24','2023-05-29','Una exposicion dedicada a los amantes de la lectura, donde se podrán encontrar una amplia selección de libros de diferentes géneros y autores.','librosvzla23@yahoo.com','1','2');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('5','Exposicion de Moda','2023-02-05','2023-02-10','Una exposicion dedicada a los amantes de la lectura, donde se podrán encontrar una amplia selección de libros de diferentes géneros y autores.','infomoda2020@gmail.com','1','2');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('6','Bazar de Arte Contemporáneo','2023-03-27','2023-03-30','Un bazar que presenta obras de arte contemporáneo de artistas locales e internacionales, ofreciendo a los visitantes la oportunidad de apreciar y adquirir arte de calidad.','venecontemporaneo@outlook.com','1','3');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('7','Feria de Productos Orgánicos','2023-05-09','2023-05-14','Una feria que promueve el consumo de productos orgánicos y sustentables, ofreciendo una variedad de alimentos, productos de cuidado personal y artículos para el hogar.','poinfo@gmail.com','1','1');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('8','Exposicion de Arte y Manualidades','2023-09-10','2023-09-12','Una exposicion donde artistas y artesanos locales exhiben y venden sus creaciones, que incluyen pinturas, esculturas, cerámica, tejidos y más.','venezuelarte@yahoo.com','1','2');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('9','Feria de Automóviles Clásicos','2023-01-25','2023-02-01','Una feria que muestra una colección de automóviles clásicos y antiguos, permitiendo a los entusiastas de los autos disfrutar de estas joyas de la historia automotriz.','clasicosmoviles@hotmail.com','1','1');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('10','Bazar de Turismo y Viajes','2023-06-04','2023-06-13','Un bazar que ofrece información y promociones sobre destinos turísticos nacionales e internacionales, agencias de viajes y servicios relacionados con el turismo.','turutavzla@gmail.com','1','3');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('11','Bazar Navideño','2023-12-03','2023-12-10','Un bazar temático de Navidad donde se podrán encontrar regalos, decoraciones y productos relacionados con las festividades navideñas.','bazarnavideño@hotmail.com','1','3');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('12','Exposición de Fotografía','2023-09-04','2023-09-15','Una exposición que presenta una selección de fotografías de artistas locales, abarcando diferentes estilos y temáticas.','fotomania@outlook.com','1','2');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('13','Exposicion de Productos Sostenibles','2023-05-05','2023-05-15','Una exposicion que destaca productos y servicios sostenibles, promoviendo un estilo de vida consciente y respetuoso con el medio ambiente.','poinfo2021@gmail.com','1','2');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('14','Feria de Arte Urbano','2023-04-21','2023-04-28','Una feria que exhibe y vende obras de arte urbano, como graffiti, murales y arte callejero, brindando una plataforma para artistas urbanos locales.','bellasartes@gmail.com','1','1');
INSERT INTO evento (cod_evento, nb_evento, fecha_inicio, fecha_fin, descripcion, email, cod_sede, cod_tipo_evento) VALUES('15','Bazar de Tecnología Innovadora','2023-08-15','2023-08-25','Un bazar que presenta las últimas innovaciones tecnológicas en áreas como la inteligencia artificial, la robótica y la realidad aumentada.','infotec@hotmail.com','1','3');


INSERT INTO tipo_stand (cod_tipo_stand, nb_tipo_stand) VALUES('1','Minimo');
INSERT INTO tipo_stand (cod_tipo_stand, nb_tipo_stand) VALUES('2','Estandar');
INSERT INTO tipo_stand (cod_tipo_stand, nb_tipo_stand) VALUES('3','Maximo/Ajustable');


INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('1','2','1','10','100');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('1','3','2','15','150');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('2','3','2','20','200');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('2','2','1','12','120');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('3','2','2','18','180');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('3','3','2','22','220');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('4','2','1','11','110');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('4','3','2','16','160');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('5','3','2','21','210');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('5','2','1','10','100');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('6','2','1','13','130');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('6','3','1','12','120');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('7','3','2','21','210');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('7','1','1','7','70');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('8','3','2','17','180');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('8','1','1','8','80');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('9','1','1','9','90');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('9','2','1','13','130');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('10','3','2','22','220');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('10','2','2','20','200');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('11','2','1','12','120');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('11','1','1','8','80');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('12','2','1','14','140');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('12','3','2','15','150');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('13','3','2','21','210');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('13','2','2','17','170');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('14','2','1','12','120');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('14','3','1','13','130');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('15','2','1','10','100');
INSERT INTO evento_stand (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES('15','1','1','7','70');


INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('1','Electronica');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('2','Ropa');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('3','Hogar');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('4','Deportes');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('5','Alimentos');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('6','Epoca');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('7','Arte');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('8','Vehiculos');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('9','Turismo');
INSERT INTO categoria (cod_categoria, nb_categoria) VALUES('10','Libros');


INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('1','Telefonos','1');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('2','Televisores','1');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('3','Computadoras','1');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('4','Accesorios Electronicos','1');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('5','Camisetas','2');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('6','Casual','2');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('7','Vestido','2');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('8','Accesorios de Moda','2');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('9','Muebles','3');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('10','Decoracion','3');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('11','Electrodomesticos','3');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('12','Articulos para el hogar','3');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('13','Futbol','4');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('14','Baloncesto','4');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('15','Tenis','4');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('16','Equipamento deportivo','4');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('17','Frutas y verduras','5');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('18','Carnes y pescados','5');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('19','Lacteos','5');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('20','Panaderia y reposteria','5');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('21','Bebidas','5');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('22','Navidad','6');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('23','Otoño','6');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('24','Verano','6');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('25','Pintura','7');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('26','Escultura','7');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('27','Fotografia','7');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('28','Arte digital','7');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('29','Arte conceptual','7');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('30','Automoviles','8');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('31','Motocicletas','8');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('32','Bicicletas','8');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('33','Camiones','8');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('34','Barcos','8');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('35','Paquetes vacacionales','9');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('36','Hoteles y alojamientos','9');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('37','Excursiones y actividades','9');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('38','Transporte','9');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('39','Guias turisticas','9');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('40','Ficcion','10');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('41','No ficcion','10');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('42','Autoayuda','10');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('43','Ciencia','10');
INSERT INTO subcategoria (cod_sub_categoria, nb_sub_categoria, cod_categoria) VALUES('44','Literatura infantil','10');


INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('1','Juan Perez','5886059','4241713813','Calle Los Ángeles, Edificio Los Ángeles, Chacao, Caracas, 1070, Venezuela.','juan19@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('2','Maria Lopez','6226834','4127836277','Avenida Oeste 5, Caracas 1010, Distrito Capital, Venezuela.','marial@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('3','Pedro Gomez','20543876','4145278782','Llanos de Miquillen, Distrito Capital, Venezuela.','1204pedro@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('4','Ana Rodriguez','12590542','4145592539','Esquina de Salas a Caja de Agua, Edificio Sede del MPPE, Parroquia Altagracia, Distrito Capital, Caracas, Venezuela.','anaro08@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('5','Luisa Torres','7898012','4126177314','Loma del Águila (Caracas), Distrito Capital, Venezuela.','luisatorres1@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('6','Carlos Ramirez','10102103','4126682406','Lomas de Terrabel (Caracas), Distrito Capital, Venezuela.','carlosrs23@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('7','Laura Garcia','18892171','4261667942','Los Magallanes, Distrito Capital, Venezuela.','llauragg@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('8','Andres Martinez','24674533','4246713322','Macarao (Caracas), Distrito Capital, Venezuela.','andresmartinez@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('9','Sofia Herrera','9974521','4128936511','Merecure, Distrito Capital, Venezuela.','sofi_linda@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('10','Alejandro Ruis','6790412','4247893544','Parroquia Altagracia (Caracas), Distrito Capital, Venezuela.','aleruiz1965@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('11','Carolina Castro','14034202','4245634491','Parroquia Catedral (Caracas), Distrito Capital, Venezuela.','carolcastro@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('12','Daniel Morales','16935103','4167897789','Parroquia Santa Teresa (Caracas), Distrito Capital, Venezuela.','danielmora_les@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('13','Gabriela Sanchez','18313254','4129106512','Prado de María (Caracas), Distrito Capital, Venezuela.','gabriela_sanchez@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('14','Manuel Vargas','9876543','4124335679','Plaza Venezuela (Caracas), Distrito Capital, Venezuela.','manuel15vargas@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('15','Natalia Rivas','6717707','4261715438','Calle Aurora, cerca de una clínica dental y frente a la gasolinera, Caracas, Venezuela.','natibebe@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('16','Oscar Castro','22456733','4264937732','Calle Diamante, cerca de un parque, Caracas, Venezuela.','oscarcastro@outlook.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('17','Patricia Lopez','25655855','4167252539','Calle donde queda el hospital, Caracas, Venezuela.','patriciatorres45@hotmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('18','Ricardo Torres','13555551','4167737724','Calle sobre la que está ubicada la farmacia, Caracas, Venezuela.','ricardott@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('19','Valeria Martinez','15789010','4169790304','Calle donde se encuentra el banco, Caracas, Venezuela.','vale_marti@outlook.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('20','Xavier Herrera','19091092','4265040678','Calle donde se encuentra el supermercado y varios restaurantes, Caracas, Venezuela.','xavierherre@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('21','Yolanda Ruiz','21989982','4128719999','Parroquia Santa Teresa (Caracas), Distrito Capital, Venezuela.','yolandaruiz@hotmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('22','Zenaida Castro','11547921','4241345456','Parroquia Catedral (Caracas), Distrito Capital, Venezuela.','zenaidacastro99@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('23','Alberto Morales','80954776','4128879933','Los Magallanes, Distrito Capital, Venezuela.','albertomrales@hotmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('24','Beatriz Vargas','10083556','4267543456','Parroquia Santa Teresa (Caracas), Distrito Capital, Venezuela.','beatrizvvargas@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('25','Carlos Rivas','13092483','4246678992','Parroquia Altagracia (Caracas), Distrito Capital, Venezuela.','carlosrivas@outlook.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('26','Diana Castro','17927392','4246351238','Los Magallanes, Distrito Capital, Venezuela.','dianac123@gmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('27','Eduardo Lopez','18092549','4240809003','Parroquia Catedral (Caracas), Distrito Capital, Venezuela.','edulopez11@hotmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('28','Fabiola Torres','13820482','4127120983','Los Magallanes, Distrito Capital, Venezuela.','fabiolatorres_67@hotmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('29','Gerardo Martinez','17029384','4148870096','Parroquia Altagracia (Caracas), Distrito Capital, Venezuela.','gerardomartinezzz@hotmail.com');
INSERT INTO cliente (cod_cliente, nb_cliente, ci_rif, telefono, direccion, email) VALUES('30','Helena Herrera','19028883','4167152537','Parroquia Santa Teresa (Caracas), Distrito Capital, Venezuela.','helenaherre@hotmail.com');


INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('1','1','2','2022-09-24','7','70','28','5');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('2','1','3','2022-12-25','10','100','28','10');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('3','2','3','2022-10-26','15','150','20','15');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('4','2','2','2022-11-27','10','100','18','20');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('5','3','3','2022-09-28','16','160','4','25');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('6','3','3','2022-09-29','17','170','1','30');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('7','4','2','2022-09-30','10','100','40','1');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('8','4','3','2022-08-01','15','150','43','3');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('9','5','3','2022-09-02','15','150','8','7');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('10','5','2','2022-07-30','10','100','7','9');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('11','6','2','2022-10-04','10','100','29','11');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('12','6','2','2022-10-14','10','100','26','13');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('13','7','3','2022-07-06','15','150','17','17');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('14','7','1','2022-11-28','7','70','19','19');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('15','8','3','2022-10-08','15','150','27','21');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('16','8','1','2022-12-09','7','70','26','23');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('17','9','1','2022-10-30','8','80','31','27');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('18','9','2','2022-08-11','10','100','32','29');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('19','10','3','2022-08-05','18','180','39','2');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('20','10','3','2022-10-13','15','150','36','4');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('21','11','2','2022-10-10','10','100','22','6');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('22','11','1','2022-10-15','5','50','22','8');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('23','12','2','2022-07-16','10','100','27','12');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('24','12','3','2022-09-17','15','150','27','14');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('25','13','3','2022-09-12','15','150','11','16');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('26','13','3','2022-09-19','15','150','12','18');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('27','14','2','2022-10-20','10','100','28','22');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('28','14','3','2022-12-14','10','100','28','24');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('29','15','2','2022-12-22','10','100','3','26');
INSERT INTO contrato (nro_stand, cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_sub_categoria, cod_cliente) VALUES('30','15','1','2022-12-15','7','70','2','28');


INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('1','5881059','Carlos Perez','Masculino','carlos1234@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('2','6226634','Jose Garcia','Masculino','jose284@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('3','20643876','Jose Toro','Masculino','josetoro00@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('4','12590642','Maria Tauroni','Femenino','mariant_96@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('5','7899012','Heddis Gonzales','Femenino','heddysmm_@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('6','10162103','Marco Perez','Masculino','marcopj@outlook.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('7','18896271','Saul Nouel','Masculino','saulng4@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('8','24676533','Esteban Toro','Masculino','estebandavid15@yahoo.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('9','9974621','Daniel Gonzalez','Masculino','danielgg@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('10','6790612','Abraham Hernandez','Masculino','abrahamlinc@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('11','14064202','Marian Perez','Femenino','marianavp@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('12','16125103','Andres Jimenez','Masculino','andresvrj@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('13','18316654','Luis Jimenez','Masculino','luisraj267@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('14','9882543','Andrea Mancilla','Femenino','andreamancilla@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('15','6719107','Josue Ochoa','Masculino','josueo8@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('16','22456003','Daniel Oropeza','Masculino','danielaoo0@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('17','25623855','Manuel Pico','Masculino','manuelpicochile@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('18','13548551','Arturo Hung','Masculino','arturocraneohung@outlook.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('19','15785510','Jonas Perez','Masculino','jonasperezgm@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('20','19621092','Leonardo Quintero','Masculino','leonardoquint3ro@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('21','21985182','Lucia Cardoso','Femenino','lucia98cardoso@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('22','11548221','Nadia Ochoa','Femenino','nadia8amr@hotmai.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('23','80954946','Victor Pabon','Masculino','victorpabon11@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('24','17383556','Vicente Fernandez','Masculino','vicenteafernandez@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('25','13442483','Daniela Carvajal','Femenino','danielac90@hotmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('26','17927702','Victor Madera','Masculino','victormadera@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('27','18582549','Carlos Carvajal','Masculino','carloscarvajal123@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('28','13888482','Jenniffer Contreras','Femenino','jenniffercontreras25@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('29','17529384','Omar Velez','Masculino','omarevp@gmail.com');
INSERT INTO visitante (cod_visitante, cedula, nb_visitante, sexo, email) VALUES('30','19988883','Deiby Ochoa','Masculino','deibyelisandro8a@hotmail.com');


INSERT INTO leyenda_estrella (cod_leyenda_estrellas, nb_descripcion) VALUES('1','Malo');
INSERT INTO leyenda_estrella (cod_leyenda_estrellas, nb_descripcion) VALUES('2','Regular');
INSERT INTO leyenda_estrella (cod_leyenda_estrellas, nb_descripcion) VALUES('3','Bueno');
INSERT INTO leyenda_estrella (cod_leyenda_estrellas, nb_descripcion) VALUES('4','Muy Bueno');
INSERT INTO leyenda_estrella (cod_leyenda_estrellas, nb_descripcion) VALUES('5','Excelente');


INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('2','1','2023-02-16',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('3','1','2023-02-17',TO_TIMESTAMP('1:15', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('4','1','2023-02-15',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('5','1','2023-02-16',TO_TIMESTAMP('1:45', 'HH24:MI:SS'),'Recomienda','5','5','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('6','1','2023-02-17',TO_TIMESTAMP('3:00', 'HH24:MI:SS'),'Recomienda','3','3','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('7','1','2023-02-15',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('8','1','2023-02-16',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('9','1','2023-02-17',TO_TIMESTAMP('12:00', 'HH24:MI:SS'),'No recomienda','1','1','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('10','1','2023-02-15',TO_TIMESTAMP('11:30', 'HH24:MI:SS'),'No recomienda','1','1','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('11','1','2023-02-16',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('12','1','2023-02-17',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('13','1','2023-02-15',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('14','1','2023-02-16',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('15','1','2023-02-17',TO_TIMESTAMP('12:45', 'HH24:MI:SS'),'Recomienda','5','5','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('16','1','2023-02-15',TO_TIMESTAMP('1:20', 'HH24:MI:SS'),'Recomienda','3','3','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('17','1','2023-02-16',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('18','1','2023-02-17',TO_TIMESTAMP('4:00', 'HH24:MI:SS'),'Recomienda','4','4','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('19','1','2023-02-15',TO_TIMESTAMP('4:25', 'HH24:MI:SS'),'Recomienda','4','4','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('20','1','2023-02-16',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'Recomienda','3','3','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('21','1','2023-02-17',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('22','1','2023-02-15',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('23','1','2023-02-16',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('24','1','2023-02-17',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','4','4','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('25','1','2023-02-15',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('26','2','2023-03-21',TO_TIMESTAMP('1:45', 'HH24:MI:SS'),'Recomienda','3','3','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('27','2','2023-03-22',TO_TIMESTAMP('3:00', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('28','2','2023-03-23',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('29','2','2023-03-24',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('30','2','2023-03-25',TO_TIMESTAMP('12:00', 'HH24:MI:SS'),'Recomienda','4','4','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('31','2','2023-03-26',TO_TIMESTAMP('11:30', 'HH24:MI:SS'),'Recomienda','5','5','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('32','2','2023-03-27',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('33','2','2023-03-28',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('34','2','2023-03-21',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('35','2','2023-03-22',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('36','2','2023-03-23',TO_TIMESTAMP('4:00', 'HH24:MI:SS'),'Recomienda','4','4','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('37','2','2023-03-24',TO_TIMESTAMP('4:25', 'HH24:MI:SS'),'Recomienda','5','5','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('38','2','2023-03-25',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'Recomienda','5','5','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('39','2','2023-03-26',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('40','2','2023-03-27',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('41','2','2023-03-28',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','5','5','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('42','2','2023-03-21',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','5','5','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('43','2','2023-03-22',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('44','2','2023-03-23',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','5','5','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('45','2','2023-03-24',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('46','2','2023-03-25',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('47','2','2023-03-26',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('48','2','2023-03-27',TO_TIMESTAMP('4:00', 'HH24:MI:SS'),'Recomienda','3','3','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('49','2','2023-03-28',TO_TIMESTAMP('4:25', 'HH24:MI:SS'),'Recomienda','3','3','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('50','2','2023-03-22',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('51','3','2023-04-12',TO_TIMESTAMP('4:25', 'HH24:MI:SS'),'Recomienda','3','3','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('52','3','2023-04-13',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'Recomienda','3','3','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('53','3','2023-04-14',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('54','3','2023-04-15',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('55','3','2023-04-16',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('56','3','2023-04-17',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','2','2','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('57','3','2023-04-18',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('58','3','2023-04-19',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('59','3','2023-04-20',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('60','3','2023-04-21',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('61','3','2023-04-14',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('62','3','2023-04-15',TO_TIMESTAMP('4:00', 'HH24:MI:SS'),'Recomienda','4','4','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('63','3','2023-04-16',TO_TIMESTAMP('4:25', 'HH24:MI:SS'),'Recomienda','4','4','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('64','3','2023-04-17',TO_TIMESTAMP('4:25', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('65','3','2023-04-18',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'Recomienda','5','5','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('66','3','2023-04-14',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('67','3','2023-04-15',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('68','3','2023-04-16',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('69','3','2023-04-17',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'No recomienda','1','1','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('70','3','2023-04-18',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('71','3','2023-04-14',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('72','3','2023-04-15',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('73','3','2023-04-16',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('74','3','2023-04-17',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('75','3','2023-04-18',TO_TIMESTAMP('4:00', 'HH24:MI:SS'),'No recomienda','1','1','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('76','4','2023-05-24',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'Recomienda','3','3','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('77','4','2023-05-25',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('78','4','2023-05-26',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('79','4','2023-05-27',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('80','4','2023-05-28',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'No recomienda','1','1','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('81','4','2023-05-29',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('82','4','2023-05-24',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('83','4','2023-05-25',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('84','4','2023-05-26',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('85','4','2023-05-27',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'No recomienda','1','1','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('86','4','2023-05-28',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('87','4','2023-05-29',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('88','4','2023-05-24',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('89','4','2023-05-25',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','4','4','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('90','4','2023-05-26',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'No recomienda','1','1','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('91','4','2023-05-27',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('92','4','2023-05-28',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('93','4','2023-05-29',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'No recomienda','1','1','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('94','4','2023-05-24',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('95','4','2023-05-25',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('96','4','2023-05-26',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','5','5','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('97','4','2023-05-27',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('98','4','2023-05-28',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('99','4','2023-05-29',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('100','4','2023-05-26',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('101','5','2023-02-05',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('102','5','2023-02-06',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('103','5','2023-02-07',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('104','5','2023-02-08',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','2','2','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('105','5','2023-02-09',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('106','5','2023-02-10',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('107','5','2023-02-05',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','2','2','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('108','5','2023-02-06',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('109','5','2023-02-07',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('110','5','2023-02-08',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('111','5','2023-02-09',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('112','5','2023-02-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','5','5','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('113','5','2023-02-05',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('114','5','2023-02-06',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','5','5','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('115','5','2023-02-07',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('116','5','2023-02-10',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('117','5','2023-02-05',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('118','5','2023-02-06',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('119','5','2023-02-07',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('120','5','2023-02-08',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('121','5','2023-02-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('122','5','2023-02-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('123','5','2023-02-05',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','4','4','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('124','5','2023-02-09',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('125','5','2023-02-09',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','3','3','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('126','6','2023-03-27',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'No recomienda','1','1','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('127','6','2023-03-28',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('128','6','2023-03-29',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('129','6','2023-03-30',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('130','6','2023-03-27',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'Recomienda','5','5','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('131','6','2023-03-28',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('132','6','2023-03-29',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('133','6','2023-03-30',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('134','6','2023-03-27',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'Recomienda','5','5','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('135','6','2023-03-28',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('136','6','2023-03-29',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('137','6','2023-03-30',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('138','6','2023-03-27',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('139','6','2023-03-28',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','5','5','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('140','6','2023-03-29',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'No recomienda','1','1','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('141','6','2023-03-29',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'No recomienda','1','1','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('142','6','2023-03-30',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'No recomienda','1','1','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('143','6','2023-03-27',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('144','6','2023-03-28',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('145','6','2023-03-29',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('146','6','2023-03-30',TO_TIMESTAMP('10:00', 'HH24:MI:SS'),'Recomienda','4','4','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('147','6','2023-03-27',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('148','6','2023-03-29',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','2','2','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('149','6','2023-03-27',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('150','6','2023-03-27',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('151','7','2023-05-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('152','7','2023-05-10',TO_TIMESTAMP('10:45', 'HH24:MI:SS'),'No recomienda','1','1','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('153','7','2023-05-11',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('154','7','2023-05-12',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('155','7','2023-05-13',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('156','7','2023-05-14',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('157','7','2023-05-09',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('158','7','2023-05-10',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('159','7','2023-05-11',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('160','7','2023-05-12',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('161','7','2023-05-13',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'No recomienda','1','1','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('162','7','2023-05-14',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('163','7','2023-05-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('164','7','2023-05-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('165','7','2023-05-11',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('166','7','2023-05-14',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('167','7','2023-05-09',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('168','7','2023-05-10',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('169','7','2023-05-11',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','5','5','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('170','7','2023-05-12',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('171','7','2023-05-13',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('172','7','2023-05-14',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('173','7','2023-05-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('174','7','2023-05-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('175','7','2023-05-11',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('176','8','2023-09-10',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('177','8','2023-09-11',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('178','8','2023-09-12',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('179','8','2023-09-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','5','5','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('180','8','2023-09-11',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','5','5','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('181','8','2023-09-12',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','5','5','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('182','8','2023-09-10',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('183','8','2023-09-11',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('184','8','2023-09-12',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('185','8','2023-09-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('186','8','2023-09-11',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('187','8','2023-09-12',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('188','8','2023-09-10',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('189','8','2023-09-11',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('190','8','2023-09-12',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('191','8','2023-09-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('192','8','2023-09-11',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('193','8','2023-09-12',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('194','8','2023-09-10',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('195','8','2023-09-11',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('196','8','2023-09-12',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('197','8','2023-09-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('198','8','2023-09-11',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('199','8','2023-09-12',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('200','8','2023-09-10',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('201','9','2023-01-25',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('202','9','2023-01-26',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('203','9','2023-01-27',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('204','9','2023-01-28',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('205','9','2023-01-29',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','2','2','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('206','9','2023-01-30',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('207','9','2023-01-31',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('208','9','2023-02-01',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('209','9','2023-01-25',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('210','9','2023-01-26',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('211','9','2023-01-27',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('212','9','2023-01-28',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('213','9','2023-01-29',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','5','5','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('214','9','2023-01-30',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('215','9','2023-01-31',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','5','5','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('216','9','2023-02-01',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('217','9','2023-01-25',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('218','9','2023-01-26',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'No recomienda','1','1','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('219','9','2023-01-27',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('220','9','2023-01-28',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('221','9','2023-01-29',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('222','9','2023-01-30',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('223','9','2023-01-31',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('224','9','2023-02-01',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('225','9','2023-01-29',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('226','10','2023-06-04',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'No recomienda','1','1','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('227','10','2023-06-05',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('228','10','2023-06-06',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('229','10','2023-06-07',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('230','10','2023-06-08',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'No recomienda','1','1','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('231','10','2023-06-09',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'No recomienda','1','1','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('232','10','2023-06-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('233','10','2023-06-04',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('234','10','2023-06-05',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('235','10','2023-06-06',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('236','10','2023-06-07',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('237','10','2023-06-08',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('238','10','2023-06-09',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('239','10','2023-06-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('240','10','2023-06-04',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('241','10','2023-06-05',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('242','10','2023-06-06',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('243','10','2023-06-07',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('244','10','2023-06-08',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('245','10','2023-06-09',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('246','10','2023-06-10',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('247','10','2023-06-11',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('248','10','2023-06-12',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('249','10','2023-06-13',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('250','10','2023-06-13',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('251','11','2023-12-03',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('252','11','2023-12-04',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('253','11','2023-12-05',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('254','11','2023-12-06',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('255','11','2023-12-07',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('256','11','2023-12-08',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('257','11','2023-12-09',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('258','11','2023-12-03',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('259','11','2023-12-04',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('260','11','2023-12-05',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('261','11','2023-12-06',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('262','11','2023-12-07',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('263','11','2023-12-08',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('264','11','2023-12-09',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('265','11','2023-12-03',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('266','11','2023-12-04',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('267','11','2023-12-05',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('268','11','2023-12-06',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('269','11','2023-12-07',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('270','11','2023-12-08',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','5','5','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('271','11','2023-12-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('272','11','2023-12-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('273','11','2023-12-10',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('274','11','2023-12-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','4','4','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('275','11','2023-12-10',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','5','5','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('276','12','2023-09-04',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('277','12','2023-09-05',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('278','12','2023-09-06',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('279','12','2023-09-07',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('280','12','2023-09-08',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('281','12','2023-09-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('282','12','2023-09-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('283','12','2023-09-11',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('284','12','2023-09-12',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('285','12','2023-09-13',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('286','12','2023-09-14',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('287','12','2023-09-15',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('288','12','2023-09-04',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('289','12','2023-09-05',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('290','12','2023-09-06',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('291','12','2023-09-07',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('292','12','2023-09-08',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'No recomienda','1','1','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('293','12','2023-09-09',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('294','12','2023-09-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('295','12','2023-09-11',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('296','12','2023-09-12',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('297','12','2023-09-13',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('298','12','2023-09-14',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('299','12','2023-09-15',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('300','12','2023-09-12',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('301','13','2023-05-05',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('302','13','2023-05-06',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('303','13','2023-05-07',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('304','13','2023-05-08',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('305','13','2023-05-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('306','13','2023-05-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','5','5','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('307','13','2023-05-11',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('308','13','2023-05-05',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('309','13','2023-05-06',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('310','13','2023-05-07',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('311','13','2023-05-08',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('312','13','2023-05-09',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('313','13','2023-05-10',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('314','13','2023-05-11',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('315','13','2023-05-05',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('316','13','2023-05-06',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('317','13','2023-05-07',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('318','13','2023-05-08',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('319','13','2023-05-09',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('320','13','2023-05-10',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','4','4','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('321','13','2023-05-11',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('322','13','2023-05-05',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('323','13','2023-05-06',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('324','13','2023-05-07',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('325','13','2023-05-08',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('326','14','2023-04-21',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('327','14','2023-04-22',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('328','14','2023-04-23',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('329','14','2023-04-24',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('330','14','2023-04-25',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('331','14','2023-04-26',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('332','14','2023-04-27',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('333','14','2023-04-28',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('334','14','2023-04-21',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('335','14','2023-04-22',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('336','14','2023-04-23',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('337','14','2023-04-24',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('338','14','2023-04-25',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('339','14','2023-04-26',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('340','14','2023-04-27',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','2','2','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('341','14','2023-04-28',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('342','14','2023-04-21',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('343','14','2023-04-22',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('344','14','2023-04-23',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('345','14','2023-04-24',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','5','5','5');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('346','14','2023-04-25',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','6');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('347','14','2023-04-26',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','2','2','7');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('348','14','2023-04-27',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','8');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('349','14','2023-04-28',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','9');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('350','14','2023-04-28',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','10');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('351','15','2023-08-15',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','11');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('352','15','2023-08-16',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','12');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('353','15','2023-08-17',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','13');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('354','15','2023-08-18',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','14');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('355','15','2023-08-19',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','2','2','15');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('356','15','2023-08-20',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','2','2','16');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('357','15','2023-08-21',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','2','2','17');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('358','15','2023-08-22',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','18');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('359','15','2023-08-23',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','19');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('360','15','2023-08-24',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','20');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('361','15','2023-08-25',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','4','4','21');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('362','15','2023-08-15',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'No recomienda','1','1','22');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('363','15','2023-08-16',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'No recomienda','1','1','23');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('364','15','2023-08-17',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','24');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('365','15','2023-08-18',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','5','5','25');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('366','15','2023-08-19',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','2','2','26');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('367','15','2023-08-20',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','27');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('368','15','2023-08-21',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','3','3','28');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('369','15','2023-08-22',TO_TIMESTAMP('11:00', 'HH24:MI:SS'),'Recomienda','3','3','29');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('370','15','2023-08-23',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','30');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('371','15','2023-08-24',TO_TIMESTAMP('2:00', 'HH24:MI:SS'),'Recomienda','3','3','1');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('372','15','2023-08-25',TO_TIMESTAMP('2:15', 'HH24:MI:SS'),'Recomienda','3','3','2');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('373','15','2023-08-24',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','3','3','3');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('374','15','2023-08-19',TO_TIMESTAMP('3:25', 'HH24:MI:SS'),'Recomienda','4','4','4');
INSERT INTO entrada (nro_entrada, cod_evento, fecha_entrada, hora_entrada, recomienda_amigo, calificacion, cod_leyenda_estrellas, cod_visitante) VALUES('375','15','2023-08-17',TO_TIMESTAMP('10:30', 'HH24:MI:SS'),'Recomienda','2','2','5');




-- Tabla administrador, para controlar su inicio de sesión
CREATE TABLE administrador (
    id         INT(11) NOT NULL AUTO_INCREMENT,
    useradmin	   VARCHAR(15) NOT NULL,
    pass   VARCHAR(40) NOT NULL,
    nombre     VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);


-- Tabla autobús, donde se guardará su número y su matrícula
CREATE TABLE autobus (
    matricula   VARCHAR(8) NOT NULL,
    numero      INT(11) NOT NULL,
    poblacion   VARCHAR(50) NOT NULL
);

ALTER TABLE autobus ADD CONSTRAINT autobus_pk PRIMARY KEY ( matricula );

CREATE TABLE bus_conductor (
    conductor_dni       VARCHAR(9) NOT NULL,
    autobus_matricula   VARCHAR(8) NOT NULL,
    fecha_inicio        DATE NOT NULL,
    fecha_fin           DATE
);

ALTER TABLE bus_conductor
    ADD CONSTRAINT bus_conductor_pk PRIMARY KEY ( conductor_dni,
                                                  autobus_matricula );

-- Conductor del bus
CREATE TABLE conductor (
    dni        VARCHAR(9) NOT NULL,
    nombre     VARCHAR(100) NOT NULL,
    user     VARCHAR(15) NOT NULL,
    pass   VARCHAR(40) NOT NULL,
    correo     VARCHAR(70) NOT NULL,
    PRIMARY KEY (dni)
);


-- Linea, marca de bus
CREATE TABLE linea (
    id       INT(11) NOT NULL AUTO_INCREMENT,
    numero   INT(11) NOT NULL,
    nombre   VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE salida (
    id         INT(11) NOT NULL AUTO_INCREMENT,
    hora       TIME NOT NULL,
    id_linea   INT(11) NOT NULL,
    dia        ENUM('f', 's', 'n') NOT NULL DEFAULT 'n',
    PRIMARY KEY (id)
);


-- Guardo hora legada y numero de parada para controlar las llegadas a las paradas
CREATE TABLE linea_autobus (
    id                  INT(11) NOT NULL AUTO_INCREMENT,
    linea_id            INT(11) NOT NULL,
    autobus_matricula   VARCHAR(8) NOT NULL,
    hora_llegada        TIME NOT NULL,
    num_parada          INT(4) NOT NULL,
    PRIMARY KEY (id)
);



-- Guardo orden de la parada dentro de la línea y duración entre esa parada y la anterior
CREATE TABLE linea_parada (
    id          INT(11) NOT NULL AUTO_INCREMENT,
    parada_id   INT(11) NOT NULL,
    linea_id    INT(11) NOT NULL,
    orden       INT(3) NOT NULL,
    duracion    TIME NOT NULL,
    PRIMARY KEY (id)
);



-- Parada donde parará el bus
CREATE TABLE parada (
    id         INT(11) NOT NULL AUTO_INCREMENT,
    nombre     VARCHAR(100) NOT NULL,
    latitud    DECIMAL(10,6) NOT NULL,
    longitud   DECIMAL(10,6) NOT NULL,
    PRIMARY KEY (id)
);


-- Foreign Keys
ALTER TABLE bus_conductor
    ADD CONSTRAINT bus_conductor_autobus_fk FOREIGN KEY ( autobus_matricula )
        REFERENCES autobus ( matricula );

ALTER TABLE bus_conductor
    ADD CONSTRAINT bus_conductor_conductor_fk FOREIGN KEY ( conductor_dni )
        REFERENCES conductor ( dni );

ALTER TABLE linea_autobus
    ADD CONSTRAINT linea_autobus_autobus_fk FOREIGN KEY ( autobus_matricula )
        REFERENCES autobus ( matricula );

ALTER TABLE linea_autobus
    ADD CONSTRAINT linea_autobus_linea_fk FOREIGN KEY ( linea_id )
        REFERENCES linea ( id );

ALTER TABLE linea_parada
    ADD CONSTRAINT linea_parada_linea_fk FOREIGN KEY ( linea_id )
        REFERENCES linea ( id );

ALTER TABLE linea_parada
    ADD CONSTRAINT linea_parada_parada_fk FOREIGN KEY ( parada_id )
        REFERENCES parada ( id );

ALTER TABLE salida
    ADD CONSTRAINT salida_linea_fk FOREIGN KEY ( id_linea )
        REFERENCES linea ( id );




-- Insert de Administradores
INSERT INTO administrador(useradmin, pass, nombre) VALUES ('ManuCS', MD5('manucs'), 'Manuel');

-- Insert de Parada
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Plaza Esteve', 36.68183, -6.1366);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Villamarta', 36.6834, -6.13486);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Arcos', 36.68411, -6.13029);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Pío XII', 36.68317, -6.13014);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Descalzos', 36.6812, -6.13077);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Madre de Dios', 36.67955, -6.12961);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Bajada San Telmo', 36.67734, -6.13094);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cerrofruto', 36.67734, -6.13094);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Constitución', 36.67074, -6.1326);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Nueva Cartuja', 36.66911, -6.12707);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Solidaridad', 36.67029, -6.1252);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Vallesequillo II', 36.66982, -6.12788);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Moreno Mendoza (subiendo)', 36.67307, -6.12835);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('San Telmo', 36.67188, -6.1317);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ermita San Telmo (subiendo)', 36.6738, -6.13224);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Madre de Dios (Hacia Centro)', 36.67679, -6.13135);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Diego F. Herrera', 36.68064, -6.13109);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Convento Angustias', 36.68083, -6.13242);

INSERT INTO parada(nombre, latitud, longitud) VALUES ('Santo Domingo II', 36.68763, -6.13708);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Mamelón', 36.68888, -6.1376);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ancha', 36.68803, -6.14271);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Merced', 36.68708, -6.14536);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Azahar', 36.68691, -6.14958);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Mirador', 36.68699, -6.15255);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Amapolas', 36.68535, -6.15133);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Picadueña Alta', 36.68465, -6.14933);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Luis Vives', 36.68547, -6.14729);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Nueva Medina', 36.68259, -6.14661);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Puerta de Rota', 36.68259, -6.14661);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Picadueña Baja', 36.68223, -6.14876);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Teodoro Molina', 36.68186, -6.15006);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Pilar', 36.68126, -6.14975);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Puerta de Rota (Hacia Nueva Medina)', 36.68259, -6.14661);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Nueva Medina (Hacia Calle Muro)', 36.6832, -6.14642);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Calle Muro', 36.686, -6.14584);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ancha (Hacia Porvera)', 36.68808, -6.14216);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Porvera II', 36.68737, -6.13964);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Porvera I', 36.68616, -6.13773);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Rotonda Casino', 36.68502, -6.13647);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Calle Sevilla', 36.6904, -6.1356);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Calle Paul', 36.68848, -6.13284);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Bda. España (Hacia Estaciones)', 36.68807, -6.12792);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Estaciones', 36.68147, -6.12819);

INSERT INTO parada(nombre, latitud, longitud) VALUES ('Lealas', 36.68865, -6.14123);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('San Fco. Javier', 36.68996, -6.14229);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Lealas II', 36.69202, -6.14323);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Plata', 36.69457, -6.14235);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Perpetuo Socorro', 36.69538, -6.14226);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Serrana', 36.69479, -6.14387);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Soleá', 36.69502, -6.14584);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Las Torres', 36.69578, -6.14704);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Amontillado', 36.69461, -6.148);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Icovesa', 36.69345, -6.14615);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Santa Ana', 36.69205, -6.14393);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Asta', 36.68994, -6.14393);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Santiago Barrera', 36.68863, -6.14385);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Virgen de Fátima', 36.68834, -6.1295);

INSERT INTO parada(nombre, latitud, longitud) VALUES ('Álvara Domecq', 36.69162, -6.13369);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Coloma', 36.69302, -6.13148);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cruz Roja (Hacia Merca 80)', 36.69488, -6.13168);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Merca 80', 36.69722, -6.13487);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('García Lorca', 36.70016, -6.1353);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('María Auxiliadora', 36.70202, -6.13429);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Comedia', 36.70185, -6.13311);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Parque Luz (Hacia San Joaquín)', 36.70284, -6.12989);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('San Joaquín (Hacia Maternidad)', 36.70344, -6.12768);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Buenos Aires', 36.70535, -6.12367);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Guatemala I', 36.70636, -6.12276);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Guatemala II', 36.70616, -6.11986);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Hipercor', 36.70521, -6.11778);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Avenida Andalucía', 36.70318, -6.12016);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('San Juan de Ávila', 36.70266, -6.12288);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Maternidad', 36.70367, -6.12582);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('San Joaquín (Hacia Almendral)', 36.70368, -6.12785);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Parque Luz (Hacia La Espléndida)', 36.70264, -6.1302);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Espléndida', 36.70061, -6.13158);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('San Ginés', 36.70135, -6.13427);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('García Lorca (Hacia Merca 80)', 36.69938, -6.13584);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Merca 80 (Hacia Cruz Roja)', 36.69697, -6.13468);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cruz Roja (Hacia Plaza Caballo)', 36.69365, -6.13031);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Plaza Caballo', 36.69365, -6.13031);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Torres de Córdoba', 36.69224, -6.12831);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Constancia', 36.68995, -6.12789);

INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Constancia (Hacia La Granja)', 36.69005, -6.12766);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Torres de Córdoba', 36.69178, -6.12774);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Plaza Caballo', 36.69361, -6.12933);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Avenida Caballo', 36.69846, -6.12637);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Feria', 36.69746, -6.12632);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Bosque', 36.69757, -6.12514);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Edificio Congreso', 36.69637, -6.11767);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Carrefour Norte', 36.69668, -6.11573);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Arrumbadores', 36.69765, -6.11024);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Instituto La Granja', 36.69851, -6.10581);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Avenida Europa', 36.69906, -6.10269);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Azulejos Bahía', 36.6999, -6.10486);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Arroyo del Membrillar', 36.70213, -6.10705);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Fdez. Cruzado', 36.70301, -6.1056);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ermita de Palomares', 36.70326, -6.10288);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ermita de Setefilla', 36.70493, -6.1027);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Picador', 36.70739, -6.09877);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Rabanito', 36.70943, -6.09041);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ferretería', 36.71609, -6.09209);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Feria Guadalcacín', 36.71718, -6.08866);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Mercado', 36.71519, -6.08694);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Calle Madrid', 36.71451, -6.08493);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Divina Pastora', 36.71237, -6.0856);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Guadalcacín', 36.71112, -6.0891);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Rabanito (Hacia San José Obrero)', 36.70954, -6.09021);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Picador (Hacia San José Obrero)', 36.70745, -6.09924);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ermita Setefilla (Hacia La Granja)', 36.70478, -6.1027);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ermita Palomares (Hacia La Granja)', 36.70304, -6.10333);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Santa Antonia', 36.70318, -6.10573);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Arroyo del Membrillar (Hacia La Granja)', 36.7016, -6.10703);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Azulejos Bahía (Hacia Av. Europa)', 36.69979, -6.1049);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Instituto La Granja (Hacia Arrumbadores)', 36.69899, -6.10499);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Arrumbadores (Hacia Carrefour Norte)', 36.7016, -6.10703);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Carrefour Norte (Hacia Ed. Congreso)', 36.69716, -6.11487);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Ed. Congreso (Hacia El Bosque)', 36.6966, -6.11815);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Bosque (Hacia Alvaro Domecq)', 36.6975, -6.12498);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Feria (Hacia Caballo)', 36.69754, -6.12652);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Avenida Caballo (Hacia Plaza Caballo)', 36.69484, -6.12954);

INSERT INTO parada(nombre, latitud, longitud) VALUES ('Harinera', 36.68445, -6.12727);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Fábrica de Botellas', 36.68492, -6.1235);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Burguer King', 36.68548, -6.12102);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Universidad', 36.68606, -6.11847);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Torres Blancas', 36.68745, -6.11303);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Glorieta Biarritz', 36.68925, -6.11074);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Lola Flores', 36.69031, -6.10888);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Pinar', 36.69154, -6.10664);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Residencia Pensionistas', 36.6931, -6.10351);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Fernando Portillo', 36.69527, -6.10591);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('7 Pinos', 36.69722, -6.10675);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Calle Almería', 36.69773, -6.10137);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Suite La Marquesa', 36.69519, -6.10004);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Piscina Jerez', 36.69437, -6.10147);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Residencia Pensionista (Sentido Centro)', 36.69333, -6.10366);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Pinar (Sentido Centro)', 36.69183, -6.10662);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Lola Flores (Sentido Centro)', 36.6905, -6.10912);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Glorieta Biarritz (Sentido Centro)', 36.68933, -6.11102);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Torres Blancas (Sentido Centro)', 36.68752, -6.11316);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Universidad (Sentido Centro)', 36.68639, -6.119);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Burguer King (Sentido Centro)', 36.6857, -6.12096);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Fábrica de Botellas (Sentido Centro)', 36.68495, -6.12392);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Harinera (Sentido Centro)', 36.68451, -6.12766);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Medina', 36.68158, -6.13155);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Plaza de las Angustias', 36.68082, -6.13438);

INSERT INTO parada(nombre, latitud, longitud) VALUES ('Porvenir', 36.67927, -6.13074);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Plaza Madre de Dios', 36.67909, -6.1295);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cartuja', 36.68065, -6.12818);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Retiro', 36.68106, -6.12377);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Parque Retiro', 36.68141, -6.12117);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Alborán', 36.68202, -6.11882);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Delicias', 36.68293, -6.1157);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Záfer', 36.68321, -6.11305);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Pedro R. del Raño', 36.6852, -6.10784);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cantalejo', 36.68559, -6.10579);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Centauro', 36.68601, -6.10409);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Pita', 36.6864, -6.1013);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cementerio', 36.68541, -6.09518);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Venta La Cueva', 36.68609, -6.07976);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Hogar Pensionista', 36.68466, -6.07734);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Arboleda', 36.68456, -6.07359);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('El Pozo', 36.68583, -6.07341);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Estella', 36.68525, -6.0749);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Hogar Pensionista (Saliendo de Estella)', 36.68465, -6.07721);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Venta La Cueva (Saliendo de Estella)', 36.68613, -6.07966);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cementerio (Hacia Plaza Angustias)', 36.68555, -6.09498);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('La Pita (Hacia Plaza Angustias)', 36.6867, -6.10127);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Centauro (Hacia Plaza Angustias)', 36.68606, -6.10424);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cantalejo (Hacia Plaza Angustias)', 36.68572, -6.1057);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Pedro R. del Raño (Hacia Plaza Angustias)', 36.68527, -6.10801);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Zafer (Hacia Plaza Angustias)', 36.68337, -6.11309);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Delicias (Hacia Plaza Angustias)', 36.68306, -6.11582);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Alborán (Hacia Plaza Angustias)', 36.68225, -6.11889);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Parque Retiro (Hacia Plaza Angustias)', 36.68154, -6.12126);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Retiro (Hacia Plaza Angustias)', 36.68112, -6.12383);
INSERT INTO parada(nombre, latitud, longitud) VALUES ('Cartuja (Hacia Plaza Angustias)', 36.68093, -6.1279);



-- Insert de Linea
INSERT INTO linea(numero, nombre) VALUES (1, 'Esteve - San Telmo');
INSERT INTO linea(numero, nombre) VALUES (2, 'Esteve - Picadueña');
INSERT INTO linea(numero, nombre) VALUES (3, 'Esteve - Las Torres');
INSERT INTO linea(numero, nombre) VALUES (4, 'Esteve - San Joaquín - Hipercor');
INSERT INTO linea(numero, nombre) VALUES (5, 'Esteve - Guadalcacín');
INSERT INTO linea(numero, nombre) VALUES (6, 'Esteve - La Granja');
INSERT INTO linea(numero, nombre) VALUES (7, 'Angustias - Estella');


-- Insert de Autobus (número es la línea en que trabaja)
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('4444KJP', 1, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('4589JQP', 1, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('2378POU', 2, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('0649DWR', 2, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('1103KJP', 3, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('2005PJM', 3, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('0410CTB', 4, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('1040JPK', 4, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('5678LKJ', 5, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('1234MNG', 5, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('9087HYT', 6, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('3465CMD', 6, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('9876QWR', 7, 'Jerez');
INSERT INTO autobus(matricula, numero, poblacion) VALUES ('7658HTG', 7, 'Jerez');

-- Conductor
-- Linea 1
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('40148519H', 'Pepe', 'Peperugar', MD5('pepesito11'), 'peperg@bus.com');
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('00523517Z', 'Juan', 'Juangus', MD5('juangustin22'), 'juangus@bus.com');

-- Linea 2
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('62876382V', 'Miguel', 'Migueli', MD5('migueli33'), 'migueli@bus.com');
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('46690366K', 'Paco', 'Pacunix', MD5('fuckwindows'), 'pacunix@bus.com');

-- Linea 3
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('39877545F', 'Fernando', 'Fernandux', MD5('fer404'), 'fernandux@bus.com');
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('87634410V', 'Carmen', 'Carmeni', MD5('carmeni1'), 'carmeni@bus.com');

-- Linea 4
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('66332392R', 'Ximo', 'Ximuny', MD5('xim'), 'ximuny@bus.com');
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('57188526S', 'Sandra', 'Sandriu', MD5('sandris2'), 'sandriu@bus.com');

-- Linea 5
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('00328209E', 'Luis', 'LuPer', MD5('luperi'), 'luper@bus.com');
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('71753794G', 'Pedro', 'Pedrin', MD5('pedrin1'), 'pedrin@bus.com');

-- Linea 6
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('19626702C', 'Joaquin', 'JVidal', MD5('jviga'), 'jvidal@bus.com');
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('86351829P', 'Dolores', 'Dolwors', MD5('dolws'), 'dolwors@bus.com');

-- Linea 7
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('58502188D', 'Rodolfo', 'Rodolf', MD5('roudf'), 'rodolf@bus.com');
INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('34811341J', 'Sirius', 'SiriusB', MD5('black'), 'siriusb@bus.com');


-- Bus_Conductor
-- Linea 1
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('40148519H', '4444KJP', '2016-03-11');
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('00523517Z', '4589JQP', '2016-05-07');
-- Linea 2
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('62876382V', '2378POU', '2016-07-23');
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('46690366K', '0649DWR', '2016-10-04');
-- Linea 3
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('39877545F', '1103KJP', '2016-05-15');
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('87634410V', '2005PJM', '2016-12-04');
-- Linea 4
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('66332392R', '0410CTB', '2016-04-11');
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('57188526S', '1040JPK', '2016-02-04');
-- Linea 5
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('00328209E', '5678LKJ', '2016-02-04');
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('71753794G', '1234MNG', '2016-02-04');
-- Linea 6
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('19626702C', '9087HYT', '2016-02-04');
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('86351829P', '3465CMD', '2016-02-04');
-- Linea 7
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('58502188D', '9876QWR', '2016-02-04');
INSERT INTO bus_conductor(conductor_dni, autobus_matricula, fecha_inicio) VALUES ('34811341J', '7658HTG', '2016-02-04');



-- linea_autobus
-- buses linea 1
INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES(1, '4444KJP', '07:00:00', '1');
INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES(1, '4589JQP', '15:00:00', '1');
INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES(1, '4589JQP', '11:00:00', 7);
INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES(1, '4589JQP', '15:00:00', 12);


-- linea_parada
-- linea 1
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(1, 1, 1, '00:00:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(2, 1, 2, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(3, 1, 3, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(4, 1, 4, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(5, 1, 5, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(6, 1, 6, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(7, 1, 7, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(8, 1, 8, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(9, 1, 9, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(10, 1, 10, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(11, 1, 11, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(12, 1, 12, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(13, 1, 13, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(14, 1, 14, '00:05:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(15, 1, 15, '00:04:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(16, 1, 16, '00:05:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(17, 1, 17, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(18, 1, 18, '00:01:00');

-- linea 2
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(1, 2, 1, '00:00:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(19, 2, 2, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(20, 2, 3, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(21, 2, 4, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(22, 2, 5, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(23, 2, 6, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(24, 2, 7, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(25, 2, 8, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(26, 2, 9, '00:00:30');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(27, 2, 10, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(28, 2, 11, '00:00:30');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(29, 2, 12, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(30, 2, 13, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(31, 2, 14, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(32, 2, 15, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(33, 2, 16, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(34, 2, 17, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(35, 2, 18, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(36, 2, 19, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(37, 2, 20, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(38, 2, 21, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(39, 2, 22, '00:03:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(19, 2, 23, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(40, 2, 24, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(41, 2, 25, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(42, 2, 26, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(43, 2, 27, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(17, 2, 28, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(18, 2, 29, '00:01:00');

-- Linea 3
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(1, 3, 1, '00:00:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(19, 3, 2, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(20, 3, 3, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(44, 3, 4, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(45, 3, 5, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(46, 3, 6, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(47, 3, 7, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(48, 3, 8, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(49, 3, 9, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(50, 3, 10, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(51, 3, 11, '00:04:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(52, 3, 12, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(53, 3, 13, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(54, 3, 14, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(55, 3, 15, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(56, 3, 16, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(36, 3, 17, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(37, 3, 18, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(38, 3, 19, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(39, 3, 20, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(40, 3, 21, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(41, 3, 22, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(42, 3, 23, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(43, 3, 24, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(17, 3, 25, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(18, 3, 26, '00:02:00');

-- Linea 4
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(1, 4, 1, '00:00:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(40, 4, 2, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(58, 4, 3, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(59, 4, 4, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(60, 4, 5, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(61, 4, 6, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(62, 4, 7, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(63, 4, 8, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(64, 4, 9, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(65, 4, 10, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(66, 4, 11, '00:04:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(67, 4, 12, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(68, 4, 13, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(69, 4, 14, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(70, 4, 15, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(71, 4, 16, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(72, 4, 17, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(73, 4, 18, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(74, 4, 19, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(75, 4, 20, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(76, 4, 21, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(77, 4, 22, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(78, 4, 23, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(79, 4, 24, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(80, 4, 25, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(81, 4, 26, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(82, 4, 27, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(83, 4, 28, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(42, 4, 29, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(43, 4, 30, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(17, 4, 31, '00:03:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(18, 4, 32, '00:02:00');

-- Linea 5
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(1, 5, 1, '00:00:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(2, 5, 2, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(3, 5, 3, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(42, 5, 4, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(84, 5, 5, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(85, 5, 6, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(86, 5, 7, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(87, 5, 8, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(88, 5, 9, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(89, 5, 10, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(90, 5, 11, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(91, 5, 12, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(92, 5, 13, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(93, 5, 14, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(94, 5, 15, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(95, 5, 16, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(96, 5, 17, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(97, 5, 18, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(98, 5, 19, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(99, 5, 20, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(100, 5, 21, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(101, 5, 22, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(102, 5, 23, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(103, 5, 24, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(104, 5, 25, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(105, 5, 26, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(106, 5, 27, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(107, 5, 28, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(108, 5, 29, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(109, 5, 30, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(110, 5, 31, '00:04:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(111, 5, 32, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(112, 5, 33, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(113, 5, 34, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(114, 5, 35, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(115, 5, 36, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(116, 5, 37, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(117, 5, 38, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(118, 5, 39, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(119, 5, 40, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(120, 5, 41, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(121, 5, 42, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(81, 5, 43, '00:03:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(83, 5, 44, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(42, 5, 45, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(43, 5, 46, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(17, 5, 47, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(18, 5, 48, '00:02:00');

-- Linea 6
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(1, 6, 1, '00:00:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(2, 6, 2, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(3, 6, 3, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(122, 6, 4, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(123, 6, 5, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(124, 6, 6, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(125, 6, 7, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(126, 6, 8, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(127, 6, 9, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(128, 6, 10, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(129, 6, 11, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(130, 6, 12, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(131, 6, 13, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(132, 6, 14, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(93, 6, 15, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(133, 6, 16, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(134, 6, 17, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(135, 6, 18, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(136, 6, 19, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(137, 6, 20, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(138, 6, 21, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(139, 6, 22, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(140, 6, 23, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(141, 6, 24, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(142, 6, 25, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(143, 6, 26, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(144, 6, 27, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(4, 6, 28, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(145, 6, 29, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(146, 6, 30, '00:01:00');

-- Linea 7
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(146, 7, 1, '00:00:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(147, 7, 2, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(148, 7, 3, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(149, 7, 4, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(150, 7, 5, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(151, 7, 6, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(152, 7, 7, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(153, 7, 8, '00:02:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(154, 7, 9, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(155, 7, 10, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(156, 7, 11, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(157, 7, 12, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(158, 7, 13, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(159, 7, 14, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(160, 7, 15, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(161, 7, 16, '00:04:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(162, 7, 17, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(163, 7, 18, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(164, 7, 19, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(165, 7, 20, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(166, 7, 21, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(167, 7, 22, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(168, 7, 23, '00:04:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(169, 7, 24, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(170, 7, 25, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(171, 7, 26, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(172, 7, 27, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(173, 7, 28, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(174, 7, 29, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(175, 7, 30, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(176, 7, 31, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(177, 7, 32, '00:01:00');
INSERT INTO linea_parada(parada_id, linea_id, orden, duracion) VALUES(18, 7, 33, '00:02:00');


-- Salida (hora)

-- Linea 1 normal
INSERT INTO salida (hora, id_linea, dia) VALUES('07:18:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('07:56:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:39:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:00:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:26:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:48:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:13:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:34:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:57:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:14:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:39:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:56:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:24:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:42:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:10:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:26:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:51:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:11:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:55:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:15:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:57:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:34:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:30:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:08:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:47:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:27:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:07:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:47:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:25:00', 1, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:59:00', 1, 'n');

-- Linea 1 Sabado
INSERT INTO salida (hora, id_linea, dia) VALUES('07:49:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:23:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:57:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:32:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:25:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:03:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:43:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:24:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:04:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:44:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:24:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:05:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:16:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:47:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:00:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:18:00', 1, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:34:00', 1, 's');


-- Linea 1 Festivo
INSERT INTO salida (hora, id_linea, dia) VALUES('09:36:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:14:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:34:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:53:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:12:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:48:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:04:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:43:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:04:00', 1, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:26:00', 1, 'f');


-- Linea 2 Normal
INSERT INTO salida (hora, id_linea, dia) VALUES('07:47:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:31:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:23:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:16:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:11:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:05:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:01:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:56:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:18:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:06:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:54:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:43:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:34:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:23:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:14:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:03:00', 2, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:46:00', 2, 'n');

-- Linea 2 Sabado
INSERT INTO salida (hora, id_linea, dia) VALUES('08:03:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:45:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:50:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:41:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:32:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:24:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:17:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:10:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:05:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:35:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:25:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:58:00', 2, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:32:00', 2, 's');

-- Linea 2 Festivo
INSERT INTO salida (hora, id_linea, dia) VALUES('09:43:00', 2, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:36:00', 2, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:14:00', 2, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:45:00', 2, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:13:00', 2, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:55:00', 2, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:28:00', 2, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:02:00', 2, 'f');


-- Linea 3 Normal
INSERT INTO salida (hora, id_linea, dia) VALUES('06:56:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('07:16:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('07:35:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('07:56:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:05:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:19:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:30:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:42:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:55:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:09:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:20:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:33:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:47:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:01:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:12:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:26:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:40:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:54:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:05:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:18:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:33:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:47:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:58:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:12:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:26:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:40:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:52:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:06:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:21:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:34:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:46:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:15:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:28:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:40:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:10:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:23:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:43:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:59:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:14:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:29:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:44:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:59:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:14:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:28:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:43:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:59:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:16:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:31:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:49:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:06:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:21:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:39:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:56:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:12:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:31:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:49:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:05:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:24:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:40:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:54:00', 3, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('22:12:00', 3, 'n');

-- Linea 3 Sabado
INSERT INTO salida (hora, id_linea, dia) VALUES('07:56:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:18:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:37:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:00:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:36:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:02:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:21:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:37:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:53:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:10:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:28:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:43:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:02:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:19:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:34:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:53:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:13:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:28:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:28:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:45:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:01:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:18:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:53:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:15:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:58:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:40:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:22:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:21:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:07:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:56:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:44:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:32:00', 3, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('22:14:00', 3, 's');


-- Linea 3 Festivo
INSERT INTO salida (hora, id_linea, dia) VALUES('08:59:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:42:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:43:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:28:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:17:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:05:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:56:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:44:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:15:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:59:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:41:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:41:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:24:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:11:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:57:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:44:00', 3, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:30:00', 3, 'f');


-- Linea 4 Normal
INSERT INTO salida (hora, id_linea, dia) VALUES('07:27:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('07:59:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:14:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:33:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:50:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:09:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:29:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:47:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:05:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:24:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:40:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:58:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:18:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:34:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:53:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:12:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:28:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:47:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:07:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:23:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:42:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:02:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:18:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:57:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:20:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:45:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:10:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:34:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:57:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:21:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:44:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:11:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:34:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:03:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:28:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:57:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:22:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:51:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:15:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:41:00', 4, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('22:02:00', 4, 'n');

-- Linea 4 Sabado
INSERT INTO salida (hora, id_linea, dia) VALUES('07:56:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:39:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:23:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:09:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:33:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:57:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:23:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:48:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:16:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:40:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:09:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:33:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:02:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:26:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:00:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:45:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:29:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:30:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:13:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:01:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:52:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:44:00', 4, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:34:00', 4, 's');

-- Linea 4 Festivo
INSERT INTO salida (hora, id_linea, dia) VALUES('08:54:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:34:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:32:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:14:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:00:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:45:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:35:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:23:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:40:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:10:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:22:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:04:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:02:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:43:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:25:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:08:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:55:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:42:00', 4, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:23:00', 4, 'f');


-- Linea 5 Normal
INSERT INTO salida (hora, id_linea, dia) VALUES('07:10:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('07:41:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:20:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:56:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:33:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:10:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:49:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:25:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:03:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:39:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:18:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:53:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:09:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:46:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:22:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:36:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:49:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:03:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:17:00', 5, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('22:30:00', 5, 'n');

-- Linea 5 Sábado
INSERT INTO salida (hora, id_linea, dia) VALUES('07:31:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:28:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:48:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:54:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:03:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:12:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:20:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:22:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:40:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:43:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:47:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:54:00', 5, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:00:00', 5, 's');

-- Linea 5 festivos
INSERT INTO salida (hora, id_linea, dia) VALUES('09:03:00', 5, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:16:00', 5, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:20:00', 5, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:40:00', 5, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:32:00', 5, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:42:00', 5, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:44:00', 5, 'f');


-- Linea 6 Normal
INSERT INTO salida (hora, id_linea, dia) VALUES('07:22:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:01:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:21:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:05:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:29:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:52:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:13:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:36:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:56:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:19:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:42:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:05:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:05:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:29:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:50:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:16:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:37:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:02:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:25:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:49:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:11:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:33:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:52:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:14:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:33:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:54:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:13:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:34:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:54:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:16:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:36:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:59:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:19:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:44:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:05:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:32:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:53:00', 6, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:37:00', 6, 'n');

-- Linea 6 sabado
INSERT INTO salida (hora, id_linea, dia) VALUES('07:56:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:35:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:13:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:53:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:14:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:36:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:59:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:21:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:44:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:05:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:29:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:51:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:15:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:38:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:02:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:25:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:06:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:25:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:58:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:20:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:53:00', 6, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:32:00', 6, 's');

-- Linea 6 festivo
INSERT INTO salida (hora, id_linea, dia) VALUES('09:25:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:52:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:10:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:33:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:53:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:18:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:32:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:02:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:20:00', 6, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:43:00', 6, 'f');


-- Linea 7 Normal
INSERT INTO salida (hora, id_linea, dia) VALUES('07:23:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:04:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:24:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:50:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:13:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:55:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:20:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:44:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:08:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:32:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:58:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:23:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:50:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:14:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:41:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:32:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:20:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:03:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:50:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:36:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:39:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:28:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:20:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:11:00', 7, 'n');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:55:00', 7, 'n');

-- Linea 7 Sabado
INSERT INTO salida (hora, id_linea, dia) VALUES('07:53:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('08:33:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:32:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:16:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:01:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:49:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:37:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:29:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:19:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:10:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:51:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:31:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:29:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:09:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:53:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:37:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:24:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:09:00', 7, 's');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:52:00', 7, 's');

-- Linea 7 Festivo
INSERT INTO salida (hora, id_linea, dia) VALUES('08:30:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:11:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('09:52:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('10:52:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('11:42:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('12:36:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('13:30:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:21:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('14:40:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:06:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('15:25:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:06:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('16:45:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('17:42:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('18:22:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:04:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('19:51:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('20:38:00', 7, 'f');
INSERT INTO salida (hora, id_linea, dia) VALUES('21:20:00', 7, 'f');


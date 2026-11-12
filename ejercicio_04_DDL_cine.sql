/*
Agrega un nuevo esquema llamado "cine" y realiza un script con el DDL de las posibles tablas que 
se emplearian en una base de datos para un cine. En conclusión se crearon 6 tablas posibles para 
que un cine funcione corectamente.
 */

create schema cine; -- Creación  del  esquema cine, el esquema es un contenedor.

-- Tabla "genero", catalogo de generos (accion, comedia, terror, etc.)
CREATE TABLE cine.genero (
    id_genero int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_genero varchar(50) NOT NULL UNIQUE
);


-- Tabla "pelicula", peliculas que se muestran en el cine
CREATE TABLE cine.pelicula (
    id_pelicula int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo varchar(150) NOT NULL,
    duracion_min int NOT NULL,
    clasificacion varchar(10),
    fecha_estreno date,
    id_genero int NOT NULL,
    CONSTRAINT fk_pelicula_genero FOREIGN KEY (id_genero) REFERENCES cine.genero (id_genero),
    CONSTRAINT ck_pelicula_duracion CHECK (duracion_min > 0)
);


-- Tabla "sala", salas del cine
CREATE TABLE cine.sala (
    id_sala int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_sala varchar(50) NOT NULL UNIQUE,
    capacidad int NOT NULL,
    CONSTRAINT ck_sala_capacidad CHECK (capacidad > 0)
);


-- Tabla "funcion",  proyeccion de una pelicula en una sala, a una fecha y hora especificas
CREATE TABLE cine.funcion (
    id_funcion int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_pelicula int NOT NULL,
    id_sala int NOT NULL,
    fecha_hora timestamp NOT NULL,
    precio  numeric(8,2) NOT NULL,
    CONSTRAINT fk_funcion_pelicula FOREIGN KEY (id_pelicula) REFERENCES cine.pelicula (id_pelicula),
    CONSTRAINT fk_funcion_sala FOREIGN KEY (id_sala) REFERENCES cine.sala (id_sala),
    CONSTRAINT ck_funcion_precio CHECK (precio >= 0),
    -- Una sala no puede tener dos funciones a la misma hora
    CONSTRAINT uq_funcion_sala_hora UNIQUE (id_sala, fecha_hora)
);


-- Tabla "cliente",  personas que compran boletos
CREATE TABLE cine.cliente (
    id_cliente int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_cliente varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    phone varchar(20),
    email varchar(100) UNIQUE
);


-- Tabla "boleto", boleto comprado por un cliente para una funcion
CREATE TABLE cine.boleto (
    id_boleto int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_funcion int NOT NULL,
    id_cliente int NOT NULL,
    asiento varchar(5) NOT NULL,
    fecha_compra timestamp NOT NULL DEFAULT now(),
    CONSTRAINT fk_boleto_funcion FOREIGN KEY (id_funcion) REFERENCES cine.funcion (id_funcion),
    CONSTRAINT fk_boleto_cliente FOREIGN KEY (id_cliente) REFERENCES cine.cliente (id_cliente),
    -- Un asiento no se puede vender dos veces en la misma funcion
    CONSTRAINT uq_boleto_funcion_asiento UNIQUE (id_funcion, asiento)
);
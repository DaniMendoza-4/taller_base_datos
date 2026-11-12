-- create schema biblioteca; -- Creación   del   esquema  biblioteca,  el   esquema   es   un   contenedor.
CREATE SCHEMA IF NOT EXISTS biblioteca; -- Crea el esquema "biblioteca" solo si todavía no existe pero en este caso ya existe
SET search_path TO biblioteca; -- Indica que las tablas siguientes se creen dentro del esquema "biblioteca"

CREATE TABLE tbl_author (
    id_author int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_author varchar(100) NOT NULL,
    origin varchar(50)
);



CREATE TABLE tbl_books (
    id_book int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_book varchar(100) NOT NULL,
    publication_year int,
    copies int NOT NULL DEFAULT 1,
    id_author int NOT NULL,
    CONSTRAINT fk_book_author FOREIGN KEY (id_author) REFERENCES tbl_author (id_author)
);

--CREACION DE TABLAS QUE SE PIDEN DE TAREA EN EL EJERCICIO PRACTICO

-- Creacion de la tabla "socio"
CREATE TABLE socio (
    id_socio int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name_socio varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    phone varchar(20),
    email varchar(100) UNIQUE
);
SELECT * FROM biblioteca.socio;

-- Creacion de la tabla "prestamos"
CREATE TABLE biblioteca.prestamos (
    id_prestamo int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio int NOT NULL,
    id_book int NOT NULL,
    loan_date date NOT NULL,
    return_date date,
    CONSTRAINT fk_prestamo_socio FOREIGN KEY (id_socio) REFERENCES biblioteca.socio (id_socio),
    CONSTRAINT fk_prestamo_book FOREIGN KEY (id_book) REFERENCES biblioteca.tbl_books (id_book),
    CONSTRAINT ck_return_after_loan CHECK (return_date >= loan_date)
);


-- Jose Daniel Mendoza

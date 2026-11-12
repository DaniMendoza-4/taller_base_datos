-- DML - Lenguaje de Manipulacion de Datos

-- CRUD

-- CREATE (INSERTAR)

-- INSERCIÓN DE AUTORES 
INSERT INTO biblioteca.tbl_author (name_author, origin) VALUES ('Stephen King', 'USA');
INSERT INTO biblioteca.tbl_author (name_author, origin) VALUES ('J. K. Rowling', 'UK');
INSERT INTO biblioteca.tbl_author (name_author, origin) VALUES ('Eiichiro Oda', 'Japón');

-- INSERCIÓN DE LIBROS
INSERT INTO biblioteca.tbl_books (name_book, publication_year, id_author) VALUES ('It', 1987, 1);
INSERT INTO biblioteca.tbl_books (name_book, publication_year, id_author) VALUES ('One Piece', 1997, 2);
INSERT INTO biblioteca.tbl_books (name_book, publication_year, id_author) VALUES ('Harry Potter: La piedra Filosofal', 2000, 2);
INSERT INTO biblioteca.tbl_books (name_book, publication_year, id_author) VALUES ('Harry Potter: El sucio Poter', 2000, 2);


-- INSERCCIÓN DE SOCIOS
INSERT INTO biblioteca.socio (name_socio, last_name, phone, email) VALUES ('Luis', 'Perez', '2841098152', 'luis8252@gmail.com');
INSERT INTO biblioteca.socio (name_socio, last_name, phone, email) VALUES ('Sofi', 'López', '2841094947', 'sofi4947@gmail.com');

-- INSERCCIÓN DE PRESTAMOS
INSERT INTO biblioteca.prestamos (id_socio, id_book, loan_date) VALUES (1, 1, '2026-11-01');
INSERT INTO biblioteca.prestamos (id_socio, id_book, loan_date) VALUES (2, 4, '2026-09-13');



-- READ (LEER)

-- Consultas de cada tabla
SELECT * FROM biblioteca.tbl_author ta;
SELECT * FROM biblioteca.tbl_books tb;
SELECT * FROM biblioteca.socio s;
SELECT * FROM biblioteca.prestamos p;

-- Consultas con solo algunas columnas 
SELECT tb.id_book, tb.name_book FROM biblioteca.tbl_books tb;

-- Consulta, libros con su autor
SELECT 
    tb.name_book AS NOMBRE_LIBRO,
    ta.name_author AS NOMBRE_AUTOR,
    tb.publication_year AS PUBLICADO_EN
FROM biblioteca.tbl_books tb 
INNER JOIN biblioteca.tbl_author ta ON tb.id_author = ta.id_author;

-- Consulta, prestamos con el nombre del socio y el libro
SELECT 
    s.name_socio AS NOMBRE_SOCIO,
    b.name_book AS NOMBRE_LIBRO,
    p.loan_date AS FECHA_PRESTAMO,
    p.return_date AS FECHA_DEVOLUCION
FROM biblioteca.prestamos p 
INNER JOIN biblioteca.socio s ON p.id_socio = s.id_socio 
INNER JOIN biblioteca.tbl_books b ON p.id_book = b.id_book;
    
-- UPDATE (ACTUALIZAR)

-- Siempre  debemos  usar  WHERE  para  no  modificar  todas  las filas
-- Actualizar, cambiar el rigen del author 1
UPDATE biblioteca.tbl_author ta 
SET origin = 'Estados Unidos'
WHERE ta.id_author = 1;

--Actualizar, correccion del autor de "One Piece" (era Rowling, es Oda)
UPDATE biblioteca.tbl_books tb 
SET id_author = 3
WHERE tb.id_book = 2;

--Actualizar,  cambiar  el  nombre  de   un   libro
UPDATE biblioteca.tbl_books tb 
SET name_book = 'HP: La camara secreta'
WHERE id_book = 3;

-- Actualizar, resgistrar la devolucion del primer prestamo
UPDATE biblioteca.prestamos p 
SET return_date = '2026-11-08'
WHERE p.id_prestamo = 1;

-- DELETE (ELIMINAR)

-- Eliminar, el segundo prestamo
DELETE FROM biblioteca.prestamos WHERE id_prestamo = 2;  

-- Eliminar, el segundo socio, ya no tiene prestamos
DELETE FROM biblioteca.socio  WHERE id_socio = 2;

-- Eliminar, libros 2 y 3, ya  no  tienen  prestamos
DELETE FROM biblioteca.tbl_books WHERE id_book = 2;
DELETE FROM biblioteca.tbl_books WHERE id_book = 3;


--Eliminar, autor 3, ya no tiene libros 
DELETE FROM biblioteca.tbl_author WHERE  id_author = 3;
-- BORRAR BASE DE DATOS SI NO EXISTE
DROP DATABASE IF EXISTS consultorio_adriana;
-- CREAR UNA BASE DE DATOS
CREATE DATABASE consultorio_adriana;

USE consultorio_adriana;

CREATE TABLE medico(
    medico_cuit     VARCHAR(11)
,   nombre          VARCHAR(200) 
,   especialidad    VARCHAR(200)
,   PRIMARY KEY (medico_cuit)
);

CREATE TABLE paciente(
    paciente_dni    VARCHAR(8)
,   email           VARCHAR(200)
,   edad            INT
,   PRIMARY KEY(paciente_dni)
);

CREATE TABLE link_paciente_medico(
    medico_cuit     VARCHAR(11)
,   paciente_dni    VARCHAR(8)
,   med_cabecera    BOOL DEFAULT TRUE
,   PRIMARY KEY(medico_cuit, paciente_dni)
);

ALTER TABLE link_paciente_medico
    ADD CONSTRAINT fk_medico_link
    FOREIGN KEY (medico_cuit) REFERENCES medico(medico_cuit);

ALTER TABLE link_paciente_medico
    ADD CONSTRAINT fk_paciente_link
    FOREIGN KEY (paciente_dni) REFERENCES paciente(paciente_dni);

CREATE TABLE obra_social(
    obra_social_id  INT PRIMARY KEY NOT NULL AUTO_INCREMENT
,   nombre      VARCHAR(200)
,   plan        VARCHAR(100)
);

CREATE TABLE facturacion(
    id_factura      INT PRIMARY KEY NOT NULL AUTO_INCREMENT
,   medico_cuit     VARCHAR(11)
,   paciente_dni    VARCHAR(8)
,   obra_social_id  INT
,   precio          DECIMAL(12,2)
,   fecha           DATE DEFAULT(CURRENT_DATE)
);

ALTER TABLE facturacion
    ADD CONSTRAINT fk_medico_fact
    FOREIGN KEY (medico_cuit) REFERENCES medico(medico_cuit);

ALTER TABLE facturacion
    ADD CONSTRAINT fk_paciente_fact
    FOREIGN KEY (paciente_dni) REFERENCES paciente(paciente_dni);

ALTER TABLE facturacion
    ADD CONSTRAINT fk_obra_social_fact
    FOREIGN KEY (obra_social_id) REFERENCES obra_social(obra_social_id);


USE consultorio_adriana;
-- INGRESAR DATOS
INSERT INTO
    medico
VALUES
(9999990, "marcelo", "cardiologo intervencionista");

SELECT
medico_cuit
,   nombre 
,   especialidad

FROM medico;


INSERT INTO
    paciente
VALUES
(78658978, "Emma",56);

INSERT INTO link_paciente_medico
VALUES
("9999990","78658978", FALSE);

INSERT INTO obra_social
(nombre, plan)
VALUES
("OSDE","501"),
("GALENO","ORO"),
("SANCOR","310");

INSERT INTO facturacion
VALUES
(NULL,"9999990","78658978",3,40000,DEFAULT);

UPDATE facturacion
SET obra_social_id = 2
WHERE id_factura = 2;
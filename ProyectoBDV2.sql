--2. De que partido corresponde cada representate de casilla
SELECT nombrePartido, nombPilaR, apPaternoR, apMaternoR, CURP_R
FROM representante r
INNER JOIN partido p
ON r.idpartido = p.idpartido;

--3. Que candidatos son Federales y Locales
SELECT tipocandidato,p.nombrepartido,nombPilaC, apPaternoC, apMaternoC
FROM candidato c
INNER JOIN tipocandidato t
ON c.idcandidato = t.idcandidato
INNER JOIN partido p
ON c.idpartido = p.idpartido

--4. Cantidad de Votos por cada candidato mostrando tambien su partido
SELECT COUNT( v.noVoto), p.nombrepartido, v.idcandidato, v.nombrecandidato
FROM voto v
INNER JOIN candidato c
ON v.idcandidato = c.idCandidato
INNER JOIN partido p
ON c.idpartido = p.idpartido
GROUP BY p.nombrepartido, v.nombrecandidato, v.idcandidato


SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE agregarRepresentante(vidRepresentante representante.idRepresentante%type,
                                                 vidPartido representante.idPartido%type,
                                                 vnoCasillaR representante.noCasillaR%type,
                                                 vCURP_R representante.CURP_R%type,
                                                 vnombPilaR representante.nombPilaR%type,
                                                 vapPaternoR representante.apPaternoR%type,
                                                 vapMaternoR representante.apMaternoR%type,
                                                 vfotografia REPRESENTANTE.FOTOGRAFÍAR%type)
AS
vidR representante.idRepresentante%type;
BEGIN
    SELECT idrepresentante INTO vidR FROM representante
    WHERE idRepresentante=vidRepresentante;
    
    IF(SQL%FOUND) THEN
        dbms_output.put_line('Representante existente');
    END IF;
    EXCEPTION WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Representante no existe en el registro '||vCURP_R);
    INSERT INTO representante VALUES(vidRepresentante,vidPartido,vnoCasillaR,
    vCURP_R,vnombPilaR,vapPaternoR,vapMaternoR,vfotografia);
    COMMIT;
    dbms_output.put_line('Representante nuevo almacenado '||vCURP_R);
END;
/

CREATE OR REPLACE PROCEDURE agregarGasto(vidNomina gasto.idNomina%type,
                                        vgastoCampaña gasto.gastoCampaña%type,
                                        vgastoActividades gasto.gastoActividades%type)
AS
vidN gasto.idnomina%type;
BEGIN
    SELECT idnomina INTO vidN FROM gasto
    WHERE idnomina=vidNomina;
    
    IF(SQL%FOUND) THEN
        dbms_output.put_line('Nomina existente');
    END IF;
    EXCEPTION WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Nomina no existe en el registro '||vidNomina);
    INSERT INTO gasto VALUES(vidNomina,vgastoCampaña,vgastoActividades);
    COMMIT;
    dbms_output.put_line('Representante nuevo almacenado '||vidNomina);
END;
/

EXEC agregarrepresentante('R15','P6',366,'GUMM970216HDFR001','Mario','Guadarrama','Mendoza',NULL);

EXEC agregargasto('N11',1200000,300000);


--Vistas
--1. Vista de todos los condidatos y su partido
CREATE VIEW candidatos
AS
SELECT p.nombrepartido,c.nombPilaC, c.apPaternoC, c.apMaternoC
FROM candidato c, partido p
WHERE c.idpartido = p.idpartido;

SELECT * FROM candidatos;

-- 2. Vista de todos los nombres de representate de casilla con nombre de partido
CREATE VIEW representantes
AS
SELECT p.nombrePartido, r.nombPilaR, r.apPaternoR, r.apMaternoR
FROM representante r, partido p
WHERE r.idpartido = p.idpartido;
                                        
SELECT * FROM representantes

SELECT nombPilaC, apPaternoC, apMaternoC FROM candidato c
INNER JOIN partido p
ON c.idpartido = p.idpartido



-- Disparador de pago a representantes
select sysdate from dual

CREATE TABLE PAGOR(
usuario VARCHAR(10),
fecha DATE,
accion CHAR (1),
pago NUMBER
);

CREATE OR REPLACE TRIGGER pagoRepresentante
BEFORE INSERT ON representante
FOR EACH ROW
DECLARE
    accion CHAR(1);
    BEGIN
    IF INSERTING THEN
        accion:='I';
    END IF;
    INSERT INTO pagor VALUES
    (USER,sysdate,accion,500);
    dbms_output.put_line('Pago a representante realizado '||SYSDATE);
END pagoRepresentante;
/

EXEC agregarrepresentante('R13','P6',366,'SAOC970216HDFR001','Cesar','Sanchez','Ortega',NULL);

SELECT * from pagor
    

commit;




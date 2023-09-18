CREATE TABLE gasto(
idNomina CHAR(4),
gastoCampaña Number NOT NULL, 
gastoActividades Number NOT NULL,
CONSTRAINT GastoPK Primary KEY(idNomina) 
);

CREATE TABLE partido(
idPartido CHAR(4), --PK
idNomina CHAR(4), --FK
nombrePartido VARCHAR (60) NOT NULL, 
presupuesto Number NOT NULL, 
descripción VARCHAR(150),
CONSTRAINT PartidoPK Primary KEY(idPartido),
CONSTRAINT GASTOFK Foreign Key(idNomina)REFERENCES gasto (idNomina),
CONSTRAINT nombrePartidoCK CHECK(nombrePartido 
IN('Morena','PAN', 'PRI','PV','MC','PVEM','PES','PT','RSP','FxM')));

CREATE TABLE candidato(
idCandidato CHAR(4), --PK
idPartido CHAR(4), --FK
nacionalidadC VARCHAR(10) NOT NULL, 
nombPilaC VARCHAR(15)NOT NULL, 
apPaternoC VARCHAR(20)NOT NULL, 
apMaternoC VARCHAR(20), 
calleC VARCHAR(40)NOT NULL, 
numeroC Number NOT NULL, 
coloniaC VARCHAR(40)NOT NULL, 
codigoPostalC CHAR(5)NOT NULL, 
alcaldiaC  VARCHAR(40)NOT NULL, 
estadoC VARCHAR(40)NOT NULL, 
edadC Number, 
RFC_C CHAR(13) NOT NULL UNIQUE, 
CURP_C CHAR(18)NOT NULL UNIQUE,
CONSTRAINT candidatoPK Primary KEY(idCandidato),
CONSTRAINT idPartidoFK Foreign Key(idPartido)REFERENCES partido (idPartido),
CONSTRAINT nacionalidadCK CHECK(nacionalidadC IN('Mexicana'))
);

CREATE TABLE TIPOCANDIDATO(
idCandidato CHAR(4), -- FK (PK)
tipoCandidato VARCHAR(20),
CONSTRAINT CandidatoREFK Foreign Key(idCandidato)REFERENCES candidato(idCandidato),
CONSTRAINT DipLocalPK Primary KEY(idCandidato),
CONSTRAINT tipoCandidatoCK CHECK(tipoCandidato IN('Local','Federal'))
);


CREATE TABLE Voto(
noVoto CHAR(5), --FK PK
idCandidato CHAR(4), -- FK 
CURP_V Char(18), --FK
nombrePartido VARCHAR (60) NOT NULL, --CK
nombreCandidato VARCHAR(80) NOT NULL,
CONSTRAINT noVotoPK Primary KEY(noVoto),
CONSTRAINT votoREcandidato Foreign Key(idCandidato)REFERENCES candidato(idCandidato),
CONSTRAINT votoREvotante Foreign Key(CURP_V)REFERENCES votante(CURP_V),
CONSTRAINT nombrePCK CHECK(nombrePartido 
IN('Morena','PAN', 'PRI','PV','MC','PVEM','PES','PT','RSP','FxM'))
);


CREATE TABLE Votante(
CURP_V CHAR(18), --PK
noCasillaV Number NOT NULL, --FK
credencial VARCHAR(2) NOT NULL,
vigCredencial DATE NOT NULL,
nombPilaV VARCHAR(15) NOT NULL, 
apPaternoV VARCHAR(20)NOT NULL,
apMaternoV VARCHAR(20), 
fotografía BLOB, 
edad Number NOt NULL,
CONSTRAINT credencialCK CHECK(credencial IN('Si','No')),
CONSTRAINT CURP_VPK Primary KEY(CURP_V)
);

CREATE TABLE casilla(
noCasilla Number, --PK
noSeccion Number NOT NULL , 
ubicación VARCHAR(150) NOT NULL,
CONSTRAINT noCasillaPK Primary KEY(noCasilla)
)

--agregando constraint de llave foranea entre votante y casilla
ALTER TABLE Votante ADD CONSTRAINT votanteREFcasilla
FOREIGN KEY (noCasillaV) REFERENCES casilla (noCasilla);

CREATE TABLE TIPOCASILLA(
noCasilla NUMBER, -- FK (PK)
tipoCasilla VARCHAR(20) NOT NULL, --(CK)
CONSTRAINT noCasillaREFK Foreign Key(noCasilla)REFERENCES casilla (noCasilla),
CONSTRAINT tipoCasillaPK Primary KEY(noCasilla),
CONSTRAINT tipoCasillaCK CHECK(tipoCasilla IN('Basica','Contigua'))
);



CREATE TABLE representante(
idRepresentante CHAR(4), --PK 
idPartido CHAR(4), --FK
noCasillaR Number, --FK
CURP_R CHAR(18) NOt NULL UNIQUE, 
nombPilaR VARCHAR(15) NOT NULL, 
apPaternoR VARCHAR(20)NOT NULL, 
apMaternoR VARCHAR(20), 
fotografíaR BLOB,
CONSTRAINT RepresentantePK Primary KEY(idRepresentante),
CONSTRAINT representanteREFpartido Foreign Key(idPartido)REFERENCES partido (idPartido),
CONSTRAINT representanteREFcasilla Foreign Key(noCasillaR)REFERENCES casilla (noCasilla)
);

CREATE TABLE TIPOREPRESENTANTE(
idRepresentante CHAR(4), -- FK (PK)
tipoRepresentante VARCHAR(20) NOT NULL, --(CK)
CONSTRAINT refuncionarioREFrepresentante Foreign Key(idRepresentante)REFERENCES representante (idRepresentante),
CONSTRAINT tipoRepresentantePK Primary KEY(idRepresentante),
CONSTRAINT tipoRepresentanteCK CHECK(tipoRepresentante IN('Funcionario','Observador'))
);


--tuplas para gasto
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N1',1500000,500000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N2',1600000,700000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N3',1400000,400000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N4',1500000,700000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N5',1300000,800000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N6',1100000,800000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N7',1200000,700000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N8',1500000,500000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N9',1600000,300000);
INSERT INTO gasto (idNomina,gastoCampaña,gastoActividades) VALUES ('N10',1000000,900000);

--tuplas para partido
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P1','N1','PRI',2000000,'Partido Revolucionacion intitucional creado, viejo priismo');
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P2','N2','Morena',2300000,'Morean la esperanza de méxico');
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P3','N3','PAN',1800000,'Luchando por el cambio');
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P4','N4','PV',2200000,'Dando dinero a influencers');
INSERT INTO partido(idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P5','N5','MC',2100000,'Movimiento naranja');
INSERT INTO partido(idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P6','N6','PVEM',1900000,'Partido bienestar');
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P7','N7','PES',1900000,'vamos por el cambio');
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P8','N8','PT',2000000,'Partido del trabajo');
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P9','N9','RSP',1900000,'Nuevo cambio');
INSERT INTO partido (idPartido,idNomina,nombrePartido,presupuesto,descripción)
VALUES ('P10','N10','FxM',1900000,'Union contra morena');

--Tuplas de Candidatos
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C2','P1','Mexicana',
'Jose', 'Antonio', 'Meade', 'Jupiter', 250, 'San Angel', '13510',
'Coyoacan', 'Ciudad de México',50,'ANMJ710516SYA','ANMJ710516HDFDR001');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C1','P2','Mexicana',
'Juan', 'Perez', 'Mota', 'Av. Churubusco', 316, 'Portales', '13512',
'Alvaro Obregon', 'Ciudad de México',45,'MOPJ160675HDF','MOPJ160675HDFDR001');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C3','P3','Mexicana',
'Ricardo', 'Anaya', 'Cortés', 'Av. Pedregal', 126, 'Pedregal', '13560',
'Coyoacan', 'Ciudad de México',43,'ANCR750523MKG','ANCR750523HDFDR001');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C4','P4','Mexicana',
'Griselda', 'Santiago', 'Ramirez', 'Mar de las Crisis', 290, 'Selene', '13430',
'Tlahuac', 'Ciudad de México',45,'SARG760314WRT','SARG760314HDFDR001');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C5','P5','Mexicana',
'Luis', 'Donaldo', 'Colosio', 'Lluvias', 80, 'San Jose', '13412',
'Iztapalapa', 'Ciudad de México',52,'DOCL690624LKF','DOCL690624HDFDR00');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C6','P6','Mexicana',
'Antonio', 'Ponton', 'Rivera', 'Pineda', 36, '10 de Mayo', '14329',
'Xochimilco', 'Ciudad de México',43,'PORA780913NBD','PORA780913HDFDR01');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C7','P7','Mexicana',
'Ignacio', 'Perez', 'Uerta', 'Av. Guillermo Prieto',24, 'Santa Ana', '13360',
'Tlalpan', 'Ciudad de México',48,'PEUI730419FGH','PEUI730419HDFDR00');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C8','P8','Mexicana',
'Mario', 'Delgado', 'Alcala', 'Av. Homero',130, 'Polanco', '11550',
'Miguel Hidalgo','Ciudad de México',40,'DEAM810714PTE','DEAM810714HDFDR01');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C9','P9','Mexicana',
'Miranda', 'Maldonado', 'Sanchez', 'San Marcos',15, 'Guadalupe', '02020',
'Azcapotzalco','Ciudad de México',41,'MASM800125SDT','MASM800125HDFDR00');
INSERT INTO candidato(idCandidato,idPartido,nacionalidadC,
nombPilaC,apPaternoC,apMaternoC,calleC,numeroC,coloniaC,codigoPostalC,
alcaldiaC,estadoC,edadC,RFC_C,CURP_C) VALUES('C10','P10','Mexicana',
'Olga', 'Sanchez', 'Cordero', 'Av. Insurgentes',16, 'Juarez', '06600',
'Cuauhtémoc','Ciudad de México',45,'SACO760209VDT','SACO760209HDFDR01');


-- tuplas casilla
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00256,3666,'Calle Francisco Villa, Número 224, Colonia Guadalupe Tlaltenco, Código Postal 13450, Alcaldía Tláhuac, Ciudad De México');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00366,3665,'Calle Francisco Villa, Número 224, Colonia Guadalupe Tlaltenco, Código Postal 13450, Alcaldía Tláhuac, Ciudad De México');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00456,3664,'Calle Lago De Los Sueños, Número 129, Código Postal 13420, Alcaldía Tláhuac, Ciudad De México DM Esquina Cráter Tycho');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00125,3663,'Calle Vicente Guerrero, Número 8, Código Postal 13400, Alcaldía Tláhuac, Ciudad De México Escuela Primaria Plan De Ayala');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00508,3662,'Avenida Tláhuac, Sin Número, Colonia El Triángulo, Código Postal 13420, Alcaldía Tláhuac, Ciudad De México');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00309,3661,'Calle General Benjamín Hill, 43, Colonia Hipódromo Condesa, Código Postal 06170 Universidad La Salle');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00250,3660,'Calle Orquídea Sin Número, Colonia Torres De Potrero, Código Postal 01840 Primaria Aurelio Hidalgo');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00935,3670,'Calle Orquídea Sin Número, Colonia Torres De Potrero, Código Postal 01840 Primaria Aurelio Hidalgo');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00512,3669,'Calle Orquídea Sin Número, Colonia Torres De Potrero, Código Postal 01840 Primaria Aurelio Hidalgo');
INSERT INTO casilla(noCasilla,noSeccion,ubicación)
VALUES(00333,3668,'Calle Puerto Catania, Manzana 5 Lote 4, Unidad Habitacional Ejidos San Juan De Aragón Código Postal 07940 Domicilio Particular');



--Tuplas de votante
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('GUOC970216DHFDRS01',00256,'Si',TO_DATE('2025/05/03','yyyy/mm/dd'),
'Cesar','Guadarrama','Ortega',NULL,24);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('LORG980520DHFDRS00',00366,'Si',TO_DATE('2026/08/06','yyyy/mm/dd'),
'George','Lopez','Ramirez',NULL,23);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('MEOM000203DHFDRS00',00125,'Si',TO_DATE('2027/09/15','yyyy/mm/dd'),
'Maria','Mendoza','Ortega',NULL,20);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('ORPE720602DHFDRS01',00508,'Si',TO_DATE('2023/11/20','yyyy/mm/dd'),
'Estela','Ortega','Portocarrero',NULL,50);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('WIHE980420DHFDRS00',00250,'Si',TO_DATE('2028/03/25','yyyy/mm/dd'),
'Emilio','Wingartz','Hernandez',NULL,22);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('VAOB970317DHFDRS01',00309,'Si',TO_DATE('2025/06/15','yyyy/mm/dd'),
'Berenice','Valderas','Ortiz',NULL,25);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('MANY970216DHFDRS01',00333,'Si',TO_DATE('2027/01/27','yyyy/mm/dd'),
'Yahir','Martinez','Negrete',NULL,25);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('GERK950612DHFDRS00',00512,'Si',TO_DATE('2030/12/12','yyyy/mm/dd'),
'Karime','Guerrero','De La Rosa',NULL,27);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('CHLA980510DHFDRS00',00935,'Si',TO_DATE('2028/06/17','yyyy/mm/dd'),
'Alejandro','Chavarria','Lira',NULL,23);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('MUAM000825DHFDRS01',00309,'Si',TO_DATE('2024/07/11','yyyy/mm/dd'),
'Mario','Murillo','Ancona',NULL,20);
INSERT INTO votante(CURP_V,noCasillaV,credencial,vigCredencial,
nombPilaV,apPaternoV,apMaternoV,fotografía,edad)
VALUES('SEPA970415DHFDRS01',00456,'Si',TO_DATE('2030/01/15','yyyy/mm/dd'),
'Alison','Segundo','Pineda',NULL,25);


--Tuplas Voto
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00001','C2','GUOC970216DHFDRS01','PRI','Jose Antonio Meade');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00002','C1','LORG980520DHFDRS00','Morena','Juan Perez Mota');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00003','C3','MEOM000203DHFDRS00','PAN','Ricardo Anaya Cortés');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00004','C3','ORPE720602DHFDRS01','PAN','Ricardo Anaya Cortés');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00005','C1','WIHE980420DHFDRS00','Morena','Juan Perez Mota');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00006','C5','VAOB970317DHFDRS01','MC','Luis Donaldo Colosio');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00007','C8','MANY970216DHFDRS01','PT','Mario Delgado Alcala');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00008','C4','GERK950612DHFDRS00','PV','Griselda Santiago Dominguez');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00009','C7','CHLA980510DHFDRS00','PES','Ignacio Perez Uerta');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00010','C9','MUAM000825DHFDRS01','RSP','Miranda Maldonado Sanchez');
INSERT INTO voto(noVoto,idCandidato,CURP_V,nombrePartido,nombreCandidato)
VALUES('00011','C10','SEPA970415DHFDRS01','FxM','Olga Sanchez Cordero');

--Tuplas Representate
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R1','P5',256,'COMJ851113HDFR001','Jesus','Costa','Mendez',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R2','P1',125,'ALSA830416HDFR001','Lupe','Alcala','Segundo',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R3','P8',250,'SAAD970117HDFR000','Dulce','Santiago','Alcala',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R4','P10',512,'PECA010425HDFR001','Saul','Perez','Chavarria',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R5','P2',935,'MEJL950623HDFR001','Luis','Mendoza','Jimenez',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R6','P4',333,'OLRX990528HDFR000','Ximena','Olmedo','Ruiz',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R7','P3',512,'SALF020710HDFR001','Fernanda','Santander','Lopez',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R8','P9',366,'MASR970416HDFR001','Rosa','Martinez','Segundo',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R9','P6',508,'CHCM960510HDFR001','Mario','Chavarria','Chavarria',NULL);
INSERT INTO representante(idRepresentante,idPartido,noCasillaR,CURP_R,nombPilaR, 
apPaternoR,apMaternoR,fotografíaR)
VALUES('R10','P7',256,'GURA690727HDFR001','Alejandro','Guadarrama','De La Rosa',NULL);

--Tuplas tipo de candidato
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C1','Local');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C6','Federal');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C5','Local');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C4','Federal');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C7','Local');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C2','Federal');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C9','Local');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C3','Local');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C10','Local');
INSERT INTO tipoCandidato(idCandidato,tipoCandidato)
VALUES('C8','Local');

--Tuplas tipo de casilla
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(256,'Basica');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(366,'Contigua');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(456,'Basica');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(125,'Basica');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(508,'Basica');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(309,'Basica');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(250,'Basica');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(935,'Contigua');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(333,'Basica');
INSERT INTO tipoCasilla(noCasilla, tipoCasilla)
VALUES(512,'Contigua');

--tuplas tipo de representante
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R1','Funcionario');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R2','Funcionario');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R3','Observador');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R4','Funcionario');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R5','Observador');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R6','Funcionario');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R7','Funcionario');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R8','Observador');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R9','Funcionario');
INSERT INTO tipoRepresentante(idRepresentante,tipoRepresentante)
VALUES('R10','Funcionario');



--1. Consulta, obtener todas las nominas con gastos de actividades
-- mayores a 500,000
SELECT idNomina, gastoActividades
FROM gasto
WHERE gastoActividades > 500000;

--2. Obtener el nombre de los candidatos ordenados por edad menor a mayor
SELECT idCandidato,edadC, nombPilaC, apPaternoC, apMaternoC
FROM candidato
ORDER BY edadC asc;

--3. Obtener el nombre de los candidatos que viven en Coyoacan y  
SELECT idCandidato,alcaldiaC,nombPilaC, apPaternoC, apMaternoC
FROM candidato
WHERE alcaldiaC LIKE('Coyoacan');
--4. Cantiad de votantes en esta elección que tienen o son mayores de 25 años
SELECT Count(CURP_V)
FROM votante
WHERE edad>=25;

--5. Representantes de casilla donde su CURP diga que hayan
-- nacido en los noventa
SELECT CURP_R,nombPilaR, apPaternoR, apMaternoR
FROM representante
WHERE CURP_R LIKE('____9%');

--Consultas con joins
--1. Traer el o los patidos que gastaron mas de 2,000,000
SELECT p.idNomina,nombrePartido, gastoCampaña, gastoActividades
FROM partido p
INNER JOIN gasto g
ON p.idNomina = g.idNomina
WHERE (g.gastoCampaña + g.gastoActividades)>2000000;

commit;



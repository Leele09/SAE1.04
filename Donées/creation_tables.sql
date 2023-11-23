use sae104;

/*Etape 3: Creation des tables */
DROP TABLE if exists Langue;
CREATE table if not exists Langue(
	id_langue INT AUTO_INCREMENT,
    LVA varchar(20) NOT NULL,
    LVB varchar(20) NOT NULL,
    PRIMARY KEY (id_langue)
    );
    
DROP TABLE if exists Baccalaureat;
CREATE table if not exists Baccalaureat(
	id_bac INT,
    nom_serie varchar(25) not null,
    PRIMARY KEY (id_bac)
    );

DROP TABLE IF EXISTS Localite ;
CREATE table if not exists Localite(
	id_localite int primary key,
    nom_commune varchar(45),
    departement numeric(2) CHECK (departement in (75 , 77 , 78 , 91 , 92 ,93 ,94,95))
    );

DROP TABLE IF EXISTS etablissement;
CREATE table if not exists etablissement(
    UAI VARCHAR(9) PRIMARY KEY,
    Libelle text,
    id_localite int,
    foreign key (id_localite) REFERENCES Localite(id_localite) ON DELETE restrict ON UPDATE cascade
    );
    
    
DROP TABLE IF EXISTS Etudiant;
CREATE TABLE if not exists Etudiant (  
	id_etudiant INT UNIQUE, 
	nom VARCHAR(255) UNIQUE, 
	prenom VARCHAR(255) UNIQUE, 
	genre VARCHAR(1) NOT NULL CHECK (genre = "M" OR genre = "F")  , 
	boursier BOOLEAN DEFAULT False , 
	mention VARCHAR(255) DEFAULT 'None', 
	UAI VARCHAR(255) NOT NULL, 
	id_langue INT,
    id_bac INT NOT NULL,

PRIMARY KEY (id_etudiant), 
FOREIGN KEY (UAI) REFERENCES Etablissement(UAI)  ON UPDATE cascade ON DELETE set null, 
FOREIGN KEY (id_langue) REFERENCES Langue(id_langue) ON DELETE restrict,
FOREIGN KEY (id_bac) REFERENCES Baccalaureat(id_bac) ON DELETE restrict
); 

/*Etape 4: Modification de la structure*/
ALTER TABLE Langue ADD COLUMN LVC varchar(30) default NULL;

    
/*Etape 5: Insertion des données*/
INSERT INTO Langue(LVA, LVB)
VALUES
("Anglais", "Espagnole"),
("Anglais", "Allemand"),
("Anglais", "Japonnais");


INSERT INTO Baccalaureat(id_bac , nom_serie)
VALUES
(1,"Générale"),
(2,"STL"),
(3,"STHR"),
(4,"STMG"),
(5,"STI2D");

INSERT INTO Localite(id_localite, nom_commune , departement)
VALUES
(1,"Cesson",77),
(2,"Chelles",77),
(3,"Argenteuil",95),
(4,"Longjumeau",91),
(5,"Saint-Germain-en-Laye",78),
(6,"Avon",77);

INSERT INTO etablissement(UAI,Libelle,id_localite)
VALUES
	('0761742F','Lycée Val De Seine',1),
	('0631669X','Lycée des Métiers de Chamalières',2),
	('0530052U','Lycée Don Bosco',3),
	('9830557N','Lycée Dick Ukeiwë',4),
	('0630068G','Lycée Montdory',5),
	("0772332S","Lycée Sonia Delaunay",6) ,
    ("0771720B","Lycée Gasnier Guy Sainte Bathilde",7) ,
	("0950641F","Lycée Jean Jaures",8) ,
    ("0911577V","Lycée Jacques Prevert",9) ,
    ("0782557F","Lycée Jean-Baptiste Poquelin",10) ,
	("0770918E","Lycée Uruguay France",11);
    
    
INSERT INTO Etudiant(id_etudiant, prenom, nom, genre, boursier, mention, UAI, id_langue,id_bac)
VALUES
(51398, 'N51398', 'P51398', 'M', true, 'B', '9830557N', 3,1),
(101096, 'N101096', 'P101096', 'F', false, 'AB', '0761742F',1,2),
(102534, 'N102534', 'P102534', 'F', true, 'TB','0631669X', 1,3),
(105883, 'N105883', 'P105883', 'F', false, 'AB','0772332S', 1,4),
(105942, 'N105942', 'P105942', 'F', false, 'None','0772332S', 1,1),
(105980, 'N105980', 'P105980', 'F', false, 'AB','0772332S', 1,1),
(106025, 'N106025', 'P106025', 'F', false, 'AB', '0772332S', 2,1),
(106029, 'N106029', 'P106029', 'F', true, 'None', '0772332S', 1,1),
(106045, 'N106045', 'P106045', 'F', false, 'AB', '0772332S', 1,1),
(106447, 'N106447', 'P106447', 'F', false, 'TB', '0772332S', 1,1),
(106452, 'N106452', 'P106452', 'M', true, 'TB', '0772332S', 1,1),
(106867, 'N106867', 'P106867', 'M', true, 'None', '0530052U', 1,1),
(106873, 'N106873', 'P106873', 'M', true, 'TB', '0530052U', 2,1),
(106986, 'N106986', 'P106986', 'F', false, 'AB', '0530052U', 1,1),
(106988, 'N106988', 'P106988', 'M', false, 'B', '0530052U', 1,5),
(106989, 'N106989', 'P106989', 'F', false, 'B', '9830557N', 1,1),
(107008, 'N107008', 'P107008', 'F', true,'AB', '9830557N', 2,1), 
(107010, 'N107010', 'P107010', 'F', false, 'AB', '9830557N', 2,1),
(107016, 'N107016', 'P107016', 'F', false, 'AB', '9830557N', 1,5),
(107033, 'N107033', 'P107033','M', true,'B','0950641F',2,5),
(107036, 'N107036', 'P107036', 'M', true,'B','0950641F',1,5),
(107038, 'N107038', 'P107038', 'M', true,'B','0950641F',1,1),
(107043, 'N107043', 'P107043', 'M', true,'AB','0950641F',1,5),
(107051, 'N107051', 'P107051', 'M', false,'None','0950641F',2,5),
(107078, 'N107078', 'P107078', 'M', false,'None','0950641F',1,1),
(107132, 'N107132', 'P107132', 'M', false,'B','0950641F',1,5),
(107144, 'N107144', 'P107144', 'M', true,'None','0950641F',1,1),
(107152, 'N107152', 'P107152', 'M', false,'None','0950641F',1,1),
(107236, 'N107236', 'P107236', 'F', false,'B','0770918E',1,5),
(107258, 'N107258', 'P107258', 'F', false,'AB', '0770918E',2,1),
(107927, 'N107927', 'P107927', 'F', true,'TB','0770918E',1,1),
(109099, 'N109099', 'P109099', 'F', false,'B','0770918E',1,1),
(109208, 'N109208', 'P109208', 'F', true,'TB','0770918E',1,1),
(109224, 'N109224', 'P109224', 'F', false,'None','0770918E',1,1),
(109262, 'N109262', 'P109262', 'F', true,'TB','0770918E',2,1),
(111398, 'N111398', 'P111398', 'F', false,'TB','0770918E',1,1),
(111818, 'N111818', 'P111818', 'F', true,'B','0630068G',1,1),
(117970, 'N117970', 'P117970', 'F', false,'None','0630068G',1,4),
(123668, 'N123668', 'P123668', 'F', true,'AB','0630068G',2,4);


/* Affichage des tables */
SELECT * from Langue;
SELECT * from Baccalaureat;
SELECT * from Localite;
SELECT * from etablissement;
SELECT * FROM Etudiant
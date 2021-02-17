/* 
   COM'IN EG 01-2012
*/ 

set feedback off

Prompt Destruction des tables et sequences en cours ...

DROP TABLE client 	cascade constraints;
DROP TABLE dept 	cascade constraints;
DROP TABLE emp 		cascade constraints;
DROP TABLE bonus 	cascade constraints;
DROP TABLE inventaire 	cascade constraints;
DROP TABLE lgncom 	cascade constraints;
DROP TABLE com 		cascade constraints;
DROP TABLE produit 	cascade constraints;
DROP TABLE region 	cascade constraints;
DROP TABLE titre 	cascade constraints;
DROP TABLE entrep 	cascade constraints;

DROP SEQUENCE noclient;
DROP SEQUENCE nodept;
DROP SEQUENCE noemp;
DROP SEQUENCE nocom;
DROP SEQUENCE noproduit;
DROP SEQUENCE noregion;
DROP SEQUENCE noentrep;

prompt Destruction des tables et sequences terminee.

prompt Creation des tables et sequences en cours ...

CREATE TABLE client 
(noclient                   NUMBER(7),
 nom                        VARCHAR2(50) CONSTRAINT client_nom_nn NOT NULL,
 telephone                  VARCHAR2(25),
 adresse                    VARCHAR2(400),
 ville                      VARCHAR2(30),
 etat                       VARCHAR2(20),
 pays                       VARCHAR2(30),
 departement                VARCHAR2(75),
 niveau_credit              VARCHAR2(1),
 novendeur                  NUMBER(7),
 noregion                   NUMBER(7),
 commentaires               VARCHAR2(255),
     CONSTRAINT client_noclient_pk PRIMARY KEY (noclient),
     CONSTRAINT client_niveau_credit_ck CHECK (niveau_credit IN ('E', 'B', 'M')));

INSERT INTO client VALUES (
   201, 'RATP', '12345678',
   '12 Rue du Train', 'Paris', NULL, 'France', '75001',
   'E', 12, 2, 'Le client commande de grandes quantites. ' ||
   'C''est bon tant que le niveau de credit reste excellent.');
INSERT INTO client VALUES (
   202, 'EDF', '23456789',
   '13 Rue du Transformateur', 'Lyon', NULL, 'France', '69003',
   'M', 14, 4, 'Le client doit payer comptant tant que son niveau ' ||
   'de credit n''augmente pas.');
INSERT INTO client VALUES (
   203, 'ADIDAS', '34567890',
   '14 Rue du Sport', 'Marseille', NULL, 'France', '13005',
   'B', 14, 4, 'Le client a une configuration tres decentralisee.');
INSERT INTO client VALUES (
   204, 'BHV', '45678901',
   '15 AVE du BAZAR', 'Paris', NULL, 'France', '75004',
   'E', 11, 1, NULL);
INSERT INTO client VALUES (
   205, 'PHILIPS', '56789012',
   '16 Rue Volta', 'Nantes', NULL, 'FRANCE', '44000',
   'E', 15, 4, NULL);
INSERT INTO client VALUES (
   206, 'TELEFUNKEN', '67890123',
   '17 Rue de Rivoli', 'Toulouse', NULL, 'France', '31000',
   'E', 15, 5, 'Le client passe de nombreuses petites commandes.');
INSERT INTO client VALUES (
   207, 'ANDRE', '78901234',
   '18 Saint Antoine', 'Bordeaux', NULL, 'France', '33000',
   'B', 11, 3, NULL);
INSERT INTO client VALUES (
   208, 'IBM', '89012345',
   '19 Boul du Sud', 'Biarritz', NULL, 'France', '64000',
   'B', 15, 5, 'Le client paie comptant, le plus souvent.');
INSERT INTO client VALUES (
   209, 'COMPAQ', '90123456',
   '20 Place Balzac', 'Toulouse', NULL, 'France', '31002', 
   'E', 11, 1, NULL);
INSERT INTO client VALUES (
   210, 'HP', '01234567',
   '21 Rue Mozart', 'Paris', NULL, 'France', '75011',
   'E', 12, 2, 'Le client est toujours en deplacement.');
INSERT INTO client VALUES (
   211, 'TRINDEL', '22345678',
   '22 Rue Chopin', 'Marseille', NULL, 'France', '13005',
   'E', 15, 5, NULL);
INSERT INTO client VALUES (
   212, 'LANCOME', '33456789',
   '23 Rue de la Rose', 'Bordeaux', NULL, 'France', '33003',
   'E', 13, 3, 'Le client a des problemes.');
INSERT INTO client VALUES (
   213, 'GUERLAIN', '44567890',
   '24 Rue de Javel', 'Paris', NULL, 'France', '75001',
   'E', 11, 1, NULL);
INSERT INTO client VALUES (
   214, 'Rank Xerox', '55678901',
   '25 Grande Rue', 'Nantes', NULL, 'France', '44002',
   'M', 11, 1, NULL);
INSERT INTO client VALUES (
   215, 'KODAK', '66789012',
   '26 Boul de la Lumiere', 'Lyon', NULL, 'France', '69003',
   'M', 15, 5, 'Le client a des difficultes de paiement');
COMMIT;

CREATE TABLE dept 
(nodept                     NUMBER(7),
 nom                        VARCHAR2(25) CONSTRAINT dept_nom_nn NOT NULL,
 noregion                   NUMBER(7),
     CONSTRAINT dept_nodept_pk PRIMARY KEY (nodept),
     CONSTRAINT dept_nom_noregion_uk UNIQUE (nom, noregion));

INSERT INTO dept VALUES (10, 'Finance', 1);
INSERT INTO dept VALUES (20, 'Atelier', 2);
INSERT INTO dept VALUES (30, 'Atelier', 3);
INSERT INTO dept VALUES (31, 'Vente', 1);
INSERT INTO dept VALUES (32, 'Vente', 2);
INSERT INTO dept VALUES (33, 'Vente', 3);
INSERT INTO dept VALUES (34, 'Vente', 4);
INSERT INTO dept VALUES (35, 'Vente', 5);
INSERT INTO dept VALUES (41, 'Distribution', 1);
INSERT INTO dept VALUES (42, 'Distribution', 2);
INSERT INTO dept VALUES (43, 'Distribution', 3);
INSERT INTO dept VALUES (44, 'Distribution', 4);
INSERT INTO dept VALUES (45, 'Distribution', 5);
INSERT INTO dept VALUES (50, 'Administration', 1);
COMMIT;

CREATE TABLE emp 
(noemp                      NUMBER(7),
 nom                        VARCHAR2(25) CONSTRAINT emp_nom_nn NOT NULL,
 prenom                     VARCHAR2(25),
 userid                     VARCHAR2(8),
 embauche                   DATE,
 commentaires               VARCHAR2(255),
 nosupr                     NUMBER(7),
 titre                      VARCHAR2(25),
 nodept                     NUMBER(7),
 salaire                    NUMBER(11, 2),
 tx_commission              NUMBER(4, 2),
     CONSTRAINT emp_noemp_pk PRIMARY KEY (noemp),
     CONSTRAINT emp_userid_uk UNIQUE (userid),
     CONSTRAINT emp_tx_commission_ck CHECK (tx_commission BETWEEN 10 AND 20));

CREATE TABLE BONUS AS
SELECT NOM, TITRE, SALAIRE, TX_COMMISSION
FROM EMP
;

INSERT INTO emp VALUES (
  1, 'Vabres', 'Pierre', 'vabpie',
   round(sysdate-600), NULL, NULL, 'President',
   50, 7600, NULL);
INSERT INTO emp VALUES (
   2, 'Natter', 'Genevieve', 'natgen',
   round(sysdate-580), NULL, 1, 'Dir, Distribution',
   41, 5300, NULL);
INSERT INTO emp VALUES (
   3, 'Nury', 'Patrick', 'nurpat',
   round(sysdate-560), NULL, 1, 'Dir, Vente',
   31, 5200, NULL);
INSERT INTO emp VALUES (
   4, 'Quenot', 'Alain', 'queala', 
   round(sysdate-540), NULL, 1, 'Dir, Finance', 
   10, 5500, NULL);
INSERT INTO emp VALUES (
   5, 'Roques', 'Anne-Marie', 'roqann',
   round(sysdate-520), NULL, 1, 'Dir, Administration',
   50, 5500, NULL);
INSERT INTO emp VALUES (
   6, 'Ubertin', 'Charles', 'ubecha',
   round(sysdate-500), NULL, 2, 'Chef Entrepot',
   41, 3800, NULL);
INSERT INTO emp VALUES (
   7, 'Mayer', 'Germaine', 'mayger',
   round(sysdate-480), NULL, 2, 'Chef Entrepot',
   42, 3650, NULL);
INSERT INTO emp VALUES (
   8, 'Boutin', 'Gerard', 'bouger',
   round(sysdate-460), NULL, 2, 'Chef Entrepot',
   43, 3500, NULL);
INSERT INTO emp VALUES (
   9, 'Cazer', 'Antoinette', 'cazant',
   round(sysdate-440), NULL, 2, 'Chef Entrepot',
   44, 3350, NULL);
INSERT INTO emp VALUES (
   10, 'Hazan', 'Philippe', 'hazphi',
   round(sysdate-420), NULL, 2, 'Chef Entrepot',
   45, 3200, NULL);
INSERT INTO emp VALUES (
   11, 'Mougeot', 'Thomas', 'moutho',
   round(sysdate-400), NULL, 3, 'Representant',
   31, 3800, 10);
INSERT INTO emp VALUES (
   12, 'Gallet', 'Michel', 'galmic',
   round(sysdate-380), NULL, 3, 'Representant',
   32, 4000, 12.5);
INSERT INTO emp VALUES (
   13, 'Schmitt', 'Pierre', 'schpie',
   round(sysdate-360), NULL, 3, 'Representant',
   33, 4100, 10);
INSERT INTO emp VALUES (
   14, 'Nguyen', 'Mai', 'ngumai',
   round(sysdate-340), NULL, 3, 'Representant',
   34, 3890, 15);
INSERT INTO emp VALUES (
   15, 'Dumas', 'Andre', 'dumand',
   round(sysdate-320), NULL, 3, 'Representant',
   35, 3500, 17.5);
INSERT INTO emp VALUES (
   16, 'Martinet', 'Robert', 'marrob',
   round(sysdate-320), NULL, 6, 'Secretaire',
   41, 2300, NULL);
INSERT INTO emp VALUES (
   17, 'Simon', 'Marc', 'simmar',
   round(sysdate-310), NULL, 6, 'Secretaire',
   41, 2100, NULL);
INSERT INTO emp VALUES (
   18, 'Nicolas', 'Brigitte', 'nicbri',
   round(sysdate-300), NULL, 7, 'Secretaire',
   42, 2000, NULL);
INSERT INTO emp VALUES (
   19, 'Paumier', 'Caroline', 'paucar',
   round(sysdate-280), NULL, 7, 'Secretaire',
   42, 2000, NULL);
INSERT INTO emp VALUES (
   20, 'Neulat', 'Jean-Pierre', 'neujea',
   round(sysdate-280), NULL, 8, 'Secretaire',
   43, 2000, NULL);
INSERT INTO emp VALUES (
   21, 'Meret', 'Francoise', 'merfra',
   round(sysdate-270), NULL, 8, 'Secretaire',
   43, 1800, NULL);
INSERT INTO emp VALUES (
   22, 'Chamart', 'Laure', 'chalau',
   round(sysdate-270), NULL, 9, 'Secretaire',
   44, 3400, NULL);
INSERT INTO emp VALUES (
   23, 'Perrin', 'Sylvie', 'persyl',
   round(sysdate-260), NULL, 9, 'Secretaire',
   34, 1750, NULL);
INSERT INTO emp VALUES (
   24, 'Delages', 'Gilles', 'delgil',
   round(sysdate-250), NULL, 10, 'Secretaire',
   45, 1680, NULL);
INSERT INTO emp VALUES (
   25, 'Seron', 'Patricia', 'serpat',
   round(sysdate-240), NULL, 10, 'Secretaire',
   45, 1680, NULL);
COMMIT;


CREATE TABLE inventaire 
(noproduit                  NUMBER(7),
 noentrep                   NUMBER(7),
 quant_en_stock             NUMBER(9),
 niveau_reappro             NUMBER(9),
 max_en_stock               NUMBER(9),
 rem_rupture_stock          VARCHAR2(255),
 date_reappro               DATE,
     CONSTRAINT inventaire_noprod_noentr_pk
	PRIMARY KEY (noproduit, noentrep));

INSERT INTO inventaire VALUES (
   10011, 101, 650, 625, 1100, NULL, NULL);
INSERT INTO inventaire VALUES (
   10012, 101, 600, 560, 1000, NULL, NULL);
INSERT INTO inventaire VALUES (
   10013, 101, 400, 400, 700, NULL, NULL);
INSERT INTO inventaire VALUES (
   10021, 101, 500, 425, 740, NULL, NULL);
INSERT INTO inventaire VALUES (
   10022, 101, 300, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   10023, 101, 400, 300, 525, NULL, NULL);
INSERT INTO inventaire VALUES (
   20106, 101, 993, 625, 1000, NULL, NULL);
INSERT INTO inventaire VALUES (
   20108, 101, 700, 700, 1225, NULL, NULL);
INSERT INTO inventaire VALUES (
   20201, 101, 802, 800, 1400, NULL, NULL);
INSERT INTO inventaire VALUES (
   20510, 101, 1389, 850, 1400, NULL, NULL);
INSERT INTO inventaire VALUES (
   20512, 101, 850, 850, 1450, NULL, NULL);
INSERT INTO inventaire VALUES (
   30321, 101, 2000, 1500, 2500, NULL, NULL);
INSERT INTO inventaire VALUES (
   30326, 101, 2100, 2000, 3500, NULL, NULL);
INSERT INTO inventaire VALUES (
   30421, 101, 1822, 1800, 3150, NULL, NULL);
INSERT INTO inventaire VALUES (
   30426, 101, 2250, 2000, 3500, NULL, NULL);
INSERT INTO inventaire VALUES (
   30433, 101, 650, 600, 1050, NULL, NULL);
INSERT INTO inventaire VALUES (
   32779, 101, 2120, 1250, 2200, NULL, NULL);
INSERT INTO inventaire VALUES (
   32861, 101, 505, 500, 875, NULL, NULL);
INSERT INTO inventaire VALUES (
   40421, 101, 578, 350, 600, NULL, NULL);
INSERT INTO inventaire VALUES (
   40422, 101, 0, 350, 600, NULL, NULL);
INSERT INTO inventaire VALUES (
   41010, 101, 250, 250, 437, NULL, NULL);
INSERT INTO inventaire VALUES (
   41020, 101, 471, 450, 750, NULL, NULL);
INSERT INTO inventaire VALUES (
   41050, 101, 501, 450, 750, NULL, NULL);
INSERT INTO inventaire VALUES (
   41080, 101, 400, 400, 700, NULL, NULL);
INSERT INTO inventaire VALUES (
   41100, 101, 350, 350, 600, NULL, NULL);
INSERT INTO inventaire VALUES (
   50169, 101, 2530, 1500, 2600, NULL, NULL);
INSERT INTO inventaire VALUES (
   50273, 101, 233, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   50417, 101, 518, 500, 875, NULL, NULL);
INSERT INTO inventaire VALUES (
   50418, 101, 244, 100, 275, NULL, NULL);
INSERT INTO inventaire VALUES (
   50419, 101, 230, 120, 310, NULL, NULL);
INSERT INTO inventaire VALUES (
   50530, 101, 669, 400, 700, NULL, NULL);
INSERT INTO inventaire VALUES (
   50532, 101, 0, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   50536, 101, 173, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   20106, 201, 220, 150, 260, NULL, NULL);
INSERT INTO inventaire VALUES (
   20108, 201, 166, 150, 260, NULL, NULL);
INSERT INTO inventaire VALUES (
   20201, 201, 320, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   20510, 201, 175, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   20512, 201, 162, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   30321, 201, 96, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30326, 201, 147, 120, 210, NULL, NULL);
INSERT INTO inventaire VALUES (
   30421, 201, 102, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30426, 201, 200, 120, 210, NULL, NULL);
INSERT INTO inventaire VALUES (
   30433, 201, 130, 130, 230, NULL, NULL);
INSERT INTO inventaire VALUES (
   32779, 201, 180, 150, 260, NULL, NULL);
INSERT INTO inventaire VALUES (
   32861, 201, 132, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   50169, 201, 225, 220, 385, NULL, NULL);
INSERT INTO inventaire VALUES (
   50273, 201, 75, 60, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   50417, 201, 82, 60, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   50418, 201, 98, 60, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   50419, 201, 77, 60, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   50530, 201, 62, 60, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   50532, 201, 67, 60, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   50536, 201, 97, 60, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   20510, 301, 69, 40, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   20512, 301, 28, 20, 50, NULL, NULL);
INSERT INTO inventaire VALUES (
   30321, 301, 85, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30421, 301, 102, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30433, 301, 35, 20, 35, NULL, NULL);
INSERT INTO inventaire VALUES (
   32779, 301, 102, 95, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   32861, 301, 57, 50, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   40421, 301, 70, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   40422, 301, 65, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   41010, 301, 59, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   41020, 301, 61, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   41050, 301, 49, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   41080, 301, 50, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   41100, 301, 42, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   20510, 401, 88, 50, 100, NULL, NULL);
INSERT INTO inventaire VALUES (
   20512, 401, 75, 75, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30321, 401, 102, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30326, 401, 113, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30421, 401, 85, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30426, 401, 135, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   30433, 401, 0, 100, 175, 'Une livraison defectueuse a ete retournee',
			    round(sysdate-20));
INSERT INTO inventaire VALUES (
   32779, 401, 135, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   32861, 401, 250, 150, 250, NULL, NULL);
INSERT INTO inventaire VALUES (
   40421, 401, 47, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   40422, 401, 50, 40, 70, NULL, NULL);
INSERT INTO inventaire VALUES (
   41010, 401, 80, 70, 220, NULL, NULL);
INSERT INTO inventaire VALUES (
   41020, 401, 91, 70, 220, NULL, NULL);
INSERT INTO inventaire VALUES (
   41050, 401, 169, 70, 220, NULL, NULL);
INSERT INTO inventaire VALUES (
   41080, 401, 100, 70, 220, NULL, NULL);
INSERT INTO inventaire VALUES (
   41100, 401, 75, 70, 220, NULL, NULL);
INSERT INTO inventaire VALUES (
   50169, 401, 240, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   50273, 401, 224, 150, 280, NULL, NULL);
INSERT INTO inventaire VALUES (
   50417, 401, 130, 120, 210, NULL, NULL);
INSERT INTO inventaire VALUES (
   50418, 401, 156, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   50419, 401, 151, 150, 280, NULL, NULL);
INSERT INTO inventaire VALUES (
   50530, 401, 119, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   50532, 401, 233, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   50536, 401, 138, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   10012, 10501, 300, 300, 525, NULL, NULL);
INSERT INTO inventaire VALUES (
   10013, 10501, 314, 300, 525, NULL, NULL);
INSERT INTO inventaire VALUES (
   10022, 10501, 502, 300, 525, NULL, NULL);
INSERT INTO inventaire VALUES (
   10023, 10501, 500, 300, 525, NULL, NULL);
INSERT INTO inventaire VALUES (
   20106, 10501, 150, 100, 175, NULL, NULL);
INSERT INTO inventaire VALUES (
   20108, 10501, 222, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   20201, 10501, 275, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   20510, 10501, 57, 50, 87, NULL, NULL);
INSERT INTO inventaire VALUES (
   20512, 10501, 62, 50, 87, NULL, NULL);
INSERT INTO inventaire VALUES (
   30321, 10501, 194, 150, 275, NULL, NULL);
INSERT INTO inventaire VALUES (
   30326, 10501, 277, 250, 440, NULL, NULL);
INSERT INTO inventaire VALUES (
   30421, 10501, 190, 150, 275, NULL, NULL);
INSERT INTO inventaire VALUES (
   30426, 10501, 423, 250, 450, NULL, NULL);
INSERT INTO inventaire VALUES (
   30433, 10501, 273, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   32779, 10501, 280, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   32861, 10501, 288, 200, 350, NULL, NULL);
INSERT INTO inventaire VALUES (
   40421, 10501, 97, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   40422, 10501, 90, 80, 140, NULL, NULL);
INSERT INTO inventaire VALUES (
   41010, 10501, 151, 140, 245, NULL, NULL);
INSERT INTO inventaire VALUES (
   41020, 10501, 224, 140, 245, NULL, NULL);
INSERT INTO inventaire VALUES (
   41050, 10501, 157, 140, 245, NULL, NULL);
INSERT INTO inventaire VALUES (
   41080, 10501, 159, 140, 245, NULL, NULL);
INSERT INTO inventaire VALUES (
   41100, 10501, 141, 140, 245, NULL, NULL);
COMMIT;

CREATE TABLE lgncom 
(nocom                      NUMBER(7),
 nolgncom                   NUMBER(7),
 noproduit                  NUMBER(7) 
   CONSTRAINT lgncom_noproduit_nn NOT NULL,
 prix                       NUMBER(11, 2),
 quantite                   NUMBER(9),
 quantite_livree            NUMBER(9),
     CONSTRAINT lgncom_nocom_nolgncom_pk PRIMARY KEY (nocom, nolgncom),
     CONSTRAINT lgncom_nocom_noprod_uk UNIQUE (nocom, noproduit));

INSERT INTO lgncom VALUES (
   97, 1, 20106, 1380, 10, 10);
INSERT INTO lgncom VALUES (
   97, 2, 30321, 2600, 20, 20);

INSERT INTO lgncom VALUES (
   98, 1, 40421, 30, 10, 10);

INSERT INTO lgncom VALUES (
   99, 1, 20510, 2150, 5, 5);
INSERT INTO lgncom VALUES (
   99, 2, 20512, 900, 7, 7);
INSERT INTO lgncom VALUES (
   99, 3, 50417, 1000, 5, 5);
INSERT INTO lgncom VALUES (
   99, 4, 50530, 460, 10, 10);

INSERT INTO lgncom VALUES (
   100, 1, 10011, 460, 5, 5);
INSERT INTO lgncom VALUES (
   100, 2, 10013, 460, 4, 4);
INSERT INTO lgncom VALUES (
   100, 3, 10021, 150, 5, 5);
INSERT INTO lgncom VALUES (
   100, 4, 10023, 900, 4, 4);
INSERT INTO lgncom VALUES (
   100, 5, 30326, 1300, 6, 6);
INSERT INTO lgncom VALUES (
   100, 6, 30433, 560, 10, 10);
INSERT INTO lgncom VALUES (
   100, 7, 41010, 60, 5, 5);

INSERT INTO lgncom VALUES (
   101, 1, 30421, 2400, 3, 3);
INSERT INTO lgncom VALUES (
   101, 2, 40422, 40, 30, 30);
INSERT INTO lgncom VALUES (
   101, 3, 41010, 60, 20, 20);
INSERT INTO lgncom VALUES (
   101, 4, 41100, 3050, 3, 3);
INSERT INTO lgncom VALUES (
   101, 5, 50169, 490, 10, 10);
INSERT INTO lgncom VALUES (
   101, 6, 50417, 1000, 3, 3);
INSERT INTO lgncom VALUES (
   101, 7, 50530, 450, 20, 20);

INSERT INTO lgncom VALUES (
   102, 1, 20108, 2000, 10, 10);
INSERT INTO lgncom VALUES (
   102, 2, 20201, 2100, 12, 12);

INSERT INTO lgncom VALUES (
   103, 1, 30433, 560, 9, 9);
INSERT INTO lgncom VALUES (
   103, 2, 32779, 305, 10, 10);

INSERT INTO lgncom VALUES (
   104, 1, 20510, 2100, 1, 1);
INSERT INTO lgncom VALUES (
   104, 2, 20512, 900, 8, 8);
INSERT INTO lgncom VALUES (
   104, 3, 30321, 2600, 8, 8);
INSERT INTO lgncom VALUES (
   104, 4, 30421, 2400, 5, 5);

INSERT INTO lgncom VALUES (
   105, 1, 50273, 900, 10, 10);
INSERT INTO lgncom VALUES (
   105, 2, 50419, 3350, 7, 7);
INSERT INTO lgncom VALUES (
   105, 3, 50532, 450, 15, 15);

INSERT INTO lgncom VALUES (
   106, 1, 20108, 2000, 13, 13);
INSERT INTO lgncom VALUES (
   106, 2, 20201, 2100, 11, 11);
INSERT INTO lgncom VALUES (
   106, 3, 50169, 490, 20, 20);
INSERT INTO lgncom VALUES (
   106, 4, 50273, 900, 6, 6);
INSERT INTO lgncom VALUES (
   106, 5, 50418, 300, 50, 50);
INSERT INTO lgncom VALUES (
   106, 6, 50419, 3350, 10, 10);

INSERT INTO lgncom VALUES (
   107, 1, 20106, 1400, 5, 5);
INSERT INTO lgncom VALUES (
   107, 2, 20108, 1400, 2, 2);
INSERT INTO lgncom VALUES (
   107, 3, 20201, 2100, 12, 12);
INSERT INTO lgncom VALUES (
   107, 4, 30321, 2600, 7, 7);
INSERT INTO lgncom VALUES (
   107, 5, 30421, 2400, 5, 5);

INSERT INTO lgncom VALUES (
   108, 1, 20510, 2100, 5, 5);
INSERT INTO lgncom VALUES (
   108, 2, 20512, 920, 9, 9);
INSERT INTO lgncom VALUES (
   108, 3, 30321, 2600, 8, 8);
INSERT INTO lgncom VALUES (
   108, 4, 32779, 305, 8, 8);
INSERT INTO lgncom VALUES (
   108, 5, 32861, 600, 10, 10);
INSERT INTO lgncom VALUES (
   108, 6, 41080, 460, 6, 6);
INSERT INTO lgncom VALUES (
   108, 7, 41100, 3050, 10, 10);

INSERT INTO lgncom VALUES (
   109, 1, 10011, 460, 15, 15);
INSERT INTO lgncom VALUES (
   109, 2, 10012, 1525, 6, 6);
INSERT INTO lgncom VALUES (
   109, 3, 10022, 335, 20, 20);
INSERT INTO lgncom VALUES (
   109, 4, 30326, 1300, 8, 8);
INSERT INTO lgncom VALUES (
   109, 5, 30426, 3350, 5, 5);
INSERT INTO lgncom VALUES (
   109, 6, 32861, 610, 12, 12);
INSERT INTO lgncom VALUES (
   109, 7, 50418, 305, 4, 4);

INSERT INTO lgncom VALUES (
   110, 1, 50273, 900, 3, 3);
INSERT INTO lgncom VALUES (
   110, 2, 50536, 80, 20, 20);

INSERT INTO lgncom VALUES (
   111, 1, 40421, 30, 30, 30);
INSERT INTO lgncom VALUES (
   111, 2, 41080, 460, 25, 25);

INSERT INTO lgncom VALUES (
   112, 1, 20106, 1380, 5, 5);
COMMIT;


CREATE TABLE com 
(nocom                      NUMBER(7),
 noclient                   NUMBER(7) 
   CONSTRAINT com_noclient_nn NOT NULL,
 date_com                   DATE,
 date_liv                   DATE,
 novendeur                  NUMBER(7),
 total                      NUMBER(11, 2),
 type_paiement              VARCHAR2(6),
 com_remplie                VARCHAR2(1),
     CONSTRAINT com_nocom_pk PRIMARY KEY (nocom),
     CONSTRAINT com_type_paiement_ck CHECK (type_paiement in ('CASH', 'CREDIT')),
     CONSTRAINT com_com_remplie_ck CHECK (com_remplie in ('O', 'N')));

INSERT INTO com VALUES (
    97, 201, round(sysdate-276), round(sysdate-266), 12,  65800, 'CREDIT', 'O');
INSERT INTO com VALUES (
    98, 202, round(sysdate-274), round(sysdate-264), 14,    300,   'CASH', 'O');
INSERT INTO com VALUES (
    99, 203, round(sysdate-272), round(sysdate-262), 14,  26650, 'CREDIT', 'O');
INSERT INTO com VALUES (
   100, 204, round(sysdate-300), round(sysdate-290), 11,  22190, 'CREDIT', 'O');
INSERT INTO com VALUES (
   101, 205, round(sysdate-298), round(sysdate-288), 15,  36550, 'CREDIT', 'O');
INSERT INTO com VALUES (
   102, 206, round(sysdate-296), round(sysdate-286), 15,  45200, 'CREDIT', 'O');
INSERT INTO com VALUES (
   103, 208, round(sysdate-294), round(sysdate-284), 15,  35540,   'CASH', 'O');
INSERT INTO com VALUES (
   104, 208, round(sysdate-292), round(sysdate-282), 15,  42100, 'CREDIT', 'O');
INSERT INTO com VALUES (
   105, 209, round(sysdate-290), round(sysdate-280), 11,  39200, 'CREDIT', 'O');
INSERT INTO com VALUES (
   106, 210, round(sysdate-288), round(sysdate-278), 12, 112800, 'CREDIT', 'O');
INSERT INTO com VALUES (
   107, 211, round(sysdate-286), round(sysdate-276), 15,  65200, 'CREDIT', 'O');
INSERT INTO com VALUES (
   108, 212, round(sysdate-284), round(sysdate-274), 13,  81280, 'CREDIT', 'O');
INSERT INTO com VALUES (
   109, 213, round(sysdate-282), round(sysdate-272), 11,  58440, 'CREDIT', 'O');
INSERT INTO com VALUES (
   110, 214, round(sysdate-280), round(sysdate-270), 11,   4300,   'CASH', 'O');
INSERT INTO com VALUES (
   111, 204, round(sysdate-278), round(sysdate-268), 11,  12400,   'CASH', 'O');
INSERT INTO com VALUES (
   112, 210, round(sysdate-270), round(sysdate-260), 12,   6900, 'CREDIT', 'O');
COMMIT;

CREATE TABLE produit 
(noproduit                  NUMBER(7),
 nom                        VARCHAR2(50) CONSTRAINT produit_nom_nn NOT NULL,
 desc_courte                VARCHAR2(255),
 notextlong                 NUMBER(7),
 noimage                    NUMBER(7),
 prix_catalogue             NUMBER(11, 2),
     CONSTRAINT produit_noproduit_pk PRIMARY KEY (noproduit),
     CONSTRAINT produit_nom_uk UNIQUE (nom));

INSERT INTO produit VALUES (
   10011, 'PC de Poche',         null, 518, 1001,   500);
INSERT INTO produit VALUES (
   10012, 'Apple Mac',           null, 519, 1002,  1600);
INSERT INTO produit VALUES (
   10013, 'Moniteur Apple',      null, 520, 1003,   500);
INSERT INTO produit VALUES (
   10021, 'Power Print',         null, 528, 1011,   200);
INSERT INTO produit VALUES (
   10022, 'Scanner Powerlook',   null, 529, 1012,   400);
INSERT INTO produit VALUES (
   10023, 'PC Optimiste',        null, 530, 1013,  1000);
INSERT INTO produit VALUES (
   20106, 'PC Arbitre',          null, 613, NULL,  1400);
INSERT INTO produit VALUES (
   20108, 'PC Heros',            null, 615, NULL,  2000);
INSERT INTO produit VALUES (
   20201, 'PC HP',               null, 708, NULL,  2200);
INSERT INTO produit VALUES (
   20510, 'Presario CDS',        null, 1017, NULL, 2200);
INSERT INTO produit VALUES (
   20512, 'Moniteur Pronitron',  null, 1019, NULL, 1000);
INSERT INTO produit VALUES (
   30321, 'Moniteur Philips',    null, 828, 1291,  2700);
INSERT INTO produit VALUES (
   30326, 'Notebook IBM',        null, 833, 1296,  1400);
INSERT INTO produit VALUES (
   30421, 'Notebook Texas',      null, 927, NULL,  2500);
INSERT INTO produit VALUES (
   30426, 'Notebook Toshiba',    null, 933, NULL,  3400);
INSERT INTO produit VALUES (
   30433, 'Imprimante Epson',    null, 940, NULL,   600);
INSERT INTO produit VALUES (
   32779, 'Imprimante HP',       null, 1286, NULL,  400);
INSERT INTO produit VALUES (
   32861, 'Imprimante Canon',    null, 1368, 1829,  700);
INSERT INTO produit VALUES (
   40421, 'Toolkit for Linux',   null, 928, 1381,    35);
INSERT INTO produit VALUES (
   40422, 'Linux',               null, 929, 1382,    45);
INSERT INTO produit VALUES (
   41010, 'Space Simulator',     null, 517, NULL,    70);
INSERT INTO produit VALUES (
   41020, 'Carte son Premium',   null, 527, NULL,   220);
INSERT INTO produit VALUES (
   41050, 'Sound Blaster 16',    null, 557, NULL,   300);
INSERT INTO produit VALUES (
   41080, 'Lecteur CD-ROM X4',   null, 587, NULL,   500);
INSERT INTO produit VALUES (
   41100, 'Graveur Kodak',       null, 607, NULL,  3100);
INSERT INTO produit VALUES (
   50169, 'Disque dur 1 Go',     null, 676, 1119,   500);
INSERT INTO produit VALUES (
   50273, 'Disque dur 2 Go',     null, 780, 1223,  1000);
INSERT INTO produit VALUES (
   50417, 'Carte Intel Zappa',   null, 924, 1367,  1100);
INSERT INTO produit VALUES (
   50418, 'Fax-Modem 28800',     null, 925, 1368,   350);
INSERT INTO produit VALUES (
   50419, 'Scanner couleur Agfa',null, 926, 1369,  3400);
INSERT INTO produit VALUES (
   50530, 'Scanner Mono HP',     null, 1037, 1480,  500);
INSERT INTO produit VALUES (
   50532, 'Word 6.0 Win',        null, 1039, 1482,  500);
INSERT INTO produit VALUES (
   50536, 'Windows CD Training', null, 1043, 1486,   90);
COMMIT;

CREATE TABLE region 
(noregion                   NUMBER(7),
 nom                        VARCHAR2(50) CONSTRAINT region_nom_nn NOT NULL,
     CONSTRAINT region_noregion_pk PRIMARY KEY (noregion),
     CONSTRAINT region_nom_uk UNIQUE (nom));

INSERT INTO region VALUES (1, 'Region 1');
INSERT INTO region VALUES (2, 'Region 2');
INSERT INTO region VALUES (3, 'Region 3');
INSERT INTO region VALUES (4, 'Region 4');
INSERT INTO region VALUES (5, 'Region 5');
COMMIT;

CREATE TABLE titre
(titre                      VARCHAR2(25),
	CONSTRAINT titre_titre_pk PRIMARY KEY (titre));

INSERT INTO titre VALUES ('President');
INSERT INTO titre VALUES ('Representant');
INSERT INTO titre VALUES ('Secretaire');
INSERT INTO titre VALUES ('Dir, Administration');
INSERT INTO titre VALUES ('Dir, Finance');
INSERT INTO titre VALUES ('Dir, Distribution');
INSERT INTO titre VALUES ('Dir, Vente');
INSERT INTO titre VALUES ('Chef Entrepot');
COMMIT;

CREATE TABLE entrep 
(noentrep                   NUMBER(7),
 noregion                   NUMBER(7) CONSTRAINT entrep_noregion_nn NOT NULL,
 adresse                    LONG,
 ville                      VARCHAR2(30),
 etat                       VARCHAR2(20),
 pays                       VARCHAR2(30),
 departement                VARCHAR2(75),
 telephone                  VARCHAR2(25),
 nochef                     NUMBER(7),
     CONSTRAINT entrep_noentrep_pk PRIMARY KEY (noentrep));

INSERT INTO entrep VALUES (101, 1, '10 Rue Principale', 
   'Toulouse', null, 'France', '31000', NULL,  6);
INSERT INTO entrep VALUES (10501, 5, '11 Rue Petite',
   'Bordeaux', NULL, 'France', '33000', NULL, 10);
INSERT INTO entrep VALUES (201, 2, '12 Rue Chopin',
   'Lyon',     NULL, 'France', '69000', NULL,  7);
INSERT INTO entrep VALUES (301, 3, '13 Rue Strauss',
   'Paris',    NULL, 'France', '75002', NULL,  8);
INSERT INTO entrep VALUES (401, 4, '14 Rue Haendel',
   'Nantes',   NULL, 'France', '44000', NULL,  9);
COMMIT;

ALTER TABLE dept 
   ADD CONSTRAINT dept_noregion_fk
   FOREIGN KEY (noregion)      REFERENCES region     (noregion)   ;
ALTER TABLE emp 
   ADD CONSTRAINT emp_nosupr_fk
   FOREIGN KEY (nosupr)        REFERENCES emp        (noemp)      ;
ALTER TABLE emp 
   ADD CONSTRAINT emp_nodept_fk
   FOREIGN KEY (nodept)        REFERENCES dept       (nodept)     ;
ALTER TABLE emp 
   ADD CONSTRAINT emp_titre_fk
   FOREIGN KEY (titre)         REFERENCES titre      (titre)      ;
ALTER TABLE client 
   ADD CONSTRAINT client_novendeur_fk
   FOREIGN KEY (novendeur)     REFERENCES emp        (noemp)      ;
ALTER TABLE client 
   ADD CONSTRAINT client_noregion_fk
   FOREIGN KEY (noregion)      REFERENCES region     (noregion)   ;
ALTER TABLE com 
   ADD CONSTRAINT com_noclient_fk
   FOREIGN KEY (noclient)      REFERENCES client     (noclient)   ;
ALTER TABLE com 
   ADD CONSTRAINT com_novendeur_fk
   FOREIGN KEY (novendeur)     REFERENCES emp        (noemp)      ;
ALTER TABLE lgncom 
   ADD CONSTRAINT lgncom_nocom_fk
   FOREIGN KEY (nocom)         REFERENCES com        (nocom)      ;
ALTER TABLE lgncom 
   ADD CONSTRAINT lgncom_noproduit_fk
   FOREIGN KEY (noproduit)     REFERENCES produit    (noproduit)  ;
ALTER TABLE entrep
   ADD CONSTRAINT entrep_noregion_fk
   FOREIGN KEY (noregion)      REFERENCES region     (noregion)   ;
ALTER TABLE inventaire 
   ADD CONSTRAINT inventaire_noproduit_fk
   FOREIGN KEY (noproduit)     REFERENCES produit    (noproduit)  ;
ALTER TABLE inventaire 
   ADD CONSTRAINT inventaire_noentrep_fk
   FOREIGN KEY (noentrep)      REFERENCES entrep     (noentrep)   ;

CREATE SEQUENCE noclient   INCREMENT BY 1 START WITH 216   ;
CREATE SEQUENCE nodept     INCREMENT BY 1 START WITH 51    ;
CREATE SEQUENCE noemp      INCREMENT BY 1 START WITH 26    ;
CREATE SEQUENCE nocom      INCREMENT BY 1 START WITH 113   ;
CREATE SEQUENCE noproduit  INCREMENT BY 1 START WITH 50537 ;
CREATE SEQUENCE noregion   INCREMENT BY 1 START WITH 6     ;
CREATE SEQUENCE noentrep   INCREMENT BY 1 START WITH 10502 ;


prompt Creation des tables et sequences terminee.

set feedback on

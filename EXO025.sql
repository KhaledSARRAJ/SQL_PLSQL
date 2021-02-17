 /* Créer une vue (nom : DEPT4)
 relative au no, nom et titre des employés
 des départements supérieurs à 40 et utiliser 
 la vue pour interroger. 
 Mettre à jour EMP et utiliser la vue pour interroger. 
 ;*/
 CREATE VIEW DEPT4 
 AS select noemp, nom, titre      
 from emp     where NODEPT > 40  ;

SELECT * from dept4;
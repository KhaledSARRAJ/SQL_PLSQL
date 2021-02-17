 /* Augmenter de 5% les
 employés de la table 
 EMP qui se trouvent
 dans la table BONUS.*/
 
 update emp set SALAIRE = SALAIRE * 1.05 
 where nom in (select nom from bonus) ;
 
commit;
 /* Essayer de supprimer l'employé Dumas de la table EMP. 
 Expliquer la situation. Supprimer un autre employé. 
 Vérifier par Select, faire ROLLBACK, vérifier par Select.
 
 DELETE FROM EMP
 WHERE       NOM = 'Dumas' ; 
 select nom  from emp;
 
  DELETE FROM EMP
 WHERE       NOM = 'Simon' ; 
  select nom  
  from emp
  where nom = 'Simon';
  ROLLBACK;
  select nom  
  from emp
  where nom = 'Simon';*/
   DELETE FROM EMP
 WHERE       NOM = 'Dumas' ;
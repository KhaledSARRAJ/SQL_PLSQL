 select nom, titre, nodept, salaire 
 from emp where (titre = 'Secretaire' or titre = 'Representant') 
 and nodept = 34
 ;
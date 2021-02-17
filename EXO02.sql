select nom, titre, nodept, salaire 
from emp 
where (titre ='Representant') or (titre  = 'Secretaire' and nodept = 34)
;
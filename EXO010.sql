
select e.nom, d.nom  
from emp e join dept d    
on e.nodept = d.nodept and e.nom = 'Dumas';
select titre ,  avg(salaire)
from emp
group by titre 
having avg(salaire) > (select avg (salaire) from emp where titre 
= 'Representant')
;
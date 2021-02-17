select titre, count (NOEMP) "Nombre"
from emp 
group by titre having count(titre) > 2;
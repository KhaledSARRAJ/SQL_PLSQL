select nodept, titre, count (NOEMP) "Nombre"
 from emp  
 group by nodept, titre ;
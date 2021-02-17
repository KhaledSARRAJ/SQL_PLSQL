/*Rechercher le prénom des employés 
et le nom de la région de leur département*/
select e.prenom,r.nom
from emp e, dept d, region r

on e.nodept = d.nodept and d.noregion=r.noregion;
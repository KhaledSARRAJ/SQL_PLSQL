select nom, titre
from emp 
where nodept =31
and  titre <> all (select titre from emp where nodept = 32);
 

select nom, salaire,nodept
 from emp  
 where salaire > any (select salaire 
                      from emp                     
                      where nodept = 31)  
 order by nodept, salaire
 ;

 select nom, titre  
 from emp
 where titre = (select titre  
                from emp                    
                where nom = 'Dumas') 
; 

							 
select case 
        when  NODEPT= 41 then prenom                       
           else nom		
               end "nom ou prenoms", nodept, salaire 			
			   from emp
			   order by (salaire)	
			   ; 
   
   
   
   
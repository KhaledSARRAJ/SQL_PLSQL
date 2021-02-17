
 SELECT cl.nom, cm.nocom, lg.noproduit
 FROM client cl, com cm, lgncom lg
 WHERE cl.noclient = cm.noclient
 and cm.nocom =lg.nocom
 and cl.nom= 'IBM' ;
 
 
/*

 SELECT CL.NOM, CM.NOCOM, LG.NOPRODUIT  
 FROM CLIENT CL, COM CM, LGNCOM LG  
 WHERE CL.NOCLIENT = CM.NOCLIENT    
 AND CM.NOCOM = LG.NOCOM   
 AND CL.NOM = 'IBM' ; 
 */
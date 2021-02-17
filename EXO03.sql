select nom, salaire *(1+ nvl(tx_commission, 0)/100) "Remuneration totale"
 from emp
; 
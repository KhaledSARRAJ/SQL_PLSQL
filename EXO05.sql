select nom, EMBAUCHE
from emp
where MONTHS_BETWEEN(sysDate, EMBAUCHE ) > 12
;
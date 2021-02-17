 /*Rechercher le no, 
 le nom et le prix des produits qui
 n'ont pas encore fait l'objet d'une commande. 
 Proposer trois types d'écriture. */


  select PRODUIT.NOPRODUIT, NOM, PRIX_CATALOGUE 
 From lgncom  right outer join PRODUIT  
 on lgncom.noproduit=produit.noproduit
 where lgncom.noproduit is null;
 
 
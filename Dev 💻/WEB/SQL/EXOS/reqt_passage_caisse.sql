Nom et quantité en stock des produits.

SELECT produit.nom, unitenstock.qte
FROM produit;

Liste des passages en caisse avant le 18 avril
2009

SELECT *
FROM passagecaisse
WHERE datePassage < '2009-04-18';

Noms des produits dont les stocks sont
compris entre 50 et 100, triés par ordre
inverse de prix.

SELECT nom
FROM produit
WHERE unitEnStock BETWEEN 50 AND 100
ORDER BY pxUnit DESC;

Nom employés nés en 90 et 91. Trier par ordre inversement alphabétique sur le nom et sur ordre croissant de naissance

SELECT nom
FROM personnel
WHERE ddn BETWEEN '1990-01-01' AND '1991-31-12'
ORDER BY nom DESC, ddn ASC

Donner les noms des produits des rayons 3, 5
et 6, qui valent plus de la moitié de leur
quantité en stock.

SELECT nom
FROM produit
WHERE (idRayon = 3 OR idRayon = 5 OR idRayon = 6) AND pxUnit > (unitEnStock/2);

+>

SELECT nom
FROM produit
WHERE idRayon IN ('3','5','6') AND pxUnit > (unitEnStock/2);

Select nom
FROM Produit
WHERE PxUnit = (SELECT MIN(PxUnit FROM produit WHERE Rayon.nom = “Boucherie” AND Rayon.idRayon = Produit.idRayon);


SELECT sum(pxUnit*qte) 
FROM contenir , Produit
WHERE idpassagecaisse = 327 AND contenir.idProduit = produit.idProduit;
 

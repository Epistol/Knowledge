#Libellés des Régions triés par ordre alphabétique

SELECT libRegion
FROM Region
ORDER BY libregion ASC;

#Codes et Libellés des départements de la région dont le code est 83 

SELECT codeDepartement, libDepartement
FROM Departement
WHERE codeRegion = 83;

#Libellés  des  communes  dont  le  nom  commence  par  « Aigues »  triés  par  code  du département puis par libellés de la commune. 

select libCommune
FROM Commune
WHERE libCommune LIKE 'Aigues%'
ORDER BY codeDepartement ASC, libCommune ASC;

#Libellés des départements de la région Limousin

select libDepartement
from Departement, Region
where Region.libRegion = 'Limousin' AND Region.codeRegion=Departement.codeRegion;

#Libellé du chef-lieu du département de l’  « Allier » 

select libCommune
from Commune,Departement
where libDepartement = 'Allier' AND Departement.chefLieu = Commune.codeCommune;

#Libellés des types d'équipements 
#que l'on peut trouver sur la commune de "Aigueperse" dans le département du 63

select TypeEquipement.libType
from TypeEquipement, Equiper, Commune
where TypeEquipement.codeType = Equiper.codeType 
    AND Equiper.codeCommune = Commune.codeCommune 
    AND Commune.libCommune = 'Aigueperse'
    AND Commune.codeDepartement = '63';

#Libellés « Aigueperse » dans le département 63. 7. Libellés des communes qui sont équipées de plus de 50 terrains de boules. 

select Commune.libCommune
from Commune, Equiper, TypeEquipement
where Commune.codeCommune = Equiper.codeCommune
	AND Equiper.codeType = TypeEquipement.codeType
    AND TypeEquipement.libType = 'Terrain de boules'
    AND Equiper.qte>50;
    
#De combien d’« Anneau / piste de cyclisme » est équipée la commune qui a 160 « Boucle de randonnée »

select Commune.libCommune, TypeEquipement.libType, Equiper.qte
from Commune, Equiper, TypeEquipement
where TypeEquipement.libType = 'Anneau / piste de cyclisme'
    AND TypeEquipement.codeType = Equiper.codeType
    AND Equiper.codeCommune = Commune.codeCommune
    AND Commune.codeCommune = 
		(
			select Commune.codeCommune
            FROM Commune, Equiper, TypeEquipement
            WHERE Equiper.qte = 160
				AND Commune.codeCommune = Equiper.codeCommune
                AND Equiper.codeType = TypeEquipement.codeType
                AND TypeEquipement.libType = 'Boucle de randonnée')
                ;

#Libellés des départements équipés d’un « Terrain de horse-ball » 

select DISTINCT libDepartement
FROM Departement, Commune, Equiper, TypeEquipement
WHERE Departement.codeDepartement = Commune.codeDepartement
	AND Commune.codeCommune = Equiper.codeCommune
    AND Equiper.codeType = TypeEquipement.codeType
    AND TypeEquipement.libType =libCommune 'Terrain de horse-ball';
    
#Libellé des communes qui sont équipées d’un « Terrain de football » et d’une « Boucle de randonnée ». Cette commune est dans le département dont le chef-lieu est Clermont- Ferrand.


select libCommune
from Commune
where codeCommune in (select Equiper.codeCommune from Equiper inner join TypeEquipement on Equiper.codeType = TypeEquipement.codeType and libType = "Boucle de randonnée")
and codeCommune in (select Equiper.codeCommune from Equiper inner join TypeEquipement on Equiper.codeType = TypeEquipement.codeType and libType = "Terrain de football")
and codeDepartement = (select Departement.codeDepartement from Departement inner join Commune on Departement.chefLieu = Commune.codeCommune where libCommune = "Clermont-Ferrand");

#11. Libellé des équipements (libellés) présents sur la commune qui est équipé de 4 « Aire de
#saut » et 7 « Plateau EPS/Multisports » et 27 « Terrain de football » 

select libType
From Commune
	inner join Equiper on Commune.codeCommune = Equiper.codeCommune
    inner join TypeEquipement on TypeEquipement.codeType = Equiper.codeType
WHERE Commune.codeCommune in (select codeCommune from Equiper inner join TypeEquipement on Equiper.codeType = TypeEquipement.codeType where qte = 4 and libType = "Aire de saut" )
AND Commune.codeCommune in (select codeCommune from Equiper inner join TypeEquipement on Equiper.codeType = TypeEquipement.codeType where qte = 7 and libType = "Plateau EPS/Multisports" )
AND Commune.codeCommune in (select codeCommune from Equiper inner join TypeEquipement on Equiper.codeType = TypeEquipement.codeType where qte = 27 and libType = "Terrain de football" ) ;


#12. Liste des communes (libellés) du Cantal qui n’ont pas de « Terrain de football »
 
SELECT DISTINCT libCommune
FROM Commune, Departement
WHERE Commune.codeDepartement = Departement.codeDepartement
	AND libDepartement = "Cantal"
	AND codeCommune NOT IN (
		SELECT codeCommune from Equiper, TypeEquipement WHERE Equiper.codeType = TypeEquipement.codeType
		AND libType = "Terrain de football");

#13. Liste des équipements (libellés) qui ne sont pas disponibles en Auvergne

select libType
from TypeEquipement
where codeType not in (
SELECT DISTINCT codeType
FROM  Equiper, Commune, Departement, Region
WHERE  Equiper.codeCommune = Commune.codeCommune
	AND Commune.codeDepartement = Departement.codeDepartement
    AND Departement.codeRegion = Region.codeRegion
	AND libRegion = "Auvergne" );
    
#14. Liste des départements (libellés) qui n’ont ni « Bowling » ni « Parcours 18 trous »

select  libDepartement
from Departement
where Departement.codeDepartement not in (
	SELECT Departement.codeDepartement 
	FROM Commune, Equiper, TypeEquipement, Departement 

	WHERE  Departement.codeDepartement = Commune.codeDepartement
    AND Equiper.codeCommune = Commune.codeCommune
    AND TypeEquipement.codeType = Equiper.codeType

    AND libType = "Bowling" OR libType = "Parcours 18 trous");

#CORRECTION

select libDepartement
from Departement
where Departement.codeDepartement not in ( select Departement.codeDepartement
											from Departement
												inner join Commune on Departement.codeDepartement = Commune.codeDepartement
                                                inner join Equiper on Commune.codeCommune = Equiper.codeCommune
                                                inner join TypeEquipement on Equiper.codeType = TypeEquipement.codeType
                                                where libType = "Bowling" OR libType = "Parcours 18 trous");
                                                
#. Quels sont les installations (libellés des types d’équipements) en commun entre la
#commune de la « Sarthe » dont le libellé commence par « Lou » mais ne finit pas par
#« s », et qui n’est pas « Loué »; et le chef-lieu de la Creuse.


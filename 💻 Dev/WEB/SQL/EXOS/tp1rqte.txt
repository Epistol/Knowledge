TP EQUIPEMENT SPORTIF

19. Liste des communes (libellés) ayant 3 bowling, mais n’étant pas le chef-lieu
 du département dont le libellé commence par un B mais ne finit pas par un n. 

SELECT libCommune
FROM Commune, Departement
INNER JOIN  Equiper ON Commune.codeCommune Equiper.codeCommune
INNER JOIN TypeEquipement ON Equiper.codeType = TypeEquipement.codeType

WHERE Departement.chefLieu NOT IN (
	SELECT libDepartement 
	FROM Departement
	WHERE libDepartement LIKE 'B%'
	AND libDepartement NOT LIKE '%n')

HAVING COUNT(libType) = 3;



20. Nombre de « Salle d'escrime » dans le département du « Loiret ». 

SELECT COUNT(TypeEquipement.codeType)
FROM TypeEquipement
INNER JOIN Equiper ON TypeEquipement.codeType = Equiper.codeType
INNER JOIN Commune ON Equiper.codeCommune = Commune.codeCommune
INNER JOIN Departement ON Commune.codeCommune = Departement.chefLieu

WHERE libDepartement = "Loiret"
AND TypeEquipement.libType = "Salle d'escrime";



21. Nombre de « Salle d'escrime » dans la région « Auvergne ». 

SELECT COUNT(TypeEquipement.codeType)
FROM TypeEquipement
INNER JOIN Equiper ON TypeEquipement.codeType = Equiper.codeType
INNER JOIN Commune ON Region.chefLieuRegion = Commune.codeCommune
INNER JOIN Departement ON Region.codeRegion = Departement.codeRegion


WHERE Region.libRegion = "Auvergne"
AND TypeEquipement.libType = "Salle d'escrime";


22. Nombre d’équipements sportifs par commune du « Puy-de-Dôme ». On affiche le nom
de la commune et le nombre.





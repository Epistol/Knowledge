SELECT COUNT (DISCTINCT idProduit)
FROM Produit
WHERE idrayon=(SELECT idRayoon
		FROM Produit
		WHERE nom="Lapin"


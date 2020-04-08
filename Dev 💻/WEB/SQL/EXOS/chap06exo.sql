Exercice 1 : Cours06 manip bdd

INSERT INTO personnel (nom,prenom,ddn)
	VALUE ('Durand','Julien','1978-01-25')

2 : 

UPDATE rayon
SET idPersonnel = (SELECT idPersonnel FROM Personnel
WHERE nom = "Durand' AND prenom = 'Julien')
WHERE nom = "Habillement";

3 : 

DELETE From Personnel 
WHERE nom = "Laroche" and prenom "Robert";


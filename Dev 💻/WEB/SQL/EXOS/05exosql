Écrire la requête permettant d’obtenir la liste des
agents d’entretien (nom et adresse) de l’école dont
le code est 12.

SELECT  nomAgentn adresseAgent
FROM AgentE
where codeEcole = 12;

Écrire la requête permettant d’obtenir la liste des
écoles (code et nom) ayant au moins 5 agents
d’entretien.

SELECT codeEcole, nomEcole
FROM Ecole inner join AgentE on Ecole.codeEcole = AgentE.codeEcole
GROUP BY codeEcole, nomEcole
Having Count(AgentE.codeEcole) >/ 5;

Écrire la requête permettant d’afficher les noms et
adresses des agents actuellement en congé de
maternité (LibelléType égal à "congé maternité").
On utilisera la fonction Curdate() pour obtenir la
date du jour

SELECT nomAgent,adresseAgent
FROM AgentE, Absence, TypeAbsence
WHERE TypeAbsence.LibelleType = "congé maternité"
AND AgentE.matAgent = Absence.matAgent AND Absence.codeType = TypeAbsence.codeType
AND Absence.dateDebut = Date(Curdate());



// solution prof :
Select nomAgent, adresseAgent
FROM AgentE
  inner join Absence on AgentE.matAgent = Absence.matAgent
  inner join TypeAbsence ON Absence.codeType = TypeAbsence.codeType
WHERE LibelleType = "congé maternité"
AND curdate() BETWEEN DateDebut AND dateFIN;


Quelle est l’absence qui a duré le plus longtemps et
quel est le nom de l’agent qui s’est absenté.

SELECT idAbsence,  max(dateFin - DateDebut) AS Dureelapluslongue, nomAgentn
FROM Absence, AgentE
WHERE AgentE.matAgent = Absence.matAgent;

// prof

SELECT idAbsence, nomAgent
FROM Absence as A
INNER JOIN Agent E as B on A.matAgent = B.matAgent

Quels sont les agents qui n’ont aucune absence.

SELECT matAgent
FROM AgentE
WHERE matAgent not in (select matAgent from absence)


Quels sont les agents qui se sont absentés plus de 20 jours cette année, et qui sont revenus.

SELECT matAgent
FROM Absence
WHERE Year(curdate()) = year(dateDebut)
AND dateFin<curdate()
GROUP BY matAgent
having sum(datediff(dateFin,dateDebut)) > 20;

Quels sont les agents de l’école « JBDLS » qui ont
au moins un motif d’absence en commun avec M.
Dupont. Ces agents n’ont jamais été absents pour
« congé maternité ».

SELECT matAgent
FROM AgentF,Ecole,Absence, TypeAbsence
WHERE Ecole.nomEcole = "JBDLS"
AND matAgent NOT IN  (SELECT matAgent
                          FROM AgentE,Absence
                          WHERE AgentE.matAgent = Absence.matAgent
                          AND TypeAbsence.codeType = Absence.codeType
                          AND LibelleType = "congé maternité"
                          )

AND IN ( SELECT matAgent
                        FROM AgentE
                        WHERE nomAgent = "M.Dupont"
                      );
                      

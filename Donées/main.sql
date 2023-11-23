USE SAE104;

SELECT Libelle, COUNT(id_etudiant) AS Nb_élèves
FROM etudiant E, etablissement Et
WHERE E.UAI = Et.UAI
GROUP BY Libelle
ORDER BY Nb_élèves DESC
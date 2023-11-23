/*1 selectionne toute la table Baccalauréat DONE*/
SELECT * FROM Baccalaureat;

/*2 selectionne toute la table Langue DONE*/
SELECT * FROM Langue;

/*3 selectionne toute la table Etablissement DONE*/
SELECT * FROM etablissement;

/*4 selectionne toute la table Localite DONE*/
SELECT * FROM localite;

/*5 selectionne toute la table Etudiant DONE*/
SELECT * FROM etudiant;

/*6 selectionne tous les Etudiants ayant eu la mention Tres bien DONE*/
SELECT * FROM etudiant
WHERE mention = 'TB';

/*7 selectionne le prenom des élèves dans un bac stmg DONE*/
SELECT prenom 
FROM Etudiant E, Baccalaureat B
WHERE E.id_bac = B.id_bac
	AND nom_serie = 'STMG';

/*8 selectionne l'UAI le prenom des élèves dan sun bac generale DONE*/
SELECT UAI,prenom
FROM Etudiant E, Baccalaureat B
WHERE E.id_bac = B.id_bac
	AND nom_serie = 'Generale';

/*9 selectionne les noms d'établissements à Cesson 77*/
SELECT Libelle
FROM Etablissement E
INNER JOIN Localite L ON L.id_localite=E.id_localite
WHERE L.nom_commune='Cesson' AND L.departement='77';

/*10 selectionne l'identité des élèves boursiers DONE*/
SELECT nom,prenom
FROM Etudiant
WHERE boursier=True;

/*11 selectionne le nombre d'élèves par serie de bac DONE*/
SELECT nom_serie,COUNT(id_etudiant)
FROM Etudiant E, Baccalaureat B
WHERE E.id_bac=B.id_bac
GROUP BY nom_serie;

/*12 selectionne le nombre d'élèves par établissements DONE MAIS A REVOIR*/
SELECT Libelle, COUNT(id_etudiant)
FROM Etudiant E, Etablissement Et
WHERE E.UAI = Et.UAI
GROUP BY Libelle;

/*13 selectionne l'établissement avec le plus d'élèves DONE*/
SELECT Libelle, COUNT(id_etudiant)
FROM Etudiant E
INNER JOIN etablissement et ON E.UAI = et.UAI
GROUP BY Libelle
HAVING COUNT(id_etudiant)>=ALL(SELECT COUNT(id_etudiant)
								FROM Etudiant E
								INNER JOIN etablissement et ON E.UAI = et.UAI
								GROUP BY Libelle);
                                
/*14 selectionne l'établissement avec le moins d'élèves DONE*/
SELECT Libelle, COUNT(id_etudiant) AS Nb_etu
FROM etudiant E, etablissement Et
WHERE E.UAI = Et.UAI
GROUP BY Libelle
HAVING MIN(Nb_etu) = (SELECT COUNT(id_etudiant)
						FROM etudiant E, etablissement Et
						WHERE E.UAI = Et.UAI
						GROUP BY Libelle);

/*15 selectionne le nombre d'élèves en serie generale DONE*/
SELECT nom_serie, COUNT(id_étudiant)
FROM Etudiant E, Baccalaureat Bac
WHERE E.id_bac = Bac.id_bac
GROUP BY nom_serie
HAVING nom_serie = 'Generale';

/*16 selectionne les établissements qui contiennent "Jean" dans leur nom DONE*/
SELECT *
FROM Etablissement
WHERE Libelle LIKE '%Jean%';

/*17 selectionne les établissements du 95, 91 et 78 DONE*/
SELECT Libelle
FROM etablissement
WHERE  departement IN (95,91,78);

/*18 selectionne le nombre d'élèves regroupé par établissement trier par ordre decroissant de nombre d'élèves DONE*/
SELECT Libelle, COUNT(id_etudiant) AS Nb_élèves
FROM etudiant E, etablissement Et
WHERE E.UAI = Et.UAI
GROUP BY Libelle
ORDER BY Nb_élèves DESC;

/*19 selectionne les élèves des établissements entre le 77 et 91 DONE*/
SELECT CONCAT(nom," ", prenom) AS Identité
FROM Etudiant
INNER JOIN Etablissement ON Etudiant.UAI = Etablissement.UAI
WHERE departement BETWEEN 77 AND 91;

/*20 selectionne toute la table sans les doublons*/
SELECT DISTINCT * 
FROM Etudiant;

/*21 selectionne les étudiants avec l'UAI qui fini par F*/
SELECT *
FROM Etudiant
WHERE EXISTS(SELECT UAI 
                FROM etablissement
                WHERE etablissement.UAI=Etudiant.UAI
            	AND UAI LIKE "%F");
                
/*22 selectionne la somme de tous les étudiants*/
SELECT *
FROM Etudiants
WHERE COUNT(*)=(SELECT Libelle, COUNT(nom)
					FROM etablissement e, Etudiant E
                    WHERE e.UAI=E.UAI 
                    GROUP BY Libelle)
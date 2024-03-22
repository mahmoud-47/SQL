/* 1 Les noms des acteurs */
SELECT PRENOM_ACTEUR, NOM_ACTEUR 
FROM ACTEUR;

/* 2 Les noms des acteurs sans repetition */
SELECT DISTINCT NOM_ACTEUR 
FROM ACTEUR;

/* 3 Les acteurs français */
SELECT PRENOM_ACTEUR, NOM_ACTEUR
FROM ACTEUR
WHERE NATION_ACTEUR='FRANCAISE';

/* 4 les noms des acteurs nés entre le 1e Janvier 1950 et le 31 Dec 1999 */
SELECT PRENOM_ACTEUR, NOM_ACTEUR
FROM ACTEUR
WHERE DATE_DE_NAISSANCE BETWEEN '1950-01-01' AND '1999-12-31';

/* 5 Les noms des roles de l'acteur No 7 triés par ordre alphabetique */
SELECT NOM_DU_ROLE
FROM ROLE
WHERE NUMERO_ACTEUR = 7
ORDER BY NOM_DU_ROLE;

/* 6 Les noms et prenoms des realisateurs qui ont travaillé avec l'acteur 7 */
SELECT PRENOM_REALISATEUR, NOM_REALISATEUR
FROM REALISATEUR REA
WHERE EXISTS(
        SELECT NUMERO_ACTEUR, NUMERO_FILM
        FROM ROLE
        WHERE NUMERO_ACTEUR = 7
        AND NUMERO_FILM IN (
                SELECT NUMERO_FILM
                FROM FILM
                WHERE NUMERO_REALISATEUR = REA.NUMERO_REALISATEUR
            )
    );

/* 7 Les noms et prenoms des realisateurs qui ont travaillé avec l'acteur POIRET triés par
Ordre alphabetique sur le nom */
SELECT PRENOM_REALISATEUR, NOM_REALISATEUR
FROM realisateur r
WHERE EXISTS(
        SELECT * 
        FROM ROLE
        WHERE NUMERO_ACTEUR = (
                SELECT NUMERO_ACTEUR
                FROM ACTEUR
                WHERE upper(NOM_ACTEUR)='POIRET'
            )
        AND NUMERO_FILM IN (
                SELECT NUMERO_FILM
                FROM FILM
                WHERE NUMERO_REALISATEUR = r.NUMERO_REALISATEUR
            )
    )
ORDER BY NOM_REALISATEUR;

/* 8 Les acteurs qui ont joué avec le realisateur No 7 */
SELECT PRENOM_ACTEUR ,NOM_ACTEUR
FROM ACTEUR A
WHERE EXISTS(
        SELECT * 
        FROM ROLE
        WHERE NUMERO_ACTEUR = A.NUMERO_ACTEUR
        AND NUMERO_FILM IN (
                SELECT NUMERO_FILM
                FROM FILM
                WHERE NUMERO_REALISATEUR = 7
            )
    );

/* 9 Les numeros et prenoms des acteurs ayant une nationalité renseignée */
SELECT NUMERO_ACTEUR, PRENOM_ACTEUR, NOM_ACTEUR
FROM ACTEUR
WHERE NATION_ACTEUR IS NOT NULL;

/* 10 Les noms des realisateurs qui ont realisé un film au moins */
SELECT PRENOM_REALISATEUR, NOM_REALISATEUR
FROM REALISATEUR
WHERE NUMERO_REALISATEUR IN (
        SELECT NUMERO_REALISATEUR
        FROM FILM
    );

/* 11 Le nombre de realisateurs */
SELECT COUNT(*)
FROM REALISATEUR;

/* 12 Pour chaque acteur, le nombre de ses rôles */
SELECT PRENOM_ACTEUR, NOM_ACTEUR, COUNT(*)
FROM ACTEUR a, ROLE r
WHERE a.NUMERO_ACTEUR = r.NUMERO_ACTEUR
GROUP BY a.NUMERO_ACTEUR, PRENOM_ACTEUR, NOM_ACTEUR;

/* 13 Pour chaque acteur, la durée de son film le plus court, la duree de son film le plus long,
l'ecart max de durée entre ses films et la moyenne de duree de ses films  */
SELECT PRENOM_ACTEUR, MAX(DUREE), MIN(DUREE), MAX(DUREE)-AVG(DUREE) As ECART
FROM FILM F, ACTEUR A, ROLE R
WHERE F.NUMERO_FILM = R.NUMERO_FILM
AND A.NUMERO_ACTEUR = R.NUMERO_ACTEUR
GROUP BY A.NUMERO_ACTEUR;

/* 14 Les realisateurs ayant realisé exactement deux films */
SELECT PRENOM_REALISATEUR, NOM_REALISATEUR
FROM REALISATEUR R, FILM F
WHERE R.NUMERO_REALISATEUR = F.NUMERO_REALISATEUR
GROUP BY R.NUMERO_REALISATEUR
HAVING COUNT(DISTINCT NUMERO_FILM)=2;

/* 15 Les realisateurs ayant realisé au moins 3 films en affichant le numero et le nom des realisateurs
ainsi que le nombre de films; Le resultat est trié par ordre decroissant du nombre de films et ordre 
croissant sur le nom */
SELECT R.NUMERO_REALISATEUR, PRENOM_REALISATEUR, NOM_REALISATEUR, COUNT(DISTINCT NUMERO_FILM) AS compt
FROM REALISATEUR R, FILM F
WHERE R.NUMERO_REALISATEUR = F.NUMERO_REALISATEUR
GROUP BY R.NUMERO_REALISATEUR
HAVING COUNT(DISTINCT NUMERO_FILM)>=3
ORDER BY compt DESC, NOM_REALISATEUR ASC;

/* 16 Les numeros des acteurs dont la duree moyenne des films dans lesquels ils ont joué = 2 */
SELECT A.NUMERO_ACTEUR, AVG(DUREE)/60 AS Duree_film
FROM ACTEUR A, ROLE R, FILM F
WHERE A.NUMERO_ACTEUR = R.NUMERO_ACTEUR
AND R.NUMERO_FILM = F.NUMERO_FILM
GROUP BY A.NUMERO_ACTEUR
HAVING AVG(DUREE)/60=2;

/* 17 Les numeros des acteurs français dont la somme cumulée des durées de leurs roles est inferieure à
10h (tous films confondus) */
SELECT A.NUMERO_ACTEUR
FROM ACTEUR A, ROLE R, FILM F
WHERE A.NUMERO_ACTEUR = R.NUMERO_ACTEUR
AND R.NUMERO_FILM = F.NUMERO_FILM
AND NATION_ACTEUR='FRANCAISE'
GROUP BY A.NUMERO_ACTEUR
HAVING SUM(DUREE)<10*60;

/* 18 Les noms des acteurs et les noms des realisateurs (sans repetition sur une seule colonne) */
SELECT DISTINCT NOM_ACTEUR
FROM ACTEUR;
UNION
SELECT DISTINCT NOM_REALISATEUR
FROM REALISATEUR;

/* 19 Les noms communs des acteurs et des realisateurs sans repetition */
SELECT DISTINCT NOM_ACTEUR
FROM ACTEUR A
WHERE A.NOM_ACTEUR IN(
        SELECT NOM_REALISATEUR
        FROM REALISATEUR
    );
/* 20 les noms des acteurs qui ne sont pas des noms de realisateurs*/
SELECT DISTINCT NOM_ACTEUR
FROM ACTEUR A
WHERE A.NOM_ACTEUR NOT IN(
        SELECT NOM_REALISATEUR
        FROM REALISATEUR
    );

/* 21 Les numeros et noms des acteurs francais ou americains */
SELECT NUMERO_ACTEUR, NOM_ACTEUR
FROM ACTEUR
WHERE NATION_ACTEUR='FRANCAISE'
OR NATION_ACTEUR='AMERICAINE';

/* 22 Les realisateurs n'ayant realisé aucun film */
SELECT NUMERO_REALISATEUR
FROM REALISATEUR
WHERE NUMERO_REALISATEUR NOT IN (
        SELECT NUMERO_REALISATEUR
        FROM FILM
    );

/* 23 Les noms communs des acteurs et des realisateurs (trouver une methode differente de celle en haut) */
SELECT NOM_ACTEUR
FROM ACTEUR A
WHERE EXISTS(
        SELECT *
        FROM REALISATEUR
        WHERE NOM_REALISATEUR = A.NOM_ACTEUR
    );

/* 24 les numeros des realisateurs ayant realisé les films les plus long*/
SELECT NUMERO_REALISATEUR
FROM FILM
WHERE DUREE >= ALL(
        SELECT DUREE
        FROM FILM
    );

/* 25 Les numeros et noms des acteurs ayant la nationalité la plus frequente*/
SELECT NUMERO_ACTEUR, NOM_ACTEUR, PRENOM_ACTEUR
FROM ACTEUR A
WHERE NATION_ACTEUR = (
        SELECT NATION_ACTEUR
        FROM ACTEUR
        GROUP BY NATION_ACTEUR
        HAVING COUNT(*)>=ALL(
            SELECT COUNT(*)
            FROM ACTEUR
            GROUP BY NATION_ACTEUR
        )
    );

/* 26 Les noms des acteurs n'ayant pas joué avec le realisateur 7 */
SELECT PRENOM_ACTEUR ,NOM_ACTEUR
FROM ACTEUR A
WHERE NOT EXISTS(
        SELECT * 
        FROM ROLE
        WHERE NUMERO_ACTEUR = A.NUMERO_ACTEUR
        AND NUMERO_FILM IN (
                SELECT NUMERO_FILM
                FROM FILM
                WHERE NUMERO_REALISATEUR = 7
            )
    );

/* 27 Les realisateurs n ayant realisé aucun film */
SELECT NUMERO_REALISATEUR 
FROM REALISATEUR
EXCEPT
SELECT NUMERO_REALISATEUR
FROM FILM;
/* 1 Tous les titres de film*/
SELECT titre
FROM film_film;


/* 2 Nom et prenom des internautes Auvergnats*/
SELECT *
FROM film_internaute
WHERE region='Auvergne';


/* 3 - 1 Titre et annee de tous les drames, triés par annee ASC*/
SELECT titre, annee
FROM film_film
WHERE genre='Drame'
ORDER BY annee;


/* 3 - 2 Titre et annee de tous les drames, triés par annee DESC*/
SELECT titre, annee
FROM film_film
WHERE genre='Drame'
ORDER BY annee DESC;


/* 4 Nom et annee de naissance des artistes nés avant 1950*/
SELECT nom, anneenaiss
FROM film_artiste
WHERE anneenaiss<1950;

/* 5 Titre et annee de tous les films parus entre 1960 et 1980*/
SELECT titre, annee
FROM film_film
WHERE annee BETWEEN 1960 AND 1980;

/* 6 Tous les genres de film sans doublon*/
SELECT DISTINCT genre 
FROM film_film;

/* 7 Titre, genre et resumé de tous les films qui sont soit des drames soit des Western 
(Utilisez la construction IN), et dont le résumé contient la chaine de caracteres "vie"*/
SELECT titre, genre, resume
FROM film_film
WHERE genre IN ('Western', 'Drame')
AND resume LIKE '%vie%';

/* 8 Les artistes dont le nom commence par H */
SELECT *
FROM film_artiste
WHERE nom LIKE 'H%';

/* 9 Les acteurs dont on ignore l'année de naissance */
/* A refaire acteur est dans film_role */
SELECT *
FROM film_artiste a, film_role r
WHERE r.idacteur = a.idartiste
AND anneenaiss IS NULL;

/* 10   prenom, nom et age de chaque artiste */
SELECT prenom, nom, extract(year from current_date)-anneenaiss AS age
FROM   film_artiste;

/* 11 Qui a joué le rôle de Morpheus (nom et prenom)*/
SELECT prenom, nom
FROM film_artiste
WHERE idartiste IN (
        SELECT idacteur FROM film_role
        WHERE nomrole = 'Morpheus'
    );

/* 12 Qui est le realisateur de Alien */
SELECT  prenom, nom
FROM film_artiste a, film_film f
WHERE f.idmes = a.idartiste
AND titre='Alien';

/* 13 Prenom, nom des internautes qui ont donné une note de 4 à un film, puis donner le titre du film*/
SELECT prenom, nom, titre
FROM film_film f, film_internaute i, film_notation n
WHERE f.idfilm=n.idfilm
AND n.email = i.email
AND note = 4;

/* 14 Quels acteurs ont joué quel role dans le film Vertigo */
SELECT prenom, nom, titre, nomrole
FROM film_film f, film_artiste a, film_role r
WHERE f.idfilm = r.idfilm
AND r.idacteur = a.idartiste
AND f.titre = 'Vertigo';

/* 15 film dont le realisateur est Tim Burton et un des acteurs est Johnny Depp*/
SELECT titre
FROM film_film f
WHERE idmes IN (
                SELECT idartiste
                FROM film_artiste
                WHERE prenom='Tim'
                AND nom = 'Burton'
            )
AND ('Johnny', 'Depp') IN (
                            SELECT prenom, nom
                            FROM film_role r, film_artiste a
                            WHERE r.idfilm = f.idfilm
                            AND r.idacteur = a.idartiste
                        );    

/* 16 Titres des films dans lequel a joué Bruce Willis. Donner aussi le nom du rôle*/
SELECT titre, nomrole
FROM film_film f, film_artiste a, film_role r
WHERE f.idfilm = r.idfilm
AND a.idartiste = r.idacteur
AND prenom = 'Bruce'
AND nom = 'Willis';

/* 17 Quel metteur en scene a joué dans ses propres films ? donner le nom, le role et le titre des films*/
SELECT prenom, nom, nomrole, titre
FROM film_film f, film_artiste a, film_role r
WHERE f.idmes = r.idacteur
AND f.idfilm = r.idfilm
AND a.idartiste = r.idacteur;

/* 18 Quel metteur en scene a tourné en tant qu'acteur (mais pas dan son propre film) 
donner le nom, le role et le titre des films où le metteur en scene a joué */
SELECT idmes, prenom, nom, titre, nomrole
FROM film_film f, film_role r, film_artiste a
WHERE f.idmes = r.idacteur
AND a.idartiste = f.idmes
AND idmes IN (
        SELECT idacteur
        FROM film_role
    )
AND NOT EXISTS (
        SELECT idfilm, idacteur
        FROM film_role
        WHERE idacteur = f.idmes
        AND idfilm IN (
                SELECT idfilm
                FROM film_film
                WHERE idmes = f.idmes
            )
    );

/* 19 Dans quel film le metteur en scene a-t-il le meme prenom que l'un des interpretes ? 
titre, nom du metteur en scene, nom de l'interprete, Le metteur en scene et l'interprete ne doivent
pas etre la meme personne
*/
SELECT idfilm, titre, prenom
FROM film_film f, film_artiste a1
WHERE f.idmes = a1.idartiste
AND prenom IN (
        SELECT prenom
        FROM film_role r, film_artiste a
        WHERE r.idfilm = f.idfilm
        AND r.idacteur = a.idartiste
        AND r.idacteur != f.idmes
    );

/* 20 Nom et prenom des artistes qui ont mis en scene un film */
SELECT idmes, nom, prenom
FROM film_film f, film_artiste a
WHERE f.idmes = a.idartiste;

/* 21 Donnez le titre et année des films qui ont le même genre que Matrix*/
SELECT titre, annee
FROM film_film
WHERE genre = (
        SELECT genre
        FROM film_film
        WHERE titre = 'Matrix'
    );

/* 22 Donner le nom des internautes qui ont noté le film alien, Donner egalement la note*/
SELECT note, prenom, nom
FROM film_film f, film_notation n, film_internaute i
WHERE n.idfilm =  f.idfilm
AND i.email = n.email
AND titre = 'Alien'
;

SELECT note, email -- l'email (rigaux@cnam.fr) en question n'est pas present dans la table film_internaute
FROM film_film f, film_notation n
WHERE n.idfilm =  f.idfilm
AND titre = 'Alien'
;

/* 23 Les films sans role*/
SELECT titre
FROM film_film 
WHERE idfilm NOT IN (
            SELECT idfilm
            FROM film_role
        );

/* 24 Nom et prenom des acteurs qui n'ont jamais mis en scene de film */
SELECT DISTINCT prenom, nom
FROM film_role r, film_artiste a
WHERE r.idacteur = a.idartiste
AND idacteur NOT IN (
        SELECT idmes
        FROM film_film
    );

/* 25 Les internautes qui n'ont pas noté de film paru en 1999 */
SELECT * FROM film_internaute i
WHERE NOT EXISTS(
            SELECT email, idfilm
            FROM film_notation
            WHERE email = i.email
            AND idfilm IN (
                    SELECT idfilm
                    FROM film_film
                    WHERE annee=1999
                )
        );

/* 26 Quel est le nombre de films notés par theo@ici.com, quelle est la moyenne des notes données,
la note min et la note max */
SELECT COUNT(n.idfilm) AS Nombre, AVG(note) AS Moyenne, MIN(note) AS NoteMin, MAX(note) AS NoteMax
FROM film_notation n
WHERE email = 'davy@bnf.fr'; --theo n'a noté aucun film

/* 27 Combien de fois Bruce Willis a-t-il joué le role de McClane ? */
SELECT COUNT(DISTINCT(idfilm, idacteur, nomrole)) AS Nombre_de_fois
FROM film_role
WHERE idacteur IN (
        SELECT idartiste
        FROM film_artiste
        WHERE prenom = 'Bruce'
        AND nom = 'Willis'            
    )
AND nomrole='McClane';

/* 28 Année du film le plus ancien et du film le plus recent */
SELECT titre, annee
FROM film_film
WHERE annee >= ALL(
        SELECT annee
        FROM film_film
    )
OR annee <= ALL(
        SELECT annee
        FROM film_film
    );

/* 29 id, nom et prenom des realisateurs et le nbr de films qu'ils ont tournés */
SELECT idmes, prenom, nom, COUNT(DISTINCT idfilm) AS nbFilms
FROM film_film f, film_artiste a
WHERE f.idmes = a.idartiste
GROUP BY idmes, prenom, nom;
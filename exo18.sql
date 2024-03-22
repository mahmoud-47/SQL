/* 1 Prenoms et noms des enfants de Saliou Ba */
SELECT prenom, nom
FROM personne
WHERE pere IN (
        SELECT numpers
        FROM personne
        WHERE prenom='Saliou'
        AND nom='Ba'
    );

/* 2 Prenoms et noms des parents de Seydou Ba */
SELECT prenom, nom
FROM personne p
WHERE EXISTS(
        SELECT numpers,pere
        FROM personne
        WHERE pere = p.numpers 
        AND numpers IN (
                SELECT numpers
                FROM personne
                WHERE prenom='Seydou'
                AND nom='Ba'
            )
    )
OR EXISTS(
        SELECT numpers,mere 
        FROM personne
        WHERE mere = p.numpers 
        AND numpers IN (
                SELECT numpers
                FROM personne
                WHERE prenom='Seydou'
                AND nom='Ba'
            )
    );

/* 3 Afficher les noms et prenoms des enfants de Saliou Ba et Houleye Ly */
SELECT prenom, nom 
FROM personne
WHERE pere IN (
        SELECT numpers
        FROM personne
        WHERE prenom='Saliou'
        AND nom='Ba'
    )
AND mere IN (
        SELECT numpers
        FROM personne
        WHERE prenom='Houleye'
        AND nom='Ly'
    );

/* 4 Afficher les noms et prenoms des freres de Rama Ba */
SELECT prenom, nom
FROM personne
WHERE pere IN (
        SELECT pere
        FROM personne
        WHERE prenom='Rama'
        AND nom='Ba'
    )
AND mere IN (
        SELECT mere
        FROM personne
        WHERE prenom='Rama'
        AND nom='Ba'
    );

/* 5 Afficher les noms et prenoms des cousins de Salimata Ba */

-- frers et soeurs du pere de salimata ba
SELECT numpers INTO TabFreres_pere_Salimata
FROM personne
WHERE pere IN (
        SELECT pere
        FROM personne
        WHERE numpers = (
            SELECT pere
            FROM personne
            WHERE prenom='Salimata'
            AND nom='Ba'
        )
    )
AND mere IN (
        SELECT mere
        FROM personne
        WHERE numpers = (
            SELECT pere
            FROM personne
            WHERE prenom='Salimata'
            AND nom='Ba'
        )
    )
AND numpers != (
    SELECT pere
    FROM personne
    WHERE prenom='Salimata'
    AND nom='Ba'
);

SELECT prenom, nom
FROM personne
WHERE pere IN (
        SELECT numpers 
        FROM TabFreres_pere_Salimata
    )
OR mere IN (
        SELECT numpers 
        FROM TabFreres_pere_Salimata
    );
DROP TABLE IF EXISTS TabFreres_pere_Salimata;

/* 6 Afficher les noms et prenoms des demi-frères (du côté de leur père) des enfants de Houleye Ly */
SELECT prenom, nom
FROM personne
WHERE pere IN (
        SELECT pere
        FROM personne
        WHERE mere = (
                SELECT numpers
                FROM personne
                WHERE prenom='Houleye'
                AND nom='Ly'
            )
    )
AND mere != (
        SELECT numpers
        FROM personne
        WHERE prenom='Houleye'
        AND nom='Ly'
    );

/* 7 Afficher les noms et prenoms de la mère des enfants de Tapha Ly */
SELECT prenom, nom
FROM personne
WHERE numpers IN (
        SELECT mere
        FROM personne
        WHERE pere IN (
                SELECT numpers
                FROM personne
                WHERE prenom='Tapha'
                AND nom='Ly'
            )
    );

/* 8 Afficher les noms et prenoms des neveux legitimes de Seydou Ba */
 -- freres&soeurs de Seydou Ba
SELECT numpers INTO freres_Seydou
FROM personne
WHERE pere IN (
        SELECT pere
        FROM personne
        WHERE numpers IN (
                SELECT numpers
                FROM personne
                WHERE prenom='Seydou'
                AND nom='Ba'
            )
    )
AND mere IN (
        SELECT mere
        FROM personne
        WHERE numpers IN (
                SELECT numpers
                FROM personne
                WHERE prenom='Seydou'
                AND nom='Ba'
            )
    );
 -- les neveux de Seydou Ba
SELECT prenom, nom
FROM personne
WHERE pere IN(
        SELECT numpers FROM freres_Seydou
    )
OR mere IN(
        SELECT numpers FROM freres_Seydou
    );

DROP TABLE IF EXISTS freres_Seydou;

/* 9 Afficher les noms et prenoms de meres des petits enfants de Awa Camara */
 --Petits enfants de Awa Camara
SELECT numpers INTO petis_fils_Awa
FROM personne
WHERE pere IN(
        SELECT numpers
        FROM personne
        WHERE mere IN(
                SELECT numpers
                FROM personne
                WHERE prenom='Awa'
                AND nom='Camara'
            )
    )
OR mere IN(
        SELECT numpers
        FROM personne
        WHERE mere IN(
                SELECT numpers
                FROM personne
                WHERE prenom='Awa'
                AND nom='Camara'
            )
    );
-- meres des petits enfants de Awa Camara
SELECT prenom, nom
FROM personne p
WHERE EXISTS(
    SELECT numpers, mere
    FROM personne
    WHERE mere = p.numpers
    AND numpers IN (
            SELECT numpers
            FROM petis_fils_Awa
        )
);
DROP TABLE IF EXISTS petis_fils_Awa;

/* 10 Afficher les noms et prenoms des parents et grand parents de Ibrahima Ba */
 --parents de Ibrahima Ba
SELECT * INTO parents_Ibrahima
FROM personne p
WHERE EXISTS (
        SELECT numpers, pere
        FROM personne
        WHERE pere = p.numpers
        AND numpers IN(
                SELECT numpers
                FROM personne
                WHERE prenom='Ibrahima'
                AND nom='Ba'
            )
    )
OR EXISTS (
        SELECT numpers, mere
        FROM personne
        WHERE mere = p.numpers
        AND numpers IN(
                SELECT numpers
                FROM personne
                WHERE prenom='Ibrahima'
                AND nom='Ba'
            )
    );
-- grans parents de Ibrahima Ba
(
    SELECT prenom, nom
    FROM personne p
    WHERE EXISTS(
            SELECT numpers, pere
            FROM personne
            WHERE pere = p.numpers
            AND numpers IN(
                    SELECT numpers
                    FROM parents_Ibrahima
                )
        )
    OR EXISTS (
            SELECT numpers, mere
            FROM personne
            WHERE mere = p.numpers
            AND numpers IN(
                    SELECT numpers
                    FROM personne
                    WHERE prenom='Ibrahima'
                    AND nom='Ba'
                )
        )
)
UNION 
(
    SELECT prenom, nom 
    FROM parents_Ibrahima
);
DROP TABLE IF EXISTS parents_Ibrahima;
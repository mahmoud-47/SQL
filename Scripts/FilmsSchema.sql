DROP TABLE IF EXISTS FILM_Notation;
DROP TABLE IF EXISTS FILM_Role;
DROP TABLE IF EXISTS FILM_Film;
DROP TABLE IF EXISTS FILM_Artiste;  
DROP TABLE IF EXISTS FILM_Internaute;
DROP TABLE IF EXISTS FILM_Pays;
DROP TABLE IF EXISTS FILM_Genre;

-- Creation des tables
CREATE TABLE FILM_Internaute (email VARCHAR (40) NOT NULL, 
                         nom VARCHAR (30) NOT NULL ,
                         prenom VARCHAR (30) NOT NULL,
                         region VARCHAR (30),
                         CONSTRAINT PKFILM_Internaute PRIMARY KEY (email));
 
CREATE TABLE FILM_Pays (code    VARCHAR(4) NOT NULL,
                   nom  VARCHAR (30) DEFAULT 'Inconnu' NOT NULL,
                   langue VARCHAR (30) NOT NULL,
                   CONSTRAINT PKFILM_Pays PRIMARY KEY (code));

CREATE TABLE FILM_Artiste  (idArtiste INTEGER NOT NULL,
                       nom VARCHAR (30) NOT NULL,
                       prenom VARCHAR (30) NOT NULL,
                       anneeNaiss INTEGER,
                       CONSTRAINT PKFILM_Artiste PRIMARY KEY (idArtiste));

CREATE TABLE FILM_Film  (idFilm INTEGER NOT NULL,
                    titre    VARCHAR (40) NOT NULL,
                    annee    INTEGER NOT NULL,
                    idMES    INTEGER,
                    genre VARCHAR (20) NOT NULL,
                    resume      TEXT,
                    codePays    VARCHAR (4),
                    CONSTRAINT PKFilm PRIMARY KEY (idFilm),
                    FOREIGN KEY (idMES) REFERENCES FILM_Artiste,
                    FOREIGN KEY (codePays) REFERENCES FILM_Pays);

CREATE TABLE FILM_Notation (idFilm INTEGER NOT NULL,
                       email  VARCHAR (40) NOT NULL,
                       note  INTEGER NOT NULL,
                       CONSTRAINT PKFilm_Notation PRIMARY KEY (idFilm, email));

CREATE TABLE FILM_Role (idFilm  INTEGER NOT NULL,
                   idActeur INTEGER NOT NULL,
                   nomRole  VARCHAR(50), 
                   CONSTRAINT PKFilm_Role PRIMARY KEY (idActeur,idFilm),
                   FOREIGN KEY (idFilm) REFERENCES FILM_Film,
                   FOREIGN KEY (idActeur) REFERENCES FILM_Artiste);

CREATE TABLE FILM_Genre (code    VARCHAR (30) NOT NULL,
                    CONSTRAINT PKFILM_Genre PRIMARY KEY (code));

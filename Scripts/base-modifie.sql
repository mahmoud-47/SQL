-- ============================================================
--   Nom de la base   :  CINEMA                                
--   Nom de SGBD      :  ORACLE Version 7.0                    
--   Date de creation :  30/10/96  12:09                       
-- ============================================================

drop table IF EXISTS ROLE;

drop table IF EXISTS FILM;

drop table IF EXISTS REALISATEUR;

drop table IF EXISTS ACTEUR;

-- ============================================================
--   Table : ACTEUR                                            
-- ============================================================
create table ACTEUR
(
    NUMERO_ACTEUR                   INTEGER              not null,
    NOM_ACTEUR                      CHAR(20)               not null,
    PRENOM_ACTEUR                   CHAR(20)                       ,
    NATION_ACTEUR                   CHAR(20)                       ,
    DATE_DE_NAISSANCE               DATE                           ,
    constraint pk_acteur primary key (NUMERO_ACTEUR)
);

-- ============================================================
--   Table : REALISATEUR                                       
-- ============================================================
create table REALISATEUR
(
    NUMERO_REALISATEUR              INTEGER              not null,
    NOM_REALISATEUR                 CHAR(20)               not null,
    PRENOM_REALISATEUR              CHAR(20)                       ,
    NATION_REALISATEUR              CHAR(20)                       ,
    constraint pk_realisateur primary key (NUMERO_REALISATEUR)
);

-- ============================================================
--   Table : FILM                                              
-- ============================================================
create table FILM
(
    NUMERO_FILM                     INTEGER              not null,
    TITRE_FILM                      CHAR(30)               not null,
    DATE_DE_SORTIE                  DATE                           ,
    DUREE                           INTEGER              not null,
    GENRE                           CHAR(20)               not null,
    NUMERO_REALISATEUR              INTEGER              not null,
    constraint pk_film primary key (NUMERO_FILM)
);

-- ============================================================
--   Table : ROLE                                              
-- ============================================================
create table ROLE
(
    NUMERO_ACTEUR                   INTEGER              not null,
    NUMERO_FILM                     INTEGER              not null,
    NOM_DU_ROLE                     CHAR(30)                       ,
    constraint pk_role primary key (NUMERO_ACTEUR, NUMERO_FILM)
);

alter table FILM
    add constraint fk1_film foreign key (NUMERO_REALISATEUR)
       references REALISATEUR (NUMERO_REALISATEUR);

alter table ROLE
    add constraint fk1_role foreign key (NUMERO_ACTEUR)
       references ACTEUR (NUMERO_ACTEUR);

alter table ROLE
    add constraint fk2_role foreign key (NUMERO_FILM)
       references FILM (NUMERO_FILM);


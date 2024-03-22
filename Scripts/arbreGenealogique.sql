DROP TABLE IF EXISTS personne;

CREATE TABLE personne
(numpers int PRIMARY KEY,
 nom varchar(30), 
 prenom varchar(30),
 pere int, 
 mere int,
 FOREIGN KEY (pere) REFERENCES personne(numpers),
 FOREIGN KEY (mere) REFERENCES personne(numpers)
);

insert into personne values (1, 'Camara', 'Awa', NULL, NULL);
insert into personne values (2, 'Ba', 'Harouna', NULL, NULL);
insert into personne values (3, 'Ba', 'Rama', 2, 1);
insert into personne values (4, 'Ba', 'Seydou', 2, 1);
insert into personne values (5, 'Ba', 'Saliou',2, 1);
insert into personne values (12, 'Ly', 'Alima', NULL, NULL);
insert into personne values (13, 'Ly', 'Tapha', NULL, NULL);
insert into personne values (9, 'Ly', 'Houleye', 13, 12);
insert into personne values (6, NULL, 'Gora', 5, NULL);
insert into personne values (8, 'Ba', 'Ibrahima', 5, 9);
insert into personne values (7, 'Ba', 'Mamadou', 5, 9);
insert into personne values (10, 'Ba', 'Myriam', 5, 9);
insert into personne values (11, 'Ly', 'Moussa', 13, 12);
insert into personne values (14, 'Ly', 'Daouda', 13, 12);
insert into personne values (15, 'Sall', 'Penda', NULL, NULL);
insert into personne values (16, 'Ba', 'Salimata', 4, 15);

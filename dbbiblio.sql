

--
-- Base de données : `dbbiblio`
--



INSERT INTO `auteurs` (`id`, `nomauteur`, `email`, `numtel`, `created_at`, `updated_at`) VALUES
(1, 'Romain Rissouan', 'Romain@yahoo.fr', '29123456', NULL, NULL),
(2, 'Emmanuel Jakobowicz', 'EmmanuelJakobowicz@gmail.com', '98123456', NULL, NULL),
(3, 'Stephan Roth', 'Stephan@gmail.com', '475213456', NULL, NULL),
(4, 'Julien Guillod', 'EmmanuelJakobowicz@gmail.com', '28574528', NULL, NULL),
(5, 'Cavier Chanet', 'Xavier@gmail.com', '28574528', NULL, NULL),
(6, 'Patrick vert', 'Pvert@gmail.com', '48574528', NULL, NULL),
(7, 'Eric Sarrion', 'Eric@gmail.com', '14574528', NULL, NULL),
(8, 'Alexandra Martin', 'Martin@gmail.com', '47854528', NULL, NULL),
(9, 'Stanislas Chaillou', 'Stanislas@gmail.com', '48954528', NULL, NULL),
(10, 'Patrick Wampe', 'patrick@gmail.com', '788954528', NULL, NULL),
(11, 'Jean Philippe', 'Jean@gmail.com', '85442412', NULL, NULL),
(12, 'Hérvé  Le Morvan', 'Morvan@gmail.com', '87442412', NULL, NULL),
(13, 'Olivier Hurtle', 'Olivier@gmail.com', '87542412', NULL, NULL),
(14, 'Ludovic Roland', 'Ludovic@gmail.com', '87442412', NULL, NULL),
(15, 'Yoann GUACHARD', 'Yoann@gmail.com', '2354685', NULL, NULL),
(16, 'Brice Arneaud Guerin', 'Brice@gmail.com', '2754685', NULL, NULL),
(17, 'Hervé Boiscontier', 'Hervé@gmail.com', '27454685', NULL, NULL),
(18, 'Jacque Poureer', 'Jacque@gmail.com', '125685', NULL, NULL),
(19, 'Jenome Gabillaud', 'JenomeGab@gmail.com', '32545874', NULL, NULL),
(20, 'DAVID Chaplin', 'Chaplin@gmail.com', '98745874', NULL, NULL),
(21, 'Bilal AMARNI', 'AMARNI@gmail.com', '212548', NULL, NULL),
(22, 'Etienne  Langlet', 'Langlet@gmail.com', '757575757', NULL, NULL);

-- --------------------------------------------------------




INSERT INTO `editeurs` (`id`, `maisonedit`, `siteweb`, `email`, `created_at`, `updated_at`) VALUES
(1, 'Eyrolles', 'https://www.eyrolles.com', 'eyrolles@domain.com', '2023-10-07 01:35:12', NULL),
(2, 'ENI', 'https://www.eni.com', 'eni@domain.com', '2023-10-07 01:36:03', NULL),
(3, 'Apress', 'https://www.apress.com', 'apress@domain.com', '2023-10-25 01:36:32', NULL),
(4, 'DUNOD', 'https://www.dunod.com', 'dunod@domain.com', '2023-10-07 01:37:12', NULL),
(5, 'Le MONITEUR', 'https://www.Moniteur.com', 'Moniteur@domain.com', '2023-10-26 01:37:35', NULL);

-- --------------------------------------------------------



INSERT INTO `livres` (`id`, `isbn`, `titre`, `annedition`, `prix`, `qtestock`, `couverture`, `specialite_id`, `editeur_id`, `created_at`, `updated_at`) VALUES
(1, '42368756', 'ReactJS', 2021, 33.00, 10, 'https://res-console.cloudinary.com/esps/thumbnails/v1/image/upload/v1696624013/YmlibGlvdGhlcXVlLzk3ODIyMTI2Nzc1NjBfaW50ZXJuZXRfdzI5MF9kM2UxNnE=/preview', 1, 1, NULL, NULL);

-- --------------------------------------------------------



INSERT INTO `livre_auteur` (`auteur_id`, `livre_id`) VALUES
(7, 1),
(22, 1);

-- --------------------------------------------------------



INSERT INTO `specialites` (`id`, `nomspecialite`, `created_at`, `updated_at`) VALUES
(1, 'Informatique', NULL, NULL),
(2, 'R�seaux', NULL, NULL);


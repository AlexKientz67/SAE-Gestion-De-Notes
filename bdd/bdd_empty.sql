-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : jeu. 11 juin 2026 à 15:29
-- Version du serveur : 8.0.45-36
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `sae`
--

-- --------------------------------------------------------

--
-- Structure de la table `app_enseignants`
--

CREATE TABLE `app_enseignants` (
  `id` bigint NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `app_etudiant`
--

CREATE TABLE `app_etudiant` (
  `id` bigint NOT NULL,
  `numero_etudiant` varchar(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `groupe` varchar(20) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `email` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `app_examen`
--

CREATE TABLE `app_examen` (
  `id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coefficient` double NOT NULL,
  `ressource_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `app_note`
--

CREATE TABLE `app_note` (
  `id` bigint NOT NULL,
  `note` double NOT NULL,
  `etudiant_id` bigint NOT NULL,
  `examen_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `app_ressources`
--

CREATE TABLE `app_ressources` (
  `id` bigint NOT NULL,
  `code` varchar(20) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `coefficient` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `app_ressources_ues`
--

CREATE TABLE `app_ressources_ues` (
  `id` bigint NOT NULL,
  `ressources_id` bigint NOT NULL,
  `ue_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `app_ue`
--

CREATE TABLE `app_ue` (
  `id` bigint NOT NULL,
  `code` varchar(20) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `semestre` int NOT NULL,
  `credits_ects` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 3, 'add_permission'),
(6, 'Can change permission', 3, 'change_permission'),
(7, 'Can delete permission', 3, 'delete_permission'),
(8, 'Can view permission', 3, 'view_permission'),
(9, 'Can add group', 2, 'add_group'),
(10, 'Can change group', 2, 'change_group'),
(11, 'Can delete group', 2, 'delete_group'),
(12, 'Can view group', 2, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add enseignants', 7, 'add_enseignants'),
(26, 'Can change enseignants', 7, 'change_enseignants'),
(27, 'Can delete enseignants', 7, 'delete_enseignants'),
(28, 'Can view enseignants', 7, 'view_enseignants'),
(29, 'Can add etudiant', 8, 'add_etudiant'),
(30, 'Can change etudiant', 8, 'change_etudiant'),
(31, 'Can delete etudiant', 8, 'delete_etudiant'),
(32, 'Can view etudiant', 8, 'view_etudiant'),
(33, 'Can add ue', 12, 'add_ue'),
(34, 'Can change ue', 12, 'change_ue'),
(35, 'Can delete ue', 12, 'delete_ue'),
(36, 'Can view ue', 12, 'view_ue'),
(37, 'Can add ressources', 11, 'add_ressources'),
(38, 'Can change ressources', 11, 'change_ressources'),
(39, 'Can delete ressources', 11, 'delete_ressources'),
(40, 'Can view ressources', 11, 'view_ressources'),
(41, 'Can add examen', 9, 'add_examen'),
(42, 'Can change examen', 9, 'change_examen'),
(43, 'Can delete examen', 9, 'delete_examen'),
(44, 'Can view examen', 9, 'view_examen'),
(45, 'Can add note', 10, 'add_note'),
(46, 'Can change note', 10, 'change_note'),
(47, 'Can delete note', 10, 'delete_note'),
(48, 'Can view note', 10, 'view_note');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1200000$WqSKkk8PkTBh5U09KJ4zbO$gi9iPGTXvlxgWl53ZQQt5f2kI6B58AxXrjlceT+mWow=', '2026-06-08 08:38:44.151082', 1, 'admin', '', '', 'illia.sitovskyi@uha.fr', 1, 1, '2026-06-04 12:03:58.647092'),
(2, 'pbkdf2_sha256$1200000$g2NoObUBRI0klisZEELLb6$aYVAEbvql3yXvo+lQQe6vMLq4/yjArUlU3jxceTxvGM=', NULL, 1, 'illia', '', '', 'illia@illia.com', 1, 1, '2026-06-08 07:55:00.742767'),
(3, 'pbkdf2_sha256$1200000$4VUkcQW56l9eXLopzvPW98$vxSTh56JWJbmKnBJIDiq3HMbj6kvXl/TMFUG7SzqYPM=', '2026-06-09 08:19:08.637217', 0, 'mura.laurent', '', '', '', 0, 1, '2026-06-08 07:57:14.093303'),
(4, 'pbkdf2_sha256$600000$A1f6ktETDzHJ6iLFlHI7ST$N/i8g+/Vsu9kpPF4BIT1JCLKThV3JOTjSE8MyrjNzDM=', '2026-06-10 13:50:10.616147', 0, 'garinet', '', '', '', 0, 1, '2026-06-08 08:39:44.170272');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

--
-- Déchargement des données de la table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2026-06-08 08:39:00.489719', '2', 'ECKLE Olivier', 3, '', 7, 1),
(2, '2026-06-08 08:39:00.489874', '1', 'GARINET Jacques', 3, '', 7, 1);

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'app', 'enseignants'),
(8, 'app', 'etudiant'),
(9, 'app', 'examen'),
(10, 'app', 'note'),
(11, 'app', 'ressources'),
(12, 'app', 'ue'),
(2, 'auth', 'group'),
(3, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-05-28 12:48:48.376503'),
(2, 'auth', '0001_initial', '2026-05-28 12:48:51.397566'),
(3, 'admin', '0001_initial', '2026-05-28 12:48:52.063244'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-05-28 12:48:52.146847'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-05-28 12:48:52.280002'),
(6, 'app', '0001_initial', '2026-05-28 12:48:54.337112'),
(7, 'app', '0002_remove_ue_enseignant', '2026-05-28 12:48:55.142027'),
(8, 'app', '0003_remove_note_appreciation', '2026-05-28 12:48:55.536759'),
(9, 'app', '0004_remove_examen_ue_examen_ressource', '2026-05-28 12:48:56.861393'),
(10, 'contenttypes', '0002_remove_content_type_name', '2026-05-28 12:48:57.436499'),
(11, 'auth', '0002_alter_permission_name_max_length', '2026-05-28 12:48:57.707776'),
(12, 'auth', '0003_alter_user_email_max_length', '2026-05-28 12:48:58.110765'),
(13, 'auth', '0004_alter_user_username_opts', '2026-05-28 12:48:58.357922'),
(14, 'auth', '0005_alter_user_last_login_null', '2026-05-28 12:48:58.667730'),
(15, 'auth', '0006_require_contenttypes_0002', '2026-05-28 12:48:58.757635'),
(16, 'auth', '0007_alter_validators_add_error_messages', '2026-05-28 12:48:58.842620'),
(17, 'auth', '0008_alter_user_username_max_length', '2026-05-28 12:48:59.087192'),
(18, 'auth', '0009_alter_user_last_name_max_length', '2026-05-28 12:48:59.294030'),
(19, 'auth', '0010_alter_group_name_max_length', '2026-05-28 12:48:59.687856'),
(20, 'auth', '0011_update_proxy_permissions', '2026-05-28 12:48:59.974612'),
(21, 'auth', '0012_alter_user_first_name_max_length', '2026-05-28 12:49:00.266971'),
(22, 'sessions', '0001_initial', '2026-05-28 12:49:00.674142'),
(23, 'app', '0005_remove_ressources_ue_ressources_ues', '2026-06-01 13:43:17.694714'),
(24, 'app', '0006_enseignants_user_alter_etudiant_photo', '2026-06-08 07:46:53.881733');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('is7auoy3llxptd7ultufyhh8sczi9j7o', '.eJxVjEEOwiAQRe_C2hAYBkhduvcMZGBAqgaS0q6Md9cmXej2v_f-SwTa1hq2kZcwszgLFKffLVJ65LYDvlO7dZl6W5c5yl2RBx3y2jk_L4f7d1Bp1G89-RKLQ1TWggNt0RcDBkvJhUBHR4msthxZkYEJEBhjZuUNafLMSrw_1k435g:1wXJJq:JzrXRiAkANOSK5DcSCEOWdbACoS5HtGNZznrU9HWO-c', '2026-06-24 13:50:10.618370'),
('jtrdropv6x8f06ehk5rn888lxzjtk554', '.eJxVjEEOwiAQRe_C2hCGwhRcuvcMZGBAqoYmpV0Z765NutDtf-_9lwi0rTVsPS9hYnEWIE6_W6T0yG0HfKd2m2Wa27pMUe6KPGiX15nz83K4fweVev3WxNZCZGcQHBoGyIXdgAaVVzhmHrQqqejRg0_oMGkCtDpGy5qiJRDvD81LN2s:1wV6nx:yGMu1YO-vaaMd_k6mSBaufZTZcmuF0YSp2c_Ey7DrPg', '2026-06-18 12:04:09.554662'),
('qdwocphbp692sxjp00ti7jt18iaf32hv', '.eJxVjEEOwiAQRe_C2hAoUAaX7j0DmYGpVA0kpV0Z765NutDtf-_9l4i4rSVunZc4Z3EWVpx-N8L04LqDfMd6azK1ui4zyV2RB-3y2jI_L4f7d1Cwl29tOMCEoyWFCiw47Uk7HsC7nAIM7MEF0hmDUaCV5kwwwsSGiZCdZfH-ANE7N-c:1wWVWQ:99EMOyE4OVs8GxkkUN6gN2JTtiJThFOoTjzSB9ekzS8', '2026-06-22 08:39:50.362609');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `app_enseignants`
--
ALTER TABLE `app_enseignants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Index pour la table `app_etudiant`
--
ALTER TABLE `app_etudiant`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_etudiant` (`numero_etudiant`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `app_examen`
--
ALTER TABLE `app_examen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_examen_ressource_id_6c51813f_fk_app_ressources_id` (`ressource_id`);

--
-- Index pour la table `app_note`
--
ALTER TABLE `app_note`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_note_examen_id_etudiant_id_7d676783_uniq` (`examen_id`,`etudiant_id`),
  ADD KEY `app_note_etudiant_id_0facffdb_fk_app_etudiant_id` (`etudiant_id`);

--
-- Index pour la table `app_ressources`
--
ALTER TABLE `app_ressources`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Index pour la table `app_ressources_ues`
--
ALTER TABLE `app_ressources_ues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_ressources_ues_ressources_id_ue_id_83183e7e_uniq` (`ressources_id`,`ue_id`),
  ADD KEY `app_ressources_ues_ue_id_6e2ed91c_fk_app_ue_id` (`ue_id`);

--
-- Index pour la table `app_ue`
--
ALTER TABLE `app_ue`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Index pour la table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Index pour la table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Index pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Index pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Index pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Index pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `app_enseignants`
--
ALTER TABLE `app_enseignants`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `app_etudiant`
--
ALTER TABLE `app_etudiant`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `app_examen`
--
ALTER TABLE `app_examen`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `app_note`
--
ALTER TABLE `app_note`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `app_ressources`
--
ALTER TABLE `app_ressources`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `app_ressources_ues`
--
ALTER TABLE `app_ressources_ues`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `app_ue`
--
ALTER TABLE `app_ue`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT pour la table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `app_enseignants`
--
ALTER TABLE `app_enseignants`
  ADD CONSTRAINT `app_enseignants_user_id_ce136b7b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `app_examen`
--
ALTER TABLE `app_examen`
  ADD CONSTRAINT `app_examen_ressource_id_6c51813f_fk_app_ressources_id` FOREIGN KEY (`ressource_id`) REFERENCES `app_ressources` (`id`);

--
-- Contraintes pour la table `app_note`
--
ALTER TABLE `app_note`
  ADD CONSTRAINT `app_note_etudiant_id_0facffdb_fk_app_etudiant_id` FOREIGN KEY (`etudiant_id`) REFERENCES `app_etudiant` (`id`),
  ADD CONSTRAINT `app_note_examen_id_32fe40b0_fk_app_examen_id` FOREIGN KEY (`examen_id`) REFERENCES `app_examen` (`id`);

--
-- Contraintes pour la table `app_ressources_ues`
--
ALTER TABLE `app_ressources_ues`
  ADD CONSTRAINT `app_ressources_ues_ressources_id_32f95c77_fk_app_ressources_id` FOREIGN KEY (`ressources_id`) REFERENCES `app_ressources` (`id`),
  ADD CONSTRAINT `app_ressources_ues_ue_id_6e2ed91c_fk_app_ue_id` FOREIGN KEY (`ue_id`) REFERENCES `app_ue` (`id`);

--
-- Contraintes pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Contraintes pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Contraintes pour la table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Contraintes pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : jeu. 11 juin 2026 à 15:28
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

--
-- Déchargement des données de la table `app_enseignants`
--

INSERT INTO `app_enseignants` (`id`, `nom`, `prenom`, `user_id`) VALUES
(3, 'Mura', 'Laurent', 3),
(4, 'Garinet', 'Jacques', 4);

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

--
-- Déchargement des données de la table `app_etudiant`
--

INSERT INTO `app_etudiant` (`id`, `numero_etudiant`, `nom`, `prenom`, `groupe`, `photo`, `email`) VALUES
(18, '100', 'Bauer', 'Alessandro', 'RT122', NULL, 'alessandro.bauer@uha.fr'),
(19, '101', 'Sicari', 'Samuel', 'RT122', NULL, 'samuel.sicari@uha.fr'),
(20, '102', 'Baur', 'Yacine', 'RT122', NULL, 'yacine.baur@uha.fr'),
(21, '103', 'Bennoune', 'Louis', 'RT122', NULL, 'louis.bennoune@uha.fr'),
(22, '104', 'Erb', 'Leo', 'RT122', NULL, 'leo.erb@uha.fr'),
(23, '105', 'Gasser', 'Bahadasht', 'RT122', NULL, 'bahadasht.gasser@uha.fr'),
(24, '106', 'Haj', 'Sinan', 'RT122', NULL, 'sinan.haj@uha.fr'),
(25, '107', 'Ho', 'Jordan', 'RT122', NULL, 'jordan.ho@uha.fr'),
(26, '108', 'Kientz', 'Alexandre', 'RT122', NULL, 'alexandre.kientz@uha.fr'),
(27, '109', 'Landauer', 'Jules', 'RT122', NULL, 'jules.landauer@uha.fr'),
(28, '110', 'Legoll', 'Benjamin', 'RT122', NULL, 'benjamin.legoll@uha.fr'),
(29, '111', 'Ozmen', 'Mehmet', 'RT122', NULL, 'mehmet.ozmen@uha.fr'),
(30, '112', 'Sasorith', 'Mael', 'RT122', NULL, 'mael.sasorith@uha.fr'),
(31, '113', 'Sebar', 'Adam', 'RT122', NULL, 'adam.sebar@uha.fr'),
(32, '114', 'Sy', 'Mohamedou', 'RT122', NULL, 'mohamedou.sy@uha.fr'),
(33, '150', 'HILT', 'Benoit', 'RT511', 'etudiants/s200_benoit.hilt.jpeg', 'hilt.benoit@gmail.com'),
(34, '300', 'Halter-Tisler', 'Louise', 'RT131', 'halter.jpg', 'test@uha.fr'),
(35, '500', 'test', 'test', 'rt120', 'halter.jpg', 'test2@uha.fr'),
(36, '1000', 'Toto', 'TATA', 'RT111', 'image.webp', 'toto.tata@mail.fr');

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

--
-- Déchargement des données de la table `app_examen`
--

INSERT INTO `app_examen` (`id`, `title`, `date`, `coefficient`, `ressource_id`) VALUES
(1, 'CM_et_TD_HILT', '2025-01-01', 2, 1),
(2, 'Moyenne1_TP_ECKLE', '2025-01-01', 1, 1),
(3, 'TP_Moyenne_ECKLE_GARINET', '2025-01-01', 1, 2),
(4, 'CM_LORENZ', '2025-01-01', 1, 2),
(5, 'Note_TP_ECKLE_GARINET', '2025-01-01', 1, 3),
(6, 'Moyenne_HILT', '2025-01-01', 1, 3),
(7, 'CM1_WOJDYLA', '2025-01-01', 1, 4),
(8, 'TP_Test_MURA_WOJDYLA', '2025-01-01', 1, 4),
(9, 'Test_Final_GARINET', '2025-01-01', 1, 5),
(10, 'Moyenne_BENDELE_GARINET', '2025-01-01', 1, 5),
(11, 'TD1_MURA', '2025-01-01', 0.5, 6),
(12, 'CM1_MURA', '2025-01-01', 1, 6),
(13, 'Validations et QCM commun - SW', '2025-01-01', 0.5, 6),
(14, 'Notes TP2 - LM/SW', '2025-01-01', 0.5, 6),
(15, 'Moyenne_BENNIS', '2025-01-01', 1, 7),
(16, 'TP_Test1_HENSEL', '2025-01-01', 2, 8),
(17, 'Examen1_HENSEL', '2025-01-01', 1, 8),
(18, 'CR_Linux_HENSEL', '2025-01-01', 1, 8),
(19, 'TP_LORENZ', '2025-01-01', 1, 8),
(20, 'Codage_ECKLE', '2025-01-01', 2, 9),
(21, 'QCM_ECKLE', '2025-01-01', 1, 9),
(22, 'Video_Interview_NGUYEN', '2025-01-01', 1, 10),
(23, 'Vocabulary_NGUYEN', '2025-01-01', 0.5, 10),
(24, 'Note1_MIDDLETON', '2025-01-01', 1, 10),
(25, 'Participation_NGUYEN', '2025-01-01', 1, 10),
(26, 'Written_NGUYEN', '2025-01-01', 1, 10),
(27, 'Note_DIETZE', '2025-01-01', 1, 11),
(28, 'Note_BARONNET', '2025-01-01', 1, 11),
(29, 'Note1_FDROUHIN', '2025-01-01', 1, 12),
(30, 'Soutenance_FDROUHIN', '2025-01-01', 1, 12),
(31, 'Rapport_FDROUHIN', '2025-01-01', 1, 12),
(32, 'Moyenne_WOJDYLA', '2025-01-01', 1, 13),
(33, 'CM1_PALLARES', '2025-01-01', 1, 14),
(34, 'Note_GASSMANN', '2025-01-01', 1, 15);

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

--
-- Déchargement des données de la table `app_note`
--

INSERT INTO `app_note` (`id`, `note`, `etudiant_id`, `examen_id`) VALUES
(517, 12.25, 32, 1),
(518, 12.62, 31, 1),
(519, 6.35, 30, 1),
(520, 18.87, 29, 1),
(521, 10.3, 28, 1),
(522, 19.88, 27, 1),
(523, 18.51, 26, 1),
(524, 12.92, 25, 1),
(525, 19.05, 24, 1),
(526, 6.48, 23, 1),
(527, 15.26, 22, 1),
(528, 6.87, 21, 1),
(529, 13.57, 20, 1),
(530, 12.25, 19, 1),
(531, 15.53, 18, 1),
(532, 5.91, 32, 2),
(533, 7.97, 31, 2),
(534, 17.11, 30, 2),
(535, 11.66, 29, 2),
(536, 16.95, 28, 2),
(537, 14.79, 27, 2),
(538, 18.09, 26, 2),
(539, 11.07, 25, 2),
(540, 11.09, 24, 2),
(541, 17.24, 23, 2),
(542, 17.91, 22, 2),
(543, 17.85, 21, 2),
(544, 15.5, 20, 2),
(545, 18.95, 19, 2),
(546, 13.27, 18, 2),
(547, 19.49, 32, 3),
(548, 7.63, 31, 3),
(549, 19.69, 30, 3),
(550, 10.54, 29, 3),
(551, 18.64, 28, 3),
(552, 11.6, 27, 3),
(553, 12.08, 26, 3),
(554, 5.57, 25, 3),
(555, 16.63, 24, 3),
(556, 16.43, 23, 3),
(557, 12.25, 22, 3),
(558, 6.99, 21, 3),
(559, 8.18, 20, 3),
(560, 14.95, 19, 3),
(561, 15.18, 18, 3),
(562, 11.06, 32, 4),
(563, 19.78, 31, 4),
(564, 15.71, 30, 4),
(565, 14.22, 29, 4),
(566, 18.97, 28, 4),
(567, 17.18, 27, 4),
(568, 9.01, 26, 4),
(569, 18.49, 25, 4),
(570, 15.42, 24, 4),
(571, 16.61, 23, 4),
(572, 16.82, 22, 4),
(573, 14.25, 21, 4),
(574, 15.82, 20, 4),
(575, 16.32, 19, 4),
(576, 14.15, 18, 4),
(577, 16.8, 32, 5),
(578, 6.53, 31, 5),
(579, 7.26, 30, 5),
(580, 11.72, 29, 5),
(581, 16.81, 28, 5),
(582, 13.89, 27, 5),
(583, 14.02, 26, 5),
(584, 8.44, 25, 5),
(585, 10.13, 24, 5),
(586, 5.34, 23, 5),
(587, 6.3, 22, 5),
(588, 10.49, 21, 5),
(589, 13.54, 20, 5),
(590, 16.24, 19, 5),
(591, 5.6, 18, 5),
(592, 19.25, 32, 6),
(593, 14.44, 31, 6),
(594, 9.46, 30, 6),
(595, 13.97, 29, 6),
(596, 6.49, 28, 6),
(597, 15.55, 27, 6),
(598, 8.25, 26, 6),
(599, 19.6, 25, 6),
(600, 8.25, 24, 6),
(601, 7.45, 23, 6),
(602, 7.49, 22, 6),
(603, 10.12, 21, 6),
(604, 8.12, 20, 6),
(605, 5.26, 19, 6),
(606, 11.92, 18, 6),
(607, 8.81, 32, 7),
(608, 18.31, 31, 7),
(609, 15.13, 30, 7),
(610, 15.72, 29, 7),
(611, 13.19, 28, 7),
(612, 13.78, 27, 7),
(613, 9.36, 26, 7),
(614, 15.43, 25, 7),
(615, 14.09, 24, 7),
(616, 19.14, 23, 7),
(617, 18.42, 22, 7),
(618, 14.7, 21, 7),
(619, 13.24, 20, 7),
(620, 17.09, 19, 7),
(621, 10.72, 18, 7),
(622, 12.34, 32, 8),
(623, 9.56, 31, 8),
(624, 5.77, 30, 8),
(625, 10.18, 29, 8),
(626, 13.58, 28, 8),
(627, 17.35, 27, 8),
(628, 11.02, 26, 8),
(629, 13.04, 25, 8),
(630, 12.12, 24, 8),
(631, 16.52, 23, 8),
(632, 11.21, 22, 8),
(633, 16.5, 21, 8),
(634, 13.87, 20, 8),
(635, 14.84, 19, 8),
(636, 12.62, 18, 8),
(637, 13.55, 32, 9),
(638, 9.89, 31, 9),
(639, 18.8, 30, 9),
(640, 14.34, 29, 9),
(641, 10.28, 28, 9),
(642, 18.37, 27, 9),
(643, 11.04, 26, 9),
(644, 10.06, 25, 9),
(645, 12.21, 24, 9),
(646, 10.84, 23, 9),
(647, 12.58, 22, 9),
(648, 10.38, 21, 9),
(649, 9.17, 20, 9),
(650, 9.72, 19, 9),
(651, 16.1, 18, 9),
(652, 16.31, 32, 10),
(653, 13.27, 31, 10),
(654, 12.4, 30, 10),
(655, 17.2, 29, 10),
(656, 13.78, 28, 10),
(657, 12.33, 27, 10),
(658, 15.29, 26, 10),
(659, 19.48, 25, 10),
(660, 16.51, 24, 10),
(661, 19.14, 23, 10),
(662, 11.14, 22, 10),
(663, 8.29, 21, 10),
(664, 18.02, 20, 10),
(665, 15.22, 19, 10),
(666, 17.05, 18, 10),
(667, 19.6, 32, 11),
(668, 11.83, 31, 11),
(669, 10.37, 30, 11),
(670, 11.37, 29, 11),
(671, 5.72, 28, 11),
(672, 19.51, 27, 11),
(673, 15.37, 26, 11),
(674, 13.31, 25, 11),
(675, 15.43, 24, 11),
(676, 17.25, 23, 11),
(677, 19.93, 22, 11),
(678, 12.92, 21, 11),
(679, 14.79, 20, 11),
(680, 15.21, 19, 11),
(681, 11.67, 18, 11),
(682, 7.74, 32, 12),
(683, 13.66, 31, 12),
(684, 10.1, 30, 12),
(685, 19.52, 29, 12),
(686, 17.28, 28, 12),
(687, 7.83, 27, 12),
(688, 12.32, 26, 12),
(689, 18.13, 25, 12),
(690, 18.7, 24, 12),
(691, 19.08, 23, 12),
(692, 19.31, 22, 12),
(693, 19.3, 21, 12),
(694, 18.58, 20, 12),
(695, 14.99, 19, 12),
(696, 14.24, 18, 12),
(697, 6.2, 32, 13),
(698, 13.29, 31, 13),
(699, 12.84, 30, 13),
(700, 19.35, 29, 13),
(701, 8.23, 28, 13),
(702, 8.08, 27, 13),
(703, 10.72, 26, 13),
(704, 9.36, 25, 13),
(705, 9.65, 24, 13),
(706, 15.17, 23, 13),
(707, 11.89, 22, 13),
(708, 8.95, 21, 13),
(709, 19.09, 20, 13),
(710, 18.58, 19, 13),
(711, 15.64, 18, 13),
(712, 17.45, 32, 14),
(713, 5.33, 31, 14),
(714, 14.32, 30, 14),
(715, 5.61, 29, 14),
(716, 10.1, 28, 14),
(717, 13.66, 27, 14),
(718, 18, 26, 14),
(719, 14.04, 25, 14),
(720, 11.18, 24, 14),
(721, 8.77, 23, 14),
(722, 5.31, 22, 14),
(723, 10.26, 21, 14),
(724, 15.36, 20, 14),
(725, 11.01, 19, 14),
(726, 18.96, 18, 14),
(727, 11.78, 32, 15),
(728, 12.03, 31, 15),
(729, 19.79, 30, 15),
(730, 12.85, 29, 15),
(731, 14.9, 28, 15),
(732, 15.96, 27, 15),
(733, 15.07, 26, 15),
(734, 7.49, 25, 15),
(735, 17.24, 24, 15),
(736, 13.72, 23, 15),
(737, 11.86, 22, 15),
(738, 13.18, 21, 15),
(739, 10.29, 20, 15),
(740, 6.92, 19, 15),
(741, 13.71, 18, 15),
(742, 12.82, 32, 16),
(743, 17.96, 31, 16),
(744, 16.33, 30, 16),
(745, 7.8, 29, 16),
(746, 14.98, 28, 16),
(747, 16.51, 27, 16),
(748, 17.62, 26, 16),
(749, 18.56, 25, 16),
(750, 19.93, 24, 16),
(751, 8.99, 23, 16),
(752, 10.17, 22, 16),
(753, 18.86, 21, 16),
(754, 13.78, 20, 16),
(755, 7.31, 19, 16),
(756, 5.24, 18, 16),
(757, 14.27, 32, 17),
(758, 5.61, 31, 17),
(759, 10.26, 30, 17),
(760, 14.45, 29, 17),
(761, 6.47, 28, 17),
(762, 13.99, 27, 17),
(763, 15.54, 26, 17),
(764, 15.74, 25, 17),
(765, 12.1, 24, 17),
(766, 8.25, 23, 17),
(767, 14.96, 22, 17),
(768, 15.05, 21, 17),
(769, 10.37, 20, 17),
(770, 16.68, 19, 17),
(771, 17.32, 18, 17),
(772, 16.56, 32, 18),
(773, 10.82, 31, 18),
(774, 14.42, 30, 18),
(775, 19.64, 29, 18),
(776, 19.94, 28, 18),
(777, 5.79, 27, 18),
(778, 9.11, 26, 18),
(779, 8.2, 25, 18),
(780, 8.68, 24, 18),
(781, 13.8, 23, 18),
(782, 7.97, 22, 18),
(783, 8.43, 21, 18),
(784, 13.23, 20, 18),
(785, 5.85, 19, 18),
(786, 14.57, 18, 18),
(787, 5.31, 32, 19),
(788, 7.83, 31, 19),
(789, 18.24, 30, 19),
(790, 17.68, 29, 19),
(791, 13.7, 28, 19),
(792, 10.45, 27, 19),
(793, 6.16, 26, 19),
(794, 9.43, 25, 19),
(795, 8.69, 24, 19),
(796, 10.17, 23, 19),
(797, 19.76, 22, 19),
(798, 18.29, 21, 19),
(799, 12.18, 20, 19),
(800, 16.01, 19, 19),
(801, 8.53, 18, 19),
(802, 19.63, 32, 20),
(803, 7.57, 31, 20),
(804, 18.94, 30, 20),
(805, 6.98, 29, 20),
(806, 18.09, 28, 20),
(807, 19.52, 27, 20),
(808, 8.34, 26, 20),
(809, 8.12, 25, 20),
(810, 10.59, 24, 20),
(811, 8.58, 23, 20),
(812, 6.14, 22, 20),
(813, 14.96, 21, 20),
(814, 6.38, 20, 20),
(815, 12, 19, 20),
(816, 5.86, 18, 20),
(817, 18.31, 32, 21),
(818, 8.98, 31, 21),
(819, 14.95, 30, 21),
(820, 12.83, 29, 21),
(821, 14.3, 28, 21),
(822, 12.99, 27, 21),
(823, 17.07, 26, 21),
(824, 11.39, 25, 21),
(825, 15.74, 24, 21),
(826, 9.51, 23, 21),
(827, 10.32, 22, 21),
(828, 18.07, 21, 21),
(829, 9.4, 20, 21),
(830, 17.78, 19, 21),
(831, 10.7, 18, 21),
(832, 10.17, 32, 22),
(833, 13.75, 31, 22),
(834, 18.23, 30, 22),
(835, 14.88, 29, 22),
(836, 14.75, 28, 22),
(837, 9.09, 27, 22),
(838, 11.18, 26, 22),
(839, 8.66, 25, 22),
(840, 19.76, 24, 22),
(841, 7.79, 23, 22),
(842, 19.71, 22, 22),
(843, 10.15, 21, 22),
(844, 16.61, 20, 22),
(845, 17.63, 19, 22),
(846, 18.32, 18, 22),
(847, 18.68, 32, 23),
(848, 18.47, 31, 23),
(849, 16.28, 30, 23),
(850, 6, 29, 23),
(851, 6.17, 28, 23),
(852, 7.83, 27, 23),
(853, 15.66, 26, 23),
(854, 19.82, 25, 23),
(855, 17.12, 24, 23),
(856, 6.13, 23, 23),
(857, 19.28, 22, 23),
(858, 13.03, 21, 23),
(859, 17.28, 20, 23),
(860, 12.33, 19, 23),
(861, 19.79, 18, 23),
(862, 11.97, 32, 24),
(863, 10.5, 31, 24),
(864, 11.57, 30, 24),
(865, 6.33, 29, 24),
(866, 6.98, 28, 24),
(867, 10.88, 27, 24),
(868, 13.46, 26, 24),
(869, 14.67, 25, 24),
(870, 12.95, 24, 24),
(871, 15.77, 23, 24),
(872, 5, 22, 24),
(873, 17.69, 21, 24),
(874, 8.42, 20, 24),
(875, 14.06, 19, 24),
(876, 10.03, 18, 24),
(877, 17.98, 32, 25),
(878, 9.82, 31, 25),
(879, 5.16, 30, 25),
(880, 6.34, 29, 25),
(881, 11.21, 28, 25),
(882, 17.01, 27, 25),
(883, 16.44, 26, 25),
(884, 11.18, 25, 25),
(885, 16.59, 24, 25),
(886, 14.39, 23, 25),
(887, 17.2, 22, 25),
(888, 7.82, 21, 25),
(889, 12.51, 20, 25),
(890, 19.08, 19, 25),
(891, 7.86, 18, 25),
(892, 7.09, 32, 26),
(893, 6.84, 31, 26),
(894, 7.92, 30, 26),
(895, 14.09, 29, 26),
(896, 11.7, 28, 26),
(897, 11.21, 27, 26),
(898, 15.94, 26, 26),
(899, 11.09, 25, 26),
(900, 17.62, 24, 26),
(901, 19.84, 23, 26),
(902, 11.32, 22, 26),
(903, 7.11, 21, 26),
(904, 11.56, 20, 26),
(905, 16.5, 19, 26),
(906, 12.82, 18, 26),
(907, 9.59, 32, 27),
(908, 19.5, 31, 27),
(909, 18.74, 30, 27),
(910, 15.19, 29, 27),
(911, 14.73, 28, 27),
(912, 8.07, 27, 27),
(913, 6.17, 26, 27),
(914, 16.63, 25, 27),
(915, 14.64, 24, 27),
(916, 18.31, 23, 27),
(917, 12.65, 22, 27),
(918, 18.3, 21, 27),
(919, 18.56, 20, 27),
(920, 17.91, 19, 27),
(921, 13.88, 18, 27),
(922, 10.66, 32, 28),
(923, 6.64, 31, 28),
(924, 11.24, 30, 28),
(925, 16.27, 29, 28),
(926, 12.61, 28, 28),
(927, 9.27, 27, 28),
(928, 18.5, 26, 28),
(929, 14.68, 25, 28),
(930, 12.91, 24, 28),
(931, 15.51, 23, 28),
(932, 18.83, 22, 28),
(933, 12.63, 21, 28),
(934, 16.63, 20, 28),
(935, 10.27, 19, 28),
(936, 11.48, 18, 28),
(937, 6.58, 32, 29),
(938, 8.45, 31, 29),
(939, 17.5, 30, 29),
(940, 12.17, 29, 29),
(941, 18.32, 28, 29),
(942, 5.12, 27, 29),
(943, 10.64, 26, 29),
(944, 17.81, 25, 29),
(945, 7.16, 24, 29),
(946, 7.37, 23, 29),
(947, 10.35, 22, 29),
(948, 9.66, 21, 29),
(949, 12.23, 20, 29),
(950, 12.19, 19, 29),
(951, 19.27, 18, 29),
(952, 9.78, 32, 30),
(953, 16.08, 31, 30),
(954, 16.05, 30, 30),
(955, 12.03, 29, 30),
(956, 6.98, 28, 30),
(957, 8.82, 27, 30),
(958, 18.18, 26, 30),
(959, 14.41, 25, 30),
(960, 12.53, 24, 30),
(961, 14.43, 23, 30),
(962, 14.55, 22, 30),
(963, 9.46, 21, 30),
(964, 13.66, 20, 30),
(965, 19.91, 19, 30),
(966, 8.57, 18, 30),
(967, 8.12, 32, 31),
(968, 9.9, 31, 31),
(969, 5.13, 30, 31),
(970, 5.95, 29, 31),
(971, 9.38, 28, 31),
(972, 9.05, 27, 31),
(973, 12.08, 26, 31),
(974, 13.27, 25, 31),
(975, 10.1, 24, 31),
(976, 5.72, 23, 31),
(977, 8.26, 22, 31),
(978, 19.17, 21, 31),
(979, 6.06, 20, 31),
(980, 12.79, 19, 31),
(981, 10.79, 18, 31),
(982, 10.57, 32, 32),
(983, 15.48, 31, 32),
(984, 10.69, 30, 32),
(985, 17.01, 29, 32),
(986, 17.96, 28, 32),
(987, 18.8, 27, 32),
(988, 5.1, 26, 32),
(989, 9.1, 25, 32),
(990, 10.19, 24, 32),
(991, 18.65, 23, 32),
(992, 12.69, 22, 32),
(993, 17.48, 21, 32),
(994, 14.35, 20, 32),
(995, 14.29, 19, 32),
(996, 8.43, 18, 32),
(997, 9.26, 32, 33),
(998, 16.03, 31, 33),
(999, 17.36, 30, 33),
(1000, 18.7, 29, 33),
(1001, 6.42, 28, 33),
(1002, 15.99, 27, 33),
(1003, 10.72, 26, 33),
(1004, 15.6, 25, 33),
(1005, 10.85, 24, 33),
(1006, 17.47, 23, 33),
(1007, 19.78, 22, 33),
(1008, 11.51, 21, 33),
(1009, 8.21, 20, 33),
(1010, 16.53, 19, 33),
(1011, 8, 18, 33),
(1012, 15.4, 32, 34),
(1013, 18.03, 31, 34),
(1014, 8.93, 30, 34),
(1015, 15.56, 29, 34),
(1016, 16, 28, 34),
(1017, 13.33, 27, 34),
(1018, 13.66, 26, 34),
(1019, 8.29, 25, 34),
(1020, 10.47, 24, 34),
(1021, 7.48, 23, 34),
(1022, 16.01, 22, 34),
(1023, 7.61, 21, 34),
(1024, 15.01, 20, 34),
(1025, 17.2, 19, 34),
(1026, 5.99, 18, 34);

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

--
-- Déchargement des données de la table `app_ressources`
--

INSERT INTO `app_ressources` (`id`, `code`, `nom`, `description`, `coefficient`) VALUES
(1, 'R1.01', 'Initiation aux réseaux locaux', '', 20),
(2, 'R1.02', 'Principes et architecture des réseaux', '', 0),
(3, 'R1.03', 'Réseaux locaux et équipements actifs', '', 0),
(4, 'R1.04', 'Fondamentaux des systèmes électroniques', '', 0),
(5, 'R1.05', 'Supports de transmission pour les réseaux locaux', '', 0),
(6, 'R1.06', 'Architecture des systèmes numériques et informatiques', '', 0),
(7, 'R1.07', 'Fondamentaux de la programmation', '', 0),
(8, 'R1.08', 'Bases des systèmes d\'exploitation', '', 0),
(9, 'R1.09', 'Introduction aux technologies Web', '', 0),
(10, 'R1.10', 'Anglais de communication et initiation au vocabulaire technique', '', 0),
(11, 'R1.11', 'Expression-Culture-Communication Professionnelles 1', '', 0),
(12, 'R1.12', 'PPP : Connaître son champ d\'activité', '', 0),
(13, 'R1.13', 'Mathématiques du signal', '', 0),
(14, 'R1.14', 'Mathématiques des transmissions', '', 0),
(15, 'R1.15', 'Gestion de projet', '', 0),
(16, '4', 'test', 'tet', 4);

-- --------------------------------------------------------

--
-- Structure de la table `app_ressources_ues`
--

CREATE TABLE `app_ressources_ues` (
  `id` bigint NOT NULL,
  `ressources_id` bigint NOT NULL,
  `ue_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `app_ressources_ues`
--

INSERT INTO `app_ressources_ues` (`id`, `ressources_id`, `ue_id`) VALUES
(1, 1, 1),
(12, 1, 2),
(22, 1, 3),
(2, 2, 1),
(3, 3, 1),
(13, 3, 2),
(23, 3, 3),
(4, 4, 1),
(14, 4, 2),
(15, 5, 2),
(5, 6, 1),
(24, 6, 3),
(25, 7, 3),
(6, 8, 1),
(26, 8, 3),
(27, 9, 3),
(7, 10, 1),
(16, 10, 2),
(28, 10, 3),
(8, 11, 1),
(17, 11, 2),
(29, 11, 3),
(9, 12, 1),
(18, 12, 2),
(30, 12, 3),
(10, 13, 1),
(19, 13, 2),
(11, 14, 1),
(20, 14, 2),
(21, 15, 2),
(31, 15, 3),
(32, 16, 1);

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

--
-- Déchargement des données de la table `app_ue`
--

INSERT INTO `app_ue` (`id`, `code`, `nom`, `semestre`, `credits_ects`) VALUES
(1, 'UE1.1', 'Administrer les réseaux et l\'Internet', 1, 11),
(2, 'UE1.2', 'Connecter les entreprises et les usagers', 1, 9),
(3, 'UE1.3', 'Créer des outils et applications informatiques pour les R&T', 1, 10),
(4, '5', 'test', 2, 20);

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `app_etudiant`
--
ALTER TABLE `app_etudiant`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `app_examen`
--
ALTER TABLE `app_examen`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT pour la table `app_note`
--
ALTER TABLE `app_note`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1027;

--
-- AUTO_INCREMENT pour la table `app_ressources`
--
ALTER TABLE `app_ressources`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `app_ressources_ues`
--
ALTER TABLE `app_ressources_ues`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `app_ue`
--
ALTER TABLE `app_ue`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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

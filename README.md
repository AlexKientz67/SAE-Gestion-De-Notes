# SAE Albert - Système de Gestion Académique

## 📋 Description

SAE Albert est une application web Django permettant de gérer les données académiques d'une institution éducative. Elle permet de gérer les enseignants, les étudiants, les unités d'enseignement (UE), les ressources et les examens.

## 🎯 Fonctionnalités

- **Gestion des enseignants** : Ajouter et gérer les enseignants
- **Gestion des étudiants** : Ajouter des étudiants avec photos et informations
- **Gestion des UE** : Créer et gérer les unités d'enseignement par semestre
- **Gestion des ressources** : Ajouter des ressources liées aux UE avec coefficients
- **Gestion des examens** : Créer des examens avec dates et coefficients
- **Authentification** : Système de connexion pour enseignants et utilisateurs
- **Notes** : Suivi des notes des étudiants

## 🏗️ Architecture

### Structure du projet

```
saeproject/
├── app/                          # Application principale
│   ├── models.py                 # Modèles de base de données
│   ├── views.py                  # Vues et logique métier
│   ├── forms.py                  # Formulaires Django
│   ├── urls.py                   # Routes de l'application
│   ├── migrations/               # Migrations de base de données
│   ├── templates/app/            # Templates HTML
│   │   ├── login.html
│   │   ├── login_enseignant.html
│   │   ├── form.html
│   │   ├── enseignant.html
│   │   └── notes.html
│   └── static/app/               # Fichiers statiques (CSS, JS, images)
├── saeproject/                   # Configuration Django
│   ├── settings.py
│   ├── urls.py
│   ├── asgi.py
│   └── wsgi.py
├── db.sqlite3                    # Base de données
└── manage.py                     # Utilitaire de ligne de commande Django
```

### Modèles de données

- **Enseignants** : Nom, Prénom
- **Étudiant** : Numéro d'étudiant, Nom, Prénom, Groupe, Photo, Email
- **UE** : Code, Nom, Semestre, Crédits ECTS
- **Ressources** : Code, Nom, Description, Coefficient, Liée à une UE
- **Examen** : Titre, Date, Coefficient, Lié à une Ressource

## 🚀 Démarrage

### Prérequis

- Python 3.8+
- pip (gestionnaire de paquets Python)
- Django 3.0+

### Installation

1. **Cloner le projet**
   ```bash
   cd /Users/alexandre/projet/sae-albert
   ```

2. **Créer un environnement virtuel** (optionnel mais recommandé)
   ```bash
   python -m venv venv
   source venv/bin/activate  # Sur macOS/Linux
   ```

3. **Installer les dépendances**
   ```bash
   pip install django pillow
   ```

4. **Appliquer les migrations**
   ```bash
   python manage.py migrate
   ```

5. **Créer un superutilisateur** (optionnel)
   ```bash
   python manage.py createsuperuser
   ```

6. **Lancer le serveur de développement**
   ```bash
   python manage.py runserver
   ```

   L'application sera accessible à `http://127.0.0.1:8000/`

## 📝 Utilisation

### Accès à l'application

- **Page d'accueil** : `/` - Page de connexion
- **Connexion enseignant** : `/app/login_enseignant` - Interface enseignant
- **Ajout d'étudiant** : `/app/ajout_etudiant` - Formulaire d'ajout d'étudiant
- **Ajout d'enseignant** : `/app/ajout_enseignant` - Formulaire d'ajout d'enseignant
- **Gestion des UE** : `/app/ajout_ue` - Ajouter une unité d'enseignement
- **Gestion des ressources** : `/app/ajout_ressource` - Ajouter une ressource
- **Admin Django** : `/admin` - Interface d'administration (superutilisateur uniquement)

## 🛠️ Développement

### Créer une nouvelle migration
```bash
python manage.py makemigrations
python manage.py migrate
```

### Accéder à l'interface d'administration Django
```bash
python manage.py runserver
```
Puis naviguer vers `http://127.0.0.1:8000/admin`

## 📂 Fichiers importants

- [models.py](saeproject/app/models.py) - Définition des modèles de données
- [views.py](saeproject/app/views.py) - Logique des vues
- [urls.py](saeproject/app/urls.py) - Configuration des routes
- [forms.py](saeproject/app/forms.py) - Formulaires Django
- [settings.py](saeproject/saeproject/settings.py) - Configuration du projet

## 📦 Dépendances

- Django - Framework web Python
- Pillow - Traitement d'images (pour les photos d'étudiants)


**Dernière mise à jour** : 29 mai 2026

# 📚 DOCUMENTATION DÉTAILLÉE - GestNotes (SAE-Albert)

**Table des matières complète:**
- [1. Vue d'ensemble](#1-vue-densemble-complet)
- [2. Architecture et stack](#2-architecture-et-stack-complet)
- [3. Schéma de base de données](#3-schéma-de-base-de-données-détaillé)
- [4. Modèles de données](#4-modèles-de-données-détaillé)
- [5. Formulaires](#5-formulaires-détaillé)
- [6. Views - Logique métier](#6-views--logique-métier-détaillé)
- [7. Templates](#7-templates-détaillé)
- [8. Authentification et sécurité](#8-authentification-et-sécurité-détaillé)
- [9. Cas d'usage complets](#9-cas-dusage-complets-avec-captures)
- [10. Gestion des erreurs](#10-gestion-des-erreurs-détaillée)
- [11. Guide de développement](#11-guide-de-développement)
- [12. Performance et optimisation](#12-performance-et-optimisation)

---

# 1. Vue d'ensemble complet

## Objectifs de l'application

GestNotes est une **plateforme de gestion académique** conçue pour les institutions éducatives (SAE-Albert). Elle facilite:

### Pour les enseignants:
- **Gestion des effectifs** - Ajouter, modifier, supprimer des étudiants
- **Gestion académique** - Créer des UE, ressources, et examens
- **Saisie des notes** - Entrée manuelle ou import en masse via Excel
- **Génération de rapports** - Exportation en PDF des relevés de notes
- **Authentification sécurisée** - Connexion avec identifiant/mot de passe

### Pour les étudiants:
- **Consultation des notes** - Voir leurs notes organisées par matière
- **Accès rapide** - Se connecter avec son numéro étudiant
- **Export personnalisé** - Télécharger son relevé en PDF

## Domaine d'utilisation

**Public cible:**
- Enseignants (accès complet au dashboard)
- Étudiants (accès lecture seule à leurs notes)
- Administrateurs (gestion BD via Django admin)

**Taille:** Petit à moyen établissement (100-1000 étudiants)

## Flux utilisateur principal

```
┌─────────────────────────────────────────────────────────┐
│           PORTAIL D'ACCUEIL (/)                         │
│  "Connexion Enseignant" ou "Connexion Étudiant"        │
└─────────────┬───────────────────────────────────────────┘
              │
    ┌─────────┴──────────┐
    │                    │
    ▼                    ▼
┌──────────────┐    ┌─────────────────────┐
│  ÉTUDIANT    │    │   ENSEIGNANT        │
│  Lire notes  │    │   Gérer tout        │
│  (RO)        │    │   (CRUD)            │
└──────────────┘    └──────────┬──────────┘
                               │
                    ┌──────────┴─────────┐
                    │                    │
                    ▼                    ▼
              ┌─────────────┐      ┌──────────────┐
              │ Dashboard   │      │ Formulaires  │
              │ (Actions)   │      │ (CRUD)       │
              └─────────────┘      └──────────────┘
```

---

# 2. Architecture et stack complet

## Structure des répertoires

```
sae-albert/
│
├── saeproject/                    # Dossier de configuration Django
│   ├── manage.py                  # Utilitaire de gestion Django
│   ├── db.sqlite3                 # Base de données SQLite
│   │
│   ├── saeproject/                # Configuration Django
│   │   ├── __init__.py
│   │   ├── settings.py            # Configuration (BD, apps, middlewares)
│   │   │                          # - INSTALLED_APPS
│   │   │                          # - DATABASES
│   │   │                          # - SECRET_KEY
│   │   │                          # - DEBUG = True/False
│   │   ├── urls.py                # URLs globales
│   │   │                          # - path('app/', include('app.urls'))
│   │   ├── wsgi.py                # Interface serveur (production)
│   │   └── asgi.py                # Interface async (production)
│   │
│   ├── app/                       # APPLICATION PRINCIPALE
│   │   ├── migrations/            # Historique des changements BD
│   │   │   ├── __init__.py
│   │   │   ├── 0001_initial.py    # Migration initiale
│   │   │   ├── 0002_*.py
│   │   │   └── ...
│   │   │
│   │   ├── models.py              # 🔴 MODÈLES DE DONNÉES
│   │   │                          # - Enseignants
│   │   │                          # - UE
│   │   │                          # - Ressources
│   │   │                          # - Etudiant
│   │   │                          # - Examen
│   │   │                          # - Note
│   │   │
│   │   ├── views.py               # 🟢 LOGIQUE MÉTIER (18 fonctions)
│   │   │                          # - Login (étudiant/enseignant)
│   │   │                          # - Profils
│   │   │                          # - Imports Excel
│   │   │                          # - Exports PDF
│   │   │                          # - CRUD complet
│   │   │
│   │   ├── urls.py                # 🔵 ROUTAGE (21 endpoints)
│   │   │                          # - path('', ...)
│   │   │                          # - path('enseignant/', ...)
│   │   │                          # - path('ajout/', ...)
│   │   │
│   │   ├── forms.py               # 🟡 FORMULAIRES (10 formulaires)
│   │   │                          # - ImportNotesForm
│   │   │                          # - LoginEnseignantForm
│   │   │                          # - EtudiantForm
│   │   │                          # - etc.
│   │   │
│   │   ├── admin.py               # Django admin interface
│   │   ├── apps.py                # Configuration de l'app
│   │   ├── tests.py               # Tests unitaires
│   │   │
│   │   ├── static/                # 📦 FICHIERS STATIQUES
│   │   │   ├── myfirstapp/
│   │   │   │   └── style.css      # Styles CSS
│   │   │   ├── modele_notes.xlsx        # Fichier modèle (Excel)
│   │   │   └── modele_etudiants.xlsx    # Fichier modèle (Excel)
│   │   │
│   │   └── templates/app/         # 📄 TEMPLATES HTML
│   │       ├── base.html          # Template de base (héritage)
│   │       ├── form.html          # Formulaire générique
│   │       ├── login.html         # Connexion étudiant
│   │       ├── login_enseignant.html
│   │       ├── notes.html         # Relevé étudiant
│   │       ├── enseignant.html    # Dashboard prof
│   │       ├── import_notes.html
│   │       └── import_etudiants.html
│
├── IMPORT_NOTES.md                # Documentation importation
├── README.md                      # Fichier principal
├── requirements.txt               # Dépendances Python
└── DOCUMENTATION.md               # Documentation simple
```

## Stack technique détaillé

### Backend
```python
Django 4.2              # Web framework Python
├── ORM                 # Object-Relational Mapping
├── Auth system         # Gestion utilisateurs/permissions
├── Admin interface     # Interface d'administration
└── Messages framework  # Notifications utilisateur

Python 3.8+
├── openpyxl 3.1.5      # Lecture/écriture Excel
├── reportlab 4.0.9     # Génération PDF
├── Pillow 10.0.0       # Traitement d'images
└── pymysql 1.2.0       # Driver MySQL (optionnel)
```

### Frontend
```html
HTML5              # Structure
├── Sémantique correcte
├── CSRF tokens
└── Accessibilité

CSS                # Style
├── Responsive design
├── Formulaires stylisés
└── Messages d'erreur visibles

JavaScript        # Interactivité (minimal)
└── Validation client (optionnel)
```

### Base de données
```
SQLite 3           # Développement/test
├── Stockage fichier (db.sqlite3)
├── Performant pour < 100K lignes
├── Pas de configuration serveur
└── Idéal pour prototypage

MySQL (optionnel)  # Production
├── Scalable
├── Multi-utilisateurs
├── Performances élevées
└── Configuration via settings.py
```

---

# 3. Schéma de base de données détaillé

## Diagramme entité-association (ER)

```
┌──────────────────┐
│      User        │
│  (Django built-in)
├──────────────────┤
│ id (PK)          │
│ username (UNIQUE)│
│ password (hashed)│
│ email            │
│ is_active        │
└────────────┬─────┘
             │
             │ OneToOne
             │
             ▼
┌──────────────────────────┐
│     Enseignants          │
├──────────────────────────┤
│ id (PK)                  │
│ user_id (FK OneToOne)    │
│ nom                      │
│ prenom                   │
└──────────────────────────┘


┌──────────────────────────────────────┐
│            UE                        │
│  (Unité d'Enseignement)              │
├──────────────────────────────────────┤
│ id (PK)                              │
│ code (UNIQUE) - "MTH101"             │
│ nom - "Mathématiques"                │
│ semestre (INT) - 1, 2, 3, 4          │
│ credits_ects (INT) - 3, 5, 6         │
└────────────────────┬─────────────────┘
                     │
                     │ ManyToMany
                     │
                     ▼
┌──────────────────────────────────────┐
│        Ressources                    │
│  (Matière/Cours)                     │
├──────────────────────────────────────┤
│ id (PK)                              │
│ code (UNIQUE) - "MTH-R1"             │
│ nom - "Calcul différentiel"          │
│ description                          │
│ coefficient (FLOAT) - 1.0, 1.5, 2.0  │
│ ues (ManyToMany) -> UE               │
└─────────────────┬──────────────────┘
                  │
                  │ ForeignKey
                  │
                  ▼
┌──────────────────────────────────────┐
│          Examen                      │
│  (Contrôle/Test)                     │
├──────────────────────────────────────┤
│ id (PK)                              │
│ title - "Contrôle 1"                 │
│ date (DATE)                          │
│ coefficient (FLOAT)                  │
│ ressource_id (FK)                    │
└──────────────┬───────────────────────┘
               │
               │ ForeignKey
               │
               ▼
           ┌─────────────────────┐
           │      Note           │
           │  (Score)            │
           ├─────────────────────┤
           │ id (PK)             │
           │ examen_id (FK)      │
           │ etudiant_id (FK)    │
           │ note (FLOAT/20)     │
           │ UNIQUE(examen, etud)│
           └─────────────────────┘
               │
               │ ForeignKey
               │
               ▼
┌──────────────────────────────────────┐
│        Etudiant                      │
│  (Apprenant)                         │
├──────────────────────────────────────┤
│ id (PK)                              │
│ numero_etudiant (UNIQUE) - "E20001"  │
│ nom - "Dupont"                       │
│ prenom - "Valentin"                  │
│ groupe - "G1"                        │
│ photo (IMAGE) - optional             │
│ email (UNIQUE)                       │
└──────────────────────────────────────┘
```

## Représentation tabulaire

### Table: auth_user
```
┌────┬──────────────┬─────────────────────────────┬─────────────┐
│ id │ username     │ password                    │ is_active   │
├────┼──────────────┼─────────────────────────────┼─────────────┤
│ 1  │ dupont.prof  │ pbkdf2_sha256$...           │ 1           │
│ 2  │ martin.prof  │ pbkdf2_sha256$...           │ 1           │
└────┴──────────────┴─────────────────────────────┴─────────────┘
```

### Table: app_enseignants
```
┌────┬────────┬──────────┬─────────────┐
│ id │ nom    │ prenom   │ user_id     │
├────┼────────┼──────────┼─────────────┤
│ 1  │ Dupont │ Jean     │ 1           │
│ 2  │ Martin │ Sophie   │ 2           │
└────┴────────┴──────────┴─────────────┘
```

### Table: app_ue
```
┌────┬──────────┬──────────────────────┬──────────┬──────────────┐
│ id │ code     │ nom                  │ semestre │ credits_ects │
├────┼──────────┼──────────────────────┼──────────┼──────────────┤
│ 1  │ MTH101   │ Mathématiques        │ 1        │ 5            │
│ 2  │ PHY102   │ Physique             │ 1        │ 6            │
│ 3  │ INFO103  │ Informatique         │ 1        │ 4            │
└────┴──────────┴──────────────────────┴──────────┴──────────────┘
```

### Table: app_ressources
```
┌────┬────────────┬────────────────────┬──────────────┐
│ id │ code       │ nom                │ coefficient  │
├────┼────────────┼────────────────────┼──────────────┤
│ 1  │ MTH-R1     │ Calcul             │ 1.5          │
│ 2  │ MTH-R2     │ Algèbre            │ 1.0          │
│ 3  │ PHY-R1     │ Mécanique          │ 2.0          │
└────┴────────────┴────────────────────┴──────────────┘
```

### Table: app_examen
```
┌────┬──────────────┬────────────┬──────────────┬──────────────┐
│ id │ title        │ date       │ coefficient  │ ressource_id │
├────┼──────────────┼────────────┼──────────────┼──────────────┤
│ 1  │ Contrôle 1   │ 2025-02-15 │ 1.0          │ 1            │
│ 2  │ Examen final │ 2025-05-20 │ 2.0          │ 1            │
│ 3  │ Contrôle 2   │ 2025-03-10 │ 1.0          │ 2            │
└────┴──────────────┴────────────┴──────────────┴──────────────┘
```

### Table: app_etudiant
```
┌────┬──────────────────┬────────┬─────────┬────────┐
│ id │ numero_etudiant  │ nom    │ prenom  │ groupe │
├────┼──────────────────┼────────┼─────────┼────────┤
│ 1  │ E20001           │ Dupont │ Valentin│ G1     │
│ 2  │ E20002           │ Martin │ Claire  │ G1     │
│ 3  │ E20003           │ Bernard│ Thomas  │ G2     │
└────┴──────────────────┴────────┴─────────┴────────┘
```

### Table: app_note
```
┌────┬───────────┬─────────────┬──────┐
│ id │ examen_id │ etudiant_id │ note │
├────┼───────────┼─────────────┼──────┤
│ 1  │ 1         │ 1           │ 14.5 │
│ 2  │ 1         │ 2           │ 16.0 │
│ 3  │ 2         │ 1           │ 15.5 │
│ 4  │ 2         │ 2           │ 17.0 │
└────┴───────────┴─────────────┴──────┘
```

---

# 4. Modèles de données détaillé

## Explication line-by-line du code

### Model 1: Enseignants

```python
class Enseignants(models.Model):
    # 📌 Lien avec Django User pour l'authentification
    # OneToOneField = une relation 1-to-1 exclusive
    # on_delete=models.CASCADE = si User supprimé, Enseignant aussi
    # related_name='enseignant' = accès depuis User: user.enseignant
    # null=True, blank=True = optionnel (pour migration progressive)
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        related_name='enseignant',
        null=True,
        blank=True
    )
    
    # Nom simple (jusqu'à 100 caractères)
    nom = models.CharField(max_length=100)
    
    # Prénom simple
    prenom = models.CharField(max_length=100)

    def __str__(self):
        # Représentation textuelle: "Dupont Jean"
        return f"{self.nom} {self.prenom}"
```

**Exemples en Python:**
```python
# Créer un enseignant
from django.contrib.auth.models import User

user = User.objects.create_user(
    username='dupont.prof',
    password='secret123'
)
prof = Enseignants.objects.create(
    user=user,
    nom='Dupont',
    prenom='Jean'
)

# Accès depuis User
prof = user.enseignant  # Via related_name

# Affichage
print(prof)  # "Dupont Jean"

# Modification
prof.nom = 'Durand'
prof.save()

# Suppression
prof.delete()
```

### Model 2: UE (Unité d'Enseignement)

```python
class UE(models.Model):
    # Code unique (ex: "MTH101", "PHY201")
    # unique=True = impossible d'avoir 2 UE avec même code
    code = models.CharField(max_length=20, unique=True)
    
    # Nom complet de l'UE (ex: "Mathématiques avancées")
    nom = models.CharField(max_length=200)
    
    # Numéro du semestre (1=S1, 2=S2, etc.)
    # IntegerField accepte les nombres entiers
    semestre = models.IntegerField()
    
    # Crédits ECTS (European Credit Transfer System)
    # Typiquement 3, 4, 5, 6, 8 ECTS
    credits_ects = models.IntegerField()

    def __str__(self):
        # Affichage: "MTH101 Mathématiques avancées"
        return f"{self.code} {self.nom}"
```

**Exemples en Python:**
```python
# Créer une UE
ue = UE.objects.create(
    code='MTH101',
    nom='Mathématiques',
    semestre=1,
    credits_ects=5
)

# Requête de recherche
ue = UE.objects.get(code='MTH101')
ues_semestre1 = UE.objects.filter(semestre=1)
ues_5ects = UE.objects.filter(credits_ects=5)

# Modification
ue.nom = 'Mathématiques avancées'
ue.save()

# Statistiques
nb_ue = UE.objects.count()  # Nombre total
total_ects = UE.objects.all().aggregate(Sum('credits_ects'))
```

### Model 3: Ressources

```python
class Ressources(models.Model):
    # Code unique pour identifier la ressource
    code = models.CharField(max_length=20, unique=True)
    
    # Nom: "Calcul différentiel", "Algèbre linéaire"
    nom = models.CharField(max_length=200)
    
    # Description longue pour expliquer le contenu
    description = models.TextField()  # Pas de limite de caractères
    
    # Coefficient: poids dans le calcul des moyennes
    # Ex: 0.5, 1.0, 1.5, 2.0
    # Plus haut = plus important pour la note finale
    coefficient = models.FloatField()

    # 🔑 RELATION ManyToMany avec UE
    # Une ressource peut être liée à plusieurs UE
    # Une UE peut avoir plusieurs ressources
    # blank=True = optionnel (une ressource peut ne pas avoir d'UE)
    # related_name='ressources' = accès depuis UE: ue.ressources.all()
    ues = models.ManyToManyField(UE, related_name='ressources', blank=True)

    def __str__(self):
        return f"{self.nom}"
```

**Exemples en Python:**
```python
# Créer une ressource
ressource = Ressources.objects.create(
    code='MTH-R1',
    nom='Calcul différentiel',
    description='Étude des dérivées et intégrales',
    coefficient=1.5
)

# Lier à une UE
ue = UE.objects.get(code='MTH101')
ressource.ues.add(ue)  # Ajouter une UE

# Lier plusieurs UE à la fois
ressource.ues.set([ue1, ue2, ue3])

# Voir toutes les UE d'une ressource
for ue in ressource.ues.all():
    print(ue.code, ue.nom)

# Voir toutes les ressources d'une UE
for res in ue.ressources.all():
    print(res.nom, res.coefficient)

# Supprimer un lien (sans supprimer la ressource)
ressource.ues.remove(ue)

# Supprimer la ressource ET tous ses liens
ressource.delete()
```

### Model 4: Etudiant

```python
class Etudiant(models.Model):
    # Numéro d'étudiant unique (ex: "E20001", "E20123")
    # unique=True = chaque étudiant a un numéro différent
    # C'est l'identifiant pour la connexion des étudiants
    numero_etudiant = models.CharField(max_length=20, unique=True)
    
    # Nom de famille
    nom = models.CharField(max_length=100)
    
    # Prénom
    prenom = models.CharField(max_length=100)
    
    # Groupe TP/TD (ex: "G1", "G2", "G3")
    # Permet de grouper les étudiants par sessions pratiques
    groupe = models.CharField(max_length=20)

    # Photo de profil (optionnelle)
    # null=True, blank=True = pas obligatoire
    # upload_to='' = enregistre dans le dossier MEDIA_ROOT
    photo = models.ImageField(upload_to='', null=True, blank=True)
    
    # Email unique pour communication
    email = models.EmailField(unique=True)
    # EmailField valide automatiquement le format

    def __str__(self):
        # Affichage: "Dupont Valentin - E20001 - G1"
        return f"{self.prenom} - {self.nom} - {self.groupe}"
```

**Exemples en Python:**
```python
# Créer un étudiant
etudiant = Etudiant.objects.create(
    numero_etudiant='E20001',
    nom='Dupont',
    prenom='Valentin',
    groupe='G1',
    email='valentin.dupont@example.com'
)

# Recherche par numéro (pour login)
etudiant = Etudiant.objects.get(numero_etudiant='E20001')

# Recherche multiple
etudiants_g1 = Etudiant.objects.filter(groupe='G1')
etudiants_nom = Etudiant.objects.filter(nom__iexact='dupont')
# iexact = case-insensitive (ignore majuscules/minuscules)

# Modification
etudiant.groupe = 'G2'
etudiant.save()

# Accès aux notes de l'étudiant
notes = etudiant.note_set.all()
# 'note_set' = accès inverse depuis la ForeignKey dans Note
```

### Model 5: Examen

```python
class Examen(models.Model):
    # Titre de l'examen
    # Exemples: "Contrôle 1", "Examen final", "Quiz 2"
    title = models.CharField(max_length=200)
    
    # Date de l'examen (au format DATE, pas heure)
    # Format: YYYY-MM-DD (ex: 2025-02-15)
    date = models.DateField()
    
    # Coefficient: poids de cet examen dans la note finale
    # Ex: Contrôle 1 = 1.0, Examen final = 2.0
    # Permet de donner plus d'importance aux examens importants
    coefficient = models.FloatField()

    # 🔑 RELATION ForeignKey avec Ressources
    # Chaque examen est lié à UNE seule ressource
    # ForeignKey = relation Many-to-One (plusieurs examens → une ressource)
    # on_delete=models.CASCADE = si ressource supprimée, examens aussi
    # null=True, blank=True = optionnel (examen sans ressource)
    ressource = models.ForeignKey(
        Ressources, 
        on_delete=models.CASCADE, 
        null=True, 
        blank=True
    )
    
    def __str__(self):
        return f"{self.title}"
```

**Exemples en Python:**
```python
# Créer un examen
ressource = Ressources.objects.get(code='MTH-R1')
examen = Examen.objects.create(
    title='Contrôle 1',
    date='2025-02-15',
    coefficient=1.0,
    ressource=ressource
)

# Accès à la ressource
ressource = examen.ressource
print(ressource.nom)  # "Calcul différentiel"

# Trouver tous les examens d'une ressource
examens = Examen.objects.filter(ressource=ressource)

# Accès inverse (depuis ressource)
examens = ressource.examen_set.all()

# Obtenir toutes les notes d'un examen
notes = examen.note_set.all()
nb_notes = notes.count()

# Trouver la note moyenne d'un examen
moyenne = notes.aggregate(Avg('note'))['note__avg']
```

### Model 6: Note

```python
class Note(models.Model):
    # 🔑 RELATION ForeignKey avec Examen
    # Plusieurs notes peuvent se rapporter au même examen
    # on_delete=models.CASCADE = si examen supprimé, notes aussi
    examen = models.ForeignKey(
        Examen,
        on_delete=models.CASCADE
    )

    # 🔑 RELATION ForeignKey avec Etudiant
    # Plusieurs notes peuvent appartenir au même étudiant
    etudiant = models.ForeignKey(
        Etudiant,
        on_delete=models.CASCADE
    )

    # La note elle-même (ex: 14.5, 16.0)
    # FloatField accepte les nombres décimaux
    note = models.FloatField()

    # 🔐 CONTRAINTE D'INTÉGRITÉ
    # Garantit qu'un étudiant n'a QU'UNE note par examen
    # Impossible d'avoir 2 notes pour (examen=1, etudiant=1)
    # Cette contrainte est importante pour l'intégrité des données
    class Meta:
        unique_together = ('examen', 'etudiant')

    def __str__(self):
        return f"{self.etudiant} - {self.note}"
```

**Exemples en Python:**
```python
# Créer une note
examen = Examen.objects.get(id=1)
etudiant = Etudiant.objects.get(numero_etudiant='E20001')
note = Note.objects.create(
    examen=examen,
    etudiant=etudiant,
    note=14.5
)

# Créer ou mettre à jour une note
# update_or_create retourne (objet, created=True/False)
note_obj, created = Note.objects.update_or_create(
    examen=examen,
    etudiant=etudiant,
    defaults={'note': 15.0}
)
if created:
    print("Nouvelle note créée")
else:
    print("Note mise à jour")

# Trouver les notes d'un étudiant
notes = Note.objects.filter(etudiant=etudiant)

# Trouver les notes d'un examen
notes = Note.objects.filter(examen=examen)

# Trouver une note spécifique
note = Note.objects.get(examen=examen, etudiant=etudiant)

# Supprimer une note
note.delete()

# ERROR: Créer une note en double
# ❌ Note.objects.create(...)  # Viole unique_together
# IntegrityError: UNIQUE constraint failed

# Calculs
notes_examen = Note.objects.filter(examen=examen)
moyenne = notes_examen.aggregate(Avg('note'))['note__avg']
max_note = notes_examen.aggregate(Max('note'))['note__max']
min_note = notes_examen.aggregate(Min('note'))['note__min']
```

---

# 5. Formulaires détaillé

## ImportNotesForm - Explicitation complète

```python
class ImportNotesForm(forms.Form):
    # 🔹 CHAMP 1: Fichier Excel
    # FileField = pour uploader des fichiers
    # Les fichiers sont reçus dans request.FILES
    fichier_excel = forms.FileField(
        label='Fichier Excel (.xlsx)',  # Label affiché
        help_text='Format: NOM, PRENOM, NOTE1, NOTE2, ...'
        # help_text = texte d'aide sous le champ
    )
    
    # 🔹 CHAMP 2: Sélection d'examen
    # ModelChoiceField = dropdown listant les objets BD
    # queryset=Examen.objects.all() = charge tous les examens
    # Le dropdown affiche examen.__str__() pour chaque item
    examen = forms.ModelChoiceField(
        queryset=Examen.objects.all(),
        label='Sélectionner l\'examen'
    )
```

**Utilisation dans une view:**
```python
def import_notes_excel(request):
    if request.method == 'POST':
        # Instancier avec les données POST et FILES
        form = ImportNotesForm(request.POST, request.FILES)
        
        if form.is_valid():
            # Les données validées sont accessibles via cleaned_data
            fichier = request.FILES['fichier_excel']
            examen = form.cleaned_data['examen']  # Objet Examen
            
            # Traitement...
        else:
            # form.errors contient les erreurs
            # Les templates affichent form.errors
```

**Validation automatique Django:**
```python
# Django valide automatiquement:

1. FileField:
   - Le fichier est fourni? (required=True par défaut)
   - C'est un fichier valide?

2. ModelChoiceField:
   - La valeur existe dans la queryset?
   - C'est un entier valide?
   - L'objet existe en BD?
```

## LoginEnseignantForm - Explicitation complète

```python
class LoginEnseignantForm(AuthenticationForm):
    # 🔹 Héritage d'AuthenticationForm
    # AuthenticationForm = formulaire de connexion Django
    # Ajoute automatiquement:
    # - Champ username
    # - Champ password
    # - Validation password hashed
    # - Tentatives de connexion limitées (optionnel)
    
    # 🔹 PERSONNALISATION: Champ username
    username = forms.CharField(
        label="Nom d'utilisateur",  # Label français
        max_length=150  # Limite de caractères
        # widget=forms.TextInput() = par défaut
    )
    
    # 🔹 PERSONNALISATION: Champ password
    password = forms.CharField(
        label="Mot de passe",
        widget=forms.PasswordInput  # Masque le texte (****)
        # render_value=False = ne jamais affecter la valeur
    )
    
    # 🔹 MESSAGES D'ERREUR PERSONNALISÉS
    error_messages = {
        # Ce message s'affiche quand username/password sont incorrects
        'invalid_login': "Identifiants incorrects. Vérifiez...",
        'inactive': "Ce compte est inactif.",
    }
```

**Utilisation dans une view:**
```python
def login_enseignant(request):
    # AuthenticationForm a besoin de request en paramètre
    form = LoginEnseignantForm(request, data=request.POST or None)
    
    if request.method == 'POST':
        if form.is_valid():
            # Récupérer l'utilisateur authenticfié
            user = form.get_user()
            # Créer une session
            login(request, user)
```

## EnseignantCreationForm - Explicitation complète

```python
class EnseignantCreationForm(forms.ModelForm):
    # 🔹 CHAMPS DE FORMULAIRE (pas en BD)
    # Ces champs existent seulement dans le formulaire
    username = forms.CharField(
        label="Nom d'utilisateur",
        max_length=150,
        help_text="Servira pour la connexion"
    )
    
    password = forms.CharField(
        label="Mot de passe",
        widget=forms.PasswordInput,
        min_length=6  # Minimum 6 caractères
    )
    
    password_confirm = forms.CharField(
        label="Confirmer le mot de passe",
        widget=forms.PasswordInput
    )

    # 🔹 META: Configuration du formulaire
    class Meta:
        model = Enseignants  # Le modèle BD associé
        fields = ['nom', 'prenom']  # Champs du modèle à afficher
        # Les champs username/password ne sont pas en Meta
        # car ce ne sont pas des champs Enseignants

    # 🔹 VALIDATION PERSONNALISÉE
    def clean(self):
        # clean() s'appelle après la validation de tous les champs
        cleaned_data = super().clean()
        
        # Vérifier que les mots de passe correspondent
        pwd = cleaned_data.get('password')
        pwd_confirm = cleaned_data.get('password_confirm')

        if pwd and pwd_confirm and pwd != pwd_confirm:
            # Lever une erreur au niveau du formulaire (non-field)
            raise forms.ValidationError(
                "Les mots de passe ne correspondent pas."
            )

        # Vérifier que l'username est unique
        username = cleaned_data.get('username')
        if username and User.objects.filter(username=username).exists():
            raise forms.ValidationError(
                "Ce nom d'utilisateur est déjà pris."
            )

        return cleaned_data
```

**Utilisation dans une view:**
```python
def ajout_enseignant(request):
    form = EnseignantCreationForm(request.POST or None)

    if form.is_valid():
        # Création du User Django
        user = User.objects.create_user(
            username=form.cleaned_data['username'],
            password=form.cleaned_data['password']
        )
        
        # Création de l'Enseignant lié
        enseignant = form.save(commit=False)
        # commit=False = ne pas sauvegarder en BD tout de suite
        enseignant.user = user  # Ajouter le lien User
        enseignant.save()  # Sauvegarder maintenant
```

---

# 6. Views - Logique métier détaillé

## Flux complet: Connexion enseignant

```python
def login_enseignant(request):
    """
    Gère la connexion des enseignants.
    
    GET: Affiche le formulaire
    POST: Traite la connexion
    """
    
    # Créer une instance du formulaire avec les données POST
    form = LoginEnseignantForm(request, data=request.POST or None)
    # request = nécessaire pour AuthenticationForm
    # data=request.POST or None = gérer GET et POST

    if request.method == "POST":
        if form.is_valid():
            # form.get_user() retourne l'User authentifié
            # C'est une méthode de AuthenticationForm
            user = form.get_user()
            
            # Vérifier que cet User est lié à un Enseignant
            if hasattr(user, 'enseignant'):
                # hasattr(obj, 'attr') = l'objet a-t-il cet attribut?
                # OneToOneField crée automatiquement: user.enseignant
                
                # Créer une session Django pour l'utilisateur
                # La session est stockée en BD et un cookie est envoyé
                login(request, user)
                
                # Redirection vers le dashboard
                # 'enseignant' = name de l'URL
                # id=user.enseignant.id = paramètre de l'URL
                return redirect('enseignant', id=user.enseignant.id)
            else:
                # Si l'User existe mais pas d'Enseignant associé
                form.add_error(None, "Ce compte n'est pas un compte enseignant.")
        else:
            # Si le formulaire n'est pas valide
            # form.errors est automatiquement affiché dans le template
            form.add_error(None, "Identifiants incorrects.")

    # Afficher le formulaire (GET ou POST avec erreurs)
    return render(request, 'app/login_enseignant.html', {'form': form})
```

## Flux complet: Import de notes

```python
def import_notes_excel(request):
    """
    Import des notes via un fichier Excel.
    
    Format attendu:
    NOM        | PRENOM  | NOTE
    Dupont     | Valentin| 14.5
    Martin     | Claire  | 16.0
    """
    
    # Récupérer l'ID du prof (optionnel, pour redirection)
    prof_id = request.GET.get('prof_id')
    
    if request.method == 'POST':
        # Créer le formulaire avec POST et FILES
        form = ImportNotesForm(request.POST, request.FILES)
        
        if form.is_valid():
            try:
                # Récupérer le fichier uploadé
                fichier = request.FILES['fichier_excel']
                # request.FILES = dictionnaire des fichiers uploadés
                
                # Récupérer l'examen sélectionné
                examen = form.cleaned_data['examen']
                
                # 📖 Lire le fichier Excel avec openpyxl
                file_data = fichier.read()  # Lire les bytes du fichier
                workbook = load_workbook(io.BytesIO(file_data))
                # io.BytesIO = convertir bytes en file-like object
                
                worksheet = workbook.active  # Première feuille
                
                # Compteurs pour les messages
                notes_creees = 0
                notes_echouees = 0
                erreurs = []
                
                # 🔄 BOUCLE: Pour chaque ligne du fichier
                for row_idx, row in enumerate(worksheet.iter_rows(values_only=True), 1):
                    # values_only=True = ne récupère que les valeurs
                    # enumerate(iterable, 1) = numérotation à partir de 1
                    
                    # ⏭️ Ignorer la première ligne si c'est l'en-tête
                    if row_idx == 1:
                        if row[0] and row[0].upper() in ['NOM', 'NAME']:
                            continue  # Passer à la prochaine ligne
                    
                    try:
                        # ⏭️ Ignorer les lignes vides
                        if not row or not row[0]:
                            continue
                        
                        # 📝 EXTRACTION: Récupérer les données
                        # row = tuple ou liste
                        # row[0] = première colonne (NOM)
                        # row[1] = deuxième colonne (PRENOM)
                        # row[2] = troisième colonne (NOTE)
                        
                        nom = row[0].strip() if row[0] else None
                        # .strip() = enlever les espaces avant/après
                        
                        prenom = row[1].strip() if len(row) > 1 and row[1] else None
                        # len(row) > 1 = il y a au moins 2 colonnes?
                        
                        note_valeur = row[2] if len(row) > 2 else None
                        
                        # ✔️ VALIDATION: Vérifier que les données sont complètes
                        if not nom or not prenom or note_valeur is None:
                            erreurs.append(f"Ligne {row_idx}: Données incomplètes")
                            notes_echouees += 1
                            continue
                        
                        # 🔢 CONVERSION: Noter en nombre décimal
                        try:
                            note_valeur = float(note_valeur)
                        except (ValueError, TypeError):
                            # Impossible de convertir en nombre
                            erreurs.append(f"Ligne {row_idx}: Note invalide")
                            notes_echouees += 1
                            continue
                        
                        # 🔍 RECHERCHE: Trouver l'étudiant en BD
                        try:
                            etudiant = Etudiant.objects.get(
                                nom__iexact=nom,  # Case-insensitive
                                prenom__iexact=prenom
                            )
                        except Etudiant.DoesNotExist:
                            # L'étudiant n'existe pas
                            erreurs.append(f"Ligne {row_idx}: Étudiant {nom} {prenom} non trouvé")
                            notes_echouees += 1
                            continue
                        except Etudiant.MultipleObjectsReturned:
                            # Plusieurs étudiants trouvés (ambiguïté)
                            erreurs.append(f"Ligne {row_idx}: Plusieurs étudiants trouvés")
                            notes_echouees += 1
                            continue
                        
                        # 💾 CRÉER/METTRE À JOUR: La note
                        note_obj, created = Note.objects.update_or_create(
                            examen=examen,
                            etudiant=etudiant,
                            # update_or_create cherche avec ces paramètres (clé unique)
                            
                            defaults={'note': note_valeur}
                            # Si créée: utilise tous les defaults
                            # Si mise à jour: applique les defaults
                        )
                        
                        notes_creees += 1
                        # Compter chaque import réussi
                    
                    except Exception as e:
                        # Erreur inattendue lors du traitement de la ligne
                        erreurs.append(f"Ligne {row_idx}: Erreur - {str(e)}")
                        notes_echouees += 1
                
                # 📢 MESSAGES: Afficher les résultats
                messages.success(request, f"✓ {notes_creees} note(s) importée(s)!")
                # messages.success = message vert en template
                
                if erreurs:
                    for erreur in erreurs[:10]:  # Afficher max 10 erreurs
                        messages.warning(request, f"⚠ {erreur}")
                    # messages.warning = message orange en template
                    
                    if len(erreurs) > 10:
                        messages.warning(request, f"... et {len(erreurs) - 10} autre(s)")
                
                # ↩️ REDIRECTION: Retour au dashboard
                if prof_id:
                    return redirect('enseignant', id=prof_id)
                return redirect('/')
            
            except Exception as e:
                # Erreur grave lors du traitement du fichier
                messages.error(request, f"Erreur: {str(e)}")
                # messages.error = message rouge en template
    else:
        # GET: Afficher le formulaire vide
        form = ImportNotesForm()
    
    # Afficher le template (avec formulaire ou résultats)
    return render(request, 'app/import_notes.html', {
        'form': form,
        'prof_id': prof_id
    })
```

## Export PDF - Explication line-by-line

```python
def export_notes_etudiant_pdf(request, id):
    """
    Exporte les notes d'un étudiant en PDF.
    Le PDF contient:
    - Titre et infos étudiant
    - Tableau des notes par UE > Ressource > Examen
    """
    
    # 🔍 RÉCUPÉRATION: Étudiant
    etudiant = get_object_or_404(Etudiant, id=id)
    # get_object_or_404 = retourner l'objet ou erreur 404
    # Sécurité: pas d'erreur détaillée aux utilisateurs
    
    # 🔍 REQUÊTE: Récupérer les notes de l'étudiant
    notes = Note.objects.filter(etudiant=etudiant).select_related('examen__ressource')
    # filter(etudiant=etudiant) = uniquement les notes de cet étudiant
    # select_related('examen__ressource') = OPTIMISATION
    # Charge examen ET ressource en une seule requête (joins)
    
    notes = notes.prefetch_related('examen__ressource__ues')
    # prefetch_related('...ues') = OPTIMISATION
    # Charge les UE associées (relation inverse)
    
    # 📊 ORGANISATION: Notes par UE > Ressource
    notes_par_ue = {}
    # notes_par_ue[ue_obj][ressource_obj] = [note1, note2, ...]
    
    for note in notes:
        ressource = note.examen.ressource
        
        # Boucler à travers les UE liées à la ressource
        for ue in ressource.ues.all():
            # Créer l'entrée UE si elle n'existe pas
            if ue not in notes_par_ue:
                notes_par_ue[ue] = {}
            
            # Créer l'entrée Ressource si elle n'existe pas
            if ressource not in notes_par_ue[ue]:
                notes_par_ue[ue][ressource] = []
            
            # Ajouter la note
            notes_par_ue[ue][ressource].append(note)
    
    # 📄 RÉPONSE HTTP: Type PDF
    response = HttpResponse(content_type='application/pdf')
    # content_type='application/pdf' = le navigateur télécharge
    
    response['Content-Disposition'] = f'attachment; filename="notes_{etudiant.numero_etudiant}.pdf"'
    # Content-Disposition = nom du fichier téléchargé
    # attachment = force le téléchargement (au lieu d'afficher)
    
    # 🎨 CRÉATION DU PDF: SimpleDocTemplate
    doc = SimpleDocTemplate(
        response,
        pagesize=landscape(A4),  # Format paysage A4
        rightMargin=1*cm,        # Marges en cm
        leftMargin=1*cm,
        topMargin=1*cm,
        bottomMargin=1*cm
    )
    
    # 🎨 STYLES: Police et mise en forme
    styles = getSampleStyleSheet()
    # getSampleStyleSheet = styles prédéfinis Django
    
    title_style = ParagraphStyle(
        'CustomTitle',
        parent=styles['Heading1'],  # Hériter de Heading1
        fontSize=16,
        textColor=colors.HexColor('#1a1a1a'),  # Gris foncé
        spaceAfter=20,
        alignment=TA_CENTER  # Centré
    )
    
    # 📝 CONTENU: Construire le document
    story = []  # Liste des éléments du PDF
    
    # Titre
    title = f"RELEVÉ DE NOTES - {etudiant.prenom} {etudiant.nom}"
    story.append(Paragraph(title, title_style))
    
    # Infos étudiant
    info_text = f"<b>N° Étudiant:</b> {etudiant.numero_etudiant}"
    story.append(Paragraph(info_text, styles['Normal']))
    
    # Date de génération
    info_text2 = f"<b>Généré le:</b> {datetime.now().strftime('%d/%m/%Y à %H:%M')}"
    story.append(Paragraph(info_text2, styles['Normal']))
    story.append(Spacer(1, 0.5*cm))  # Espace blanc
    
    # Ajouter les notes par UE
    if notes_par_ue:
        for ue, ressources in notes_par_ue.items():
            # Titre UE
            ue_title = f"{ue.code} - {ue.nom} (S{ue.semestre}, {ue.credits_ects} ECTS)"
            story.append(Paragraph(ue_title, ue_style))
            
            # Pour chaque ressource
            for ressource, notes_list in ressources.items():
                # Tableau des notes
                data = [['Examen', 'Date', 'Coefficient', 'Note']]
                
                for note in notes_list:
                    data.append([
                        note.examen.title,
                        note.examen.date.strftime('%d/%m/%Y'),
                        str(note.examen.coefficient),
                        f"{note.note}/20"
                    ])
                
                table = Table(data, colWidths=[...])
                story.append(table)
    
    # 🔨 GÉNÉRATION: Construire le PDF
    doc.build(story)  # Générer le PDF dans response
    
    return response
```

---

# 7. Templates détaillé

## Héritage de templates

```
┌─────────────────────────────────────────────┐
│         base.html                           │
│  ┌───────────────────────────────────────┐  │
│  │ {% block navbar_extra %}              │  │
│  ├───────────────────────────────────────┤  │
│  │ {% block content %}                   │  │
│  │                                       │  │
│  │ Chaque page remplit ces blocs        │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

**base.html:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>{% block title %}GestNotes{% endblock %}</title>
    <link rel="stylesheet" href="{% static 'style.css' %}">
</head>
<body>
    <!-- HEADER avec logo -->
    <nav class="navbar">
        <div class="navbar-logo">📚 GestNotes</div>
        <div class="navbar-right">
            {% block navbar_extra %}<!-- Boutons spécifiques -->{% endblock %}
        </div>
    </nav>
    
    <!-- CONTENU PRINCIPAL -->
    <div class="container">
        {% block content %}<!-- Chaque page remplit ici -->{% endblock %}
    </div>
    
    <!-- FOOTER -->
    <footer>© SAE Albert 2025</footer>
</body>
</html>
```

**form.html (hérité de base.html):**
```html
{% extends 'app/base.html' %}

{% block title %}{{ titre }} — GestNotes{% endblock %}

<!-- BARRE DE NAVIGATION SPÉCIFIQUE -->
{% block navbar_extra %}
    {% if prof_id %}
        <a href="{% url 'enseignant' prof_id %}" class="btn-nav">← Retour</a>
    {% else %}
        <a href="/app/" class="btn-nav">← Retour</a>
    {% endif %}
{% endblock %}

<!-- CONTENU DU FORMULAIRE -->
{% block content %}
    <div class="form-wrapper">
        <!-- Erreurs globales -->
        {% if form.non_field_errors %}
            <div class="form-error">
                {% for error in form.non_field_errors %}
                    <p>⚠️ {{ error }}</p>
                {% endfor %}
            </div>
        {% endif %}
        
        <!-- BOUCLE: Pour chaque champ du formulaire -->
        {% for field in form %}
            <div class="form-group">
                <label for="{{ field.id_for_label }}">
                    {{ field.label }}
                    {% if field.field.required %}
                        <span class="required">*</span>
                    {% endif %}
                </label>
                
                {{ field }}  <!-- Affiche le champ HTML -->
                
                <!-- Erreurs du champ -->
                {% if field.errors %}
                    <span class="field-error">{{ field.errors.0 }}</span>
                {% endif %}
                
                <!-- Texte d'aide -->
                {% if field.help_text %}
                    <span class="field-help">{{ field.help_text|safe }}</span>
                {% endif %}
            </div>
        {% endfor %}
        
        <!-- BOUTONS -->
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">✅ Enregistrer</button>
            
            {% if prof_id %}
                <a href="{% url 'enseignant' prof_id %}" class="btn btn-secondary">
                    ✖ Annuler
                </a>
            {% else %}
                <a href="/app/" class="btn btn-secondary">✖ Annuler</a>
            {% endif %}
        </div>
    </div>
{% endblock %}
```

**enseignant.html (Dashboard prof):**
```html
{% extends 'app/base.html' %}

{% block title %}{{ enseignant.prenom }} {{ enseignant.nom }} — GestNotes{% endblock %}

{% block navbar_extra %}
    <span class="navbar-user">👨‍🏫 {{ enseignant.prenom }} {{ enseignant.nom }}</span>
    <a href="{% url 'logout_enseignant' %}" class="btn-nav">🚪 Déconnexion</a>
{% endblock %}

{% block content %}
    <!-- EN-TÊTE PROFIL -->
    <div class="profil-header">
        <div class="profil-avatar-large">{{ enseignant.prenom|first }}{{ enseignant.nom|first }}</div>
        <h1>{{ enseignant.prenom }} {{ enseignant.nom }}</h1>
        <a href="{% url 'export_notes_prof_pdf' enseignant.id %}">📄 Exporter PDF</a>
    </div>
    
    <!-- TITRE SECTION -->
    <h2 class="section-title">⚡ Actions rapides</h2>
    
    <!-- GRILLE D'ACTIONS -->
    <div class="actions-grid">
        <!-- Chaque action = une carte cliquable -->
        
        <a href="{% url 'ajout_etudiant' %}?prof_id={{ enseignant.id }}" class="action-card">
            <span class="action-icon">👥</span>
            <span class="action-label">Ajouter étudiant</span>
        </a>
        
        <a href="{% url 'import_notes' %}?prof_id={{ enseignant.id }}" class="action-card">
            <span class="action-icon">📊</span>
            <span class="action-label">Importer notes</span>
        </a>
        
        <!-- ... autres actions ... -->
    </div>
{% endblock %}
```

---

# 8. Authentification et sécurité détaillé

## Flux de sécurité: Connexion enseignant

```
1️⃣ ÉTAPE 1: Affichage du formulaire
   GET /app/enseignant/
   ↓
   Django affiche login_enseignant.html
   Template contient:
   - Form CSRF token
   - Input username
   - Input password (type="password", masqué)
   - Button submit

2️⃣ ÉTAPE 2: Soumission des identifiants
   POST /app/enseignant/
   Données:
   {
     'csrfmiddlewaretoken': 'abc123...',  ← 🔐 Protection CSRF
     'username': 'dupont.prof',
     'password': '****'  ← Pas en clair
   }

3️⃣ ÉTAPE 3: Validation du formulaire
   form = LoginEnseignantForm(request, data=request.POST)
   ↓
   Django valide:
   - CSRF token correct? (sinon rejette)
   - username existe en BD?
   - password correspond au hash?

4️⃣ ÉTAPE 4: Authentification
   user = form.get_user()  ← Récupère User validé
   ↓
   if hasattr(user, 'enseignant'):  ← Vérifier la liaison
   ↓
   login(request, user)  ← Créer la session

5️⃣ ÉTAPE 5: Création de session
   Django crée une session:
   - Identifiant unique (session_key)
   - Données: {'user_id': 1}
   - Stocke en BD (django_session)
   - Envoie un cookie au navigateur
   
   Cookie HTTP:
   Set-Cookie: sessionid=abc123def456; Path=/; HttpOnly

6️⃣ ÉTAPE 6: Redirection
   return redirect('enseignant', id=user.enseignant.id)
   ↓
   GET /app/enseignant/1/
   (Le navigateur envoie automatiquement le cookie)

7️⃣ ÉTAPE 7: Protection de la page
   @login_required(login_url='login_enseignant')
   def profil_enseignant(request, id):
   ↓
   Si le cookie/session n'existe pas:
   - Redirection vers /app/enseignant/
   
   Si la session existe:
   - request.user = User(id=1)
   - Vérification supplémentaire:
     if request.user.enseignant.id != id:
         return redirect('login_enseignant')
   - Affichage de la page

8️⃣ ÉTAPE 8: Déconnexion
   GET /app/logout/
   ↓
   logout(request)  ← Détruit la session
   ↓
   Django supprime la session en BD
   Django supprime le cookie
   ↓
   Redirection vers login_etudiant
```

## Sécurité détaillée

### CSRF Protection (Protection contre les attaques cross-site)

**Problème:**
```html
<!-- Attaquant crée ce lien malveillant -->
<img src="https://gestnotes.com/app/ajout/notes/?note=20">
<!-- Si une personne connectée clique, la note est créée sans confirmation -->
```

**Solution Django:**
```html
<form method="POST">
    {% csrf_token %}  <!-- Token unique inclus -->
    <input type="text" name="note">
</form>
```

Django vérifie:
```python
# POST doit contenir le token
POST /app/ajout/notes/
csrfmiddlewaretoken: abc123...

# Django compare avec le token en session
# Si ne correspondent pas: erreur 403 CSRF
```

### Hash des mots de passe

```python
# ❌ MAUVAIS: Stocker le mot de passe en clair
password = "dupont123"  # Visible en BD!

# ✅ BON: Django utilise PBKDF2 (Password-Based Key Derivation Function 2)
from django.contrib.auth.models import User

user = User.objects.create_user(
    username='dupont',
    password='dupont123'  # Django le hash automatiquement
)

# En BD:
# password = "pbkdf2_sha256$260000$xyzabc123$..."
# Impossible de retrouver le mot de passe original

# Vérification lors de login:
# 1. Récupérer le mot de passe saisi: "dupont123"
# 2. Appliquer le même hash
# 3. Comparer les résultats
# 4. Si identiques: authentification réussie
```

### Sessions sécurisées

```
🔒 Côté serveur (Django):
┌─────────────────────────────────────────┐
│ django_session (table BD)               │
├─────────────────────────────────────────┤
│ session_key   | session_data     | date │
├─────────────────────────────────────────┤
│ abc123def456  | {'user_id': 1}   | ...  │
│ xyz789uvw123  | {'user_id': 2}   | ...  │
└─────────────────────────────────────────┘
   ↑
   Identifiant unique aléatoire

🔒 Côté client (Navigateur):
Cookie: sessionid=abc123def456
- HttpOnly: pas accessible via JavaScript
- Secure: uniquement en HTTPS en production
- SameSite: protection contre CSRF
```

### Vérification d'accès

```python
# ✅ BON: Un prof ne peut voir que SON dashboard
@login_required(login_url='login_enseignant')
def profil_enseignant(request, id):
    enseignant = get_object_or_404(Enseignants, id=id)
    
    # Sécurité: vérifier l'accès
    if not hasattr(request.user, 'enseignant') \
       or request.user.enseignant.id != enseignant.id:
        messages.error(request, "Accès refusé.")
        return redirect('login_enseignant')
    
    # Maintenant on peut afficher le dashboard
    return render(request, 'app/enseignant.html', {
        'enseignant': enseignant
    })

# ❌ MAUVAIS: Pas de vérification
def profil_enseignant(request, id):
    enseignant = get_object_or_404(Enseignants, id=id)
    return render(request, 'app/enseignant.html', ...)
    # Un utilisateur peut accéder à /app/enseignant/2/ même s'il est prof 1
```

---

# 9. Cas d'usage complets avec captures

## Cas 1: Ajouter un enseignant (Admin)

```
┌─────────────────────────────────────┐
│ Django Admin                        │
│ /admin/                             │
│                                     │
│ [+] Ajouter Enseignants             │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│ Formulaire de création              │
│                                     │
│ User: [Créer] dupont.prof           │
│ Nom: Dupont                         │
│ Prénom: Jean                        │
│                                     │
│ [Sauvegarder]                       │
└────────────────┬────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────┐
│ Données en BD:                      │
│                                     │
│ auth_user:                          │
│   id=1, username='dupont.prof'      │
│   password=pbkdf2_sha256$...        │
│                                     │
│ app_enseignants:                    │
│   id=1, user_id=1                   │
│   nom='Dupont', prenom='Jean'       │
└─────────────────────────────────────┘
```

## Cas 2: Connexion enseignant

```
1. L'enseignant accède à /app/enseignant/
   ↓
   Formulaire:
   [Espace Enseignant]
   Username: _______________
   Password: _______________
   [Se connecter]

2. Saisit: dupont.prof / ****
   ↓
   POST /app/enseignant/ + csrf_token

3. Vue login_enseignant():
   - Valide csrf_token ✓
   - Cherche User avec username='dupont.prof' ✓
   - Vérifie password avec hash ✓
   - Récupère Enseignant associé ✓
   - Crée la session ✓
   
4. Redirection vers /app/enseignant/1/

5. Dashboard affichée:
   ┌──────────────────────────────────────┐
   │ 👨‍🏫 Dupont Jean         [🚪 Déconnexion] │
   ├──────────────────────────────────────┤
   │ ⚡ Actions rapides                   │
   │                                      │
   │ ┌───┬───┬───┐                        │
   │ │👥 │📊 │📝 │                       │
   │ └───┴───┴───┘                        │
   │ [Ajouter étudiant] [Import notes]... │
   │                                      │
   │ [📄 Exporter PDF]                    │
   └──────────────────────────────────────┘
```

## Cas 3: Import de notes (2-5 étudiants)

**Fichier Excel téléchargé:**
```
NOM        | PRENOM  | NOTE
Dupont     | Valentin| 14.5
Martin     | Claire  | 16.0
Bernard    | Thomas  | 12.5
```

**Étapes:**
```
1. Enseignant clique "Importer des notes"
   ↓
   GET /app/import/notes/?prof_id=1

2. Page d'import affichée:
   [Fichier Excel] [Choisir...]
   [Examen] [Contrôle 1 ▼]
   [Importer les notes]
   [Télécharger un modèle]

3. Sélectionne le fichier et l'examen
   ↓
   POST /app/import/notes/ + fichier + examen

4. Vue import_notes_excel() traite:

   Ligne 1: "Dupont", "Valentin", 14.5
   ├─ Validation: OK (3 données)
   ├─ Conversion: 14.5 → float
   ├─ Recherche: Etudiant(nom='Dupont', prenom='Valentin') ✓
   ├─ Création: Note(examen=1, etudiant=1, note=14.5)
   └─ Compteur: notes_creees = 1

   Ligne 2: "Martin", "Claire", 16.0
   ├─ Validation: OK
   ├─ Recherche: Etudiant ✓
   ├─ Création: Note(examen=1, etudiant=2, note=16.0)
   └─ Compteur: notes_creees = 2

   Ligne 3: "Bernard", "Thomas", 12.5
   ├─ Validation: OK
   ├─ Recherche: Etudiant ✓
   ├─ Création: Note(examen=1, etudiant=3, note=12.5)
   └─ Compteur: notes_creees = 3

5. Messages affichées:
   ✓ 3 note(s) importée(s) avec succès!

6. Redirection vers /app/enseignant/1/
```

---

# 10. Gestion des erreurs détaillée

## Erreurs de validation de formulaire

```python
# FORMULAIRE: EnseignantCreationForm

# ❌ Erreur 1: Mots de passe non-identiques
username: dupont
password: secret123
password_confirm: secret456  ← Différent!

Résultat:
ValidationError("Les mots de passe ne correspondent pas.")
Template affiche: ⚠️ Les mots de passe...

---

# ❌ Erreur 2: Username déjà pris
username: dupont.prof  ← Existe déjà
password: secret123
password_confirm: secret123

Résultat:
ValidationError("Ce nom d'utilisateur est déjà pris.")
Template affiche: ⚠️ Ce nom d'utilisateur...
```

## Erreurs de base de données

```python
# UNIQUE CONSTRAINT: Impossible d'avoir 2 notes identiques

Note.objects.create(examen=1, etudiant=1, note=15.0)
Note.objects.create(examen=1, etudiant=1, note=16.0)  # ❌

IntegrityError: UNIQUE constraint failed: app_note.examen_id, app_note.etudiant_id

❌ MAUVAIS (crée une erreur 500):
except Exception as e:
    return HttpResponse("Erreur serveur", status=500)

✅ BON (gère proprement):
try:
    Note.objects.create(...)
except IntegrityError:
    messages.error(request, "Cette note existe déjà")
    return render(request, 'form.html', {...})
```

## Erreurs d'import Excel

```
┌──────────────────────────────────────────┐
│ ERREUR: Fichier non-Excel                │
│                                          │
│ User upload un fichier .txt              │
│ openpyxl.load_workbook() lève:           │
│ BadZipFile: File is not a zip file       │
│                                          │
│ Gestion:                                 │
│ except Exception as e:                   │
│     messages.error(request,              │
│         "Erreur fichier: " + str(e))     │
│                                          │
│ Message affiché: ⚠️ Erreur fichier...    │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│ ERREUR: Étudiant non trouvé              │
│                                          │
│ Ligne 2: "Inconnu", "Étudiant", 15.0     │
│ Etudiant.objects.get(nom='Inconnu',      │
│                      prenom='Étudiant')  │
│ DoesNotExist: Etudiant matching query... │
│                                          │
│ Gestion:                                 │
│ erreurs.append(f"Ligne {row_idx}: ...")  │
│ messages.warning(request, "⚠ Ligne 2...")│
│                                          │
│ Résultat: Ligne ignorée, import continue│
│ Message affiché: ⚠️ Ligne 2: Étudiant... │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│ ERREUR: Note invalide                    │
│                                          │
│ Ligne 3: "Dupont", "Valentin", "XYZ"     │
│ float("XYZ") lève:                       │
│ ValueError: could not convert string...  │
│                                          │
│ Gestion:                                 │
│ except (ValueError, TypeError):          │
│     erreurs.append(...)                  │
│                                          │
│ Message affiché: ⚠️ Ligne 3: Note inv... │
└──────────────────────────────────────────┘
```

---

# 11. Guide de développement

## Workflow: Ajouter une nouvelle fonctionnalité

### Exemple: Supprimer une note

**Étape 1: Créer la view**
```python
# views.py
def supprimer_note(request, id):
    note = get_object_or_404(Note, id=id)
    
    if request.method == 'POST':
        prof_id = request.GET.get('prof_id')
        note.delete()
        messages.success(request, "Note supprimée")
        if prof_id:
            return redirect('enseignant', id=prof_id)
        return redirect('/')
    
    return render(request, 'app/confirm_delete.html', {'note': note})
```

**Étape 2: Ajouter l'URL**
```python
# urls.py
path('supprimer/note/<int:id>/', views.supprimer_note, name='supprimer_note'),
```

**Étape 3: Créer le template**
```html
{% extends 'app/base.html' %}

{% block content %}
    <div class="warning-box">
        <h2>Êtes-vous sûr?</h2>
        <p>Supprimer la note: {{ note }}</p>
        
        <form method="POST">
            {% csrf_token %}
            <button type="submit" class="btn btn-danger">Supprimer</button>
            <a href="{% url 'enseignant' prof_id %}" class="btn btn-secondary">
                Annuler
            </a>
        </form>
    </div>
{% endblock %}
```

**Étape 4: Tester**
```python
# tests.py
from django.test import TestCase, Client
from .models import Note, Examen, Etudiant

class NoteDeleteTest(TestCase):
    def setUp(self):
        # Créer les données de test
        self.etudiant = Etudiant.objects.create(...)
        self.examen = Examen.objects.create(...)
        self.note = Note.objects.create(...)
    
    def test_delete_note(self):
        self.client = Client()
        # POST vers l'URL
        response = self.client.post(f'/app/supprimer/note/{self.note.id}/')
        # Vérifier que la note a été supprimée
        self.assertFalse(Note.objects.filter(id=self.note.id).exists())
```

---

# 12. Performance et optimisation

## Optimisation des requêtes BD

```python
# ❌ MAUVAIS: N+1 queries problem
notes = Note.objects.all()
for note in notes:
    print(note.examen.ressource.nom)
    # Chaque note = 2 requêtes (examen + ressource)
    # 100 notes = 200 requêtes!

# ✅ BON: select_related pour les ForeignKey
notes = Note.objects.select_related('examen__ressource')
for note in notes:
    print(note.examen.ressource.nom)
    # 1 requête seulement (JOIN SQL)

---

# ❌ MAUVAIS: ManyToMany sans optimisation
for ue in UE.objects.all():
    for ressource in ue.ressources.all():
        print(ressource.nom)
    # Chaque UE = N requêtes pour les ressources

# ✅ BON: prefetch_related pour les ManyToMany
ues = UE.objects.prefetch_related('ressources')
for ue in ues:
    for ressource in ue.ressources.all():
        print(ressource.nom)
    # 2 requêtes totales (liste UE + liste ressources)
```

## Mise en cache

```python
# ✅ Cacher les sessions des utilisateurs
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'gestnotes-cache',
    }
}

# Dans une view:
from django.views.decorators.cache import cache_page

@cache_page(60 * 5)  # Cache 5 minutes
def stats_dashboard(request):
    # Cette page ne change pas souvent
    total_etudiants = Etudiant.objects.count()
    ...
```

## Pagination pour les grandes listes

```python
from django.paginator import Paginator

def liste_etudiants(request):
    all_etudiants = Etudiant.objects.all()
    
    # Paginer: 20 par page
    paginator = Paginator(all_etudiants, 20)
    page_number = request.GET.get('page', 1)
    page_obj = paginator.get_page(page_number)
    
    return render(request, 'etudiants_list.html', {
        'page_obj': page_obj
    })
```

```html
<!-- Template -->
<ul>
    {% for etudiant in page_obj %}
        <li>{{ etudiant }}</li>
    {% endfor %}
</ul>

<!-- Pagination -->
{% if page_obj.has_previous %}
    <a href="?page=1">Première</a>
    <a href="?page={{ page_obj.previous_page_number }}">Précédent</a>
{% endif %}

<span>Page {{ page_obj.number }}/{{ page_obj.paginator.num_pages }}</span>

{% if page_obj.has_next %}
    <a href="?page={{ page_obj.next_page_number }}">Suivant</a>
    <a href="?page={{ page_obj.paginator.num_pages }}">Dernière</a>
{% endif %}
```

---

**Fin de la documentation détaillée**
**Version:** 2.0 (Détaillée)
**Date:** 2026-06-09

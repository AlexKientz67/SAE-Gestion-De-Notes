# 📚 Documentation Complète - GestNotes (SAE-Albert)

## Table des matières

1. [Vue d'ensemble](#vue-densemble)
2. [Architecture générale](#architecture-générale)
3. [Modèles de données](#modèles-de-données)
4. [Formulaires](#formulaires)
5. [Views (Vues)](#views-vues)
6. [URLs et Routage](#urls-et-routage)
7. [Templates](#templates)
8. [Authentification](#authentification)
9. [Flux de données](#flux-de-données)
10. [Installation et configuration](#installation-et-configuration)
11. [Fonctionnalités principales](#fonctionnalités-principales)

---

## Vue d'ensemble

**GestNotes** est une application Django de gestion des notes et des étudiants. Elle permet aux enseignants de :
- Gérer les étudiants
- Créer et organiser les UE (Unités d'Enseignement) et ressources
- Importer des notes en masse via fichiers Excel
- Exporter les notes en PDF
- Se connecter de manière sécurisée

**Stack technique:**
- **Framework:** Django 4.2
- **Base de données:** SQLite (db.sqlite3)
- **Backend:** Python 3
- **Frontend:** HTML, CSS, JavaScript
- **Exportation:** ReportLab (PDF), openpyxl (Excel)

---

## Architecture générale

```
saeproject/
├── manage.py                 # Gestionnaire Django
├── db.sqlite3               # Base de données SQLite
├── saeproject/              # Configuration Django
│   ├── settings.py         # Configuration générale
│   ├── urls.py             # URLs principales
│   ├── wsgi.py             # Interface WSGI
│   └── asgi.py             # Interface ASGI
└── app/                     # Application principale
    ├── models.py           # Modèles de données
    ├── views.py            # Logique métier
    ├── urls.py             # URLs de l'app
    ├── forms.py            # Formulaires
    ├── admin.py            # Panel admin Django
    ├── tests.py            # Tests unitaires
    ├── static/             # Fichiers statiques
    │   ├── style.css
    │   ├── modele_notes.xlsx
    │   └── modele_etudiants.xlsx
    ├── templates/app/      # Templates HTML
    │   ├── base.html
    │   ├── form.html
    │   ├── login.html
    │   ├── login_enseignant.html
    │   ├── notes.html
    │   ├── enseignant.html
    │   ├── import_notes.html
    │   └── import_etudiants.html
    └── migrations/         # Migrations de la BD
```

---

## Modèles de données

Les modèles représentent la structure de la base de données. Ils sont définis dans `models.py`.

### 1. **Enseignants**

```python
class Enseignants(models.Model):
    user = models.OneToOneField(User, ...)  # Lien avec Django User
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
```

**Explication:**
- Représente un enseignant
- `user`: Lien 1-to-1 avec le modèle User Django (authentification)
- Stocke les informations personnelles (nom, prénom)

**Relationships:**
- ↔️ **User** (1-to-1)
- ← **Examen** (peut créer des examens)

---

### 2. **UE (Unité d'Enseignement)**

```python
class UE(models.Model):
    code = models.CharField(max_length=20, unique=True)
    nom = models.CharField(max_length=200)
    semestre = models.IntegerField()
    credits_ects = models.IntegerField()
```

**Explication:**
- Représente une unité d'enseignement (cours)
- `code`: Code unique (ex: "MTH101")
- `semestre`: Numéro du semestre (1, 2, etc.)
- `credits_ects`: Crédits ECTS (European Credit Transfer System)

**Relationships:**
- ↔️ **Ressources** (Many-to-Many, une UE peut avoir plusieurs ressources)

---

### 3. **Ressources**

```python
class Ressources(models.Model):
    code = models.CharField(max_length=20, unique=True)
    nom = models.CharField(max_length=200)
    description = models.TextField()
    coefficient = models.FloatField()
    ues = models.ManyToManyField(UE, ...)
```

**Explication:**
- Représente une ressource (partie d'une UE)
- `coefficient`: Poids dans le calcul des moyennes
- `ues`: Peut être liée à plusieurs UE

**Relationships:**
- ↔️ **UE** (Many-to-Many)
- ← **Examen** (ForeignKey)

---

### 4. **Etudiant**

```python
class Etudiant(models.Model):
    numero_etudiant = models.CharField(max_length=20, unique=True)
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    groupe = models.CharField(max_length=20)
    photo = models.ImageField(null=True, blank=True)
    email = models.EmailField(unique=True)
```

**Explication:**
- Représente un étudiant
- `numero_etudiant`: Numéro étudiant unique
- `groupe`: Groupe TP/TD (ex: "G1", "G2")
- `photo`: Image de profil (optionnelle)

**Relationships:**
- ← **Note** (ForeignKey)

---

### 5. **Examen**

```python
class Examen(models.Model):
    title = models.CharField(max_length=200)
    date = models.DateField()
    coefficient = models.FloatField()
    ressource = models.ForeignKey(Ressources, ...)
```

**Explication:**
- Représente un examen/contrôle
- `title`: Nom de l'examen
- `coefficient`: Poids dans le calcul
- `ressource`: Liée à une ressource

**Relationships:**
- → **Ressources** (ForeignKey)
- ← **Note** (ForeignKey)

---

### 6. **Note**

```python
class Note(models.Model):
    examen = models.ForeignKey(Examen, ...)
    etudiant = models.ForeignKey(Etudiant, ...)
    note = models.FloatField()
    
    class Meta:
        unique_together = ('examen', 'etudiant')
```

**Explication:**
- Représente la note d'un étudiant à un examen
- `unique_together`: Garantit qu'un étudiant n'a qu'une note par examen
- Crée une relation Many-to-Many entre Examen et Etudiant

---

## Formulaires

Les formulaires gèrent la validation et le rendu des données. Ils sont dans `forms.py`.

### 1. **ImportNotesForm**

```python
class ImportNotesForm(forms.Form):
    fichier_excel = forms.FileField(label='Fichier Excel (.xlsx)')
    examen = forms.ModelChoiceField(queryset=Examen.objects.all())
```

**Utilisation:** Import de notes depuis un fichier Excel
**Validation:** Vérification du format .xlsx

---

### 2. **LoginEnseignantForm**

```python
class LoginEnseignantForm(AuthenticationForm):
    error_messages = {
        'invalid_login': "Identifiants incorrects..."
    }
```

**Utilisation:** Connexion des enseignants
**Héritage:** Étend `AuthenticationForm` de Django

---

### 3. **EnseignantCreationForm**

```python
class EnseignantCreationForm(forms.ModelForm):
    username = forms.CharField(max_length=150)
    password = forms.CharField(widget=forms.PasswordInput, min_length=6)
    password_confirm = forms.CharField(widget=forms.PasswordInput)
    
    def clean(self):
        # Validation personnalisée
        # Vérifier que les mots de passe correspondent
        # Vérifier que l'username est unique
```

**Utilisation:** Création d'un nouvel enseignant avec compte
**Validations:**
- Mots de passe identiques
- Username unique

---

### 4. **Autres formulaires**

| Formulaire | Modèle | Utilisation |
|-----------|--------|-------------|
| **EtudiantForm** | Etudiant | Ajout/modification étudiant |
| **UEForm** | UE | Création UE |
| **RessourceForm** | Ressources | Création ressource |
| **ExamenForm** | Examen | Création examen |
| **NoteForm** | Note | Saisie manuelle note |
| **ImportEtudiantsForm** | - | Import Excel étudiants |

---

## Views (Vues)

Les views contiennent la logique métier. Elles traitent les requêtes et retournent des réponses.

### 1. **Connexion - `login_etudiant(request)`**

```python
def login_etudiant(request):
    # Permet à un étudiant de se connecter avec son numéro
    form = LoginEtudiantForm(request.POST or None)
    if form.is_valid():
        numero = form.cleaned_data['numero_etudiant']
        etudiant = Etudiant.objects.get(numero_etudiant=numero)
        return redirect('profil_etudiant', id=etudiant.id)
```

**Flux:**
1. L'étudiant entre son numéro
2. On cherche l'étudiant en BD
3. Redirection vers son profil

---

### 2. **Profil Étudiant - `profil_etudiant(request, id)`**

```python
def profil_etudiant(request, id):
    etudiant = get_object_or_404(Etudiant, id=id)
    notes = Note.objects.filter(etudiant=etudiant)
    # Organisation des notes par UE > Ressource
```

**Fonctionnalité:**
- Affiche les notes de l'étudiant
- Organise les notes hiérarchiquement (UE → Ressource → Examen)
- Permet l'export en PDF

---

### 3. **Connexion Enseignant - `login_enseignant(request)`**

```python
def login_enseignant(request):
    form = LoginEnseignantForm(request.POST or None)
    if form.is_valid():
        user = authenticate(request, username=..., password=...)
        if user and hasattr(user, 'enseignant'):
            login(request, user)
            return redirect('enseignant', id=user.enseignant.id)
```

**Sécurité:**
- Utilise Django's `authenticate()` et `login()`
- Vérifie que l'utilisateur est un enseignant
- Utilise les sessions Django

---

### 4. **Dashboard Enseignant - `profil_enseignant(request, id)`**

```python
@login_required(login_url='login_enseignant')
def profil_enseignant(request, id):
    enseignant = get_object_or_404(Enseignants, id=id)
    # Sécurité : un prof ne voit que son propre profil
    if request.user.enseignant.id != enseignant.id:
        return redirect('login_enseignant')
```

**Décorateur `@login_required`:**
- Redirige vers login si non connecté
- Protège le dashboard

**Page affichée:**
- Actions rapides (ajouter étudiant, importer notes, etc.)
- Accès aux différents formulaires
- Bouton déconnexion

---

### 5. **Import Notes - `import_notes_excel(request)`**

```python
def import_notes_excel(request):
    if request.method == 'POST':
        fichier = request.FILES['fichier_excel']
        workbook = load_workbook(io.BytesIO(file_data))
        
        for row in worksheet.iter_rows():
            # Lire: NOM, PRENOM, NOTE
            # Trouver l'étudiant
            # Créer/mettre à jour la note
```

**Processus:**
1. Récupère le fichier Excel uploadé
2. Lit chaque ligne
3. Cherche l'étudiant par nom/prénom
4. Crée ou met à jour la note
5. Affiche les erreurs et succès

**Format attendu:**
```
NOM         | PRENOM  | NOTE
Dupont      | Valentin| 14.5
Martin      | Claire  | 16.0
```

---

### 6. **Export PDF - `export_notes_etudiant_pdf(request, id)`**

```python
def export_notes_etudiant_pdf(request, id):
    etudiant = get_object_or_404(Etudiant, id=id)
    response = HttpResponse(content_type='application/pdf')
    
    # Créer document PDF avec ReportLab
    doc = SimpleDocTemplate(response, ...)
    
    # Ajouter titre, info étudiant, tableau des notes
    story = [Paragraph(...), Table(...)]
    doc.build(story)
    return response
```

**Bibliothèque:** ReportLab
**Contenu du PDF:**
- Titre (RELEVÉ DE NOTES)
- Infos étudiant (numéro, groupe, email, date)
- Tableau des notes par UE

---

### 7. **Ajout Formulaires**

```python
def ajout_etudiant(request):
    prof_id = request.GET.get('prof_id')
    form = EtudiantForm(request.POST or None, request.FILES or None)
    
    if form.is_valid():
        form.save()
        if prof_id:
            return redirect('enseignant', id=prof_id)  # Retour au dashboard
        return redirect('/')
```

**Pattern utilisé:**
- Récupère `prof_id` en paramètre GET
- Après sauvegarde, redirige vers le dashboard du prof
- Utilise le même template pour tous les formulaires

---

### 8. **Déconnexion - `logout_enseignant(request)`**

```python
def logout_enseignant(request):
    logout(request)  # Utilise Django's session handler
    messages.success(request, "Vous avez été déconnecté.")
    return redirect('login_etudiant')
```

**Sécurité:**
- Détruit la session
- Redirige vers login

---

## URLs et Routage

Les URLs sont définies dans `app/urls.py`:

```python
urlpatterns = [
    # Authentification
    path('', views.login_etudiant, name='login_etudiant'),
    path('enseignant/', views.login_enseignant, name='login_enseignant'),
    
    # Profils
    path('notes/<int:id>/', views.profil_etudiant, name='profil_etudiant'),
    path('enseignant/<int:id>', views.profil_enseignant, name='enseignant'),
    
    # Exports
    path('export/notes/pdf/<int:id>/', views.export_notes_etudiant_pdf, name='export_notes_pdf'),
    path('export/notes-prof/pdf/<int:id>/', views.export_notes_prof_pdf, name='export_notes_prof_pdf'),
    
    # Ajouts
    path('ajout/etudiant/', views.ajout_etudiant, name='ajout_etudiant'),
    path('ajout/enseignant/', views.ajout_enseignant, name='ajout_enseignant'),
    path('ajout/ue/', views.ajout_ue, name='ajout_ue'),
    path('ajout/ressource/', views.ajout_ressource, name='ajout_ressource'),
    path('ajout/examens/', views.ajout_examens, name='ajout_examens'),
    path('ajout/notes/', views.ajout_notes, name='ajout_notes'),
    
    # Imports
    path('import/notes/', views.import_notes_excel, name='import_notes'),
    path('import/etudiants/', views.import_etudiants_excel, name='import_etudiants'),
    
    # Autres
    path('modifier/etudiant/<int:id>/', views.modifier_etudiant, name='modifier_etudiant'),
    path('logout/', views.logout_enseignant, name='logout_enseignant'),
]
```

**Conventions de nommage:**
- `name` permet de générer les URLs dans les templates
- Les routes de profils utilisent `<int:id>` pour les IDs
- Les routes d'import utilisent les noms anglais

---

## Templates

Les templates se trouvent dans `app/templates/app/`.

### 1. **base.html** - Template de base

```html
{% extends 'app/base.html' %}

{% block title %}Titre de page{% endblock %}
{% block navbar_extra %}<!-- Boutons header -->{% endblock %}
{% block content %}<!-- Contenu principal -->{% endblock %}
```

**Blocs:**
- `title`: Titre de la page
- `navbar_extra`: Boutons/liens en haut à droite
- `content`: Contenu principal

---

### 2. **form.html** - Template générique des formulaires

Utilisé pour tous les formulaires (ajout UE, ressource, examen, etc.)

**Caractéristiques:**
- Rend dynamiquement les champs du formulaire
- Affiche les erreurs de validation
- Support du `prof_id` pour retour au dashboard
- Boutons Enregistrer/Annuler

**Variables de contexte:**
- `form`: Instance du formulaire
- `titre`: Titre de la page
- `prof_id`: ID du prof (optionnel)

---

### 3. **login_enseignant.html** - Connexion enseignant

```html
<form method="post" class="login-form">
    {% csrf_token %}
    <!-- Champ username -->
    <!-- Champ password -->
    <button type="submit">Se connecter</button>
</form>
```

**Sécurité:**
- Token CSRF contre les attaques
- Mots de passe en input type="password"

---

### 4. **enseignant.html** - Dashboard enseignant

Affiche:
- **En-tête:** Nom de l'enseignant, bouton déconnexion
- **Actions rapides:** Grid de 8 cartes cliquables
  - Ajouter étudiant
  - Importer étudiants
  - Saisir note
  - Importer notes
  - Créer examen
  - Ajouter UE
  - Ajouter ressource
  - Ajouter enseignant
- **Export PDF:** Bouton pour exporter toutes les notes

**Lien vers formulaires:**
```html
<a href="{% url 'ajout_notes' %}?prof_id={{ enseignant.id }}">
```

---

### 5. **import_notes.html** - Import Excel des notes

```html
<form method="post" enctype="multipart/form-data">
    {% csrf_token %}
    <!-- Input fichier -->
    <!-- Select examen -->
    <button type="submit">Importer</button>
    <a href="{% static 'modele_notes.xlsx' %}" download>
        Télécharger modèle
    </a>
</form>
```

**Utilisation:**
- Utilisateur sélectionne un fichier Excel
- Choisit l'examen associé
- Clique importer
- Les notes sont créées/mises à jour en BD

---

### 6. **notes.html** - Relevé de notes étudiant

Affiche les notes organisées:
```
UE: MTH101 - Mathématiques (S1, 5 ECTS)
  Ressource: MTH-R1 - Calcul (Coef. 1.5)
    Examen: Contrôle 1       | 14.5/20
    Examen: Examen final     | 16.0/20
```

**Fonctionnalité:**
- Bouton export PDF
- Organisation hiérarchique

---

## Authentification

### Flux de connexion

**Étudiant:**
```
1. Accès à /
2. Entre numéro étudiant
3. Recherche en BD
4. Redirection vers profil
```

**Enseignant:**
```
1. Accès à /app/enseignant/
2. Entre username et password
3. authenticate() vérifie les credentials
4. Crée une session Django
5. Redirection vers dashboard
```

### Sécurité

- **Django User:** Stockage sécurisé des mots de passe (PBKDF2)
- **Sessions:** Stockées en BD (sécurisées)
- **CSRF Token:** Protection contre les attaques
- **@login_required:** Décorateur pour protéger les vues
- **Vérification d'accès:** Un prof ne voit que son propre dashboard

---

## Flux de données

### Cas d'usage: Import de notes

```
1. Enseignant accède au dashboard
2. Clique "Importer des notes"
3. Sélectionne un fichier Excel
4. Choisit l'examen
5. POST vers import_notes_excel()
6. La view:
   - Lit le fichier avec openpyxl
   - Parse chaque ligne (NOM, PRENOM, NOTE)
   - Cherche l'étudiant en BD
   - Crée/met à jour la note (update_or_create)
   - Affiche les messages de succès/erreur
7. Redirection vers le dashboard
```

### Cas d'usage: Export PDF

```
1. Étudiant accède à son profil
2. Clique "Exporter en PDF"
3. GET vers export_notes_etudiant_pdf(id)
4. La view:
   - Récupère l'étudiant
   - Query toutes ses notes
   - Organise par UE > Ressource
   - Crée un PDF avec ReportLab
   - Retourne le fichier en download
5. Le navigateur télécharge le PDF
```

---

## Installation et configuration

### Prérequis

```bash
Python 3.8+
Django 4.2
openpyxl 3.1.5
Pillow 10.0.0
reportlab 4.0.9
pymysql 1.2.0
```

### Installation

```bash
# 1. Cloner le repo
git clone <repo>
cd sae-albert

# 2. Créer un venv
python -m venv venv
source venv/bin/activate  # ou venv\Scripts\activate sur Windows

# 3. Installer les dépendances
pip install -r requirements.txt

# 4. Migrations BD
cd saeproject
python manage.py makemigrations
python manage.py migrate

# 5. Créer un super-utilisateur (optionnel)
python manage.py createsuperuser

# 6. Lancer le serveur
python manage.py runserver
```

### Configuration Django

`settings.py`:
```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'app',  # Notre application
]

STATIC_URL = '/static/'
MEDIA_URL = '/media/'
MEDIA_ROOT = ...
```

---

## Fonctionnalités principales

### 1. **Gestion des étudiants**
- ✅ Création manuelle
- ✅ Import en masse (Excel)
- ✅ Modification
- ✅ Photo de profil
- ✅ Groupes TP/TD

### 2. **Gestion académique**
- ✅ Création d'UE (Unités d'Enseignement)
- ✅ Création de ressources (parties d'UE)
- ✅ Création d'examens
- ✅ Coefficients configurables

### 3. **Gestion des notes**
- ✅ Saisie manuelle
- ✅ Import Excel en masse
- ✅ Modification
- ✅ Unicité par (étudiant, examen)

### 4. **Rapports et exports**
- ✅ Relevé de notes PDF par étudiant
- ✅ Relevé complet PDF par enseignant
- ✅ Organisé par UE > Ressource

### 5. **Authentification sécurisée**
- ✅ Connexion enseignant avec username/password
- ✅ Connexion étudiant avec numéro étudiant
- ✅ Sessions Django sécurisées
- ✅ Déconnexion

### 6. **Interface utilisateur**
- ✅ Dashboard avec actions rapides
- ✅ Formulaires validés
- ✅ Messages de confirmation
- ✅ Affichage d'erreurs claires

---

## Exemple complet: Créer un enseignant

### Étape 1: Accéder au formulaire
```
GET /app/ajout/enseignant/
```

### Étape 2: Remplir le formulaire
```html
<form method="POST">
    <input type="text" name="username" value="dupont.prof">
    <input type="password" name="password" value="****">
    <input type="password" name="password_confirm" value="****">
    <input type="text" name="nom" value="Dupont">
    <input type="text" name="prenom" value="Jean">
    <button type="submit">Créer</button>
</form>
```

### Étape 3: La view traite
```python
# views.py - ajout_enseignant()
user = User.objects.create_user(
    username='dupont.prof',
    password='****'
)
enseignant = form.save(commit=False)
enseignant.user = user
enseignant.save()
# Redirection vers login_enseignant
```

### Étape 4: Authentification
```
GET /app/enseignant/
POST /app/enseignant/
  username: dupont.prof
  password: ****
```

### Étape 5: Accès au dashboard
```
GET /app/enseignant/1/  (ID = 1)
```

---

## Variables de contexte principales

| Variable | Type | Utilisée dans |
|----------|------|---------------|
| `form` | Form instance | form.html, login_enseignant.html |
| `etudiant` | Etudiant | notes.html |
| `enseignant` | Enseignants | enseignant.html |
| `notes_par_ue` | Dict | notes.html |
| `prof_id` | int | form.html (navigation) |
| `titre` | str | form.html |

---

## Codes HTTP et redirections

| Situation | Code | Redirection |
|-----------|------|-------------|
| Ajout réussi | 302 | Dashboard prof ou home |
| Connexion réussie | 302 | Dashboard prof |
| Pas connecté | 302 | Login page |
| Accès non autorisé | 302 | Login page |
| Export PDF | 200 | Téléchargement fichier |
| Erreur formulaire | 200 | Formulaire + erreurs |

---

## Optimisations et bonnes pratiques utilisées

### ✅ Performance
- `select_related()` et `prefetch_related()` pour les queries
- Utilisation de `get_object_or_404()` pour les 404s
- Query optimisées pour éviter les N+1

### ✅ Sécurité
- CSRF tokens sur les formulaires
- Authentification Django
- Vérification des permissions
- Mots de passe hashés

### ✅ Code
- Séparation concerns (models, views, forms, templates)
- Réutilisation de templates (form.html générique)
- Décorateurs pour la protection
- Messages utilisateur clairs

---

## Troubleshooting

### Problème: "Étudiant non trouvé" lors du login
**Cause:** Le numéro étudiant n'existe pas en BD
**Solution:** Créer l'étudiant d'abord via le dashboard prof

### Problème: Import Excel échoue
**Cause:** Format du fichier incorrect
**Solution:** Utiliser le modèle fourni (bouton "Télécharger modèle")

### Problème: Mots de passe ne correspondent pas
**Cause:** Les deux champs ne sont pas identiques
**Solution:** Vérifier la saisie des deux mots de passe

### Problème: "Username déjà pris"
**Cause:** Un enseignant avec ce username existe
**Solution:** Utiliser un autre username unique

---

## Extensions possibles

1. **Intégration email**: Envoyer les relevés de notes par email
2. **Calcul de moyennes**: Calcul automatique des moyennes par UE/Ressource
3. **Graphiques**: Visualiser les performances des étudiants
4. **API REST**: Créer une API pour intégration tiers
5. **Mobile**: App mobile pour consulter les notes
6. **Notifications**: Alertes en cas de mauvaise note
7. **Multi-langue**: Traduction en anglais/autres langues

---

**Dernière mise à jour:** 2026-06-09
**Version:** 1.0
**Auteur:** SAE Albert Team

# 📊 Fonctionnalité d'Import de Notes via Excel

Une nouvelle fonctionnalité a été ajoutée pour importer les notes en masse via un fichier Excel.

## 📋 Format du fichier Excel

Le fichier doit contenir:
- **Colonne A:** NOM de l'étudiant
- **Colonne B:** PRENOM de l'étudiant  
- **Colonne C:** NOTE (numérique)

### Exemple:
```
NOM        | PRENOM   | NOTE
-----------|----------|------
Dupont     | Valentin | 14.5
Martin     | Claire   | 16.0
Bernard    | Thomas   | 12.5
```

## 🚀 Utilisation

1. Allez sur le profil d'un enseignant
2. Cliquez sur le bouton **"📊 Importer des notes"**
3. Sélectionnez le fichier Excel (.xlsx)
4. Choisissez l'examen correspondant
5. Cliquez sur **"Importer les notes"**

## ✅ Fonctionnalités

- ✔️ Support des fichiers Excel (.xlsx)
- ✔️ Recherche automatique des étudiants par NOM et PRENOM (insensible à la casse)
- ✔️ Mise à jour automatique des notes existantes
- ✔️ Rapport détaillé des imports (succès/erreurs)
- ✔️ Gestion des erreurs avec messages explicites

## ⚙️ Installation

Assurez-vous que les dépendances suivantes sont installées:

```bash
pip install -r requirements.txt
```

Notamment:
- `openpyxl==3.10.10` (pour lire les fichiers Excel)
- `Django==4.2`
- `Pillow==10.0.0`

## 🔧 API et Vue

### URL
- Route: `/app/import/notes/`
- Paramètres optionnels: `prof_id` (redirige vers le profil de l'enseignant après import)

### Vue: `import_notes_excel`

Traite l'import des notes avec les fonctionnalités suivantes:
- Validation des données
- Gestion des erreurs ligne par ligne
- Messages de feedback utilisateur
- Support de la redirection optionnelle

## 📝 Limitations et Considérations

- Le fichier doit être au format `.xlsx` (Excel moderne)
- Les noms et prénoms sont recherchés de manière insensible à la casse
- Les notes doivent être numériques (entiers ou décimales)
- Si plusieurs étudiants ont le même nom/prénom, une erreur sera générée
- Les lignes vides sont automatiquement ignorées

## 🐛 Dépannage

### Erreur: "Étudiant non trouvé"
- Vérifiez que le nom et prénom sont exactement écrits dans la base de données
- Vérifiez les accents (é, è, ê, etc.)

### Erreur: "Plusieurs étudiants trouvés"
- Plusieurs étudiants portent le même nom/prénom
- Essayez d'ajouter plus d'informations (numéro d'étudiant, groupe)

### Erreur: "Note invalide"
- La valeur n'est pas un nombre
- Utilisez un point (.) ou une virgule (,) comme séparateur décimal


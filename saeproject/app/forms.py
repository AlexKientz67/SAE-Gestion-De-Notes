from django import forms
from .models import (
    Enseignants,
    UE,
    Ressources,
    Etudiant,
    Examen,
    Note
)
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User


# =========================
# Import Notes
# =========================

class ImportNotesForm(forms.Form):
    fichier_excel = forms.FileField(
        label='Fichier Excel (.xlsx)',
        help_text='Format: NOM, PRENOM, NOTE1, NOTE2, ...'
    )
    examen = forms.ModelChoiceField(
        queryset=Examen.objects.all(),
        label='Sélectionner l\'examen'
    )


# =========================
# Import Etudiants
# =========================

class ImportEtudiantsForm(forms.Form):
    fichier_excel = forms.FileField(
        label='Fichier Excel (.xlsx)',
        help_text='Format: NUMERO_ETUDIANT, NOM, PRENOM, GROUPE, EMAIL'
    )


# =========================
# Enseignants
# =========================

class EnseignantForm(forms.ModelForm):

    class Meta:
        model = Enseignants

        fields = [
            'nom',
            'prenom'
        ]


# =========================
# UE
# =========================

class UEForm(forms.ModelForm):

    class Meta:
        model = UE

        fields = [
            'code',
            'nom',
            'semestre',
            'credits_ects',
        ]


# =========================
# Ressources
# =========================

class RessourceForm(forms.ModelForm):

    class Meta:
        model = Ressources

        fields = [
            'code',
            'nom',
            'description',
            'coefficient',
            'ues'
        ]
        
        widgets = {
            'ues': forms.CheckboxSelectMultiple()
        }


# =========================
# Etudiants
# =========================

class EtudiantForm(forms.ModelForm):

    class Meta:
        model = Etudiant

        fields = [
            'numero_etudiant',
            'nom',
            'prenom',
            'groupe',
            'photo',
            'email'
        ]


# =========================
# Examens
# =========================

class ExamenForm(forms.ModelForm):

    class Meta:
        model = Examen

        fields = [
            'title',
            'date',
            'coefficient',
            'ressource'
        ]

        widgets = {
            'date': forms.DateInput(
                attrs={'type': 'date'}
            )
        }


# =========================
# Notes
# =========================

class NoteForm(forms.ModelForm):

    class Meta:
        model = Note

        fields = [
            'examen',
            'etudiant',
            'note',
        ]

class LoginEtudiantForm(forms.Form):

    numero_etudiant = forms.CharField(
        max_length=20,
        label="Numéro étudiant"
    )
# Login Enseignant
class LoginEnseignantForm(AuthenticationForm):
    username = forms.CharField(
        label="Nom d'utilisateur",
        max_length=150
    )
    password = forms.CharField(
        label="Mot de passe",
        widget=forms.PasswordInput
    )

# Création d'un enseignant avec compte
class EnseignantCreationForm(forms.ModelForm):
    username = forms.CharField(
        label="Nom d'utilisateur",
        max_length=150,
        help_text="Servira pour la connexion"
    )
    password = forms.CharField(
        label="Mot de passe",
        widget=forms.PasswordInput,
        min_length=6
    )
    password_confirm = forms.CharField(
        label="Confirmer le mot de passe",
        widget=forms.PasswordInput
    )

    class Meta:
        model = Enseignants
        fields = ['nom', 'prenom']

    def clean(self):
        cleaned_data = super().clean()
        pwd = cleaned_data.get('password')
        pwd_confirm = cleaned_data.get('password_confirm')

        if pwd and pwd_confirm and pwd != pwd_confirm:
            raise forms.ValidationError(
                "Les mots de passe ne correspondent pas."
            )

        username = cleaned_data.get('username')
        if username and User.objects.filter(username=username).exists():
            raise forms.ValidationError(
                "Ce nom d'utilisateur est déjà pris."
            )

        return cleaned_data
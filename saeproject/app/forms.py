from django import forms
from .models import (
    Enseignants,
    UE,
    Ressources,
    Etudiant,
    Examen,
    Note
)


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
            'ue'
        ]


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

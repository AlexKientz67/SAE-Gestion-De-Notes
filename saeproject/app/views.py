from django.shortcuts import render,redirect,get_object_or_404
from .forms import *

# Create your views here.

def ajout_etudiant(request):
    form = EtudiantForm(
        request.POST or None,
        request.FILES or None,
    )

    if form.is_valid():
        form.save()
        return redirect('/')

    return render(request,'app/form.html', {'form':form, 'titre': 'Ajouter un étudiant'})

def ajout_enseignant(request):
    form = EnseignantForm(
        request.POST or None,
    )

    if form.is_valid():
        form.save()
        return redirect('/')

    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajouter un enseignant'})

def ajout_ue(request):
    form = UEForm(
        request.POST or None,
    )
    if form.is_valid():
        form.save()
        return redirect('/')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajouter un ue'})

def ajout_ressource(request):
    form = RessourceForm(
        request.POST or None,
    )
    if form.is_valid():
        form.save()
        return redirect('/')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajout un ressource'})

def ajout_examens(request):
    form = ExamenForm(
        request.POST or None,
    )
    if form.is_valid():
        form.save()
        return redirect('/')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajout un examen'})

def ajout_notes(request):
    form = NoteForm(
        request.POST or None,
    )
    if form.is_valid():
        form.save()
        return redirect('/')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajout un note'})

def modifier_etudiant(request, id):

    etudiant = get_object_or_404(
        Etudiant,
        id=id
    )

    form = EtudiantForm(
        request.POST or None,
        request.FILES or None,
        instance=etudiant
    )

    if form.is_valid():
        form.save()
        return redirect('/')

    return render(request, 'form.html', {
        'form': form,
        'titre': 'Modifier étudiant'
    })


def login_etudiant(request):

    form = LoginEtudiantForm(request.POST or None)

    if request.method == "POST":
        if form.is_valid():
            numero = form.cleaned_data[
                'numero_etudiant'
            ]
            try:
                etudiant = Etudiant.objects.get(
                    numero_etudiant=numero
                )
                return redirect(
                    'profil_etudiant',
                    id=etudiant.id
                )
            except Etudiant.DoesNotExist:
                form.add_error(
                    None,
                    "Étudiant introuvable"
                )
    return render(request, 'app/login.html', {
        'form': form
    })


def profil_etudiant(request, id):

    etudiant = get_object_or_404(
        Etudiant,
        id=id
    )

    return render(request, 'app/notes.html', {
        'etudiant': etudiant
    })

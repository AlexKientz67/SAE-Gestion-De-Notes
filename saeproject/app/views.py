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
        return redirect('/app')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajouter un ue'})

def ajout_ressource(request):
    prof_id = request.GET.get('prof_id')
    form = RessourceForm(
        request.POST or None,
    )
    if form.is_valid():
        form.save()
        if prof_id:
            return redirect('enseignant', id=prof_id)
        return redirect('/')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajout un ressource', 'prof_id': prof_id})

def ajout_examens(request):
    prof_id = request.GET.get('prof_id')
    form = ExamenForm(
        request.POST or None,
    )
    if form.is_valid():
        form.save()
        if prof_id:
            return redirect('enseignant', id=prof_id)
        return redirect('/')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajout un examen', 'prof_id': prof_id})

def ajout_notes(request):
    prof_id = request.GET.get('prof_id')
    form = NoteForm(
        request.POST or None,
    )
    if form.is_valid():
        form.save()
        if prof_id:
            return redirect('enseignant', id=prof_id)
        return redirect('/')
    return render(request, 'app/form.html', {'form':form, 'titre': 'Ajout un note', 'prof_id': prof_id})

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

    # Récupérer toutes les notes de l'étudiant
    notes = Note.objects.filter(etudiant=etudiant).select_related('examen__ressource__ue')
    
    # Organiser les notes par UE > Ressource
    notes_par_ue = {}
    
    for note in notes:
        ue = note.examen.ressource.ue
        ressource = note.examen.ressource
        
        if ue not in notes_par_ue:
            notes_par_ue[ue] = {}
        
        if ressource not in notes_par_ue[ue]:
            notes_par_ue[ue][ressource] = []
        
        notes_par_ue[ue][ressource].append(note)

    return render(request, 'app/notes.html', {
        'etudiant': etudiant,
        'notes_par_ue': notes_par_ue
    })

def login_enseignant(request):
    enseignants = Enseignants.objects.all()
    
    return render(request, 'app/login_enseignant.html', {
        'enseignants': enseignants
    })

def profil_enseignant(request, id):
    enseignant = get_object_or_404(
        Enseignants,
        id=id
    )

    return render(request, 'app/enseignant.html', {
        'enseignant': enseignant
    })
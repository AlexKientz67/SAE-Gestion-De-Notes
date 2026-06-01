from django.shortcuts import render,redirect,get_object_or_404
from django.contrib import messages
from django.http import HttpResponse
from .forms import *
from openpyxl import load_workbook, Workbook
import io

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


def import_notes_excel(request):
    """
    Import des notes via un fichier Excel
    Format attendu: NOM, PRENOM, NOTE1, NOTE2, ...
    """
    prof_id = request.GET.get('prof_id')
    
    if request.method == 'POST':
        form = ImportNotesForm(request.POST, request.FILES)
        if form.is_valid():
            try:
                fichier = request.FILES['fichier_excel']
                examen = form.cleaned_data['examen']
                
                # Lire le fichier Excel
                file_data = fichier.read()
                workbook = load_workbook(io.BytesIO(file_data))
                worksheet = workbook.active
                
                notes_creees = 0
                notes_echouees = 0
                erreurs = []
                
                # Traiter chaque ligne
                for row_idx, row in enumerate(worksheet.iter_rows(values_only=True), 1):
                    if row_idx == 1:  # Ignorer la première ligne si c'est l'en-tête
                        if row[0] and row[0].upper() in ['NOM', 'NAME']:
                            continue
                    
                    try:
                        if not row or not row[0]:  # Ignorer les lignes vides
                            continue
                        
                        nom = row[0].strip() if row[0] else None
                        prenom = row[1].strip() if len(row) > 1 and row[1] else None
                        note_valeur = row[2] if len(row) > 2 else None
                        
                        if not nom or not prenom or note_valeur is None:
                            erreurs.append(f"Ligne {row_idx}: Données incomplètes")
                            notes_echouees += 1
                            continue
                        
                        # Convertir la note en float
                        try:
                            note_valeur = float(note_valeur)
                        except (ValueError, TypeError):
                            erreurs.append(f"Ligne {row_idx}: Note invalide pour {nom} {prenom}")
                            notes_echouees += 1
                            continue
                        
                        # Trouver l'étudiant
                        try:
                            etudiant = Etudiant.objects.get(
                                nom__iexact=nom,
                                prenom__iexact=prenom
                            )
                        except Etudiant.DoesNotExist:
                            erreurs.append(f"Ligne {row_idx}: Étudiant {nom} {prenom} non trouvé")
                            notes_echouees += 1
                            continue
                        except Etudiant.MultipleObjectsReturned:
                            erreurs.append(f"Ligne {row_idx}: Plusieurs étudiants trouvés pour {nom} {prenom}")
                            notes_echouees += 1
                            continue
                        
                        # Créer ou mettre à jour la note
                        note_obj, created = Note.objects.update_or_create(
                            examen=examen,
                            etudiant=etudiant,
                            defaults={'note': note_valeur}
                        )
                        
                        notes_creees += 1
                    
                    except Exception as e:
                        erreurs.append(f"Ligne {row_idx}: Erreur - {str(e)}")
                        notes_echouees += 1
                
                # Afficher les résultats
                messages.success(request, f"✓ {notes_creees} note(s) importée(s) avec succès!")
                if erreurs:
                    for erreur in erreurs[:10]:  # Afficher max 10 erreurs
                        messages.warning(request, f"⚠ {erreur}")
                    if len(erreurs) > 10:
                        messages.warning(request, f"... et {len(erreurs) - 10} autre(s) erreur(s)")
                
                if prof_id:
                    return redirect('enseignant', id=prof_id)
                return redirect('/')
            
            except Exception as e:
                messages.error(request, f"Erreur lors du traitement du fichier: {str(e)}")
    else:
        form = ImportNotesForm()
    
    return render(request, 'app/import_notes.html', {
        'form': form,
        'prof_id': prof_id
    })


def telecharger_modele_notes(request):
    """
    Télécharge un modèle de fichier Excel pour l'import de notes
    """
    # Créer un nouveau classeur
    workbook = Workbook()
    worksheet = workbook.active
    worksheet.title = "Notes"
    
    # Ajouter les en-têtes
    worksheet['A1'] = "NOM"
    worksheet['B1'] = "PRENOM"
    worksheet['C1'] = "NOTE"
    
    # Formater les en-têtes
    from openpyxl.styles import Font, PatternFill
    header_fill = PatternFill(start_color="4472C4", end_color="4472C4", fill_type="solid")
    header_font = Font(bold=True, color="FFFFFF")
    
    for cell in ['A1', 'B1', 'C1']:
        worksheet[cell].fill = header_fill
        worksheet[cell].font = header_font
    
    # Ajouter des lignes d'exemple
    worksheet['A2'] = "Dupont"
    worksheet['B2'] = "Valentin"
    worksheet['C2'] = 14.5
    
    worksheet['A3'] = "Martin"
    worksheet['B3'] = "Claire"
    worksheet['C3'] = 16.0
    
    worksheet['A4'] = "Bernard"
    worksheet['B4'] = "Thomas"
    worksheet['C4'] = 12.5
    
    # Ajuster la largeur des colonnes
    worksheet.column_dimensions['A'].width = 20
    worksheet.column_dimensions['B'].width = 20
    worksheet.column_dimensions['C'].width = 15
    
    # Créer une réponse HTTP avec le fichier Excel
    response = HttpResponse(
        content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
    response['Content-Disposition'] = 'attachment; filename="modele_notes.xlsx"'
    
    workbook.save(response)
    return response
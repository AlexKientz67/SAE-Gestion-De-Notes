from django.urls import path

from . import views

urlpatterns = [

    path('', views.login_etudiant, name='login_etudiant'),
    path('enseignant/', views.login_enseignant, name='login_enseignant'),
    path('notes/<int:id>/', views.profil_etudiant, name='profil_etudiant'),
    path('ajout/etudiant/', views.ajout_etudiant, name='ajout_etudiant'),
    path('ajout/enseignant/', views.ajout_enseignant, name='ajout_enseignant'),
    path('ajout/ue/', views.ajout_ue, name='ajout_ue'),
    path('ajout/ressource/', views.ajout_ressource, name='ajout_ressource'),
    path('ajout/examens/', views.ajout_examens, name='ajout_examens'),
    path('ajout/notes/', views.ajout_notes, name='ajout_notes'),
    path('import/notes/', views.import_notes_excel, name='import_notes'),
    path('telecharger/modele-notes/', views.telecharger_modele_notes, name='telecharger_modele_notes'),
    path('import/etudiants/', views.import_etudiants_excel, name='import_etudiants'),
    path('telecharger/modele-etudiants/', views.telecharger_modele_etudiants, name='telecharger_modele_etudiants'),
    path('enseignant/<int:id>', views.profil_enseignant, name='enseignant'),

    path('modifier/etudiant/<int:id>/', views.modifier_etudiant, name='modifier_etudiant'),
]

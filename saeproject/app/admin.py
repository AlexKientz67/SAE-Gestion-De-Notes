from django.contrib import admin
from .models import Enseignants, UE, Ressources, Etudiant, Examen, Note

# Register your models here.
admin.site.register(Enseignants)
admin.site.register(UE)
admin.site.register(Ressources)
admin.site.register(Etudiant)
admin.site.register(Examen)
admin.site.register(Note)

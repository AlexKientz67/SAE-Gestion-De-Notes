from django.db import models

# Create your models here.
class Enseignants(models.Model):
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.nom} {self.prenom}"

class UE(models.Model):
    code = models.CharField(max_length=20, unique=True)
    nom = models.CharField(max_length=200)
    semestre = models.IntegerField()
    credits_ects = models.IntegerField()

    def __str__(self):
        return f"{self.code} {self.nom}"

class Ressources(models.Model):
    code = models.CharField(max_length=20, unique=True)
    nom = models.CharField(max_length=200)
    description = models.TextField()
    coefficient = models.FloatField()

    ues = models.ManyToManyField(UE, related_name='ressources', blank=True)

    def __str__(self):
        return f"{self.nom}"

class Etudiant(models.Model):
    numero_etudiant = models.CharField(max_length=20, unique=True)
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    groupe = models.CharField(max_length=20)

    photo = models.ImageField(upload_to='', null=True, blank=True)
    email = models.EmailField(unique=True)

    def __str__(self):
        return f"{self.prenom} - {self.nom} - {self.groupe}"

class Examen(models.Model):
    title = models.CharField(max_length=200)
    date = models.DateField()
    coefficient = models.FloatField()

    ressource = models.ForeignKey(Ressources, on_delete=models.CASCADE, null=True, blank=True)
    def __str__(self):
        return f"{self.title}"

class Note(models.Model):
    examen = models.ForeignKey(
        Examen,
        on_delete=models.CASCADE
    )

    etudiant = models.ForeignKey(
        Etudiant,
        on_delete=models.CASCADE
    )

    note = models.FloatField()

    class Meta:
        unique_together = ('examen', 'etudiant')

    def __str__(self):
        return f"{self.etudiant} - {self.note}"
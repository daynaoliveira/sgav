from django.db import models
import string
import random


def random_chassis(size=17, chars=string.ascii_uppercase + string.digits):
    v = ''.join(random.choice(chars) for _ in range(size))
    return v


class Car(models.Model):
    marca = models.CharField(max_length=75, null=False)
    modelo = models.CharField(max_length=75, null=False)
    placa = models.CharField(max_length=25, null=False)
    ano = models.CharField(max_length=4, null=True)
    cor = models.CharField(max_length=50, null=False)
    chassi = models.CharField(max_length=50, null=False)

    def __str__(self):
        return self.marca + ' - ' + self.modelo

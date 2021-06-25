from django.db import models

from cars.models import Car
from clients.models import Client


class Rental_Car(models.Model):
    id_carro = models.ForeignKey(
        Car, on_delete=models.CASCADE, related_name='rental_cars')
    id_cliente = models.ForeignKey(
        Client, on_delete=models.CASCADE, related_name='rental_cars')
    preco = models.DecimalField(max_digits=5, decimal_places=2, null=False)
    data_aluguel = models.DateTimeField(auto_now_add=True, null=False)
    data_retorno = models.DateField(
        auto_now=False, auto_now_add=False, null=True)
    retornou = models.CharField(max_length=1, null=True)
    data_criacao = models.DateTimeField(auto_now_add=True)
    data_atualizacao = models.DateTimeField(auto_now=True)

    def __str__(self):
        return 'O.S. nº '+str(self.id)+', '+str(self.id_cliente)

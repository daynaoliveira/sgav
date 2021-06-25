from django import forms
from django.db import models
from django.db.models import fields
from .models import Rental_Car


class RentalForm(forms.ModelForm):
    class Meta:
        model = Rental_Car
        fields = ('id_carro', 'id_cliente', 'preco', 'data_retorno')

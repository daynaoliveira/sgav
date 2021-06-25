from django import forms
from django.db import models
from django.db.models import fields
from .models import Car


class CarForm(forms.ModelForm):
    class Meta:
        model = Car
        fields = ('marca', 'modelo', 'placa', 'ano', 'cor')

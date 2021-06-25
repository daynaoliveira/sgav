from django import forms
from django.db import models
from django.db.models import fields
from .models import Client


class ClientForm(forms.ModelForm):
    class Meta:
        model = Client
        fields = ('nome', 'nascimento', 'rg', 'cpf_cnpj', 'celular',
                  'email', 'endereco', 'num', 'bairro', 'complemento')

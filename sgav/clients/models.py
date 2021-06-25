from django.db import models


class Client(models.Model):
    nome = models.CharField(max_length=75, null=False)
    nascimento = models.DateField(
        auto_now=False, auto_now_add=False, null=False)
    rg = models.CharField(max_length=25, null=True)
    cpf_cnpj = models.CharField(max_length=14, null=False)
    celular = models.CharField(max_length=11, null=False)
    email = models.CharField(max_length=75, null=True)
    endereco = models.CharField(max_length=75, null=False)
    num = models.CharField(max_length=5, null=False)
    bairro = models.CharField(max_length=75, null=False)
    complemento = models.CharField(max_length=75, null=True)

    def __str__(self):
        return self.nome + ' - ' + self.cpf_cnpj

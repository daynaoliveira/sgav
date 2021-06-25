from django.shortcuts import redirect, render, get_object_or_404
from django.contrib import messages
from .models import Client
from .forms import ClientForm


def clientsList(request):
    clients = Client.objects.all().order_by('nome')
    return render(request, 'clients/list.html', {'clients': clients})


def clientDetails(request, id):
    client = get_object_or_404(Client, pk=id)
    return render(request, 'clients/client.html', {'client': client})


def editClient(request, id):
    client = get_object_or_404(Client, pk=id)
    form = ClientForm(instance=client)
    if(request.method == 'POST'):
        form = ClientForm(request.POST, instance=client)
        if(form.is_valid()):
            client.save()
            return redirect('../../list/')
        else:
            return render(request, 'clients/edit.html',
                          {'form': form, 'client': client})
    else:
        return render(request, 'clients/edit.html', {'form': form,
                                                     'client': client})


def deleteCliente(request, id):
    client = get_object_or_404(Client, pk=id)
    client.delete()
    messages.info(request, 'Cliente deletado.')
    return redirect('../../list/')


def addClient(request):
    if request.method == 'POST':
        form = ClientForm(request.POST)
        if form.is_valid():
            client = form.save(commit=False)
            client.save()
            return redirect('../list/')
    else:
        form = ClientForm()
        return render(request, 'clients/add.html', {'form': form})

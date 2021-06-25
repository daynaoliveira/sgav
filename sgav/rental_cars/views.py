from django.shortcuts import redirect, render, get_object_or_404
from datetime import date
from .models import Rental_Car
from .forms import RentalForm
from decimal import Decimal


def rentalsLists(request):
    rental = Rental_Car.objects.all().filter(
        retornou='N').order_by('-data_criacao')
    return render(request, 'rental_cars/list.html', {'rentals': rental})


def rentalsListsFinal(request):
    rental = Rental_Car.objects.all().filter(
        retornou='S').order_by('-data_atualizacao')
    return render(request, 'rental_cars/list_final.html', {'rentals': rental})


def rentalDetails(request, id):
    rental = get_object_or_404(Rental_Car, pk=id)
    return render(request, 'rental_cars/rental.html', {'rental': rental})


def editRental(request, id):
    rental = get_object_or_404(Rental_Car, pk=id)
    form = RentalForm(instance=rental)
    if(request.method == 'POST'):
        form = RentalForm(request.POST, instance=rental)
        if(form.is_valid()):
            new_price = 0
            price = rental.preco
            i = 0.05
            dt_a = date.today()
            dt_r = rental.data_retorno

            d = abs((dt_a - dt_r).days)

            if(dt_a > dt_r):
                interest = Decimal(price) * Decimal(i) * d
                new_price = price + interest
            else:
                new_price = price

            rental.preco = Decimal(new_price)
            rental.retornou = 'S'
            rental.save()
            return redirect('../../list/')
        else:
            return render(request, 'rental_cars/edit.html',
                          {'form': form, 'rental': rental})
    else:
        return render(request, 'rental_cars/edit.html',
                      {'form': form, 'rental': rental})


def addRental(request):
    if request.method == 'POST':
        form = RentalForm(request.POST)
        if form.is_valid():
            rental = form.save(commit=False)
            rental.retornou = 'N'
            rental.save()
            return redirect('../list/')
    else:
        form = RentalForm()
        return render(request, 'rental_cars/add.html', {'form': form})

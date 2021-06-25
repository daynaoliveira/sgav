import string
import random
from django.shortcuts import redirect, render, get_object_or_404
from .models import Car
from .forms import CarForm


def random_chassis(size=17, chars=string.ascii_uppercase + string.digits):
    v = ''.join(random.choice(chars) for _ in range(size))
    return v


def home(request):
    return render(request, 'cars/home.html')


def carsList(request):
    cars = Car.objects.all().order_by('marca', 'modelo')
    # .order_by('marca')
    return render(request, 'cars/list.html', {'cars': cars})


def carDetails(request, id):
    car = get_object_or_404(Car, pk=id)
    return render(request, 'cars/car.html', {'car': car})


def editCar(request, id):
    car = get_object_or_404(Car, pk=id)
    form = CarForm(instance=car)
    if(request.method == 'POST'):
        form = CarForm(request.POST, instance=car)
        if(form.is_valid()):
            car.save()
            return redirect('../../')
        else:
            return render(request, 'cars/edit.html',
                          {'form': form, 'car': car})
    else:
        return render(request, 'cars/edit.html', {'form': form, 'car': car})


def addCar(request):
    if request.method == 'POST':
        form = CarForm(request.POST)
        if form.is_valid():
            car = form.save(commit=False)
            car.chassi = random_chassis()
            car.save()
            return redirect('../list/')
    else:
        form = CarForm()
        return render(request, 'cars/add.html', {'form': form})

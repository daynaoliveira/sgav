from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name="home"),
    path('list/', views.carsList, name='cars_list'),
    path('list/car/<int:id>', views.carDetails, name="car_details"),
    path('list/car/edit_car/<int:id>', views.editCar, name="edit-car"),
    path('add_car/', views.addCar, name="add_car")
]

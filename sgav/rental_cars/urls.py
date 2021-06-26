from django.urls import path
from . import views

urlpatterns = [
    path('list/', views.rentalsLists, name='rentals_list'),
    path('list/final', views.rentalsListsFinal, name='rentals_list_final'),
    path('list/rental/<int:id>', views.rentalDetails, name='rental_details'),
    path('list/edit_rental/<int:id>', views.editRental, name="edit_rental"),
    path('add_rental/', views.addRental, name="add_rental")
]

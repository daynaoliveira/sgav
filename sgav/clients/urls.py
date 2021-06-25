from django.urls import path
from . import views

urlpatterns = [
    path('list/', views.clientsList, name='clients_list'),
    path('list/client/<int:id>', views.clientDetails, name='client_details'),
    path('list/edit_client/<int:id>', views.editClient, name="edit_client"),
    path('list/delete/<int:id>', views.deleteCliente, name="delete_client"),
    path('add_client/', views.addClient, name="add_client")
]

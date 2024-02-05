from django.urls import path
from .views import * # using "*" means importing all the functions inside views


urlpatterns = [
    path('', index, name='landing-page'),
]

# -*- coding: cp1252 -*-
from django.shortcuts import render_to_response
from django import forms
from django.forms import ModelForm
from pyVisualCasa.models import Utente


#TODO ricontrollare
class User_form( ModelForm  ):
    class Meta :
        model = Utente
        fields = ( 'username', 'password')


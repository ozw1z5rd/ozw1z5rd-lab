# -*- coding: cp1252 -*-
from django.forms import ModelForm
from pyVisualCasa.models import Contatto

#
# Same name in Immobile.py, what a samw
#
class Contatto_form( ModelForm  ):
    class Meta :
        model = Contatto
        exclude = ( 'profilo', 'attivo')


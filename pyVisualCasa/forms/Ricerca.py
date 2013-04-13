# -*- coding: cp1252 -*-
from django.forms import ModelForm
from pyVisualCasa.models import Ricerca

#
# Same name in Immobile.py, what a samw
#
class Ricerca_form( ModelForm  ):
    class Meta :
        model = Ricerca
        exclude = ( profilo )

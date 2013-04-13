# -*- coding: cp1252 -*-
from django.forms import ModelForm
from settings import VC_DEBUG
from pyVisualCasa.models import RaccoltaDiFoto

#
# Same name in Immobile.py, what a samw
#
class Foto_form( ModelForm  ):
    class Meta :
        model = RaccoltaDiFoto


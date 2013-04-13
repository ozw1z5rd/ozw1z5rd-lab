# -*- coding: cp1252 -*-
from django.forms import ModelForm
from pyVisualCasa.models import Banner

#
# Same name in Immobile.py, what a samw
#
class Banner_form( ModelForm  ):
    class Meta :
        model = Banner
        fields = ( 'Immagine_Spot', 'numero_click', 'data_inizio', 'data_fine', 'CAP' )

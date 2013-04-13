# -*- coding: cp1252 -*-
from django.forms import ModelForm
from pyVisualCasa.models import Video


#
# Same name in Immobile.py, what a samw
#
class Video_form( ModelForm  ):
    class Meta :
        model = Video


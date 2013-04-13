# -*- coding: cp1252 -*-
from django.forms import ModelForm
from pyVisualCasa.models import Profilo



class Utente_form ( ModelForm ) :
    class Meta :
        model = Profilo
        exclude = ( 'attivo', 'annunci_disponibili  ', 'recupero_password', 'last_upload_date', 'last_upload_time',
                    'riceve_news', 'riceve_news_email', 'frequenza_news' )


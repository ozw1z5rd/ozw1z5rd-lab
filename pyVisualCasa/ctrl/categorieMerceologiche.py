# -*- coding: cp1252 -*-
from pyVisualCasa.models import CategoriaMerceologica
from django.shortcuts import render_to_response

def get_list( request ):
    return render_to_response( 'listaCategorieMerceologiche.html' ,
                               { 'cms' : CategoriaMerceologica.objects.all() }
                             )



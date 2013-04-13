# -*- coding: cp1252 -*-
from pyVisualCasa.forms.Ricerca import *
from pyVisualCasa.ctrl.base import CURD
from pyVisualCasa.models import Ricerca

class Ctrl_ricerca( CURD ) :

    template_file="ricerca.html"

    def get_form(self, **dict ):
        return Ricerca_form( **dict )

    def get_model(self, **dict):
        return Ricerca( **dict )
# -*- coding: cp1252 -*-
from pyVisualCasa.forms.Contatto import *
from pyVisualCasa.ctrl.base import CURD
from pyVisualCasa.models import Contatto

class Ctrl_contatto( CURD ) :
    template_file = "contatto.html"

    def get_form(self, *seq, **dict):
        return Contatto_form( *seq, **dict )

    def get_model(self, *seq, **dict):
        return Contatto( *seq, **dict )
    
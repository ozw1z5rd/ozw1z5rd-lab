# -*- coding: cp1252 -*-
from pyVisualCasa.forms.Foto import *
from pyVisualCasa.models import RaccoltaDiFoto
from pyVisualCasa.ctrl.base import CURD

class Ctrl_foto( CURD ) :
    template_file = "foto.html"

    def get_form(self, **dict):
        return Foto_form( **dict )

    def get_model(self, **dict):
        return RaccoltaDiFoto( **dict )

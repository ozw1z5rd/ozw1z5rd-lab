# -*- coding: cp1252 -*-
from pyVisualCasa.forms.Banner import *
from pyVisualCasa.ctrl.base import CURD
from pyVisualCasa.models import Banner

class Ctrl_banner( CURD ) :
    
    template_file="banner.html"

    def get_form(self, *seq, **dict ):
        return Banner_form( *seq, **dict )

    def get_model(self, *seq, **dict):
        return Banner( *seq, **dict )
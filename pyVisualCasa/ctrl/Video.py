# -*- coding: cp1252 -*-
from pyVisualCasa.forms.Video import *
from pyVisualCasa.ctrl.base import CURD
from pyVisualCasa.models import Video

class Ctrl_video( CURD ) :

    template_file="video.html"

    def get_form(self, *seq,  **dict ):
        return VideoForm( *seq, **dict )

    def get_model(self, *seq, **dict):
        return Video( *seq, **dict )
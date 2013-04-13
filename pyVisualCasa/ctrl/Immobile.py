# -*- coding: cp1252 -*-
from pyVisualCasa.forms.Immobile import Dynamic_immobile_form
from pyVisualCasa.forms.Utente import *
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response
from pyVisualCasa.models import Copertura, Pavimentazione, \
                                Impianto, Finitura, \
                                DestinazioneUrbanistica, Profilo, \
                                CategoriaMerceologica, \
                                Immobile

from pyVisualCasa.ctrl.base import CURD

#TODO controllare che l'utente non abbia raggiunto il massimo numero di annunci possibili

class Ctrl_immobile( CURD ):

    template_file = "immobile.html"

    def get_form(self, **dict):
        obj_cm = CategoriaMerceologica.objects.get( pk=dict['categoria_merceologica'] )
        return Dynamic_immobile_form( obj_cm )

    def get_model(self, **dict):
        return Immobile( **dict )

# TODO il modulo che appare non è corretto. (URGENTE)
    def anonymous_insert( self, request ):
        """
        la stessa url viene chimata con id_categoria ( questo solo la prima
        volta ) successivamente l'id categoria passa nel cookie e li rimane.
        c'è un variabile che rappresenta lo stato e viene aggiornato ad ogni
        paso.
        """

        request.logger.info("id_categoria = %s and state cookie = %s" % ( categoria_merceologica, request.session.get('_anonymous_state') ))
        request.logger.info("cookie id categoria = %s" % ( request.session.get('id_categoria') ))

# reset the cookie state, we dispatch call along the code using this value.
# we also store the id_categoria which we will loose in later calls, otherwise
# reload the data from the cookies.

        if categoria_merceologica :
            request.session['_anonymous_state'] = "load_immobile"
            request.session['id_categoria'] = categoria_merceologica

# reload and init anything
        _anonymous_state = request.session['_anonymous_state']

        cm = CategoriaMerceologica.objects.get( pk = request.session['id_categoria'] )

        if _anonymous_state == "load_immobile" :
# LOAD IMMOBILE ------------------------------------------------
            if request.method != 'POST' :
                form = Dynamic_immobile_form( cm )
                message = """Riempi i campi indicati, potrai inserire un video dopo che sarai stato verificato il tuo indirizzo di posta elettronica"""
            else:
                form = Dynamic_immobile_form( cm, request.POST )
                if form.is_valid(): 
# save the immobile data inside the session infos
                    fields_to_save = request.POST.keys()
                    for key in fields_to_save :
                        request.session[key] = request.POST.get( key, '')
                        request.logger.info("saving %s = %s " % ( key, request.session[key] ))

# pass the token
                    request.session['_anonymous_state'] = 'load_utente'
                    _anonymous_state = 'pass'

                    message = ""
                    request.logger.info("Immobile stored switching to load_utente")

                else:
                    message ="Correggi i dati qui sotto indicati"

        if _anonymous_state == "pass" or _anonymous_state == "load_utente" :
# LOAD UTENTE --------------------------------------------------
            if request.method != 'POST' or _anonymous_state == "pass" :
                form = Utente_form()
                message = """Inserisci i dati"""
            else:
                form = Utente_form( request.POST )
                if form.is_valid() :
                    userdb = form.save()
                    request.logger.info("Recovering the data from the session")
                            
                    immobile = Immobile(
                        utente_id_id            = userdb.id,
                        mq                      = _norm_to_float(request.session.get('mq','0')),
                        vani                    = _norm_to_int(request.session.get('vani','0')),
                        camere                  = _norm_to_int(request.session.get('camere','0')),
                        bagni                   = _norm_to_int(request.session.get('bagni','0')),
                        ripostigli              = _norm_to_int(request.session.get('ripostigli','0')),
                        balconi                 = _norm_to_int(request.session.get('balconi','0')),
                        terrazzo                = _norm_to_int(request.session.get('terrazzo','0')),
                        post_auto               = _norm_to_int(request.session.get('post_auto','0')),
                        garage                  = _norm_to_int(request.session.get('garage','0')),
                        prezzo                  = request.session.get('prezzo','0'),
                        giardino                = _norm_to_int(request.session.get('giardino','0')),
                        piscina                 = _norm_to_int(request.session.get('piscina','0')),
                        trattabile              = _norm_to_int(request.session.get('trattabile','0')),
                        destinazione_urbanistica= DestinazioneUrbanistica(id=request.session.get('destinazione_urbanistica','0')),
                        tipo_di_copertura       = Copertura(id=request.session.get('tipo_di_copertura','0')),
                        tipo_di_impianto        = Impianto(id=request.session.get('tipo_di_impianto','0')),
                        tipo_di_finitura        = Finitura(id=request.session.get('tipo_di_finitura','0')),
                        tipo_di_pavimentazione  = Pavimentazione(id=request.session.get('tipo_di_pavimentazione','0')),
                        indice_cubatura         = _norm_to_float(request.session.get('indice_cubatura','0')),
                        indice_cubatura_misura  = request.session.get('indice_cubatura_misura','0'),
                        numero_vetrine          = _norm_to_int(request.session.get('numero_vetrine','0')),
                        esposizione             = _norm_to_int(request.session.get('esposizione','0')),
                        categoria_merceologica  = CategoriaMerceologica(id=request.session.get('categoria_merceologica','0')),
                        periodo_di_attivita     = _norm_to_int(request.session.get('periodo_di_attivita','0')),
                        altezza                 = _norm_to_float(request.session.get('altezza','0')),
                        piazzale                = _norm_to_int(request.session.get('piazzale','0')),
                        numero_livelli          = _norm_to_int(request.session.get('numero_livelli','0')),
                        uffici                  = _norm_to_int(request.session.get('uffici','0')),
                        aree_verdi              = _norm_to_int(request.session.get('aree_verdi','0')),
                        tipo_contratto          = _norm_to_int(request.session.get('tipo_contratto','0')),
                    )
                    immobile.save()
                    message ="""ok"""
                    request.session['_anonymous_state'] = "complete"
                    HttpResponseRedirect('......') # TODO
                else:
                    message = """il form utente non era valido"""

        return render_to_response( 'insertImmobile.html', { 'form' : form, 'message' : message } )


def _norm_to_int( str ):
    if str == '' :
        return 0
    else:
        return int( str )


def _norm_to_float( str ):
    if str == '' :
        return 0.0
    else:
        return float( str )
#
# There are no check on parameter.. TODO FIX ME
#


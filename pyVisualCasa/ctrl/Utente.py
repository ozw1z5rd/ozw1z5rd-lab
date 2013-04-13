# -*- coding: cp1252 -*-
from django.shortcuts import render_to_response
from pyVisualCasa.ctrl.base import CURD
from pyVisualCasa.models import Immobile, Ricerca, Contatto, Banner, Posizione, CategoriaMerceologica
from pyVisualCasa.Exceptions import *

import datetime
from django.contrib.auth.decorators import login_required


class Ctrl_utente ( CURD ):
    
    @login_required
    def home(self , request):

        now=datetime.datetime.now()

        user = request.user
        try:
            profile = user.get_profile()
        except:
# TODO fix the exception for this software
            request.logger.critical("No profile has been defined for this user")
            raise Profile_missing_exception


        annunci_utente      = Immobile.objects.filter( profilo = profile.id )
        annunci_inseriti    = annunci_utente.count()
        annunci_ko          = annunci_utente.filter( non_approvato = False ).count()
        annunci_ok          = annunci_utente.filter( pubblicato    = True ).count()

        annunci_disponibili = profile.annunci_disponibili - annunci_inseriti

        annunci_pending     = annunci_inseriti - annunci_ko - annunci_ok

        ricerca             = Ricerca.objects.filter( profilo = profile.id )
        ricerche_salvate    = ricerca.count()

        contatti            = Contatto.objects.filter( profilo = profile.id)
        numero_contatti     = contatti.count()

        banner_utente  = Banner.objects.filter( profilo = profile.id )
        banner         = banner_utente.count()
        banner_scaduti = banner_utente.filter( profilo = profile.id).filter(data_fine__lte=now ).count()

        categorie_merceologiche = CategoriaMerceologica.objects.all()

        l_categorie_merceologiche = [ { 'descrizione' : cm.titolo , 'id' : cm.id } for cm in categorie_merceologiche ]

# No logo, no pics at all   
# TODO default empty pics

        try:
            logo_img_url = profile.logo.url
        except:
            logo_img_url = ""

        try:
            logo_small_img_url = profile.logo_small.url
        except:
            logo_small_img_url = ""

        l_annunci = []
        for annuncio in annunci_utente :
            posizione = Posizione.objects.filter( immobile = annuncio.id )[0]
            descrizione = "%s %s %s %s %s %s" % ( annuncio.categoria_merceologica, annuncio.tipo_contratto, posizione.via, annuncio.descrizione, annuncio.mq, annuncio.prezzo,  )
            l_annunci.append( { 'descrizione' : descrizione, 'id' : annuncio.id } )

# categoria merceologia | tipo contratto | via | descrizione + mq + prezzo

        l_ricerca  = [ { 'descrizione' : r.descrizione,
                         'id' : r.id } for r in ricerca]

        l_contatto = [ { 'descrizione' : "%s %s" % ( c.nome, c.cognome) ,
                         'id': c.id } for c in contatti ]

        l_banner   = [ { 'descrizione' : "Click residui %s data fine %s" % ( b.numero_click - b.click, b.data_fine ),
                         'id' : b.id,
                         'url': b.Immagine_Spot.url } for b in banner_utente ]

        return render_to_response( 'utenteHome.html',
            {  'nome'                : "%s %s" % ( user.first_name, user.last_name),
               'numero_annunci'      : annunci_inseriti,
               'annunci_pending'     : annunci_pending,
               'annunci_ko'          : annunci_ko,
               'annunci_disponibili' : annunci_disponibili,

               'livello_poweruser'   : profile.power_user,

               'ricerche_salvate'    : ricerche_salvate,

               'numero_contatti'     : numero_contatti,

               'numero_banner'       : banner,
               'banner_scaduti'      : banner_scaduti,

               'l_banners'           : l_banner,
               'l_annunci'           : l_annunci,
               'l_contatti'          : l_contatto,
               
# TODO messaggistica interna disabilitata
#              'l_messages'          : l_message,

               'l_ricerche'          : l_ricerca,
               'l_categorie_merceologiche' : l_categorie_merceologiche,

               'url_logo_miniatura'  : logo_small_img_url,
               'url_logo'            : logo_img_url
             } )


        template_file="utente.html"

        def get_form(self, **dict ):
            return Utente_form( **dict )

        def get_model(self, **dict):
            return Utente( **dict )
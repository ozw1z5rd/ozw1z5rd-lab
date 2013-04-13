# -*- coding: cp1252 -*-
from django.http import HttpResponseRedirect
from django.http import HttpResponse
from django.db.models import F,Q

from settings import MEDIA_URL, VC_DEBUG
from pyVisualCasa.models import CategoriaMerceologica, Immobile, Posizione, Banner, BannerSession, Video

from pyVisualCasa.ctrl.Banner import Ctrl_banner
from pyVisualCasa.ctrl.Video import  Ctrl_video
from pyVisualCasa.ctrl.Foto import Ctrl_foto
from pyVisualCasa.ctrl.Utente import Ctrl_utente
from pyVisualCasa.ctrl.Contatto import Ctrl_contatto
from pyVisualCasa.ctrl.Immobile import Ctrl_immobile
from pyVisualCasa.ctrl.Ricerca import Ctrl_ricerca

import Google
import md5
import time
import datetime
import string

# Mancano i percorsi ai file ( non e' possibile acedere ai dati ) 
fake_showroom_response = """
<visualCasaFooter>
<pic url="uno.jpg" desc="villetta" position="1" />
<pic url="uno.jpg" desc="appartamento" position="2" />
<pic url="uno.jpg" desc="terreno" position="3" />
<pic url="uno.jpg" desc="tuo" position="4" />
<pic url="d4e.jpg" desc="tuo" position="5" />
<pic url="uno.jpg" desc="tuo" position="6" />
</visualCasaFooter>"""

def get_cap_from_string ( request, string ) :
    pass


#
# get the sponsor record from the cookie
# after this:
#   update the sponsor record
#   redirect to the sponsor link
#

def get_banner_info( request ):
    pass


def redirect_to_banner( request, cookie ):
    """
    Purge the session banner table, then try to load the cookie's data
    """
    
    if VC_DEBUG:
        print cookie

    now=datetime.datetime.now()
    BannerSession.objects.filter(endtime__lt=now).delete()

    bs = BannerSession.objects.get( pk = cookie )
    
    
    if bs.url == "" :
        # TODO NOT A GOOD IDEA LEAVE THIS HARDCODED
        url = "http://www.visualcasa.it"
    else:
        url    = bs.url
        banner = Banner.objects.get( pk = bs.banner_id )
        banner.click = banner.click + 1
        banner.save()

    return HttpResponseRedirect( url )

#
# These call are limited, there is no way to get more than n record,
# so the paying ones are first.\
#
# all building infos in the area
def get_building_in_area( request, post_data ):
    return HttpResponse(post_data)

#
# Return the building described bu the query
# a xml input is required.
#
def get_buildings_by_query ( request ):

# recover from the GET dictionary all the data
    lista_categorie = []
    lista_contratto = []

# TODO CONVERT THE COMUNE IN CAP 
    CAP = request.GET.get('comune')

# build the categoria merceologia list
    for i in request.GET.keys():
        if i[0:3] == 'cat' :
            if  request.GET.get(i) == "1" :
                categoria = i.replace('cat','')
                lista_categorie.append(categoria)
                print "categoria #%s" % categoria

# no categoria mean all categorie
    if lista_categorie == [] :
        lista_categorie = [  c.id for c in CategoriaMerceologica.objects.all() ]

# build affitto / vendita list
# at least one category must be selected, if none then set them both

    if request.GET.get('affitti') == '1' :
        print "affitti si"
        lista_contratto.append(1) # CONTRATTO DI TIPO 1

    if request.GET.get('vendite') == '1' :
        print "vendite si"
        lista_contratto.append(2) # CONTRATTO DI TIPO 2

    if lista_contratto == [] :
        lista_contratto.append(1)
        lista_contratto.append(2)
        print "forzate entrambe"

    if lista_categorie == [] :
        categorie = CategoriaMerceologica.object.all().id
        lista_categorie = ( cm.id for cm in categorie )
        print "abilitate tutte le categorie"

# TODO controllare che abbia inserito un CAP e se non e' un cap ricavare il nome
# dal nome del comune.


    if VC_DEBUG :
            print "Dumping query parameters"
            print "CAP " + CAP
            print "Contratti "
            print lista_contratto
            print "Categoria Mercologia "
            print lista_categorie


#TODO Wroste, It's using the select_related, but it's not an happy choice

    lista_immobili  = Immobile.objects.select_related().filter( \
                            posizione__CAP = CAP, \
                            tipo_contratto__in=lista_contratto, \
                            categoria_merceologica__in=lista_categorie );

# TODO we are taking the 1st result..
#      doing no safety checks

    ls_imm = []
    for i in lista_immobili :
        posizione = Posizione.objects.filter( immobile=i.id )[0]
        ls_imm.append({  'lat' : posizione.google_lat,
                         'lan' : posizione.google_lan,
                         'mq'  : i.mq,
                         'desc': i.descrizione,
                         'prz' : i.prezzo,
                         'ok'  : 1,
                         'id'  : i.id,
                    })

    response = __return_building_list( ls_imm )
    return HttpResponse( response )

# all video for the area
def get_videos_in_area ( request ):
    pass

# the number fo building inside the db

def get_buildings_n( request ):
    lista_immobili =  []

# todo usare la chiave sulla tabella immobile...

    response = ""

    if Posizione.objects.filter( immobile__pubblicato = True ).count() > 0:

#TODO ADD LIMIT
        lista_posizioni = Posizione.objects.filter( immobile__pubblicato = True )
        lista_immobili = [ { 'lat' : o.google_lat,
                             'lan' : o.google_lan,
                             'mq'  : o.immobile.mq,
                             'desc': o.immobile.descrizione,
                             'prz' : o.immobile.prezzo,
                             'id'  : o.immobile.id,
                             'ok'  : o.immobile.pubblicato } for o in lista_posizioni ]

# Old Code for debug purpose, to be removed    
        response = __return_building_list( lista_immobili )
        
    return HttpResponse( response )



# the number of video inside the db
def get_videos_n ( request ):
    pass

#
# Initialize the header returing the info for the availables categories
#
def get_header_info( request ):
    
    lista_categorie=[ ( cm.titolo ) for cm in CategoriaMerceologica.objects.all().order_by('ordine_visualizzazione') ]
    response = "<visualcasaHeader><categorie>"
                    
    for i in lista_categorie:
        response = response + "<nome>"+i+"</nome>"

    response = response + "</categorie>"

    numero_immobili = Immobile.objects.count() # TODO deve estrarre solo quelli pubblicati

    response = response + "<annunci numero='%d' >" % numero_immobili
    response = response + "</VisualCasaHeader>"
    return HttpResponse( response )
    
#
# Return the data for the showroom slider
# TODO  : non ha espresso nessuna indicazione sul particolare tipo di query
#         quindi seleziona tutto in base al comune in cui l'utente di trova
#

def get_showroom_info( request, CAP ):
    """
    Returns the data for the show room in the bottom page
    """


    return HttpResponse( fake_showroom_response )


def get_banners_by_cap ( request, CAP ):
    """
    return the banner list in XML format ( it's processed by flash, so no
    conversion in cvs.
    """
# Tutti i banner che sono nel comune corrente e che non sono stati ancora
# invalidati dalla data oppure dal numero dei click

    now = datetime.datetime.now()
    dt_1day = datetime.timedelta(days=1)

    b_count = Banner.objects.filter( CAP = CAP,  \
                                     click__lte=F('numero_click'), \
                                     data_fine__gte=now, data_inizio__lte=now \
                                    ).count()

# check if there are banners suitable for this CAP
# it none, uses any available banner.

    if b_count > 0 :
        banners = Banner.objects.filter( CAP = CAP,  \
                                         click__lte=F('numero_click'), \
                                         data_fine__gte=now, data_inizio__lte=now \
                                        ).order_by('priorita')
    else:
        banners = Banner.objects.filter( click__lte=F('numero_click'), \
                                         data_fine__gte=now, data_inizio__lte=now \
                                        ).order_by('priorita')


    res =  []
    total_x = 0
    
# store the cookie in the table, delete the previous cookie out of date if any

    for banner in banners[0:9] :

        total_x = total_x + banner.xsize
        if total_x > 1024 :
            break

        cookie = md5.new( banner.link + str( time.time() ) ).hexdigest()
        session = BannerSession( cookie = cookie, \
                                 endtime = (now + dt_1day).strftime("%Y-%m-%d"), \
                                 url = banner.link, \
                                 banner_id = banner.id )
        session.save()

        re_ =   MEDIA_URL + str(banner.Immagine_Spot) + "|" + cookie 

        res.append(re_)

    return HttpResponse( string.join(res,";" ) )



def get_building_info_by_videoid( request, videoid ):
    """
    Return the building info which belongs to the video id given, not all
    fields are returned, just the ones required by the categoria
    """

    html = []

    if not Immobile.objects.get( video__id = videoid ) :
        print """ E' stato chiesto di recupeare le informazioni per un un
        immobile associato ad un video che è stato pubblicato, ma non c'e'
        nessuna registazione di immobile che faccia capo a questo video."""
        return "ko"

    immobile = Immobile.objects.get( video__id = videoid  )
    
# TODO skippare tutti i campi non indicati
    for field in immobile.categoria_merceologica.list_fields:
        if getattr( immobile.categoria_merceologica, field ) == 1 :            
            value = getattr( immobile, field )
            html.append( "\"%s\"=\"%s\"" % ( field, value  ) )


    return HttpResponse( string.join( html, "&" ) )


def __return_building_list( lista_immobili ):
    """
    Return the building list adding the center and the zoom factor.
    Comma separated buildings list + [lat, lan, zoom ]
    """
    
    lat = 0.00
    lan = 0.00
    list_lat = []
    list_lan = []
    
    response = ""
    n = lista_immobili.__len__()

    if n != 0 :

        for i in lista_immobili :
            if response.__len__() != 0 :
                response = response + "#"

            lat = lat + i['lat']
            lan = lan + i['lan']

            list_lan.append( i['lan'] )
            list_lat.append( i['lat'] )

            response = response + """
                    "%s","%s","%s","%s","%s","%s"
            """ % ( i['lat'], i['lan'], i['mq'], i['desc'], i['prz'], i['id'] )

# get the zoom factor
# pack the data in the answer

        print " (%s %s) (%s %s)" % ( min(list_lat), min(list_lan), max(list_lat), max(list_lan) )

        d = Google.point_distance( min(list_lat), min(list_lan), max(list_lat), max(list_lan) )
        zoom = Google.get_zoom_value( d )

# immobile was an empty list, building custom values
    else:
        zoom = 9
        lat = 42.4424572
        lan = 14.2096282
        n = 1

    response = response + "[%f,%f,%d]" % (lat/n, lan/n, zoom)
        
    return response

#//////////////////////////////////////////////////////////////////////////


def insert_banner( request ):
    return Ctrl_banner().insert( request )

def edit_banner( request ):
    return Ctrl_banner().edit( request )

def delete_banner( request ):
    return Ctrl_banner().delete( request )

def list_banner( request ):
    return Ctrl_banner().list( request )

#//////////////////////////////////////////////////////////////////////////

def insert_contatto( request ):
    return Ctrl_contatto().insert( request )

def edit_contatto( request ):
    return Ctrl_contatto().edit( request )

def delete_contatto( request ):
    return Ctrl_contatto().delete( request )

def list_contatto( request ):
    return Ctrl_contatto().list( request )

#//////////////////////////////////////////////////////////////////////////

def insert_ricerca( request ):
    return Ctrl_ricerca().insert( request )

def edit_ricerca( request ):
    return Ctrl_ricerca().edit( request )

def delete_ricerca( request ):
    return Ctrl_ricerca().delete( request )

def list_ricerca( request ):
    return Ctrl_ricerca().list( request )


#//////////////////////////////////////////////////////////////////////////

def insert_immobile( request, cm ):
    request.logger.warning("Insert immobile has %s as categoria merceologica" % ( cm ))
    return Ctrl_immobile().insert( request, categoria_merceologica=cm )

def edit_immobile( request ):
    return Ctrl_immobile().edit( request )

def delete_immobile( request ):
    return Ctrl_immobile().delete( request )

def anonymous_insert( request, id_categoria ):
    return Ctrl_immobile().anonymous_insert( request, categoria_merceologica=id_categoria )

#//////////////////////////////////////////////////////////////////////////


def insert_video( request ):
    return Ctrl_video().insert( request )

def edit_video( request ):
    return Ctrl_video().edit( request )

def delete_video( request ):
    return Ctrl_video().delete( request )

def list_video( request ):
    return Ctrl_video().list( request )

#//////////////////////////////////////////////////////////////////////////

def insert_foto( request ):
    return Ctrl_foto().insert( request )

def edit_foto( request ):
    return Ctrl_foto().edit( request )

def delete_foto( request ):
    return Ctrl_foto().delete( request )

def list_foto( request ):
    return Ctrl_foto().list( request )

def list_immobile( request ):
    return Ctrl_immobile().list( request )

#//////////////////////////////////////////////////////////////////////////

def insert_ricerca( request ):
    return Ctrl_ricerca().insert( request )

def edit_ricerca( request ):
    return Ctrl_ricerca().edit( request )

def delete_ricerca( request ):
    return Ctrl_ricerca().delete( request )

def list_ricerca( request ):
    return Ctrl_ricerca().list( request )

#//////////////////////////////////////////////////////////////////////////

def utente_login( request ):
    return Ctrl_utente().login( request )

def utente_home( request ):
    return Ctrl_utente().home( request )
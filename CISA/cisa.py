#
# Quick and dirty cisa recovery
# fascia inferiore sempre verde
#
import cgi
import datetime
import logging
from google.appengine.api import users
from google.appengine.api import images

from jinja2 import Template
from Model import * 
from AdminCategory import * 
from AdminProduct import *
from AdminHtml import *
from AdminCSS import * 
from StandardPage import *
from DataStore import * 
from HTML import * 
from MainPage import *
from FrontPage import * 

class resizeImages( StandardPage ):

    def get( self ):
        print "mi preparo al prelevo delle immagini.."
        j = Articolo.all().fetch(500)
        print "fatto... inzio ciclo"
        c = 0
        for a in j:
            print c
            c += 1
            if a.immagine:
                a.thumb= images.resize( a.immagine, 85,115 )
            else: 
                print "immagine vuota"

class LoadData( StandardPage ):
    def get( self ):
        for i in Categoria.all():
            i.delete()
        for i in Articolo.all():
            i.delete()

        c1 = Categoria( pos= 1,titolo="uno", coloreFB="000", coloreBG="22f", ).save().id()
        c2 = Categoria( pos= 2,titolo="due", coloreFB="000", coloreBG="3ff", ).save().id()
        c3 = Categoria( pos= 3,titolo="tre", coloreFB="000", coloreBG="f4f", ).save().id()
        c4 = Categoria( pos= 4,titolo="quattro", coloreFB="000", coloreBG="59f", ).save().id()
        Categoria( pos= 5,titolo="cinque", coloreFB="000", coloreBG="76f", ).save()
        Categoria( pos= 6,titolo="sei", coloreFB="000", coloreBG="71f", ).save()
        Categoria( pos= 7,titolo="sette", coloreFB="000", coloreBG="67f", ).save()

        Articolo(  titolo="articolo 1 1", descrizione="..", catid = c1 ).save()
        Articolo(  titolo="articolo 2 1", descrizione="..", catid = c1 ).save()
        Articolo(  titolo="articolo 3 1", descrizione="..", catid = c1 ).save()
        Articolo(  titolo="articolo 4 1", descrizione="..", catid = c1 ).save()
        Articolo(  titolo="articolo 1 2", descrizione="..", catid = c2 ).save()
        Articolo(  titolo="articolo 2 2", descrizione="..", catid = c2 ).save()
        Articolo(  titolo="articolo 1 3", descrizione="..", catid = c3 ).save()
        Articolo(  titolo="articolo 1 4", descrizione="..", catid = c4 ).save()

        DynamicHTML( tag="1", titolo="pagina1" ).save()
        DynamicHTML( tag="2", titolo="pagina2" ).save()
        DynamicHTML( tag="3", titolo="pagina3" ).save()
        DynamicHTML( tag="4", titolo="pagina4" ).save()

        self.response.out.write("Data loaded ")        

#
# MAIN
#
      
app = webapp2.WSGIApplication([
        ( '/', FrontPage ),
        ( '/Catalogo', MainPage ),
        ( '/AdminHTML', AdminHTML),
        ( '/HTML', HTML),
	( '/Pages', MainPage ),
        ( '/PostHTML', AdminHTML),
        ( '/Admin', AdminCategory ),
        ( '/PostCategoria', AdminCategory ),
        ( '/AdminProduct', AdminProduct ),
        ( '/DataStoreImage/.*', DataStoreImage ),
        ( '/DataStorePDF/.*', DataStorePDF ),
        ( '/PostArticolo', AdminProduct ),
        ( '/ResizeImages', resizeImages),
        ( '/LoadData', LoadData ),
        ( '/AdminCSS', AdminCSS ),
        ( '/PostCSS', AdminCSS )
], debug=True )


from StandardPage import * 
from Model import * 
from google.appengine.api import images



#
# Questo codice andrebbe un attimo riorganizzato...
#

class DataStorePDF( StandardPage ):
    def get( self ):
        path = self.request.path
        binData = None
        ( svoid1, svoid, stype, ssize, sid ) = path.split("/")
        id = int ( sid )
        self.response.headers['Content-Type'] = 'application/pdf'
        if stype == "Articolo" : 
            articolo = Articolo().get_by_id( id  )
            if ssize == "PDF":
                binData = articolo.scheda 
            else:
                binData = None
        self.response.out.write( binData ) 


class DataStoreImage( StandardPage ):
    def get( self ):
        path = self.request.path
        binData = None
        ( svoid1, svoid, stype, ssize, sid ) = path.split("/")
        id = int ( sid )
        self.response.headers['Content-Type'] = 'image/jpeg'

        if stype == "Articolo" : 
            articolo = Articolo().get_by_id( id  )
            if ssize == "Big":
                binData = articolo.immagine 
            else:
                if 0 and articolo.immagine:
                     articolo.thumb = images.resize( articolo.immagine, 90, 120 )
                     articolo.put()
                     articolo.save()
                binData = articolo.thumb
        elif stype == "Categoria":
            categoria = Categoria().get_by_id( id )
            if ssize == "Big":
                binData = categoria.immagineB
            else:
                binData = categoria.immagineA
        elif stype == 'HTML' : 
            HTML = DynamicHTML().getHTMLbyTag( str(id ) )
            if ssize == 'Big' : 
                binData = HTML.immagineB
            else:
                binData = HTML.immagineA

  #      if binData == None : 
  #          binData = file.read( 
    
        return self.response.out.write( binData )
    


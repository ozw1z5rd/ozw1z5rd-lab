from StandardPage import * 
from Model import *

class AdminHTML( StandardPage ):
        
    def get( self ):
        tag = self.request.get("tag")
        form = DynamicHTML().getForm( tag )
        template = DynamicHTML().getTemplate( )
        self.render( template.render( form = form, tag = tag ) )

    def post( self ):
        tag = self.request.get("tag")
        html = self.request.get("html")
        ht = DynamicHTML.getHTMLbyTag( tag )
        coloreFG    = str(self.request.get('coloreFG'))
        coloreBG    = str(self.request.get('coloreBG'))
        immagineA   = self.request.get('immagineA')
        immagineB   = self.request.get('immagineB')
    
        if ht is None :
            ht = DynamicHTML( )
        ht.html = html
        ht.tag = tag
        ht.coloreFG = coloreFG
        ht.coloreBG = coloreBG
        if len( immagineA ) > 0:
            ht.immagineA = db.Blob(immagineA)
        if len( immagineB ) > 0:
            ht.immagineB = db.Blob(immagineB)

        ht.put()
        self.redirect("/Admin")
    


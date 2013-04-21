from StandardPage import * 

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

        return self.response.out.write( binData )
    


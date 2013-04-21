from StandardPage import * 
from Model import *

class AdminProduct( StandardPage ):

# categoria corrente
    c = 0

    def linkToHome( self ):
        return "<p>Categoria cancellata, clicca per <a href='/AdminProduct?c=%s'>continuare</a>"    % ( self.c ) 
    
#
# lista tutti gli articoli di una certa categoria
#
    def listProductByCatId(self, catid):
        cat = Categoria().getCategoriaById( catid )
        articoli = Articolo().getListArticoloByCatId( catid )
        
        html = "<h1>Lista articoli per la categoria %s</h1> <ol>" % ( cat.titolo )
        if articoli is not None:
            for articolo in articoli:
                html += "<li><img src='/DataStoreImage/Articolo/Small/%s'>" % ( articolo.key().id()  ) 
                html += "%s,  <a href='/AdminProduct?a=e&p=%s&c=%s'>modifica</a> <a href='/AdminProduct?a=d&p=%s&c=%s'>cancella</a>" \
                % ( articolo.titolo, articolo.key().id(), catid, articolo.key().id(), catid)
            html += "</ol>"
        else:
            html += "<p>Nessun articolo in questa categoria"
        html += "<p><a href='/AdminProduct?a=i&c=%s'>Aggiungi prodotto in questa categoria</a>" % ( catid  ) 
        html += "<p><a href='/Admin'>Indietro alla lista delle categorie</a>"
        return html

    def insert(self, c):
        articolo = Articolo( catid = c )
# TODO spostare il passaggio dei default nel codice che ritorna il form
        form = model_form( Articolo, field_args={ 'catid' : { 'default' : c  } } )()
        template = Articolo().getTemplate( )
        return template.render( form = form, id = '' )

    def delete(self, prodid ):
        articolo = Articolo().getArticoloById( prodid )
        if articolo is not None:
            articolo.delete()
        return self.linkToHome()

    def edit(self, artid ):
        form = Articolo().getForm( artid )
        template = Articolo().getTemplate( )
        return template.render( form = form, id = artid )

    def get(self):

        p = int( self.request.get("p") or "1" )
        c = int( self.request.get("c") or "1" )
        a = str(self.request.get("a") or "")

        r = ""
        if a == "e":
            r = self.edit( p )
        elif a == "d":
            self.c = c # salva la cat per il link alla home
            r = self.delete( p )
        elif a == "i":
            r = self.insert( c )
        elif a == "m":
            r = None
        else: 
            r = self.listProductByCatId( c ) 

        self.render( r ) 

#
# TODO deve tornare alla pagina della lista con gli articoli per la categoria visualizzata prima
#
    def post(self):
#       c           = int(self.request.get('c'))
        id          = int(self.request.get('id') or "0" )
        catid       = int(self.request.get('catid') or "99" )           
        titolo      = str(self.request.get('titolo'))
        descrizione = str(self.request.get('descrizione'))
        immagine    = self.request.get('immagine')
        variante1   = self.request.get('variante1')
        variante2   = self.request.get('variante2')
        variante3   = self.request.get('variante3')
        variante4   = self.request.get('variante4')
        variante5   = self.request.get('variante5')
        variante6   = self.request.get('variante6')
        variante7   = self.request.get('variante7')
        variante8   = self.request.get('variante8')
        variante9   = self.request.get('variante9')

        articolo = None

        if id is not 0:
            articolo = Articolo().getArticoloById( id )
        if articolo is None:
            articolo = Articolo( )

        articolo.catid        = catid        
        articolo.titolo       = titolo   
        articolo.descrizione  = descrizione 
        if immagine is not None and len( immagine ) > 0 :
            articolo.immagine = db.Blob( immagine ) 
            articolo.thumb    = db.Blob( images.resize( immagine, 120, 120 ) )
        articolo.variante1    = variante1   
        articolo.variante2    = variante2   
        articolo.variante3    = variante3   
        articolo.variante4    = variante4   
        articolo.variante5    = variante5   
        articolo.variante6    = variante6   
        articolo.variante7    = variante7   
        articolo.variante8    = variante8   
        articolo.variante9    = variante9   

        articolo.save()
        
        self.redirect("/Admin")

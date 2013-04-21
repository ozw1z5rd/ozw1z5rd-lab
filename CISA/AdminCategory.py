from StandardPage import * 
from Model import *
from google.appengine.api import users
from Model import CSS

#
# TODO : aggiungere il controllo per amministratori DOPO che gli script hanno caricato..
#

class AdminCategory( StandardPage ):

    def top( self ):
        cssCode = CSS().get().css
        return """
        <html>
        <head>
              <script type="text/javascript" src="/Static/tinymce/jscripts/tiny_mce/tiny_mce.js" ></script>
              <script>

tinyMCE.init({
                    mode : "specific_textareas",
                    editor_deselector: "noEditor",     
                    theme : "advanced",   //(n.b. no trailing comma, this will be critical as you experiment later)
                    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull",
                    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,cleanup,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
                    theme_advanced_toolbar_location : "top",
                    theme_advanced_toolbar_align : "left",
                    theme_advanced_statusbar_location : "bottom",
                    theme_advanced_resizing : true,
            });



             </script>
        </head>
        <body>
        <div style="width: 100%; height: 1cm; background-color: #9cbf1a;"></div>
        """

    def bottom( self ): 
        return """
        <div style="width: 100%; height: 0.2cm; background-color: #9cbf1a;"></div>
        </body>
        </html>
        """
#
# Main page ( the index. ) 
#   
    def mainpage(self):

        user = users.get_current_user()
        if not user :
            html = "<a href='%s'>Questa area e\' ad accesso riservato, per favore clicca ed accedi</a>" % ( users.create_login_url("/Admin") )
            return html 

        elif not users.is_current_user_admin()  : 
            html = "Questa parte del servizio e' accessibile solo agli amministratori"
            return html

        return """
        <html>
          <body>
	    <img src="https://developers.google.com/appengine/images/appengine-noborder-120x30.gif" alt="Powered by Google App Engine" />
            <a href='%s'>ESCI</a> / 
	    <a href="https://www.google.com/analytics/web/#realtime/rt-overview/a31577268w58399455p59618783/">BUSINESS INTEL.</a> /
            <a href="https://appengine.google.com/dashboard?&app_id=s~cisasas">APPLICAZIONE</a> / 
	    <a href="https://appengine.google.com/dashboard/quotadetails?&app_id=s~cisasas&version_id=1.358853136337872454">RISORSE</a>
            <h1>lista delle categorie presenti</h1>
            %s
          <h2>testi statici</h2>
          <ul>
            <li><input type="button" value="Chi siamo" onclick="javascript:document.location.href='/AdminHTML?tag=1'">
            <li><a href="/AdminHTML?tag=2">dove siamo</a>
            <li><a href="/AdminHTML?tag=3">contatti</a>
            <li><a href="/AdminHTML?tag=4">carosello</a>

           </ul>
	   <h2>CSS</h2>
	    <ul>
	     <li><a href="/AdminCSS">CSS</a>
            </ul>
          </body>
        </html>
        """ % (  users.create_logout_url("/Admin"), self.listcategories() )
 
    def linktohome( self ):
        return "categoria cancellata, clicca per <a href='/Admin'>continuare</a>"

    def delete(self, catid):
        cat = Categoria().getCategoriaById( catid )
        if cat is not None:
            cat.delete()
        return self.linktohome()

    def edit(self, catid ):
        form = Categoria().getForm( catid )
        template = Categoria().getTemplate( )
        return template.render( form = form, id = catid )

    def insert( self ):
        form = Categoria().getForm( None )
        template = Categoria().getTemplate( )
        return template.render( form = form, id = '' )
            
    def listcategories( self ):
        html = ""
        counter = 1;
        for cat in Categoria().all():
            html += """<br><br>%s. %s<br> <input type="button" value="Lista articoli" onclick="javascript:document.location.href='/AdminProduct?c=%s'"> 
                <input type="button" value="Modifica categoria" onclick="javascript:document.location.href='/Admin?a=e&c=%s'"> 
                <input type="button" value="Aggiungi prodotto" onclick="javascript:document.location.href='/AdminProduct?a=i&c=%s'"> 
                <input type="button" value="Cancella la categoria" onclick="javascript:if(confirm('Cancelli la categoria e tutti gli articoli che contiene ?')){document.location.href='/Admin?a=d&c=%s'}else{return false}"> """ \
                % ( counter, cat.titolo, cat.key().id(), cat.key().id(), cat.key().id(),  cat.key().id() )
            counter = counter + 1
        html += "<br><br>"
        html += """<input type="button" value="Aggiungi una categoria" onclick="javascript:document.location.href='/Admin?a=i'">"""
        return html

    def get(self):
        a = self.request.get("a")
        c = int(self.request.get("c") or "0" )

        r = self.mainpage()

        if a == "e":
            r = self.edit( c )
        if a == "d":
            r = self.delete( c )
        if a == "i":
            r = self.insert( )  

        return self.render(r)

    def post( self ):

        self.validateUserIsAdmin( )

        id          = int(self.request.get('id') or "0" )
        pos         = int(self.request.get('pos') or "99" )         
        titolo      = str(self.request.get('titolo'))
        colorefg    = str(self.request.get('coloreFG'))
        colorebg    = str(self.request.get('coloreBG'))
        immaginea   = self.request.get('immagineA')
        immagineb   = self.request.get('immagineB')

        categoria = None

        if id is not 0:
            categoria = Categoria().getCategoriaById( id )
        if categoria is None:
            categoria = Categoria( )

        categoria.pos       = pos
        categoria.titolo    = titolo
        categoria.coloreFG  = colorefg
        categoria.coloreBG  = colorebg
        
        # in guestbook passa per un resize della classe image
        if len( immaginea ) > 0:
            categoria.immagineA = db.Blob(immaginea)
        if len( immagineb ) > 0:
            categoria.immagineB = db.Blob(immagineb)

        categoria.save()
        
        self.redirect("/Admin")
    #   return self.linkToHome()


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
                html += """%s,  <input type="button" value="modifica" onclick="javascript:document.location.href='/AdminProduct?a=e&p=%s&c=%s'"> <input type="button" value="cancella articolo" onclick="javascript:document.location.href='/AdminProduct?a=d&p=%s&c=%s'">""" \
                % ( articolo.titolo, articolo.key().id(), catid, articolo.key().id(), catid)
            html += "</ol>"
        else:
            html += "<p>Nessun articolo in questa categoria"
        html += """<p><input type="button" value="Aggiungi un prodotto in questa categoria" onclick="javascript:document.location.href='/AdminProduct?a=i&c=%s'>""" % ( catid  ) 
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

    	self.validateUserIsAdmin()

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

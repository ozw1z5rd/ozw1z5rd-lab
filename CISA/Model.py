from google.appengine.ext import db
from wtforms.ext.appengine.db import model_form
from jinja2 import Template
from google.appengine.api import images

#
# Model
#
class Articolo( db.Model ):
    catid       = db.IntegerProperty()  
    titolo      = db.StringProperty()
    descrizione = db.TextProperty()
    immagine    = db.BlobProperty()
    thumb       = db.BlobProperty()
    scheda      = db.BlobProperty()
    pos         = db.IntegerProperty() ## keep things in order
    # codice, barcode, confezione, crt, pallet
    variante1   = db.StringProperty()
    variante2   = db.StringProperty()
    variante3   = db.StringProperty()
    variante4   = db.StringProperty()
    variante5   = db.StringProperty()
    variante6   = db.StringProperty()
    variante7   = db.StringProperty()
    variante8   = db.StringProperty()
    variante9   = db.StringProperty()

    @staticmethod
    def getArticoloById( prodid ):
        return Articolo().get_by_id( prodid )

    @staticmethod
    def getListArticoloByCatId( catid ):
        #return Articolo().all().filter("catid = ", catid ).fetch(200)
        return Articolo().all().order('pos').filter("catid = ", catid ).fetch(200)
    
    @staticmethod
    def getForm( prodid ):
        f = model_form( Articolo, exclude = ( 'thumb' ) ) 
        if prodid is None:
            return f()
        articolo = Articolo.getArticoloById( prodid )
        form = f( None, articolo )
        return form
        
    
    @staticmethod
    def getTemplate():
        return  Template("""
        <form action='/PostArticolo' method='post' enctype='multipart/form-data'>
        <table>
        <tr>
            <th>{{ form.catid.label }}</th>
            <td>{{ form.catid }}</td>
        </tr>
        <tr>
            <th>{{ form.titolo.label }}</th>
            <td>{{ form.titolo }}</td>
        </tr>
    <tr>
            <th>{{ form.pos.label }}</th>
            <td>{{ form.pos }}</td>
        </tr>
        <tr>
            <th>{{ form.descrizione.label }}</th>
            <td>{{ form.descrizione}}</td>
        </tr>
        <tr>
            <th>{{ form.immagine.label }}</th>
            <td><input id="immagine" name="immagine" type="file"></td>
        </tr>
        <tr>
            <th>{{ form.scheda.label }}</th>
            <td><input id="scheda" name="scheda" type="file"></td>
        </tr>
    <tr>
            <th>{{ form.variante1.label }}</th>
            <td>{{ form.variante1 }}</td>
        </tr>
        <tr>
            <th>{{ form.variante2.label }}</th>
            <td>{{ form.variante2 }}</td>
        </tr>
        <tr>
            <th>{{ form.variante3.label }}</th>
            <td>{{ form.variante3 }}</td>
            
        </tr>
        <tr>
            <th>{{ form.variante4.label }}</th>
            <td>{{ form.variante4 }}</td>
        </tr>
        <tr>
            <th>{{ form.variante5.label }}</th>
            <td>{{ form.variante5 }}</td>
        </tr>
        <tr>
            <th>{{ form.variante6.label }}</th>
            <td>{{ form.variante6 }}</td>
        </tr>
        <tr>
            <th>{{ form.variante7.label }}</th>
            <td>{{ form.variante7 }}</td>
        </tr>
        <tr>
            <th>{{ form.variante8.label }}</th>
            <td>{{ form.variante8 }}</td>
        </tr>
        <tr>
            <th>{{ form.variante9.label }}</th>
            <td>{{ form.variante9 }}</td>
        </tr>
    </table>
        <input type='hidden' name='id' value='{{ id }}'>
        <input type='submit' value='registra' >
        </form>
        """)    
        
class Categoria(db.Model):
    pos     = db.IntegerProperty()
    titolo      = db.StringProperty()
    coloreFG    = db.StringProperty()
    coloreBG    = db.StringProperty()
    immagineA   = db.BlobProperty()
    immagineB   = db.BlobProperty()

    @staticmethod
    def getCategoriaById( id ):
        #return Categoria().all().filter('recn =', id ).fetch(1)[0]
        return Categoria().get_by_id( id )  
    @staticmethod
    def getForm( catid ):
        f = model_form( Categoria ) 
        if catid is None:
            return f()
        categoria = Categoria.getCategoriaById( catid )
        form = f( None, categoria )
        return form
    
    @staticmethod
    def getTemplate():
        return  Template("""
        <form action='/PostCategoria' method='post' enctype='multipart/form-data'>

        <table>
        <tr>
            <th>{{ form.titolo.label}}</th>
            <td>{{ form.titolo}}</td>
        </tr>
        <tr>
            <th>{{ form.pos.label }}</th>
            <td>{{ form.pos }}</td>
        </tr>       
        <tr>
            <th>{{ form.coloreFG.label}}</th>
            <td>{{ form.coloreFG}}</td>
        </tr>               
        <tr>
            <th>{{ form.coloreBG.label}}</th>
            <td>{{ form.coloreBG}}</td>
        </tr>       
            <tr>
            <th>{{ form.immagineA.label}}</th>
            <td><input id="immagineA" name="immagineA" type="file"></td>
        </tr>
        <tr>
            <th>{{ form.immagineB.label }}</th>
            <td><input id="immagineB" name="immagineB" type="file"></td>
        </tr>
        </table>
        <input type='hidden' name='id' value='{{ id }}'>
        <input type='submit' value='registra'>
        </form>
        Annulla modifiche e torna <a href='/Admin'>indietro</a>
        """)        
    
#
# Dinamic html page
#
class DynamicHTML( db.Model ):
    titolo  = db.StringProperty()
    html    = db.TextProperty()
    coloreFG    = db.StringProperty()
    coloreBG    = db.StringProperty()
    immagineA   = db.BlobProperty()
    immagineB   = db.BlobProperty()
    tag         = db.StringProperty()
    
    @staticmethod
    def getTemplate():
        return  Template("""
        <form action='/PostHTML' method='post' enctype='multipart/form-data'>
            <table>
                <tr>
                    <th>{{ form.titolo.label}}</th>
                    <td>{{ form.titolo}}</td>
                </tr>
               <tr>
                    <th>{{ form.html.label}}</th>
                    <td>{{ form.html}}</td>
                </tr>
                <tr>
                    <th>{{ form.coloreFG.label}}</th>
                    <td>{{ form.coloreFG}}</td>
                </tr>               
                <tr>
                    <th>{{ form.coloreBG.label}}</th>
                    <td>{{ form.coloreBG}}</td>
                </tr>       
                    <tr>
                    <th>{{ form.immagineA.label}}</th>
                    <td><input id="immagineA" name="immagineA" type="file"></td>
                </tr>
                <tr>
                    <th>{{ form.immagineB.label }}</th>
                    <td><input id="immagineB" name="immagineB" type="file"></td>
                </tr>
            </table>
        <input type='hidden' name='tag' value='{{ tag }}'>
        <input type='submit' value='registra' >
        </form>
        Annulla modifiche e torna <a href='/Admin'>indietro</a>
    """)
    
    @staticmethod
    def getForm( tag ):
        f = model_form( DynamicHTML )
        if id is None:
            return f()
        html = DynamicHTML.getHTMLbyTag( tag )
        form  = f( None, html )
        return form
        
    @staticmethod
    def getHTMLbyTag( tag ):
        data = DynamicHTML.all().filter( "tag =" , tag ).fetch(1)
        if len(data) > 0:
            data = data[0]
        else: data = None
        return data
        
    @staticmethod
    def getHTMLbyId( id ):
        return DynamicHTML.get_by_id( id )
   
# TODO 
class Counter( db.Model ):
    counter = db.IntegerProperty()
  

class CSS( db.Model ):
    css = db.TextProperty()

    @staticmethod
    def getTemplate():
        return  Template("""
            <form action='/PostCSS' method='post' enctype='multipart/form-data'> 
                <table> 
                    <tr> 
                        <th><label for="css">{{ form.css.label }} </label></th> 
                        <td> <textarea name="css" id="css" class="noEditor" rows = "32" cols = "120">{{ css }}
			  			     </textarea>
                        </td> 
                    </tr> 
                </table> 
                <input type='submit' value='registra' > 
            </form> Annulla modifiche e torna <a href='/Admin'>indietro</a> 
    """)
    
    @staticmethod
    def getForm( ):
        f = model_form( CSS )
        css = CSS().get( )
        form  = f( None, css )
        return form
        
    @staticmethod
    def get( ):
        css = CSS().all().fetch( 1 )
        if len(css) == 0  :
            return  CSS()
        return css[0]






from StandardPage import * 
from Model import *

class MainPage( StandardPage ):

    def get(self):
        if self.request.get('categoria') is None or self.request.get('categoria') == "":
            categoria = Categoria.all().order("pos").fetch(1)[0]
            categoria_id = categoria.key().id()
        else:
            categoria_id = int( self.request.get('categoria') )
        prodotto_id  = int(self.request.get('prodotto') or "0" ) 

        htag = self.request.get("htag")

        self.render("""
                    <!-- intestazione --> 
                    <div>
                        <img src="/AppImg/imgHeader.png" id="h" usemap="#hmap" >
                        <map id="hmap" name="hmap">
                            <area shape="rect" coords="330,110,407,133"   href="/?htag=1" alt="" title="" />
                            <area shape="rect" coords="422,110,507,133"   href="/?htag=2" alt="" title="" />
                            <area shape="rect" coords="515,110,600,133"   href="/?htag=3" alt="" title="" />
                            <area shape="rect" coords="1126,136,1128,138" href="/" alt="" title="" />
                        </map>
                    </div>
                    <!-- corpo della pagina --> 
                    <!-- lista delle categorie ed immagine associata -->
                    <div style = 'position: absolute; top: 150px; left: 0 px; width: 490px;' >%s</div>
                    <!-- riquadro prodotto / lista della categoria -->
                    <div style = 'position: absolute; top: 150px; left: 294px; height: 750px;' >%s</div>
                    <!-- footer della pagina e immagine della categoria 2 -->
                    <div style = 'position: absolute; top: 788px; left: 0 px; width: 1280px;'>%s</div>          
        """ % ( self.doListCategory(categoria_id, htag), self.doPage( categoria_id, prodotto_id, htag), self.doFooterCategory( categoria_id, htag ) ))

    def doListCategory(self, catid, htag ):

        currentCat = Categoria().getCategoriaById( catid )
        coloreBG = currentCat.coloreBG
        coloreFG = currentCat.coloreFG
        id       = currentCat.key().id()
        titolo   = currentCat.titolo

        if len( htag ):
            currentHTML = DynamicHTML().getHTMLbyTag( htag )
            coloreBG = currentHTML.coloreBG
            coloreFG = currentCat.coloreFG
            id       = currentHTML.key().id()
            titolo   = currentHTML.titolo

        html = "<div style='height: 450px; width: 278px; background-image: url(\"/AppImg/imgBackCat.png\"); ' >"

        html += "<div style='position: absolute; top: 43px; left: 0px;' >"
        for cat in Categoria().all().order('pos'):
            html += "<img src='AppImg/categoryMask.png' style='background-color: #%s;' align='center'>" % ( cat.coloreBG ) 
            html += "<a href='?categoria=%s'> %s</a><br>" % ( cat.key().id() , cat.titolo ) 
        html += "</div>"

        html += "</div>"
        if len( htag ):
            html += "<img style='position: relative; left: 15px;' src='/DataStoreImage/HTML/Small/%s'>" % ( htag )
        else:        
            html += "<img style='position: relative; left: 15px;' src='/DataStoreImage/Categoria/Small/%s'>" % ( catid ) ###
        return html



    def doFooterCategory(self, category_id, htag ):
        if len( htag ):
            ohtml = DynamicHTML().getHTMLbyTag( htag )    
            html = "<img style='position: relative; left: 12px;' src='/DataStoreImage/HTML/Big/%s' width='1100' height='120' >" % ( htag   )
        else:            
            category = Categoria().getCategoriaById( category_id )
            html = "<img style='position: relative; left: 12px;' src='/DataStoreImage/Categoria/Big/%s' width='1100' height='120' >" % ( category_id )

        return html + "<img src='/AppImg/footerMask.png' style='background-color: #7ab51d;' >" 


    def getTableForArticolo( self, articolo ):
        counter = 0 
        html = "<table>"
        html += "<tr><th>codice</th><th>bar codecodice</th><th>confezione</th><th>CRT</th><th>Pallet</th></tr>"
       
        for i in xrange(1,10): # 1 . . . 9 
            row = getattr( articolo, "variante" + str( i ) )
            try:
                ( a, b, c, d, e ) = row.split(",")
            except:
                continue

            html += "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>" % ( a,b,c,d,e )
            counter = counter + 1

        html += "</table> "

        if counter >= 1 :
            return html 
        return ""

    def composeProductPage( self, prodid, catid  ):
        articolo = Articolo().getArticoloById( prodid )
        cat      = Categoria().getCategoriaById( catid )
        html  = self.getHeader( cat.coloreBG, cat.coloreFG, cat.titolo )
        html += "<img style='position: absolute; top: 42px; left: 11px; z-index: 3;' src='/AppImg/photoMask.png'>"
        html += "<img style='position: absolute; top: 42px; left: 0px; z-index: 1;' src='/AppImg/prodMask.png' >"
        html += "<img style='position: absolute; top: 42px; left: 50px; z-index: 2;' src='/DataStoreImage/Articolo/Big/%s'>" % ( prodid )

        html += "<div style='position: absolute; top: 42px; left: 408px; z-index: 4; background-color: #f3eccf; width: 383px; height: 552px; overflow: auto;' >"
        html += articolo.descrizione
        html += self.getTableForArticolo( articolo );
        html += "</div>"

# Titolo
        html += "<div style='position: absolute; color: #%s; left: 100px; top: 550px; z-index: 5;'>%s</div>" \
        % ( cat.coloreFG, articolo.titolo )

        html += "<div style='position: absolute; top: 620x; left: 0px; background-color: #%s; width: 828px; height: 5px;' ></div>" % ( cat.coloreBG )
        return html



    def getHeader( self, coloreBG, coloreFG, testo="nessun testo definito" ):
        coloreFG = "fff"
        html  = "<img src='/AppImg/catTitleMask.png' style='background-color: #%s;' >" % ( coloreBG )
        html += "<a href='javascript:history.go(-1)' border='0'><img src='/AppImg/bntBack.png'  style=' position: relative; top: -4px; left: -842px; ' ></a>" 
        html += "<div style='border-style: none; color: #%s; position: relative; top: -28px; left : 200px; text-align: right; width: 600px;' >%s</div>" % ( coloreFG, testo  )
        return html

    def composeCatalogPage( self, catid ):
        cat = Categoria().getCategoriaById( catid )
        html = self.getHeader( cat.coloreBG, cat.coloreFG, cat.titolo )
        html += "<div style='position: relative; top: -23px; left: 0px; background-color: #e7d6ae; width: 828px; height: 600px; overflow-y: none; overflow-x: auto;' >"

        articoli = Articolo.getListArticoloByCatId( catid )
        html += "<table border='0' cellspacing='0' cellpadding='0' >"
        while len( articoli ) > 0:
            html += "<tr style='height: 176px; overflow: auto;'>"
            for i in xrange(0,3):
                if len( articoli ) > 0:
                    articolo = articoli.pop(0)
                    artId= articolo.key().id()
                    html += """
                      <td id id='%s' name='%s' >
                        <div style='position: relative; height: 176px;' >
                            <a  border='0' href='/?categoria=%s&prodotto=%s'>
                                <img  style='position: relative; top: 0px; left: 0px; z-index: 2;' src='/AppImg/thumbMask.png'>
                            </a>
                            <img  style='position: relative; top: -178px; left: 43px; z-index: 1;' src='/DataStoreImage/Articolo/Small/%s'>
                            <div style='position: relative; top: -160px; left: 80px; z-index: 3;'>
                                %s
                            </div>
                        </div>
                     </td>
                    """ % (artId, artId, catid, artId,  artId, articolo.titolo ) 
                else:
                    html += """
                     <td>
                        <div> 
                        </div>
                     </td>
                    """ 
                    
            html += "</tr>"
        html += "</table>"
        html += "</div>"
        html += "<div style='position: absolute; top: 628px; background-color: #%s; width: 828px; height: 5px;' ></div>" % ( cat.coloreBG )
        return html 

    def composeHtmlPage( self, t ):
        image = "not def"
        titolo = ""
        if t == "1" : # chi siamo 
            image = "whoMask.png"
            titolo = "Chi Siamo"
        elif t == "3": # dove siamo 
            image =  "contactMask.png"
            titolo = "Contatti"
        elif t == "2":
            image = "whereMask.jpg"
            titolo = "Dove Siamo"

        objHTML = DynamicHTML().getHTMLbyTag( t )
        fgcolor = bgcolor = "444444"; text = ""
        if objHTML is not None:
            text    = objHTML.html
            bgcolor = objHTML.coloreBG
            fgcolor = objHTML.coloreFG
            titolo  = objHTML.titolo
           
        html = self.getHeader(bgcolor, fgcolor, titolo )
        html += "<img style='position: relative; top: -23px; left: 0px; z-index: 2;' src='/AppImg/%s'>" % ( image )

# questo e' lo sfondo che ospita il testo di chi siamo e non e' usato nelle altre sezioni
        html += "<div style='border-style: none; position: relative; top: -560px; left: 72px; z-index: 1; background-color: #fff; width: 680px; height: 500px; overflow: hidden;' >"
        html += text
        html += "</div>"

        html += "<div style='position: absolute; top: 618px; z-index: 6; background-color: #%s; width: 828px; height: 5px;' ></div>" % ( "40b93c" )

        return html


    def doPage( self, catid, prodid, htag ):
        if len(htag) > 0:
            return self.composeHtmlPage( htag )
        elif prodid != 0:
            return self.composeProductPage( prodid, catid )
        elif catid != 0:
            return self.composeCatalogPage( catid )
        else:
            return """No catid or productid."""





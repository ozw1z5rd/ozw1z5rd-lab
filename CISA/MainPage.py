from StandardPage import * 
from Model import *
from Counter import *

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
                        <img src="/AppImg/imgHeader.png" id="h" usemap="#hmap" width='1128' height='138'  >
                        <map id="hmap" name="hmap">
                            <area shape="rect" alt="" title="" coords="38,105,91,137"    href="/Pages?htag=4" />
                            <area shape="rect" alt="" title="" coords="322,114,405,134"  href="/Pages?htag=1" />
                            <area shape="rect" alt="" title="" coords="418,112,500,133"  href="/Pages?htag=2" />
                            <area shape="rect" alt="" title="" coords="21,16,83,57"      href="http://www.alter-com.it" />
                            <area shape="rect" alt="" title="" coords="516,110,585,134"  href="/Pages?htag=3" />
                            <area shape="rect" alt="" title="" coords="1078,20,1105,54"  href="#" onclick="audioStartStop()" />
                            <!-- Created by Online Image Map Editor (http://www.maschek.hu/imagemap/index) -->
                        </map>                    
                    </div>

                    <!-- corpo della pagina --> 
                    <!-- lista delle categorie ed immagine associata -->
                    <div style = 'position: absolute; top: 141px; left: 0px; width: 278px;' >%s</div>
                    <!-- riquadro prodotto / lista della categoria -->
                    <div style = 'position: absolute; top: 141px; left: 287px; width: 827px; height: 621px;' >%s</div>
                    <!-- footer della pagina e immagine della categoria 2 -->
                    <div style = 'position: absolute; top: 777px; left: 0px; width: 1110px;'>%s</div>          
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

        html = "<div style='height: 449px; width: 278px; background-image: url(\"/AppImg/imgBackCat.png\");  ' >"

        html += "<div style='position: absolute; top: 50px; left: 0px;' >"
        html += "<table border='0' cellpadding=0 cellspacing=0 >"

        for cat in Categoria().all().order('pos'):
            html += "<tr><td valign='middle'>"
            html += "<a href='/Catalogo?categoria=%s'>"  % ( cat.key().id()  ) 
            html += "<img src='AppImg/categoryMask.png' style='background-color: #%s; vertical-align: middle;' width='51' height='37' >" % ( cat.coloreBG ) 
	    html += "</a>"
            html += "</td><td valign='middle'>"
            html += "<div class=\"catDesc\"><a href='/Catalogo?categoria=%s'>"  % ( cat.key().id()  ) 
            html += "%s</a></div>" % ( cat.titolo ) 

            html += "</td></tr>"

        html += "</table>"
        html += "</div>"
        html += "</div>"

        if len( htag ):
            html += "<img style='position: relative; left: 14px; top: 1px;' src='/DataStoreImage/HTML/Small/%s'>" % ( htag )
        else:        
            html += "<img style='position: relative; left: 14px; top: 1px;' src='/DataStoreImage/Categoria/Small/%s'>" % ( catid ) ###
        return html



    def doFooterCategory(self, category_id, htag ):
        if len( htag ):
            ohtml = DynamicHTML().getHTMLbyTag( htag )    
            html = "<img style='position: relative; left: 14px;' src='/DataStoreImage/HTML/Big/%s' width='1100' height='102' >" % ( htag   )
        else:            
            category = Categoria().getCategoriaById( category_id )
            html = "<img style='position: relative; left: 14px;' src='/DataStoreImage/Categoria/Big/%s' width='1100' height='102' >" % ( category_id )

        return html + "<img  style='position: relative; top: 2px; background-color: #9cbf1a;'  src='/AppImg/footerMask.png' >" 

#
# html, nrows = getTableForArticolo
#
    def getTableForArticolo( self, articolo ):
        counter = 0 
        html = "<table  class='tableprod'  >"
        html += """<tr class = 'trprod' >
                        <th class = 'thprod' >CODICE</th>
                        <th class = 'thprod' >BARCODE</th>
                        <th class = 'thprod' >CONFEZIONE</th>
                        <th class = 'thprod' >CRT</th>
                        <th class = 'thprod' >PALLET</th>
                    </tr>"""
       
        for i in xrange(1,10): # 1 . . . 9 
            row = getattr( articolo, "variante" + str( i ) )
            try:
                ( a, b, c, d, e ) = row.split(",")
            except:
                continue

            html += """ <tr class = 'trprod' >
                           <td class='tdprod'>%s</td class=''>
                           <td class='tdprod'>%s</td class=''>
                           <td class='tdprod'>%s</td class=''>
                           <td class='tdprod'>%s</td class=''>
                           <td class='tdprod'>%s</td class=''>
                       </tr>""" % ( a,b,c,d,e )
            counter = counter + 1

        html += "</table> "

        if counter >= 1 :
            return html , ++counter
        return "",0



    def composeProductPage( self, prodid, catid  ):
        articolo = Articolo().getArticoloById( prodid )
        cat      = Categoria().getCategoriaById( catid )
        t_html , nrows = self.getTableForArticolo( articolo )
#
# se la tabella e' definita aggiunge il rigo spaziatore
#
        if nrows : 
            t_html = "<div style='height: 22px; width: 390px; background-color:  #f3eccf; display: block;'></div>" + t_html

        h = 556 + 43 - 42    # altezza della colonna + offset iniziale 
        th = 25 * ( nrows + 1 ) + 22 # altezza della tabella +20 = spazio opaco per il testo 
        py = h - th # posizione della tabella
#
# aggiunge un link alla scheda quando questa e' presente
#
        link     = None
        if articolo.scheda is not None and len( articolo.scheda ) > 1 : 
            link = "/DataStorePDF/Articolo/PDF/%s" % ( prodid )
        html  = self.getHeader( cat.coloreBG, cat.coloreFG, cat.titolo, link )
#
# scheda prodotto.........
#

        html += "<img style='position: absolute; top: 42px; left: 0px; z-index: 3;' src='/AppImg/photoMask.png'>"
        html += "<img style='position: absolute; top: 42px; left: 0px; height: 582px; z-index: 1;' src='/AppImg/prodMask.png' >"
        html += "<img style='position: absolute; top: 60px; left: 25px; z-index: 2;' src='/DataStoreImage/Articolo/Big/%s'>" % ( prodid )

#
# riquadro che contiene il tutto..

        html += "<div style='position: absolute;  left: 0px; z-index: 6;  top: %spx;'>" %( py )
        html += t_html
        html += "<br></div>"
                html += articolo.descrizione

        html += "<br><br><br><br><br><br><br><br><br><br><br><br>"



# tabella varianti prodotto 
#        html += "<div style='position: absolute;  left: 409px; z-index: 4; width: 393px; top: %spx'>" % ( py ) 
#        html += t_html
#        html += "</div>"


# Titolo
        html += "<div style='position: absolute; color: #%s; left: 46px; top: 530px; width: 320px; height: 66px; z-index: 5;' class='prodName' >%s</div>" \
        % ( cat.coloreFG, articolo.titolo )

        html += "<div style='position: absolute; top: 620px; left: 0px; background-color: #%s; width: 827px; height: 5px; z-index: 5;' ></div>" % ( cat.coloreBG )
        return html



#
# Questa intestazione pu o meno avere un bottone extra che serve a scaricare un pdf allegato 
# al prodotto visualizzato.
# quando deve essere stampato anche questo bottone il chiamante passa un parametro extra che 
# rappresenta un link,  quando  presente viena aggiunto il bottone e viene associato al link passato.
#
    def getHeader( self, coloreBG, coloreFG, testo="nessun testo definito", link=None  ):
        coloreFG = "fff"
        html  = "<div class=\"header\" style='position: relative; top:0px; left: 0px; z-index: 11;' >"
        html += "<img src='/AppImg/catTitleMask.png' style='background-color: #%s;' width='841' height='43'>" % ( coloreBG )
# bottone torna indietro
        html += "<a href='javascript:history.go(-1)' border='0'><img src='/AppImg/bntBack.png'  style=' position: absolute; top: 17px; left: 8px; ' ></a>" 
        if link is not None:
            html += "<a href='%s'><img src='/AppImg/bntDownload.png' style='position: absolute; top: 16px; left: 103px; z-index: 5;'  width='204' height='20' ></a>" % ( link )
            
        html += "<div class='catName' style='border-style: none; color: #%s; position: absolute; top: 17px; left : 200px; text-align: right; width: 600px;' >%s</div>" % ( coloreFG, testo  )
        html += "</div>"
        return html




    def composeCatalogPage( self, catid ):
        cat = Categoria().getCategoriaById( catid )
        html = self.getHeader( cat.coloreBG, cat.coloreFG, cat.titolo )

#        html += "<div style='position: absolute; top: 42px; left: 0px; background-color: #e7d6ae; width: 826px; height: 580px; overflow-y: none; overflow-x: auto;' >"

        articoli = Articolo.getListArticoloByCatId( catid )

        html += "<table border='0' cellspacing='0' cellpadding='0' >"

        while len( articoli ) > 0:
            html += "<tr>"
            for i in xrange(0,3):
                if len( articoli ) > 0:
                    articolo = articoli.pop(0)
                    artId= articolo.key().id()
                    html += """
                      <td id id='%s' name='%s' >
                        <div style='position: relative; ' >
                            <a  border='0' href='/Catalogo?categoria=%s&prodotto=%s'>
                                <img  style='position: relative; top: 0px; left: 0px; z-index: 2;' src='/AppImg/thumbMask.png' width='255' height='184'>
        otml += "</div>"
                            <img  style='position: absolute; top: 29px; left: 38px; z-index: 1;' src='/DataStoreImage/Articolo/Small/%s'><!-- TODO aggiungere la dimensione della immagine --> 
                            <div style='position: absolute; top: 148px; left: 42px; z-index: 3; width: 210px; height: 30px;'>
                                <div class='proDesc'>%s</div>
                            </div>
                            </a>
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
        html += "<tr><td colspan='3'><br></td></tr>"

#        html += "</div>"

        html += "<div style='position: absolute; top: 621px; background-color: #%s; width: 827px; height: 5px;' ></div>" % ( cat.coloreBG )
        return html 

    def composeHtmlPage( self, t ):
        image = "not def"
        ahtml = ""
        titolo = ""
        text = ""

        objHTML = DynamicHTML().getHTMLbyTag( t )
        fgcolor = bgcolor = "444444"; text = ""
        if objHTML is not None:
            text    = objHTML.html
            bgcolor = objHTML.coloreBG
            fgcolor = objHTML.coloreFG
            titolo  = objHTML.titolo

        if t == "1" : # chi siamo 
            image = "whoMask.png"
            titolo = "Chi Siamo"
            ahtml += """ 

        <div id="scrollbar1">
            <div class="scrollbar">
                    <div class="track">
                        <div class="thumb">
                              <div class="end">
                              </div>
                        </div>
                    </div>
             </div>
         <div class="viewport">
		     <div class='overview' >
             """
            ahtml += text
            ahtml += "</div></div></div>"
        elif t == "3": # dove siamo 
            image =  "contactMask.png"
            titolo = "Contatti"
	    ahtml = """
        <map id="map" name="map">
            <area shape="rect" alt="" title="" coords="83,181,353,241"  href="mailto:cisasas@libero.it" target="" />
            <area shape="rect" alt="" title="" coords="377,286,707,334" href="mailto:magazzino@cisadriatica.it" target="" />
            <area shape="rect" alt="" title="" coords="378,226,716,269" href="mailto:commerciale@cisadriatica.it" target="" />
            <area shape="rect" alt="" title="" coords="378,154,750,200" href="mailto:amministrazione@cisadriatica.it" target="" />
            <area shape="rect" alt="" title="" coords="377,84,696,135"  href="mailto:direzione@cisadriatica.it" target="" />
        <!-- Created by Online Image Map Editor (http://www.maschek.hu/imagemap/index) --></map>
        </map>
            """
        elif t == "2":
            image = "whereMask.png"
            titolo = "Dove Siamo"
            ahtml  = """
<div style='position : absolute; top: 114px; left: 93px; z-index: 5;'>
<iframe width="640" height="301" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Viale+della+Libert%C3%A0,+4,+Moscufo+PE,+Italia&amp;sll=42.45193,14.068015&amp;sspn=0.004037,0.008969&amp;ie=UTF8&amp;hq=&amp;hnear=Viale+della+Libert%C3%A0,+4,+65010+Moscufo+Pescara,+Abruzzo,+Italy&amp;t=m&amp;ll=42.452025,14.068766&amp;spn=0.002383,0.006877&amp;z=17&amp;iwloc=A&amp;output=embed"></iframe><br /><small></small></div>:
            """

        elif t == "4":
            image = "whoMask.png"
            titolo = "presentazione"
            ahtml  = """
<div style='position : absolute; top: 114px; left: 93px; z-index: 5;'>
<iframe width="640" height="301" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Viale+della+Libert%C3%A0,+4,+Moscufo+PE,+Italia&amp;sll=42.45193,14.068015&amp;sspn=0.004037,0.008969&amp;ie=UTF8&amp;hq=&amp;hnear=Viale+della+Libert%C3%A0,+4,+65010+Moscufo+Pescara,+Abruzzo,+Italy&amp;t=m&amp;ll=42.452025,14.068766&amp;spn=0.002383,0.006877&amp;z=17&amp;iwloc=A&amp;output=embed"></iframe><br /><small></small></div>:
            """

        html = self.getHeader(bgcolor, fgcolor, titolo )
        html += "<img style='position: absolute; top: 42px; left: 0px; z-index: 2;' src='/AppImg/%s' usemap='#map' >" % ( image )
	html += ahtml
        html += "<div style='position: absolute; top: 620px; z-index: 6; background-color: #%s; width: 827px; height: 5px;' ></div>" % ( "40b93c" )

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





from StandardPage import * 
from Model import *

class AdminHTML( StandardPage ):
        
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

    def get( self ):
        tag = self.request.get("tag")
        form = DynamicHTML().getForm( tag )
        template = DynamicHTML().getTemplate( )
        self.render( template.render( form = form, tag = tag ) )

    def post( self ):

        self.validateUserIsAdmin()

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
    


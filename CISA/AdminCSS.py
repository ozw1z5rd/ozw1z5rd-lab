import webapp2
from wtforms.ext.appengine.db import model_form
from jinja2 import Template
from google.appengine.api import images
from StandardPage import *
from Model import * 



class AdminCSS(  StandardPage ):

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

        form = CSS().getForm( )
        data = CSS().get()
        template = CSS().getTemplate( )
        html = template.render( form = form, css = data.css )
        return self.render( html )


    def post( self ) : 

        self.validateUserIsAdmin() 

        css = self.request.get('css')
        cso = CSS().get()
        cso.css = css
        cso.put()
        self.redirect("/Admin")

import webapp2 
from wtforms.ext.appengine.db import model_form
from jinja2 import Template
from google.appengine.api import images
from google.appengine.api import users 
from Model import CSS


class StandardPage( webapp2.RequestHandler ):
    
    a = ""
    c = ""
    p = ""

#
# interrope il programma se non e' un amministratore
#   
    def validateUserIsAdmin( self ):
        if not users.is_current_user_admin():
            raise TypeError
 
    def error404( self ):
        return "404 the uri was not found or it is not mapped"
        
    def top( self ):

#
# questa rovina il rendering su webkit ( perche' ? ) 
#
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
# <html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
#
    	cssCode = CSS().get().css
        return """
        <html>
        <head>
            <script type="text/javascript" src="/Static/scroller/jquery-1.4.2.min.js" ></script >
            <script type="text/javascript" src="/Static/tinymce/jscripts/tiny_mce/tiny_mce.js" ></script>
            
            <script type="text/javascript" >
            var _p = 1; 

<!-- timy MCE -->
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

<!-- audio player -->

            function audioStartStop() { 
                audio = top.frames[0].document.getElementById('a');
                if ( _p == 0 ) { audio.play(); _p = 1 }
                else { audio.pause(); _p = 0 }
            }

            </script >

        <script type="text/javascript">
              var _gaq = _gaq || [];
              _gaq.push(['_setAccount', 'UA-31577268-1']);
              _gaq.push(['_trackPageview']);

              (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
             })();
        </script>

        <STYLE type="text/css" >
        %s
        </STYLE>

        </head>
        <body>
        <div name="centrasito" id="centrasito" >
        <div name="bordino" id="bordino" >
        """ % ( cssCode )
        
    def bottom( self ):
        return """
        </div> <!-- close block centered -->
        </div> <!-- close div centered --> 
        </body>
        </html>
        """
        
    def render( self, string ):
        self.response.out.write( self. top() )
        self.response.out.write( string )
        self.response.out.write( self.bottom() )
        
        
        


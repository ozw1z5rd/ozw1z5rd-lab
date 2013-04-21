import webapp2 

class StandardPage( webapp2.RequestHandler ):
    
    a = ""
    c = ""
    p = ""
    
    def error404( self ):
        return "404 the uri was not found or it is not mapped"
        
    def top( self ):
        return """
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
        <html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">

        <head>
            <script type="text/javascript" src="/Static/tinymce/jscripts/tiny_mce/tiny_mce.js" ></script >
            <script type="text/javascript" >
            tinyMCE.init({
                    mode : "textareas",
                    theme : "advanced",   //(n.b. no trailing comma, this will be critical as you experiment later)
       // Theme options
                    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
                    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
                    theme_advanced_toolbar_location : "top",
                    theme_advanced_toolbar_align : "left",
                    theme_advanced_statusbar_location : "bottom",
                    theme_advanced_resizing : true,

            });
            </script >

        <script_puppa type="text/javascript">

          var _gaq = _gaq || [];
          _gaq.push(['_setAccount', 'UA-31577268-1']);
          _gaq.push(['_trackPageview']);

          (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
          })();

        </script>

            <STYLE type="text/css">
               body { font-family: verdana, arial  }
               a { font-family: verdana, arial; text-decoration:none; font-size: 10pt; }
               a:link       {color:#1c6434;}      /* unvisited link */
               a:visited    {color:#1c6434;}  /* visited link */
               a:hover      {color:#1c6434;}  /* mouse over link */
               a:active     {color:#1c6434;}  /* selected link */ 
            </STYLE>  
        </head>
        <body>
        """
        
    def bottom( self ):
        return """
        </body>
        </html>
        """
        
    def render( self, string ):
        self.response.out.write( self. top() )
        self.response.out.write( string )
        self.response.out.write( self.bottom() )
        
        
        


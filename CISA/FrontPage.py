from StandardPage import * 

class FrontPage( StandardPage ):
    def get( self ):
        self.render("<a href='/index.html'><img src='AppImg/frontImg.jpg'></a> " );


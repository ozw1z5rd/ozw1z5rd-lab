from StandardPage import *

#
# STATIC PAGES
#
class HTML( StandardPage ):
    def get(self):
        id = int(self.request.get("id"))
        html = DynamicHTML.get_by_id( id )
        return self.render( html )  


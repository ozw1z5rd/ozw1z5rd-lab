# -*- coding: cp1252 -*-
from django.conf.urls.defaults import *
#from django.conf import settings
#from settings import MEDIA_ROOT


# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

# //////////////////////////////////////////////////////////////////////////////
#  ANYTHING ACCESSIBLE VIA HTTP 
# //////////////////////////////////////////////////////////////////////////////

urlpatterns = patterns('',
    # Example:
    # (r'^wwwvc/', include('wwwvc.foo.urls')),

    # Uncomment the admin/doc line below and add 'django.contrib.admindocs' 
    # to INSTALLED_APPS to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

# //////////////////////////////////////////////////////////////////////////////
#  REST Interface
# //////////////////////////////////////////////////////////////////////////////

    # Uncomment the next line to enable the admin:
    (r'^admin/(.*)',                       admin.site.root),
    (r'header_info',                       "ctrl.rest.get_header_info"),
    (r'showroom_info',                     "ctrl.rest.get_showroom_info"),
    (r'get_buildings_n/',                  "ctrl.rest.get_buildings_n" ),
    (r'get_buildings_by_query/',           "ctrl.rest.get_buildings_by_query" ),
    (r'get_showroom_info/(.*)',            "ctrl.rest.get_showroom_info" ),
    (r'get_banners_by_cap/(.*)',           "ctrl.rest.get_banners_by_cap" ),
    (r'redirect_to_banner/(.*)',           "ctrl.rest.redirect_to_banner" ),
    (r'get_building_info_by_videoid/(.*)', "ctrl.rest.get_building_info_by_videoid"),


# //////////////////////////////////////////////////////////////////////////////
#  USER FORMS
# //////////////////////////////////////////////////////////////////////////////

    (r'categorieMerceologiche',         "ctrl.categorieMerceologiche.get_list"),
    (r'insertImmobile/(.*)',            "ctrl.rest.anonymous_insert"),
#    (r'loginUser/',                     "ctrl.rest.utenteLogin"),

# decorator facility
    (r'user/login/',                     "django.contrib.auth.views.login",{'template_name': 'login.html'}),
# home page utente
    (r'user/home/',                      "ctrl.rest.utente_home"),


# //////////////////////////////////////////////////////////////////////////////
#  USER DATA FORMS ( CURD way ) 
# //////////////////////////////////////////////////////////////////////////////

    (r'banner/Insert/',                  "ctrl.rest.insert_banner"),
    (r'banner/Edit/',                    "ctrl.rest.edit_banner"),
    (r'banner/Delete/',                  "ctrl.rest.delete_banner"),
    (r'banner/List/',                    "ctrl.rest.list_banner"),

    (r'contatto/Insert/',                "ctrl.rest.insert_contatto"),
    (r'contatto/Edit/',                  "ctrl.rest.edit_contatto"),
    (r'contatto/Delete/',                "ctrl.rest.delete_contatto"),
    (r'contatto/List/',                  "ctrl.rest.list_contatto"),

# l'inserimento di un immobile necessita la conoscenza della categoria merceologica 
    (r'immobile/Insert/(.*)',            "ctrl.rest.insert_immobile"),
    (r'immobile/Edit/',                  "ctrl.rest.edit_immobile"),
    (r'immobile/Delete/',                "ctrl.rest.delete_immobile"),
    (r'immobile/List/',                  "ctrl.rest.list_immobile"),

    (r'ricerca/Insert/',                "ctrl.rest.insert_ricerca"),
    (r'ricerca/Edit/',                  "ctrl.rest.edit_ricerca"),
    (r'ricerca/Delete/',                "ctrl.rest.delete_ricerca"),
    (r'ricerca/List/',                  "ctrl.rest.list_ricerca"),

    (r'video/Insert/',                   "ctrl.rest.insert_video"),
    (r'video/Edit/',                     "ctrl.rest.edit_video"),
    (r'video/Delete/',                   "ctrl.rest.delete_video"),
    (r'video/List/',                     "ctrl.rest.list_video"),

    (r'foto/Insert/',                    "ctrl.rest.insert_foto"),
    (r'foto/Edit/',                      "ctrl.rest.edit_foto"),
    (r'foto/Delete/',                    "ctrl.rest.delete_foto"),
    (r'foto/List/',                      "ctrl.rest.list_foto"),

)

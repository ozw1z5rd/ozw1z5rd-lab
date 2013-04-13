# -*- coding: cp1252 -*-
from django.shortcuts import render_to_response
from django.contrib.auth import authenticate, login
from settings import URL_ACCOUNT_DISABLED, URL_LOGIN_OK, URL_LOGIN, URL_USER_HOME
from pyVisualCasa.forms.Utente import Utente_form
from django.http import HttpResponseRedirect
from django.contrib.auth.decorators import login_required


class CURD(object):

    @login_required
    def list( self, request ):
        all = self.get_all_objects()
        return render_to_response( "list_" + self.template_file, { 'form' : self.form() })

    @login_required
    def edit ( self, request, id ):
        pass

    @login_required
    def delete (self,request, id ):
        res = self.model.get( pk = id ).delete()
        return render_to_response( "ok_" + self.template_file )

    @login_required
    def insert(self, request, **dict ):

# prende un utente, prepara un oggetto contatto vuoto in cui viene imposto l'utente
# appena creato, i rimanenti campi sono recuparti dal form.
# il modulo dell'immobile necessita di un parametro ( categoria merceologia ) senza non può
# funzionare

        f = self.get_form( **dict )

        if request.method == 'POST' :

            request.logger.info("Getting the user object")
            obj_profile = request.user.get_profile()
            obj_model = self.get_model( profilo = obj_profile )
            request.logger.info("Building the form from the post data")
            f = self.get_form( request.POST, request.FILES, instance=obj_model, **dict )
            
            if f.is_valid() :
                request.logger.info("Form is valid, saving data")
                try:
                    f.save()
                except:
                    request.logger.critical("Can't store data")
                else:
                    request.logger.info("Data recorded, returnig to USER HOME")
                    return HttpResponseRedirect(URL_USER_HOME)
            else:
                request.logger.info("Form is not valid, restarting")
# anyway return the final data 
        return render_to_response( self.template_file , { 'form' : f } )    


    def get_all_objects(self):
        return ()


    def _check_user ( self, request ) :
        if not request.user.is_authenticated():
            request.logger.info("user not authenticated trying to login")
            return self.login( request )
        else:
            request.logger.info("user authenticated for %s" % (request.META.get('HTTP_REFERER','NO REFERER')) )



## questo codice non serve più
#    def _login ( self, request ) :
#        """log the user, redirect him to the referer if any otherwise
#        redirect the user to the homepage
#        """
#        message = "Inserisci user e password per accedere"
#
#        user_source = request.META.get("HTTP_REFERER", URL_LOGIN_OK )
#        request.logger.info("Attempt to login the user  : referer is [%s] " % ( user_source ))
#
#        if request.method == 'POST':
#            username = request.POST['username']
#            password = request.POST['password']
#            user = authenticate(username=username, password=password)
#            if user is not None:
#                if user.is_active:
#                    message ="utente attivo"
#                    login(request, user)
#                    request.logger.info("Redirecting the user to the referer")
#                    return HttpResponseRedirect( user_source )
#                else:
#                    message="account disabilitato"
#                    return HttpResponseRedirect(URL_ACCOUNT_DISABLED)
#            else:
#                message = "password e/o username non corretti"
#        request.logger.info("returning the login page")
#        return render_to_response( 'login.html', { 'message' : message } )
#

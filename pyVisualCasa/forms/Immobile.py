# -*- coding: cp1252 -*-
from django import forms
from settings import VC_DEBUG
from pyVisualCasa.models import Immobile, CategoriaMerceologica
from pyVisualCasa.models import Copertura, Pavimentazione, Impianto, Finitura, \
                                DestinazioneUrbanistica, Profilo


#
# This will build the form depending on the categoriaMerceologica
#



class Dynamic_immobile_form( forms.Form ):
    
    def __init__(self, cm , *args, **kwargs):
#                     ^^^^
#                     !!!! Attenzione
#
        super(Dynamic_immobile_form, self).__init__( *args, **kwargs)

        if cm.categoria_merceologica :
            print cm.id
            print cm.titolo
            self.fields['categoria_merceologica'] = \
                            forms.IntegerField(
                                widget = forms.Select( choices =  [ ( cm.id, cm.titolo ) ] )
                            )

        self.fields['tipo_contratto'] = \
                forms.IntegerField(
                                widget=forms.Select( choices=( (1 , 'AFFITTO'), (2, 'VENDITA'))
                              ))

# TODO impostare il numero massimo di caratteri.
        if cm.descrizione :
            self.fields['descrizione'] = forms.CharField( widget = forms.Textarea( ) )
        if cm.mq :
            self.fields['mq'] = forms.FloatField( )
        if cm.prezzo :
            self.fields['prezzo'] = forms.DecimalField(max_digits=10,decimal_places=2)
        if cm.trattabile :
            self.fields['trattabile'] = forms.NullBooleanField()
            
        if cm.vani :
            self.fields['vani'] = forms.IntegerField()
        if cm.camere :
            self.fields['camere'] = forms.IntegerField()
        if cm.bagni  :
            self.fields['bagni'] = forms.IntegerField()
        if cm.ripostigli :
            self.fields['rispostigli'] = forms.IntegerField()
        if cm.balconi :
            self.fields['balconi'] = forms.IntegerField()
        if cm.terrazzo :
            self.fields['terrazzo'] = forms.NullBooleanField()
        if cm.post_auto :
            self.fields['post_auto'] = forms.IntegerField()
        if cm.garage :
            self.fields['garage'] = forms.IntegerField()
        if cm.giardino :
            self.fields['giardino'] = forms.NullBooleanField()
        if cm.piscina :
            self.fields['piscina'] = forms.NullBooleanField()
        if cm.esposizione :
            self.fields['esposizione'] = forms.IntegerField( widget=forms.Select( choices = (
                                                    (1, 'nord'), (2,'ovest'), (3,'sud'), (4,'est') ,
                                                    (5,'nord-est'),(6,'nord-ovest'),(7,'sud-est'),
                                                    (8,'sud-ovest')  )) )


        if cm.destinazione_urbanistica :
            self.fields['destinazione_urbanistica'] = \
                    forms.IntegerField(
                                widget = forms.Select( choices = [ ( rs.id, rs.titolo ) for rs in DestinazioneUrbanistica.objects.all() ] )
                            )
        if cm.indice_cubatura :
            self.fields['indice_cubatura'] = forms.FloatField()
        if cm.indice_cubatura_misura :
            self.fields['indice_cubatura_misura'] = forms.IntegerField( widget=forms.Select( choices=( (0,'non specificato'), (1 , 'm2/m2'), (2, 'm3/m2'))  ))
        if cm.numero_vetrine :
            self.fields['numero_vetrine'] = forms.IntegerField()

        if cm.periodo_di_attivita :
            self.fields['periodo_di_attivita'] = forms.IntegerField()
        if cm.altezza :
            self.fields['altezza'] = forms.FloatField()
        if cm.piazzale :
            self.fields['piazzale'] = forms.NullBooleanField()
        if cm.tipo_di_copertura :
            self.fields['tipo_di_copertura'] = \
                    forms.IntegerField(
                                widget = forms.Select( choices = [ ( rs.id, rs.titolo ) for rs in Copertura.objects.all() ] )
                            )
        if cm.tipo_di_impianto :
            self.fields['tipo_di_impianto'] = \
                    forms.IntegerField(
                                widget = forms.Select( choices = [ ( rs.id, rs.titolo ) for rs in Impianto.objects.all() ] )
                            )
        if cm.tipo_di_finitura :
            self.fields['tipo_di_finitura'] = \
                    forms.IntegerField(
                                widget = forms.Select( choices = [ ( rs.id, rs.titolo ) for rs in Finitura.objects.all() ] )
                            )
        if cm.tipo_di_pavimentazione :
            self.fields['tipo_di_pavimentazione'] = \
                    forms.IntegerField(
                                widget = forms.Select( choices = [ ( rs.id, rs.titolo ) for rs in Pavimentazione.objects.all() ] )
                            )
        if cm.numero_livelli :
            self.fields['numero_livelli'] = forms.IntegerField()
        if cm.uffici :
            self.fields['uffici'] = forms.NullBooleanField()
        if cm.aree_verdi :
            self.fields['aree_verdi'] = forms.NullBooleanField()


        if cm.extra_uno :
            self.fields['extra_uno'] = forms.CharField(max_length=255)
        if cm.extra_due :
            self.fields['extra_due'] = forms.CharField(max_length=255)
        if cm.extra_tre :
            self.fields['extra_tre'] = forms.CharField(max_length=255)
        if cm.extra_quattro :
            self.fields['extra_quattro'] = forms.CharField(max_length=255)


from django.contrib import admin    
from pyVisualCasa.models import *

# Gestione a pannelli combinati 


#
# Manca il powe_user assscoicato al video,
# manca il numero di pubblicazoin del vidoe
#

#class SponsorAdmin( admin.ModelAdmin ):
#    fieldsets = (
#                  (
#
#                   ('Banner', { 'fields': ( 'Immagine_Spot', 'priorita' , 'link',
#                                            'click', 'numero_click', # 'pubblicazioni', #?!?!?
#                                              'data_inizio', 'data_fine', 'CAP' )
#                                         ),
#                              }
#                   ),
#
#                   ( 'Titolare' , { 'fields' : ( 'power_user' ) }
#                   )
#
#                 )
#    )


class ContattoStacked(admin.StackedInline):
    model = Contatto
    extra = 1

    
class ContattoTabular(admin.TabularInline):
    model = Contatto
    extra = 1

class VideoStacked( admin.StackedInline ):
    model = Video
    extra = 0
    hidden_fields = ('testo', 'immobile', 'approvato', 'priorita', 'pubblicazioni', 'spot_link', 'spot' )
    fieldsets = (
            ('Altri parametri', { 'fields' : ( hidden_fields ) ,
                                  'classes': ('collapse',),
                                }
            ),
            (''               , { 'fields' : ('video',),
                                }
            )
    )

class RaccoltaDiFotoStacked( VideoStacked ):
    model = RaccoltaDiFoto
    extra = 0
    hidden_fields = ('testo', 'immobile', 'approvato', 'priorita', 'pubblicazioni', 'spot_link', 'spot',
                     'foto2','foto3','foto4','foto5','foto6','foto7','foto8','foto9')
    fieldsets = (
            ('Altri parametri', { 'fields' : ( hidden_fields ) ,
                                  'classes': ('collapse',),
                                }
            ),
            (''               , { 'fields' : ('foto1',),
                                }
            )
        )

class ImmobileTabular( admin.TabularInline):
    model = Immobile
    extra = 0


class ImmobileStacked( admin.StackedInline):
    model = Immobile
    extra = 0


class PosizioneStacked( admin.StackedInline ):
    model = Posizione
    extra = 0
    hidden_fields = ('interno', 'piano', 'denominazioneGeografica','via', 'CAP', 'n' )
    
    fieldsets = (
            ('Indirizzo completo', { 'fields' : ( hidden_fields ) ,
                                     'classes': ('collapse',),
                                   }
            ),
            
            ( ''               , { 'fields' : ( )   }
            )
    )


# TODO aggiungere visualizzazione emil user e password dall'altra tabella
class ProfiloAdmin(admin.ModelAdmin):
    inlines = [ ContattoTabular, ImmobileTabular ]
#    fieldsets = (
#        ( ('Indentita', { 'fields' : ('msisdn', 'account_skype', 'codice_fiscale', ) ,
#                           'description' : 'Valori usati per identificazione',
#                        }),
#          (''         , { 'fields' : ( 'sesso' ),
#                        })
#        )
#    )


# Immobili con video
class ImmobileAdmin( admin.ModelAdmin ):
    """


    """
    inlines=[ PosizioneStacked, VideoStacked, RaccoltaDiFotoStacked]
    raw_id_fields = [ 'profilo' ]
    fieldsets = (
            ('vani, camere...', { 'fields' : ( ('vani', 'camere', 'bagni' ),
                                               ( 'ripostigli', 'balconi', 'post_auto' ) ,
                                               ( 'garage', 'numero_vetrine', 'numero_livelli', 'altezza')
                                             ),
                                  'classes': ('collapse',),
                                }
            ),
            ('opzioni',         { 'fields' : ( ('piazzale' ,'aree_verdi', 'uffici','piscina', 'giardino', 'terrazzo'),
                                               ()
                                             ),
                                             
                                  'classes': ('collapse',),
                                }
            ),
            ('speciali',        { 'fields' : ( ('periodo_di_attivita') ,
                                               ('indice_cubatura', 'indice_cubatura_misura'),
                                               ('extra_uno','extra_due','extra_tre','extra_quattro'),
                                             ),
                                  'classes': ('collapse',),
                                }
            ),
            

            ('Tipologie',       { 'fields' : ( ('tipo_di_copertura', 'tipo_di_impianto', 'tipo_di_finitura' ),
                                               ( 'tipo_di_pavimentazione','destinazione_urbanistica', 'esposizione' ),
                                             ),
                                  'classes': ('collapse',),
                                }
            ),
            (''               , { 'fields' : ( ( 'categoria_merceologica', 'tipo_contratto' ),
                                               'mq', 'descrizione', 'profilo',
                                                 # 'data_inserimento_time' ,  'data_inserimento_date',
                                               ('prezzo', 'trattabile' ) ,
                                                'pubblicato' # visite
                                              ),
                                }
            )
        )

class VideoAdmin( admin.ModelAdmin ):
    raw_id_fields = [ 'immobile' ] # TODO dovrebbe chiamarsi immobile id


class RaccoltaDiFotoAdmin( VideoAdmin ):
    pass

class PosizioneAdmin( admin.ModelAdmin ):
    raw_id_fields = [ 'CAP', 'denominazioneGeografica', 'immobile' ]


#//////////////////////////////////////////////////////////////////////////////

admin.site.register(Immobile, ImmobileAdmin )
admin.site.register(Contatto )

admin.site.register( Frazione )
admin.site.register( DenominazioneGeografica )
admin.site.register( Profilo, ProfiloAdmin )
admin.site.register(RaccoltaDiFoto, RaccoltaDiFotoAdmin)
admin.site.register(Video, VideoAdmin)
admin.site.register(Banner)
admin.site.register(Finitura)
admin.site.register(Pavimentazione)
admin.site.register(Copertura)
admin.site.register(Ricerca)
admin.site.register(Posizione, PosizioneAdmin)
admin.site.register(PDI)
admin.site.register(Impianto)
admin.site.register(DestinazioneUrbanistica)
admin.site.register(Comune)
admin.site.register(CategoriaMerceologica)


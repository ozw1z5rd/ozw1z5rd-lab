# -*- coding: cp1252 -*-

import Google
import Image
import datetime
from django.contrib.auth.models import User
from django.db import models
from pyVisualCasa.settings import BANNER_UPLOAD_TO
from pyVisualCasa.settings import BANNER_YSIZE
from pyVisualCasa.settings import LOGO_UPLOAD_TO
from pyVisualCasa.settings import MAX_BANNER_XSIZE
from pyVisualCasa.settings import MAX_DISK_SPACE
from pyVisualCasa.settings import PHOTO_COLLECTION_UPLOAD_TO
from pyVisualCasa.settings import VC_DEBUG
from pyVisualCasa.settings import VIDEO_EFFECTS_LIST
from pyVisualCasa.settings import VIDEO_EFFECT_STANDARD_ID
from pyVisualCasa.settings import VIDEO_EFFECT_STANDARD_PATH
from pyVisualCasa.settings import VIDEO_UPLOAD_TO
import random

"""

Model.
    Doc string ..

"""

class CategoriaMerceologica(models.Model):
    """
    E' un modello che conserva solo le informazioni sulle colonne che devono
    essere visualizzate dal form di immisione degli immobili
    Ci sono alcuni campi che cmq non saranno mai visualizzati tipo quelli attinenti
    alle date di inserimento, quindi quello che è qui va opportunamente modificato
    """

    titolo = models.CharField(max_length=80)

    ordine_visualizzazione = models.IntegerField()

    list_fields = ('mq', 'vani', 'camere', 'bagni', 'ripostigli', 'balconi',
                   'terrazzo', 'post_auto', 'garage', 'giardino', 'piscina',
                   'esposizione', 'prezzo', 'trattabile',
                   'destinazione_urbanistica', 'indice_cubatura',
                   'indice_cubatura_misura', 'numero_vetrine',
                   'categoria_merceologica', 'data_inserimento_time',
                   'data_inserimento_date', 'descrizione',
                   'periodo_di_attivita', 'altezza', 'piazzale',
                   'tipo_di_copertura', 'tipo_di_impianto', 'tipo_di_finitura',
                   'tipo_di_pavimentazione', 'numero_livelli', 'uffici',
                   'aree_verdi', 'extra_uno', 'extra_due', 'extra_tre',
                   'extra_quattro'
                   )

    mq                      = models.BooleanField(blank=True, default=True)

    vani                    = models.BooleanField(blank=True, default=True)
    camere                  = models.BooleanField(blank=True, default=True)
    bagni                   = models.BooleanField(blank=True, default=True)

    ripostigli              = models.BooleanField(blank=True, default=True)
    balconi                 = models.BooleanField(blank=True, default=True)
    terrazzo                = models.BooleanField(blank=True, default=True)
    post_auto               = models.BooleanField(blank=True, default=True)
    garage                  = models.BooleanField(blank=True, default=True)
    giardino                = models.BooleanField(blank=True, default=True)
    piscina                 = models.BooleanField(blank=True, default=True)
    esposizione             = models.BooleanField(blank=True, default=True)
    prezzo                  = models.BooleanField(blank=True, default=True)
    trattabile              = models.BooleanField(blank=True, default=True)
    destinazione_urbanistica = models.BooleanField(blank=True, default=True)
    indice_cubatura         = models.BooleanField(blank=True, default=True)
    indice_cubatura_misura  = models.BooleanField(blank=True, default=True)
    numero_vetrine          = models.BooleanField(blank=True, default=True)
    categoria_merceologica  = models.BooleanField(blank=True, default=True)
    data_inserimento_time   = models.BooleanField(blank=True, default=True)
    data_inserimento_date   = models.BooleanField(blank=True, default=True)
    descrizione             = models.BooleanField(blank=True, default=True)
    periodo_di_attivita     = models.BooleanField(blank=True, default=True)
    altezza                 = models.BooleanField(blank=True, default=True)
    piazzale                = models.BooleanField(blank=True, default=True)
    tipo_di_copertura       = models.BooleanField(blank=True, default=True)
    tipo_di_impianto        = models.BooleanField(blank=True, default=True)
    tipo_di_finitura        = models.BooleanField(blank=True, default=True)
    tipo_di_pavimentazione  = models.BooleanField(blank=True, default=True)
    numero_livelli          = models.BooleanField(blank=True, default=True)
    uffici                  = models.BooleanField(blank=True, default=True)
    aree_verdi              = models.BooleanField(blank=True, default=True)
    extra_uno               = models.BooleanField(blank=True, default=True)
    extra_due               = models.BooleanField(blank=True, default=True)
    extra_tre               = models.BooleanField(blank=True, default=True)
    extra_quattro           = models.BooleanField(blank=True, default=True)


    def __unicode__(self):
        return u"%s" % self.titolo
    class Meta:
        verbose_name_plural = "Categorie Merceologiche"


class DestinazioneUrbanistica(models.Model):
    titolo = models.CharField(max_length=80)
    def __unicode__(self):
        return u"%s" % self.titolo
    class Meta:
        verbose_name_plural = "Destinazioni Urbanistiche"


#
# Un contatto è un'angrafica  associabile agli utenti
# di tutti queste anagrafiche solo una è disponibile per l'utente normale
#

class Contatto(models.Model):

    profilo     = models.ForeignKey("Profilo")
    nome        = models.CharField(max_length=80)
    cognome     = models.CharField(max_length=80)
    via         = models.CharField(max_length=100)
    n           = models.IntegerField()

    interno     = models.IntegerField(blank=True, null=True)
    citta       = models.CharField(max_length=80)
    CAP         = models.CharField(max_length=5 + 4 + 4)
    
    provincia   = models.CharField(max_length=2)
    tel         = models.CharField(max_length=14)
    fax         = models.CharField(max_length=14, blank=True, null=True)
    mobile1     = models.CharField(max_length=14, blank=True, null=True)
    mobile2     = models.CharField(max_length=14, blank=True, null=True)
    email       = models.EmailField(blank=True, null=True)
    
    attivo      = models.NullBooleanField(blank=True, null=True)

    def __unicode__(self):
        return u"%s %s " % (self.nome, self.cognome)
    class Meta:
        verbose_name_plural = "Contatti"


class Finitura(models.Model):
    titolo = models.CharField(max_length=80)
    def __unicode__(self):
        return u"%s" % self.titolo
    class Meta:
        verbose_name_plural = "Finiture"



# Gestione geografica delle posizioni

# distribuibile su più frazioni
class DenominazioneGeografica(models.Model):
    nome      = models.CharField(max_length=80)
    Frazione  = models.ManyToManyField("Frazione")
    CAPDG     = models.CharField(max_length=5, primary_key=True) # id della DG
    def __unicode__(self):
        return u"%s" % self.nome
    class Meta:
        verbose_name_plural = "Denominazioni geografiche"
    
# Definita solo in un comune
class Frazione(models.Model):
    descrizione = models.CharField(max_length=80)
    CAPF     = models.CharField(max_length=5, primary_key=True) # ID della frazione
    comune   = models.ForeignKey("Comune")
    def __unicode__(self):
        return u"%s" % self.descrizione
    class Meta:
        verbose_name_plural = "Frazioni"

# le provincie son comuni
class Comune(models.Model):
    CAP         = models.CharField(max_length=5, primary_key=True) # ID Comune
    nome        = models.CharField(max_length=80)
    provincia   = models.BooleanField(blank=True, default=False)
    def __unicode__(self):
        st = u"%s %s " % (self.nome, self.CAP)
        return st
    class Meta:
        verbose_name_plural = "Comuni"


class Copertura(models.Model):
    titolo = models.CharField(max_length=80)
    def __unicode__(self):
        return u"%s" % self.titolo
    class Meta:
        verbose_name_plural = "Coperture"



class Immobile(models.Model):
    """

    """
    profilo                 = models.ForeignKey("Profilo")
    visite                  = models.IntegerField(blank=True, default=0)
    pubblicato              = models.BooleanField(blank=True, default=False)
    non_approvato           = models.BooleanField(blank=True, default=False)

    categoria_merceologica  = models.ForeignKey("CategoriaMerceologica", null=False)
    tipo_contratto          = models.IntegerField(choices=((1, 'AFFITTO'), (2, 'VENDITA')))
    descrizione             = models.TextField(max_length=255, blank=False, null=False)
    prezzo                  = models.DecimalField(max_digits=10, decimal_places=2)
    mq                      = models.FloatField(default=0)

    vani                    = models.IntegerField(blank=True, null=True)
    camere                  = models.IntegerField(blank=True, null=True)
    bagni                   = models.IntegerField(blank=True, null=True)

    ripostigli              = models.IntegerField(blank=True, null=True)
    balconi                 = models.IntegerField(blank=True, null=True)
    terrazzo                = models.NullBooleanField(blank=True, null=True)
    post_auto               = models.IntegerField(blank=True, null=True)
    garage                  = models.IntegerField(blank=True, null=True)
    
    giardino                = models.NullBooleanField(blank=True, default=False)
    piscina                 = models.NullBooleanField(blank=True, default=False)

    esposizione             = models.IntegerField(choices=((9, 'non specificato'), (1, 'nord'), (2, 'ovest'), (3, 'sud'), (4, 'est'), (5, 'nord-est'), (6, 'nord-ovest'), (7, 'sud-est'), (8, 'sud-ovest')), default=9)

    trattabile              = models.NullBooleanField(blank=True, default=False)
    destinazione_urbanistica = models.ForeignKey("DestinazioneUrbanistica", default=1)
    indice_cubatura         = models.FloatField(blank=True, null=True)
    indice_cubatura_misura  = models.IntegerField(choices=((3, 'non specificato'), (1, 'm2/m2'), (2, 'm3/m2')), default=3)
    numero_vetrine          = models.IntegerField(blank=True, null=True)
    
    data_inserimento_time   = models.TimeField(auto_now_add=True, editable=True) # TODO questi non saranno accessibili dal pannello admin.
    data_inserimento_date   = models.DateField(auto_now_add=True, editable=True) # TODO potrebbe essere un bug ?

    periodo_di_attivita     = models.IntegerField(blank=True, null=True)
    altezza                 = models.FloatField(blank=True, null=True)
    piazzale                = models.NullBooleanField(blank=True, default=False)
    tipo_di_copertura       = models.ForeignKey("Copertura", default=1)
    tipo_di_impianto        = models.ForeignKey("Impianto", default=1)
    tipo_di_finitura        = models.ForeignKey("Finitura", default=1)
    tipo_di_pavimentazione  = models.ForeignKey("Pavimentazione", default=1)
    numero_livelli          = models.IntegerField(blank=True, null=True)
    uffici                  = models.NullBooleanField(blank=True, default=False)
    aree_verdi              = models.NullBooleanField(blank=True, default=False)

    extra_uno               = models.CharField(max_length=255, blank=True, null=True)
    extra_due               = models.CharField(max_length=255, blank=True, null=True)
    extra_tre               = models.CharField(max_length=255, blank=True, null=True)
    extra_quattro           = models.CharField(max_length=255, blank=True, null=True)

    def __unicode__(self):
        desc = u"mq=%s vani=%s camere=%s bagni=%s prezzo=%s" % (self.mq, self.vani, self.camere, self.bagni, self.prezzo)
        if not self.pubblicato:
            desc = "NON APPROVATO " + desc
        return desc

    class Meta:
        verbose_name_plural = "Immobili"

class Impianto(models.Model):
    titolo = models.CharField(max_length=80)
    def __unicode__(self):
        return u"%s" % self.titolo
    class Meta:
        verbose_name_plural = "Impianti"

class Pavimentazione(models.Model):
    titolo = models.CharField(max_length=80)
    def __unicode__(self):
        return u"%s" % self.titolo
    class Meta:
        verbose_name_plural = "Pavimentazioni"

class PDI(models.Model):
    note        = models.CharField(max_length=100)
    descrizione = models.CharField(max_length=100)
    def __unicode__(self):
        return u"%s" % self.descrizione


        # indirizzo esatto più indicazioni di "DenominazioneGeografica"
class Posizione(models.Model):
    via                     = models.CharField(max_length=100)
    n                       = models.IntegerField()
    interno                 = models.IntegerField(blank=True, null=True)
    piano                   = models.IntegerField(blank=True, null=True)

    CAP                     = models.ForeignKey("Comune")
    denominazioneGeografica = models.ForeignKey("DenominazioneGeografica", null=True, blank=True)
    # un immobile può avere più uscite su strade differenti ( tipologia commerciale )
    immobile                = models.ForeignKey("Immobile")

    # se le coordinate sono state impostate a mano non risolvere con google quando la posizione
    # viene registrata di nuovo.

    noGoogle                = models.BooleanField(blank=True, default=False)
    google_lat              = models.FloatField(blank=True, null=True)
    google_lan              = models.FloatField(blank=True, null=True)
    altezza                 = models.FloatField(blank=True, null=True)

    def __unicode__(self):
        extra = "GOOGLE ON"
        if self.noGoogle:
            extra = "NO GOOGLE"
        return u"Via %s Numero %s, CAP %s , %s" % (self.via, self.n, self.CAP, extra)

    def save(self, force_insert=False, force_update=False):

# TODO posiziona gli immobili a caso se il debug è attivo.
        if VC_DEBUG:
            list = [random.random() * 45, random.random() * 45, 7]
        else:
# TODO - se la posizione di google esce fuori dall'abruzzo sposta la posizione
#         sulla sede amministrativa
# TODO - se le coordinate sono impostate non devono essere rimpostate
            list = Google.resolver("%s %s %s " % (self.CAP, self.via, self.n))

        if list != 'None':
            list.pop()
            self.google_lat = float(list.pop())
            self.google_lan = float(list.pop())

        super(Posizione, self).save(force_insert, force_update)

    class Meta:
        verbose_name_plural = "Posizioni"

class DataMedia(models.Model):
    testo               = models.CharField(max_length=255, blank=True, null=True)
    immobile            = models.ForeignKey("Immobile")
    approvato           = models.BooleanField(default=False, blank=True)
    pubblicazioni       = models.IntegerField(blank=True, default=0)
    priorita            = models.IntegerField(choices=((1, 1), (2, 2), (3, 3),
                                              (4, 4), (5, 5), (6, 6),
                                              (7, 7), (8, 8), (9, 9),
                                              (10, 10)), blank=True, default=1)  # scelta multipla
    spot                = models.BooleanField(default=False, blank=True)
    if VC_DEBUG:
        spot_link       = models.URLField(blank=True, verify_exists=False, null=True)
    else:
        spot_link       = models.URLField(blank=True, verify_exists=True, null=True)

    class Meta:
        abstract = True


class Video(DataMedia):
    """ Solo il supporto del media in questa classe """
    video               = models.FileField(upload_to=VIDEO_UPLOAD_TO)
    def __unicode__(self):
        return u"\"%s\" " % self.testo
    class Meta:
        verbose_name_plural = "Video"

class RaccoltaDiFoto(DataMedia):
    """ Come per video, ma in questo caso le immagini possono esere composte
        in un video """
    foto1               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_12      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto2               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_23      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto3               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_34      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto4               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_45      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto5               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_56      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto6               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_67      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto7               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_78      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto8               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    transaction_89      = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )
    foto9               = models.ImageField(upload_to=PHOTO_COLLECTION_UPLOAD_TO, blank=True, null=True)
    
    # This file is the template used to load the 10 images ( actually loaded by the user )
    video               = models.CharField(max_length=256, editable=False, blank=True)

    # The available effects are store in the configuration file, change it and recompile
    # It's a just an integer ( the effect number to load )
    template            = models.IntegerField(choices=(VIDEO_EFFECTS_LIST.values()),
                                              default=0,
                                              blank=True, )

    # It' required because, we need to store the full path together the flash program to
    # download. A simbolic link in the image folder will be enought
    def save(self, force_insert=False, force_update=False):
        flash_program_to_load = ""
        
        # GET THE VIDEO EFFECT
        valori = [(h[0]) for h in VIDEO_EFFECTS_LIST.values()]

        if not self.template in valori:
            self.template = VIDEO_EFFECT_STANDARD_ID

        for i in VIDEO_EFFECTS_LIST.keys():
            effect = VIDEO_EFFECTS_LIST[i]
            if effect[0] == self.template:
                flash_program_to_load = i
                break

        # SETUP THE URL With the correct parameters, no the best way to do it
        params = "?";

        if self.foto1 != None:
            params = params + "f=1&"
        if self.foto2 != None:
            params = params + "f=2&"
        if self.foto3 != None:
            params = params + "f=3&"
        if self.foto4 != None:
            params = params + "f=4&"
        if self.foto5 != None:
            params = params + "f=5&"
        if self.foto6 != None:
            params = params + "f=6&"
        if self.foto7 != None:
            params = params + "f=7&"
        if self.foto8 != None:
            params = params + "f=8&"
        if self.foto9 != None:
            params = params + "f=9&"

        # TODO -- setup the folder for the video effects
        self.video = VIDEO_EFFECT_STANDARD_PATH + flash_program_to_load + params
        super(RaccoltaDiFoto, self).save(force_insert, force_update)

    def __unicode__(self):
        return u" \"%s\" " % self.testo
    
    class Meta:
        verbose_name_plural = "Raccolte di foto"


class Ricerca(models.Model):

    descrizione             = models.CharField(max_length=100, blank=False, null=False)
    profilo                 = models.ForeignKey("Profilo")

    categoria               = models.ForeignKey("CategoriaMerceologica", related_name="categoria_immobile", default=1)
    min_mq                  = models.FloatField(blank=True, null=True)
    min_vani                = models.IntegerField(blank=True, null=True)
    min_camere              = models.IntegerField(blank=True, null=True)
    min_bagni               = models.IntegerField(blank=True, null=True)
    min_ripostigli          = models.IntegerField(blank=True, null=True)
    min_balconi             = models.IntegerField(blank=True, null=True)
    min_terrazzo            = models.NullBooleanField(blank=True, default=False)
    min_post_auto           = models.IntegerField(blank=True, null=True)
    min_garage              = models.IntegerField(blank=True, null=True)
    min_prezzo              = models.DecimalField(max_digits=10, decimal_places=2)

    max_mq                  = models.FloatField(blank=True, null=True)
    max_vani                = models.IntegerField(blank=True, null=True)
    max_camere              = models.IntegerField(blank=True, null=True)
    max_bagni               = models.IntegerField(blank=True, null=True)
    max_ripostigli          = models.IntegerField(blank=True, null=True)
    max_balconi             = models.IntegerField(blank=True, null=True)
    max_terrazzo            = models.NullBooleanField(blank=True, default=False)
    max_post_auto           = models.IntegerField(blank=True, null=True)
    max_garage              = models.IntegerField(blank=True, null=True)
    max_prezzo              = models.DecimalField(max_digits=10, decimal_places=2)

    giardino                = models.NullBooleanField(blank=True, default=False)
    piscina                 = models.NullBooleanField(blank=True, default=False)
    trattabile              = models.NullBooleanField(blank=True, default=False)

    trattabile              = models.NullBooleanField(blank=True, default=False)
    
    # opzionale   ( non specificato )
    destinazione_urbanistica = models.ForeignKey("DestinazioneUrbanistica", default=1)

    # opzionali ( non specificato )
    tipo_di_copetura        = models.ForeignKey("Copertura", default=1)
    tipo_di_impianto        = models.ForeignKey("Impianto", default=1)
    tipo_di_finitura        = models.ForeignKey("Finitura", default=1)
    tipo_di_pavimentazione  = models.ForeignKey("Pavimentazione", default=1)

    indice_cubatura         = models.FloatField(blank=True, null=True)
    # opzionale ( non indicato )
    indice_cubatura_misura  = models.IntegerField(choices=((0, 'non specificato'), (1, 'm2/m2'), (2, 'm3/m2')), default=0)
    min_numero_vetrine      = models.IntegerField(blank=True, null=True)
    max_numero_vetrine      = models.IntegerField(blank=True, null=True)

    data_inserimento_time   = models.TimeField(auto_now_add=True)
    data_inserimento_date   = models.DateField(auto_now_add=True)

    matching_words          = models.CharField(max_length=255, null=True, blank=True) # MATCHING WORDS

    periodo_di_attivita     = models.IntegerField(blank=True, null=True)
    altezza                 = models.FloatField(blank=True, null=True)
    piazzale                = models.BooleanField(blank=True, default=False)

    numero_livelli          = models.IntegerField(blank=True, null=True)
    uffici                  = models.BooleanField(blank=True, default=False)
    aree_verdi              = models.BooleanField(blank=True, default=False)
    # questa ricerca è attiva ?
    attiva                  = models.BooleanField(blank=True, default=True)
    def __unicode__(self):
        return u"metri quadri %s" % self.descrizione

    class Meta:
        verbose_name_plural = "Ricerche"


# base class for users.
# uses the django user facility

class Profilo(models.Model):
#
#    La prima anagrafica e' quella che definisce l'indirizzo sensibile
#    per gli utenti, gli altri NON devono poter essere inseribili per gli
#    utenti che non sono poweruser ( commerciali )

    user                = models.ForeignKey(User, unique=True)
#   username, password and email are inside the above class, also is_active

#   stato, tutti campi che definiscono lo stato dell'utente
    sesso               = models.CharField(max_length=1, choices=(('M', 'Maschio'), ('F', 'Femmina')))
    attivo              = models.BooleanField(default=False)
    power_user          = models.BooleanField(default=False)
    counter             = models.IntegerField(blank=True, editable=False, null=True)
    
    # numero di annunci caricabili.
    annunci_disponibili = models.IntegerField(default=10, null=False, blank=True)
    spazio_su_disco     = models.IntegerField(default=MAX_DISK_SPACE, blank=True, null=False)
    spazio_utilizzato   = models.IntegerField(default=0, blank=True, editable=False)
    # se un utente ha perso la pass in qualche modo è degno di attenzione.
    recupero_password   = models.BooleanField(default=False)

    # informazioni per il login dell'utente sul sistema  e/o poter indentificare
    # l'utente

    msisdn              = models.CharField(max_length=15, blank=True, null=True)
    account_skype       = models.CharField(max_length=40, blank=True, null=True)
    codice_fiscale      = models.CharField(max_length=16, blank=True, null=True) # TODO preparare un campo per l'immisione del codice fiscale

    # logging dello stato

    inserito_date       = models.DateField(auto_now_add=True, editable=False)
    inserito_time       = models.DateField(auto_now_add=True, editable=False)

    cancellato_date     = models.DateField(auto_now_add=True, editable=False)
    cancellato_time     = models.DateField(auto_now_add=True, editable=False)

    sospeso_date        = models.DateField(auto_now_add=True, editable=False)
    sospeso_time        = models.DateField(auto_now_add=True, editable=False)

    autenicato_date     = models.DateField(auto_now_add=True, editable=False)
    autenticato_time    = models.DateField(auto_now_add=True, editable=False)

    last_upload_date    = models.DateField(blank=True, null=True)
    last_upload_time    = models.TimeField(blank=True, null=True)

    # preferenze dell'utente

    riceve_news         = models.BooleanField(blank=True, default=False)
    riceve_news_email   = models.BooleanField(blank=True, default=False)
    frequenza_news      = models.IntegerField(blank=True, default=0)

    logo                = models.ImageField(upload_to=LOGO_UPLOAD_TO, blank=True, null=True)
    logo_small          = models.ImageField(upload_to=LOGO_UPLOAD_TO, blank=True, null=True)

    if VC_DEBUG:
        link_cliccabile = models.URLField(blank=True, verify_exists=False)
    else:
        link_cliccabile = models.URLField(blank=True, verify_exists=True)

    def __unicode__(self):
        return u"%s %s %s "  % (self.user.username, self.user.email, self.msisdn)

    class Meta:
        verbose_name_plural = "Profili"
#
# Utente con caratteristiche evolute, può avere più anagrafiche
# Inoltre solo un power user può essere sponsor, il che significa che
# a classe Sponsor deve avere un FieldForeingKey verso questa class qui,
#

#
# Uno sponsor è un banner associato ad un certo power_user, questo banner
# può esser vincolato a un cap e la sua pubblicazione può essere impostata in modo
# indipendente da tutti quanti gli altri.
#
class Banner(models.Model):
    #indirizza un power user per il banner corrente
    profilo                 = models.ForeignKey("Profilo", related_name="power_user_sponsor")
# TODO  Immagine_[s]pot da correggere appena possibile
    Immagine_Spot           = models.FileField(upload_to=BANNER_UPLOAD_TO, blank=False, null=False)
    priorita                = models.IntegerField(choices=((1, 1), (2, 2), (3, 3),
                                                  (4, 4), (5, 5), (6, 6),
                                                  (7, 7), (8, 8), (9, 9),
                                                  (10, 10)), default=1) #scelta multipla

    bytes                   = models.IntegerField(editable=False, blank=True, null=False, default=0)
    xsize                   = models.IntegerField(editable=False, blank=True, null=True)
    ysize                   = models.IntegerField(editable=False, blank=True, null=True)
    format                  = models.CharField(max_length=4, editable=False)

    if VC_DEBUG:
        link                = models.URLField(verify_exists=False, blank=True, null=True)
    else:
        link                = models.URLField(verify_exists=True, blank=True, null=True)

    pubblicazioni           = models.IntegerField(editable=False, blank=True, null=True)
    click                   = models.IntegerField(blank=True, null=True, default=0)
    data_inizio             = models.DateField(blank=True, null=True)
    data_fine               = models.DateField(blank=True, null=True)
    numero_click            = models.IntegerField(blank=True, null=True, default=0)
    attivo                  = models.NullBooleanField(blank=True)
    # il cap e' usato per estrarre gli spot in base al comune visualizzato
    # attensione non si tratta di un cap esteso.
    CAP                     = models.ForeignKey("Comune")

    def click_residui(self):
        click_residui = self.numero_click - self.click
        if click_residui > 0:
            return click_residui
        
        return 0

    def giorni_residui(self):
        if self.data_fine != None:
            dt_diff = self.data_fine - datetime.date.today()
        if dt_diff.days > 0:
            return dt_diff.days
        return 0

    def __unicode__(self):
        desc = u"Giorni disponibili %s, click residui %s " % (self.giorni_residui(), self.click_residui())
        if not self.giorni_residui() or not self.click_residui():
            desc = "SCADUTO " + desc
        return  desc

    def save(self, force_insert=False, force_update=False):
        try:
            im = Image.open(self.Immagine_Spot)
        except all:
            return 0
        
        (xsize, ysize) = im.size
        
#TODO Correggere il codice in questo punto
        if xsize > MAX_BANNER_XSIZE or not ysize == BANNER_YSIZE or not im.format.lower() in ('jpeg', 'png'):
            print "Wrong Image size %s x %s " % (xsize, ysize)
            if VC_DEBUG:
                print "debug is on, skipping error"
            else:
                return 0

        self.xsize  = xsize
        self.ysize  = ysize
        self.format = im.format
        self.bytes  = 0
        
        super(Banner, self).save(force_insert, force_update)

    class Meta:
        verbose_name_plural = "Banner"


class BannerSession(models.Model):
    """
    must be filled with a session cookie which will be checked when user click
    the banner
    """
    cookie          = models.CharField(max_length=32, editable=False, primary_key=True)
    url             = models.URLField(editable=False)
    endtime         = models.DateField(editable=False)
    banner_id       = models.IntegerField(editable=False)
    

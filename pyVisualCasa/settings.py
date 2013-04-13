

# JUST FOR NOW TO ALLOW THE DEBUG. REMOVE IN PRODUCTION

DEBUG = True
TEMPLATE_DEBUG = DEBUG

# disables all check on data entry.
VC_DEBUG = DEBUG
#VC_DEBUG = False

######################################################################################################
#  VisualCasa Logger
######################################################################################################
LOG_ENABLED = True
LOG_FILE    = "C:/Users/Pippo/Documents/NetBeansProjects/visualcasa/trunk/pyVisualCasa/log.txt"
# LOG_NAME    = 
######################################################################################################
#  STANDARD DJANGO CONFIGURATION
######################################################################################################
ADMINS = ( ('sergio', 'sergio@visualcasa.it'), )
MANAGERS = ADMINS

######################################################################################################
# django db interface
######################################################################################################

DATABASE_ENGINE = 'mysql'           # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
DATABASE_NAME = 'visualcasa'             # Or path to database file if using sqlite3.
DATABASE_USER = 'visualcasa'             # Not used with sqlite3.
DATABASE_PASSWORD = 'visualcasa'         # Not used with sqlite3.
DATABASE_HOST = '127.0.0.1'             # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = ''             # Set to empty string for default. Not used with sqlite3.

DATABASE_TIME_FORMAT = "%Y-%m-%d %H:%M:%S"      # required to convert the



# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'Europe/Rome'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'it-IT'
SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# Absolute path to the directory that holds media.
# Example: "/home/media/media.lawrence.com/"
# TODO dove sono immagazzinati i file che son caricati sul sistema.
#      non gestisce i file temporanei ( no upload folder ) 
MEDIA_ROOT = 'C:/Users/Pippo/Documents/NetBeansProjects/visualcasa/trunk/pyVisualCasa/static/static_user_data'

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash if there is a path component (optional in other cases).
# Examples: "http://media.lawrence.com", "http://example.com/media/"
MEDIA_URL = 'http://127.0.0.1/static_user_data/'

# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
# trailing slash.
# Examples: "http://foo.com/media/", "/media/".
ADMIN_MEDIA_PREFIX = '/media/'

# Make this unique, and don't share it with anybody.
SECRET_KEY = '8)iwoy^epd2uvuv*@=^sqt6n7e!_g@!*334ti$%-u&455kp48g'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
#     'django.template.loaders.eggs.load_template_source',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'pyVisualCasa.logger.LoggingMiddleware',
)

# We want to use the django facility to handle users.
AUTH_PROFILE_MODULE = 'pyVisualCasa.Profilo'

ROOT_URLCONF = 'pyVisualCasa.urls'

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.admin',
    'pyVisualCasa'                
)


######################################################################################################
# GOOGLE CONFIGURATION
######################################################################################################
GOOGLE_KEY = 'ABQIAAAAg-WVcB-LDOiYHUnRgA30JhTGtcs1KrCtqnNtYTpxN6F8phtu9xSMmOo5VPZaniH6PiS1RNa9blCfFg'
GOOGLE_URL = 'http://maps.google.com:80/maps/geo?'


# Video effects for the image collection
# the key is the flash program to load, the second is the data used in the model to
# show the effet list, so a good description will be enougth

######################################################################################################
#  SWF INTERFACE
######################################################################################################

VIDEO_EFFECTS_LIST = {
    '1'     : (0,'standard'), # sempre disponibile
    '2'     : (1,'Effetto uno'),
    '3'     : (2,'Effettu due'),
    '4'     : (3,'Effetto tre'),
    '5'     : (4,'Effetto quattro'),
    '6'     : (5,'Effetto Cinque'),
    '7'     : (6,'Effetto sei'),
    '8'     : (7,'Effetto sette'),
}

VIDEO_EFFECT_STANDARD_ID = 0
VIDEO_EFFECT_STANDARD_PATH = MEDIA_ROOT + "/VIDEO_EFFECTS_FOLDER/"

######################################################################################################
# PATH SETTINGS
######################################################################################################

# there are the path to upper level where to store the data
PATH_SPONSOR_BANNER = "/banners/"
PATH_VIDEO = "/videos"
PATH_PHOTO_COLLECTION = "/photo_collection/"

# for each upload use this file name ( almost used to avoid to overload directories )
BANNER_UPLOAD_TO           = "banner_%Y%m%d"
VIDEO_UPLOAD_TO            = "video_%Y%m%d"
PHOTO_COLLECTION_UPLOAD_TO = "photo_%Y%m%d"
LOGO_UPLOAD_TO             = "logo_%Y%m%d"

######################################################################################################
# BOUNDARIES
######################################################################################################

MAX_BANNER_XSIZE = 1024
BANNER_YSIZE = 72
MAX_DISK_SPACE = 5000000

######################################################################################################
# REDIRECT TO STATIC PAGES
######################################################################################################

URL_ACCOUNT_DISABLED = "http://www.yahoo.com/"
URL_LOGIN_OK         = "/rest/user/home/"
URL_LOGIN            = "/rest/user/login/"
LOGIN_URL            = URL_LOGIN
URL_USER_HOME        = URL_LOGIN_OK

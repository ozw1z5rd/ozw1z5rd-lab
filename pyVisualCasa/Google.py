# -*- coding: cp1252 -*-

import urllib
import xml.dom.minidom
import math
from settings import GOOGLE_KEY, GOOGLE_URL

def resolver( what ):
    """ottiene le coordinate da un indirizzo"""

    params = urllib.urlencode({  'q' :  what,
                                 'sensor' : 'false',
                                 'key' : GOOGLE_KEY,
                                 'output' :  'xml',
                               })

    data = urllib.urlopen( GOOGLE_URL + params ).read()
    doc = xml.dom.minidom.parseString( data )
    nodelist = doc.childNodes
    a = nodelist[0].childNodes
    c =  a[0].childNodes

    for i in c :
        if i.nodeName == 'Placemark':
            for j in i.childNodes:
                if j.nodeName == 'Point' :
                    jj = j.childNodes
                    q = jj[0]
                    r = q.firstChild;
                    return r.nodeValue.split(",")


def point_distance( lat1, lan1, lat2, lan2 ):
    """
    return the distance between two coordinates
    """

    return distVincenty(lat1, lan1, lat2, lan2)


def distVincenty(lat1, lon1, lat2, lon2) :

    a = 6378137
    b = 6356752.3142
    f = 1/298.257223563  # WGS-84 ellipsiod

    L = math.radians(lon2-lon1)
    U1 = math.atan( (1-f) * math.tan(math.radians(lat1)) )
    U2 = math.atan( (1-f) * math.tan(math.radians(lat2)) )
    sinU1 = math.sin(U1)
    cosU1 = math.cos(U1)
    sinU2 = math.sin(U2)
    cosU2 = math.cos(U2)

    lambda1 = L
    lambdaP = 0
    iterLimit = 100

    while True:
        
        sinLambda = math.sin(lambda1)
        cosLambda = math.cos(lambda1)
        
        sinSigma = math.sqrt((cosU2*sinLambda)
                   * (cosU2*sinLambda)
                   + (cosU1*sinU2-sinU1*cosU2*cosLambda)
                   * (cosU1*sinU2-sinU1*cosU2*cosLambda))

        if sinSigma==0 :
            return 0

# This code can raise a problem bacause traps anything as math domain error
        try:
            cosSigma = sinU1*sinU2 + cosU1*cosU2*cosLambda
            sigma = math.atan2(sinSigma, cosSigma)
            sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma
            cosSqAlpha = 1 - sinAlpha*sinAlpha
            cos2SigmaM = cosSigma - 2*sinU1*sinU2/cosSqAlpha
        except:
            cos2SigmaM = 0 # equatorial line: cosSqAlpha=0 (§6)

        C = f/16*cosSqAlpha*(4+f*(4-3*cosSqAlpha))
        lambdaP = lambda1
        lambda1 = L + (1-C) * f * sinAlpha * (sigma + C*sinSigma*(cos2SigmaM+C*cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)))

        iterLimit = iterLimit - 1
        if abs(lambda1-lambdaP) > 1e-12 and iterLimit>0 :
            break

    if iterLimit==0 :
        return None # formula failed to converge

    uSq = cosSqAlpha * (a*a - b*b) / (b*b)
    A = 1 + uSq/16384*(4096+uSq*(-768+uSq*(320-175*uSq)))
    B = uSq/1024 * (256+uSq*(-128+uSq*(74-47*uSq)))
    deltaSigma = B*sinSigma*(cos2SigmaM+B/4*(cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)-
                 B/6*cos2SigmaM*(-3+4*sinSigma*sinSigma)*(-3+4*cos2SigmaM*cos2SigmaM)))

    s = b*A*(sigma-deltaSigma);

    return s


def get_zoom_value( d ):
    """
    return the correct zoom value to enclose the given distance
    """
    
    v=(1,2,5)
    z = 20
    multiplier = 10;
    current_d = 0

    s = 0;
    while not d < current_d :
        #print "current_d %s vs d %s" % (current_d, d)
        current_d = v[s]*multiplier
        s = s + 1
        z = z - 1
        if s == 3 :
            multiplier = multiplier * 10;
            s = 0
        if z == 1 :
            break

    return z


#import <stdio.h>
#import "Frazione.h"

@implementation Frazione 

-(void) print {
    printf("%i/%i\n", _numeratore, _denominatore );
}

-(void) setNumeratore: (int) n {
    _numeratore = n;
}

-(void) setDenominatore: (int) d {
    _denominatore = d;
}

-(void) setNum: (int) n setDen: (int) d {
    _numeratore = n; 
    _denominatore = d; 
}

-(int) numeratore {
    return _numeratore;
}

-(int) denominatore {
    return _denominatore; 
}

-(float) toFloat {
    return _numeratore / (float)_denominatore;
}

// a     c     a*d + c*b
//--- + --- = -----------
// b     d        b*d

-(id) somma: (id) frazione {
     _numeratore = _numeratore * [ frazione denominatore ] + [ frazione numeratore ] * _denominatore;
     _denominatore *= [ frazione denominatore ];
     return self;
}

// a     c     a*d - c*b
//--- - --- = -----------
// b     d        b*d
-(id) sottrai: (id) frazione {
    [self somma: [frazione neg]];
    return self;
}

//  a     c      a * d
// --- : --- = -----------
//  b     d      b * c

-(id) dividi: (id) frazione {
    _numeratore   *= [ frazione denominatore ];
    _denominatore *= [ frazione numeratore ];
    return self;
}

//  a     c      a * c
// --- x --- = -----------
//  b     d      b * d

-(id) moltiplica: (id) frazione {
    _numeratore   *= [ frazione numeratore ];
    _denominatore *= [ frazione denominatore ];
    return self;
}

-(id) semplifica {
  return self;
}

-(id) neg {
  _numeratore *= -1; 
  return self;
}

@end 

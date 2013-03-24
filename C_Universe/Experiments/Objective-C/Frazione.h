#import <Foundation/NSObject.h>

@interface Frazione : NSObject {

// Variabili di instanza ( il default è PROTECTED )
    int _numeratore; 
    int _denominatore; 
}

// Metodi di instanza ( sono preceduti da un "-" ) 
-(void)  print; 
-(void)  setNumeratore: (int) n;
-(void)  setDenominatore: (int) d; 
-(void)  setNum:(int) n setDen:(int) d; 
-(int)   numeratore; 
-(int)   denominatore; 
-(float) toFloat;
-(id)  somma:     (id) frazione;
-(id)  sottrai:   (id) frazione;
-(id)  moltiplica:(id) frazione; 
-(id)  dividi:    (id) frazione;
-(id)  neg; 
@end

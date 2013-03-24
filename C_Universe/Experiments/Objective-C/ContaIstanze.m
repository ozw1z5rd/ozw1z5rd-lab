#import <stdio.h>
#import <Foundation/NSObject.h>

static int n; 

@interface ContaIstanze: NSObject {
}

-(void) say: (int) string;
+(void) nSay; 
+(void) init;
@end


@implementation ContaIstanze 

static int n; 

-(void) say: (int) string {
    printf("Il numero è %d \n", string ); 
    return;
}

+(void) nSay {
    printf("Ci sono %d istanze\n", n );
    return;
}

// miss
+(void) init {
     printf("Init chiamato ..\n"); 
     n++;
     [super init ];
}
@end


int main() {
    ContaIstanze *obj1 = [[ContaIstanze alloc] init]; 
    ContaIstanze *obj2 = [[ContaIstanze alloc] init];
    id  K = [ obj1 class ];
   [K nSay ]; 
}

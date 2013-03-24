clang -lgnustep-base -v -lpthread -lobjc -lm  -L/usr/GNUstep/System/Library/Libraries -I/usr/GNUstep/System/Library/Headers -I/usr/include/GNUstep -I/usr/lib/gcc/x86_64-linux-gnu/4.4/include -fconstant-string-class=NSConstantString -g -o $1 $1.m


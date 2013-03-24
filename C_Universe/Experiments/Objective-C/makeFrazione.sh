# ----------------------------------------------------------------------------------------------------------------------
# Questo file serve per compilare con l'installazione standard di gnustep
# ----------------------------------------------------------------------------------------------------------------------

LIBOPTIONS="-lgnustep-base -lpthread -lobjc -lm"
INCLUDEOPTIONS="-I/usr/GNUstep/System/Library/Headers/ -I/usr/include/GNUstep/ -I/usr/lib/gcc/x86_64-linux-gnu/4.4/include"
OTHEROPTIONS=" -fconstant-string-class=NSConstantString -g -v -L/usr/GNUstep/System/Library/Libraries"


clang $INCLUDEOPTIONS $OTHEROPTIONS -c Frazione.m -o Frazione.o
clang $LIBOPTIONS $INCLUDEOPTIONS $OTHEROPTIONS Frazione.o mainFrazione.m -o mainFrazione


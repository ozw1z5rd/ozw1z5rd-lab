//
// Euphoria lib
//
// 2012-07-11 - versione inziale
//              pagina di login per touch screen.
//
//


// ClassSeqPassword : hold passoword information 
//
//
//
function ClassSeqPassword() {

    var password = new Array();
    var index = 0 

// confrona il token successivo della pass
// 1 : password corrisposta 
// 0 : password non corrisposta
    this.nextMatch = function( value ) {
        ( this.password[ this.index ] == value ) ?  this.index++ : this.reset(); 
        return ( this.password[this.index] == -1 ) ? 1: 0 ; 
    }
 
   this.reset = function( ) {
          this.index = 0; 
          console.log("password : index reset ");
    }

   this.init = function( seq ) {
          this.reset();
          this.password = seq;
   }
}

//
// animazione dei dischi di lock
// 
//
//
function ClassDiscLock() {

    var cicle = new Array();
    var dot   = new Array();

    this.randomRotate= function () {};

    this.lock = function() {};

    this.unlock = function() {};
    
    this.draw = function() {}; 

    this.undraw = function() {}; 

    this.init = function( p, sx, sy, n ) {};


}

function ClassLogin() {

      var circle = new Array(4);
      var dot = new Array(4);
      var ring = new Array(4);

      var password = [4,9,14,19,-1 ];
      var passIndex = 0; 

      var cx = 300; var cy = 300; 
      var radius = 250; 
      var thickness = 30; 
      var rotation = new Array(); 
      var circles = 6; // 8 
      var animTime = 1000;
      var p;
      var innerC  = undefined ; 
      var discAnim = 0 ; 

      var grid_x = 700; 
      var grid_y = 150; 

      var grid_sx = 7; 
      var grid_sy = 05;
      var grid_r  = 34; 
      var grid_w  = (  grid_x / grid_r ) * 4; 

      var grid = new Array(); 
      /**@ void generate() 

         rotazione casuale dei dischi di accesso .
      */
      function generate() {

            if ( discAnim ) { return undefined }
            discAnim = 1; 
            var rot = 0;
            for ( i = 0; i<circles; i++ ) {                
                 
                do {
                    rot = Math.random()*360;
                    var redo = 0;
                    if ( Math.random() > .5 ) {
                        rot *= -1; 
                    }
                    for ( j = 0 ; j < circles; j++ ) {
                        if ( (rotation[j] < rot + 0.5)  && ( rotation[j] > rot -0.5 ) ) {
                            redo = 1; 
//                            alert("kip ami");
                        }
                    }
                } while ( redo ); 

                var anim = Raphael.animation(   
                { 
                  'transform' : "R0,"+String(cx)+","+String(cy)+",R"+String(rot)+',' + String(cx) +"," + String(cy)                     },
                animTime, 
                'linear',
                function() { discAnim = 0 }
                )
                ring[i].animate( anim ); 
             }
             animTime += 00;         
      }





      /**@ void unlock( ) 
       
         rotazione per apertura dei dischi e animazione di apertura
      */ 
      function unlock () {
            lockPad();
            for ( i = 0; i<circles; i++ ) {
                var anim = Raphael.animation(   
                { 
                  'transform' : "R0,"+String(cx)+","+String(cy)+",R"+String(0)+',' + String(cx) +"," + String(cy)                       },
                animTime, 
                'linear',
                function() { accessGranted() }
                )

                ring[i].animate( anim ); 
            }
      }

      /**@ Raphael object arco( canvas, cx, cy, radius, astart, aend )

        disegna un cerchio alle coordinate date partendo e finendo dall'angolo indicato
        gli angoli devono essere dati in radianti
        
        p = contesto grafico su cui disegnare\
        cx, cy, r = coordinate del cerchio
        astart, aend = angolo di inizio e angolo di fine
        
        return un oggetto Raphael che rappresenta l'arco

      
        @params canvas : contesto grafico dove disegnare
        @params cx     : centro del cerchio X
        @params cy     : centro del cerchio Y
        @params radius : raggio
        @params astart : angolo di inizio ( DEVE ESSERE MINORE DELL'ANGOLO DI FINE )
        @params aend   : angolo di fine DEVE ESSERE MAGGIORE DELL'ANGOLO DI INIZIO )
      */
      function arco( p, cx, cy, r, astart, aend ) {
            var sx = r * Math.cos(astart)+cx;
            var sy = r * Math.sin(aend)+cy;
            var fx = r * Math.cos(-astart)+cx;
            var fy = r * Math.sin(-aend)+cy;

            var arc =  p.path( "M"+String(sx)+","+String(sy)
                          +"A"+String(r)+"," + String(r)
                          + ",0,1,1,"+String(fx)+","+String(fy) );
            return arc ;
      }
      /**@ void drawGrid( p  ) 
         disegna la griglia per inserire il pin sul contesto grafico indicato 

         @params p : contesto grafico dove eseguire il disegno.

      */
      function drawGrid(p) {
            var c = 0; 
            for ( i = 0; i < grid_sx; i++ ) {
                for ( j = 0; j < grid_sy; j++ ) {
                    grid[c] = p.circle( grid_x + i*grid_w , grid_y + j*grid_w , grid_r );
                    grid[c].mouseover( pulseIn );   // mouse sopra 
                    grid[c].data("ndx", c ); 
                    grid[c++].attr("fill", "r#f00-#0f0" ); 
                    
                }
            }
      }


      /**@ void removeGrid(   ) 
       */

      function removeGrid(  ) {

        var c= 0; 
        for ( i = 0; i<grid_sx; i++ ) {
            for ( j = 0 ; j < grid_sy ; j++ ) {
                grid[c++].remove();
            }
        }

     }



      /**@ void drawScene( ) 
      
        disegna la pagina di login. 


      */ 
      function drawScene() {
          p = Raphael( document.getElementById("container") , 1280,600);

          angle = Math.PI / ( 10  ) ;
         
          var earc = arco(p, cx, cy, radius + thickness + 1, -angle, angle );

          earc.attr("stroke-width", thickness );
          earc.attr("stroke","yellow");

          for ( i = 0; i<circles; i++ ) {
                circle[i] = p.circle( cx, cy , radius  ); 
                circle[i].attr( "stroke-width" , thickness );

                dot[i] = arco(p, cx, cy, radius , -angle, angle ); 
                dot[i].attr( "stroke" , "red" ); 
                dot[i].attr( "stroke-width" , thickness ); 

                radius -= (thickness+2); 

                ring[i] = p.set();
                ring[i].push( circle[i], dot[i] ); 
                rotation[i] = 0; 
               }
            innerC = p.circle( cx, cy, radius );
            innerC.attr("fill", "green"); 
            // un giro casuale ai dischi prima di passare la palla all'utente
            generate();
            drawGrid(p);
      }

      //
      // accesso eseguito...
      //
      function accessGranted() {
            var buttonAnim = Raphael.animation( 
                { 'fill' : '#00ff00' }, 
                animTime,
                'linear'
            );

            innerC.animate( buttonAnim.delay( 500 )  );
            removeGrid();
            var animGreen = Raphael.animation( { 'stroke': '#00ff00' }, animTime, 'linear', ringAnim ); 
            for ( i = 0; i< circles ; i++ ) {
                dot[i].animate( animGreen.delay( i * 200 ) ); 
            }
      }

     function lockPad() {
           var c = 0 ; 
            for ( i = 0; i < grid_sx; i++ ) {
                for ( j = 0; j < grid_sy; j++ ) {
                    grid[c].unmouseover( pulseIn );   // mouse sopra 
                    grid[c++].unmouseout( pulseOut );   // mouse via. 
                }
            }
     }


     function ringAnim() {
         var colorDest; 
         if ( this.attr('stroke') == "#00ff00" ) {
            colorDest = 'black'; 
         }
         else {
            colorDest = '#00ff00'; 
         }
         var animGreen = Raphael.animation( { 'stroke': colorDest }, animTime, 'linear', ringAnim ); 
         this.animate( animGreen.delay( 200 ) ); 
     }


     function pulseIn () {
          if ( this.data('ndx') == password[ passIndex ] ) {
                passIndex++;
                if ( password[ passIndex ] == -1 ) {
                   unlock(); 
                   return;
                }
          }
          else {
              passIndex = 0; 
          }
          generate();
      }


      window.onload=function(){
            drawScene();
      }
}

function ClassGrid()  { 


    var grid_x; 
    var grid_y; 

    var buttons = new Array(); 

    draw = function () { 
        for ( i =0 ; i < grid_x; i++ ) {
            for ( j = 0 ; j < grid_sy; j++ ) {
                this.buttons[i+j*(grid_sx-1)] = this.p.circle( x, y, r );
            }
    }


    lock = function () {
        var c = 0 ; 
        for ( i = 0; i < grid_sx; i++ ) {
            for ( j = 0; j< grid_sy; j++ ) {
                
            }
    }

    unlock = function () {
        this.lock( 0 ) ;
    }



    function costructor(   ) {
        this.p = 
    }


}

 

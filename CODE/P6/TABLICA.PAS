
uses crt,xvga;

var
   f : text;
   k : real;
   x : longint;
   y : longint;

begin
     xmode (true);

     assign (f,'tablica3');
     rewrite (f);
     writeln (f,'tablica3 label dword');

     repeat
           x:=round(156*cos(k)*sin(k)*sin(k))-160;
           y:=round(20*(sin(k)-cos(k)))-100;
           xplot (x+320,y+200,15,$0a000);
           k:=k+4*pi/256;
           writeln (f,'dd ',x:5,', ',y:5);
     until k>2*pi;

     close (f);

end.
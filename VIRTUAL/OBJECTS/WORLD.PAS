
uses crt;

const
     maxobj=100;

var
   f    : text;
   a    : file;
   ile  : longint;
   lup  : longint;
   p    : pointer;
   ofs  : array [1..maxobj] of longint;
   f1   : file;
   fn   : string;
   fs   : longint;
   fold : longint;

begin
     getmem (p,65535);
     assign (f,'world.txt');
     reset (f);
     readln (f,ile);
     writeln ('objektow: ',ile);

     readln (f,fn);
     assign (a,fn);
     rewrite(a,1);

     blockwrite (a,ile,4);
     seek(a,ile*4+4);
     for lup:=1 to ile do
     begin
          readln (f,fn);
          writeln ('Linking ',fn);
          assign (f1,fn);
          reset(f1,1);
          fs:=filesize(f1);
          blockread (f1,p^,fs);
          close(f1);
          blockwrite(a,p^,fs);
          if lup=1 then ofs[lup]:=4+ile*4 else
             ofs[lup]:=ofs[lup-1]+fold;
          fold:=fs;
     end;
     seek (a,4);
     for lup:=1 to ile do
          blockwrite (a,ofs[lup],4);

     close(a);

     close (f);
end.

uses crt;

var
   t    : text;
   f    : file;
   fn   : string;
   f1   : file;
   ile  : longint;
   poz  : array [1..1000] of array [1..2] of longint;
   l    : word;
   p    : pointer;
   fs   : longint;
   ja   : longint;

begin
     getmem (p,65535);
   clrscr; writeln ('Professional linker by Wlk & Nuke of ABC...');
   writeln;
   assign (t,'vodka.txt');
   reset  (t);
   assign (f,'vodka.dat');
   rewrite(f,1);
   readln (t,ile);
   writeln ('luksusowa :) ',ile);writeln;
   seek (f,1000*4*2);

   for l:=1 to ile do
   begin
        readln (t,fn);
        writeln ('Drinking: ',fn);
        assign (f1,fn);
        reset (f1,1);
        fs:=filesize(f1);
        if fs>65535 then begin
                              poz[l,1]:=filepos(f);
                              poz[l,2]:=fs;
                              for ja:=1 to (fs div 65535) do
                              begin
                                   blockread (f1,p^,65535);
                                   blockwrite(f,p^,65535);
                              end;
                                  blockread (f1,p^,fs mod 65535);
                                  blockwrite(f,p^,fs mod 65535);
                         end else
        begin
        blockread (f1,p^,fs);
        poz[l,1]:=filepos(f);
        poz[l,2]:=fs;
        blockwrite(f,p^,fs);
        end;
        close (f1);
   end;
   seek(f,0);
   blockwrite (f,poz,1000*4*2);

   close (f);
   close (t);
end.

;Storm=1

ifdef storm
visiblating=0
else
visiblating=1
endif
roling=2-1
addtoenv=64+64

;DrawPixelObject (m) - draw punktow z objekt
;PerspObject (m) - perspective
;RotateObject (m) - obroty
;LoadObject (MACRO) - plik(bez offsetu tylko nazwa), adres gdzie siedzi
;PrepareObject (M) - kopiowanie danych do tablic operacyjnych


MAX_OBJECTS EQU 10
PIXELS EQU 0
TEXTURES EQU 1
PHONG EQU 2

colorPixla db 64

number_of_objects dd 0
objects dd MAX_OBJECTS DUP (0) ;adresy  do wgranych obiektow

fileptrPomoc dd ?


DrawObject MACRO ktory
        mov ebp,[objects+ktory*4]
        mov esi,[ebp+60]
        mov edi,[ebp+76]
        mov ecx,[ebp+4]
        call persp
        call drawZielonyLudek
   ENDM

DrawZielonyLudek:

        mov eax,[ebp+60]
        mov [jajko],eax

        cmp d [ebp],0
        je zpierniczkow
        cmp d [ebp],1
        je OnlyYouTex
        cmp d [ebp],2
        je zfacowPhong

        jmp DZLend
 zfacowPhong:
;       mov ax,[ebp+72]
;       mov gs,ax

        call sort

        mov esi,[ebp+40] ;aFaces
        mov ecx,[ebp+8]
        mov edi,[ebp+76] ;wsp2d
        mov edx,[ebp+80] ;kolej
        mov ebx,[ebp+64] ;textur
 ple:   push ebx edx ecx esi edi ebp
        mov ebp,[edx] ;kolejn
        lea ebp,[ebp*2+ebp]
        mov eax,[esi+ebp*4] ;face[0]
        mov ecx,[edi+eax*8] ;x
        mov x_1,ecx
        mov ecx,[edi+eax*8+4] ;y
        mov y_1,ecx
        lea eax,[eax*2+eax]
        mov ecx,[ebx+eax*4]
        sar ecx,roling
        add ecx,addtoenv
        shl ecx,8
        mov w [p_1],cx
        mov ecx,[ebx+eax*4+4]
        sar ecx,roling
        add ecx,addtoenv
        shl ecx,8
        mov w [p_1+2],cx
mov ecx,[jajko]
shl eax,2
mov eax,[ecx+eax+8] ;z[0]
cmp eax,ZetVisible
jl ploe

        mov eax,[esi+4+ebp*4] ;face[0]
        mov ecx,[edi+eax*8] ;x
        mov x_2,ecx
        mov ecx,[edi+eax*8+4] ;y
        mov y_2,ecx
        lea eax,[eax*2+eax]
        mov ecx,[ebx+eax*4]
        sar ecx,roling
        add ecx,addtoenv
        shl ecx,8
        mov w [p_2],cx
        mov ecx,[ebx+eax*4+4]
        sar ecx,roling
        add ecx,addtoenv
        shl ecx,8
        mov w [p_2+2],cx
mov ecx,[jajko]
shl eax,2
mov eax,[ecx+eax+8] ;z[0]
cmp eax,ZetVisible
jl ploe

        mov eax,[esi+8+ebp*4] ;face[0]
        mov ecx,[edi+eax*8] ;x
        mov x_3,ecx
        mov ecx,[edi+eax*8+4] ;y
        mov y_3,ecx
        lea eax,[eax*2+eax]
        mov ecx,[ebx+eax*4]
        sar ecx,roling
        add ecx,addtoenv
        shl ecx,8
        mov w [p_3],cx
        mov ecx,[ebx+eax*4+4]
        sar ecx,roling
        add ecx,addtoenv
        shl ecx,8
        mov w [p_3+2],cx
mov ecx,[jajko]
shl eax,2
mov eax,[ecx+eax+8] ;z[0]
cmp eax,ZetVisible
jl ploe

        call isvisible
        cmp Visible,visiblating
        je ploe
        call tm_face
 ploe:  pop ebp edi esi ecx edx ebx
        add edx,4
        loop ple
        ret

 onlyYouTex:
;       mov ax,[ebp+72]
;       mov gs,ax

        call sort



        ;FROM X-FILES

ifdef xfile
        push esi edx ecx
        mov ah,write_external_file
        mov edx,o ffff
        mov esi,[ebp+60]
        mov ecx,[ebp+4]
        lea ecx,[ecx*2+ecx]
        shl ecx,2
        int_eos
        pop ecx edx esi
endif

        jmp ids
        jajko dd ?
ids:
;       mov eax,[ebp+60]
;       mov [jajko],eax

        mov esi,[ebp+40] ;aFaces
        mov ecx,[ebp+8]
        mov edi,[ebp+76] ;wsp2d
        mov edx,[ebp+80] ;kolej
        mov ebx,[ebp+44] ;textury
 ple2:  push ebx edx ecx esi edi ebp

        mov ebp,[edx] ;kolejn
        lea ebp,[ebp*2+ebp]
        mov eax,[esi+ebp*4] ;face[0]
        mov ecx,[edi+eax*8] ;x
        mov x_1,ecx
        mov ecx,[edi+eax*8+4] ;y
        mov y_1,ecx
        mov ecx,[ebx+eax*8]
shl ecx,8
        mov w [p_1],cx
        mov ecx,[ebx+eax*8+4]
shl ecx,8
        mov w [p_1+2],cx
mov ecx,[jajko]
lea eax,[eax*2+eax]
shl eax,2
mov eax,[ecx+eax+8] ;z[0]
cmp eax,ZetVisible
jl ploe2

        mov eax,[esi+4+ebp*4] ;face[0]
        mov ecx,[edi+eax*8] ;x
        mov x_2,ecx
        mov ecx,[edi+eax*8+4] ;y
        mov y_2,ecx
        mov ecx,[ebx+eax*8]
shl ecx,8
        mov w [p_2],cx
        mov ecx,[ebx+eax*8+4]
shl ecx,8
        mov w [p_2+2],cx
mov ecx,[jajko]
lea eax,[eax*2+eax]
shl eax,2
mov eax,[ecx+eax+8] ;z[0]
cmp eax,ZetVisible
jl ploe2

        mov eax,[esi+8+ebp*4] ;face[0]
        mov ecx,[edi+eax*8] ;x
        mov x_3,ecx
        mov ecx,[edi+eax*8+4] ;y
        mov y_3,ecx
        mov ecx,[ebx+eax*8]
shl ecx,8
        mov w [p_3],cx
        mov ecx,[ebx+eax*8+4]
shl ecx,8
        mov w [p_3+2],cx
mov ecx,[jajko]
lea eax,[eax*2+eax]
shl eax,2
mov eax,[ecx+eax+8] ;z[0]
cmp eax,ZetVisible
jl ploe2

        call isvisible
        cmp Visible,1
        je ploe2
        call tm_face
 ploe2: pop ebp edi esi ecx edx ebx
        add edx,4
        loop ple2
        ret

 ZPierniczkow:
ifdef xfile
        push esi edx ecx
        mov ah,write_external_file
        mov edx,o ffff
        mov esi,[ebp+60]
        mov ecx,[ebp+4]
        lea ecx,[ecx*2+ecx]
        shl ecx,2
        int_eos
        pop ecx edx esi
endif


        mov esi,[ebp+76]
        mov edi,[_screen]
        mov al,colorPixla
        mov ecx,[ebp+4]
        call pixel2d
        ret
 DZLend:
        ret

DrawPixelObject MACRO ktory
        mov ebp,[objects+ktory*4]
        mov esi,[ebp+76]
        mov edi,[_screen]
        mov al,15
        mov ecx,[ebp+4]
        call pixel2d
   ENDM

PerspObject MACRO ktory
        mov ebp,[objects+ktory*4]
        mov esi,[ebp+60]
        mov edi,[ebp+76]
        mov ecx,[ebp+4]
        call persp
   ENDM

RotateObject MACRO ktory
        mov ebp,[objects+ktory*4]
        call RotateObj
   ENDM

RotateObj:
        mov eax,[ebp+12]
        mov AngleX,eax
        mov eax,[ebp+16]
        mov AngleY,eax
        mov eax,[ebp+20]
        mov AngleZ,eax
        call PrepareRotationMatrix
        mov esi,[ebp+60]
        mov ecx,[ebp+4]
        call mrotate
        cmp d [ebp],2
        je ObrNormals
        ret
 obrNormals:
        mov esi,[ebp+64]
        mov ecx,[ebp+4]
        call mrotateNormals
        ret

PrepareObject MACRO ktory
        mov ebp,[objects+ktory*4]
        call przygotujObjekt
   ENDM

przygotujobjekt:
        mov ecx,[ebp+4]
        lea ecx,[ecx*2+ecx]
        mov esi,[ebp+36]
        mov edi,[ebp+60]
        rep movsd

        cmp d [ebp],2
        je copyNormals
        jmp outofcontrol
 copyNormals:
        mov ecx,[ebp+4]
        lea ecx,[ecx*2+ecx]
        mov esi,[ebp+52]
        mov edi,[ebp+64]
        rep movsd
 outofcontrol:

        ;teraz zabawa z katami
        mov eax,[ebp+24]
        add [ebp+12],eax
        mov eax,[ebp+28]
        add [ebp+16],eax
        mov eax,[ebp+32]
        add [ebp+20],eax
        ret

texturaKtora dd ?
costam       dd ?
EXTRN   _file_addr      : DWORD

LoadObject MACRO plik,kkkks
 LOCAL @ubik,@duck
        mov [texturaKtora],kkkks
        ;mov edx,o @ubik
        ;vodka plik,costam

                mov     esi,_file_addr
                mov     ecx,[esi+plik*8+4]
                mov     eax,[esi+plik*8]
                add     esi,eax
                mov     eax,esi

        call Load_Object
        jmp @duck
 @ubik  db plik,0
 @duck:
    ENDM

Load_Object:
       ;push edi ebp edx
       ;call load_file
       ;pop edx ebp edi
        ;mov ah,Load_internal_file
        ;int_eos
        mov [filePtrPomoc],eax
        mov ah,Allocate_Memory
        mov edx,21*4
        int_eos
        mov ebp,edx
        mov eax,number_of_objects
        mov d [objects+eax*4],edx
        mov edi,edx
        xor eax,eax
        mov ecx,21
        rep stosd
        mov esi,[FilePtrPomoc]
        mov eax,[esi]
        mov [ebp],eax ;save type
        mov eax,[esi+4]
        mov [ebp+4],eax ;save number of verts
        mov eax,[esi+8]
        mov [ebp+8],eax ;save number of faces
        mov eax,[esi+12]
        mov [ebp+24],eax ;adder to angleX
        mov eax,[esi+16]
        mov [ebp+28],eax ;adder to angleY
        mov eax,[esi+20]
        mov [ebp+32],eax ;adder to angleZ
        mov eax,[texturaKtora]
        mov ax,w [textury+eax*2]
        mov [ebp+72],ax

        add esi,36
        mov [ebp+36],esi ;address to vertex'
        mov eax,[ebp+4]
        lea eax,[eax*2+eax]
        lea esi,[esi+eax*4]
        mov [ebp+40],esi ;address to facez

        cmp d [ebp],textures
        jne NoTexturesInFile
        mov eax,[ebp+8]
        lea eax,[eax*2+eax]
        lea esi,[esi+eax*4]
        mov [ebp+44],esi ;address to texturez
 notexturesinfile:

        mov edx,[ebp+8] ;nof
        shl edx,5 ;*32
        mov ah,Allocate_Memory
        int_eos
        mov [ebp+48],edx ;address to normals
        mov eax,[ebp+8] ;nof
        lea eax,[eax*2+eax]
        shl eax,2 ;=nof*12
        add edx,eax
        mov [ebp+68],edx ;address to copy of normals
        add edx,eax
        mov [ebp+56],edx ;address to adders to color
        mov eax,[ebp+8]
        shl eax,2
        add edx,eax
        mov [ebp+80],edx ;sumyZ & kolejnosc

        mov edx,[ebp+4]
        mov eax,edx
        shl eax,2
        shl edx,3 ;*8
        lea edx,[edx*4+edx] ;*40
        lea edx,[edx+eax] ;*44

        mov ah,Allocate_Memory
        int_eos
        mov [ebp+52],edx ;address wersorof
        mov eax,[ebp+4] ;nov
        lea eax,[eax*2+eax]
        shl eax,2 ;=nov*12
        add edx,eax
        mov [ebp+60],edx ;copy vertexy
        add edx,eax
        mov [ebp+64],edx ;copy wersory
        add edx,eax
        mov [ebp+76],edx ;2d points/to draw

        inc [Number_of_objects]

        cmp d [ebp+0],2
        jne noNorm
        call CalcNormals
 noNorm:

        ;podzielenie
        mov esi,[ebp+36]
        mov ecx,[ebp+4]
  dziel:
        mov eax,[esi]
        shl eax,4
        mov [esi],eax
        mov eax,[esi+4]
        shl eax,4
        mov [esi+4],eax
        mov eax,[esi+8]
        shl eax,4
        mov [esi+8],eax
        add esi,12
        dec ecx
        jnz dziel

        ret





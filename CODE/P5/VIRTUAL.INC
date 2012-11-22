ZetVisible equ 1

include ple2
include virSort.pm


PrepareVirtualPoints:
        mov esi,[ebp+60]        ;kopia vertexow
        mov ecx,[ebp+4]         ;number of vertices
 pvp:
        mov eax,[esi] ;x
        add EAX,d [WORLD+EBX+4]
        Sub EAX,CAMERAX
        mov [esi],eax

        mov eax,[esi+4]
        add EAX,d [WORLD+EBX+8]
        sub eax,CameraY
        mov [esi+4],eax

        mov eax,[esi+8]
        add EAX,d [WORLD+EBX+12]
        sub eax,CameraZ
        mov [esi+8],eax

        add esi,12

        dec ecx
        jnz pvp


        mov esi,[ebp+60]
        mov ecx,[ebp+4]
        call transform

        ret


RotateObjectVirtual:
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
        je ObrNormalsToo
        ret
 obrNormalsToo:
        mov esi,[ebp+64]
        mov ecx,[ebp+4]
        call mrotateNormals
        ret

PrepareObjectVirtual:
        push ebx

        mov ebp,[objects+edx*4]

        mov ecx,[ebp+4]
        lea ecx,[ecx*2+ecx]
        mov esi,[ebp+36]
        mov edi,[ebp+60]
        rep movsd

        cmp d [ebp],2
        je copyNormals2
        jmp outofcontrol2
 copyNormals2:
        mov ecx,[ebp+4]
        lea ecx,[ecx*2+ecx]
        mov esi,[ebp+52]
        mov edi,[ebp+64]
        rep movsd
 outofcontrol2:

        ;teraz zabawa z katami
        mov eax,d [World+ebx+20]
        mov [ebp+12],eax
        mov eax,d [World+ebx+24]
        mov [ebp+16],eax
        mov eax,d [World+ebx+28]
        mov [ebp+20],eax

        call RotateObjectVirtual

        pop ebx
        call PrepareVirtualPoints

        ret








CalculateVisiblating PROC
        lea esi,d [World+4]  ;3dpoints
        lea edi,worldZet
        mov ebx,WorldsObjects
 Tripunk2:
        dodawacz2=8
        dodawacz=0
        xor ecx,ecx
        REPT 3
        mov eax,[esi+dodawacz]
        SUB eax,[cameraX+dodawacz]
        imul d [MatrixCamera+dodawacz*4+dodawacz2]
        shrd eax,edx,15
        add ecx,eax
        dodawacz=dodawacz+4
        ENDM
        mov [edi],ecx
        cmp ecx,zetVisible
        jge no_v
        mov d [esi-4],0 ;visiblating
        jmp yes_v
 no_v:  mov d [esi-4],1 ;here too...
 yes_v: add esi,48
        add edi,4
        dec ebx
        jnz triPunk2
        ret
CalculateVisiblating ENDP


; ²±²±²[macierz obrotu kamery]²±²±² --> MatrixCamera
MakeCameraMatrix PROC
        lea edi,MatrixCamera
        call zeroMatrix

;       mov edx,[_sinus]
;       mov edi,[_cosinus]

        mov ebx,eyeax
        and ebx,03ffh
        mov eax,[sin+ebx*4]
        mov _sin1,eax
        add ebx,256
        and ebx,03ffh
        mov eax,[sin+ebx*4]
        mov _cos1,eax

        mov ebx,eyeay
        and ebx,03ffh
        mov eax,[sin+ebx*4]
        mov _sin2,eax
        add ebx,256
        and ebx,03ffh
        mov eax,[sin+ebx*4]
        mov _cos2,eax

        mov ebx,eyeaz
        and ebx,03ffh
        mov eax,[sin+ebx*4]
        mov _sin3,eax
        add ebx,256
        and ebx,03ffh
        mov eax,[sin+ebx*4]
        mov _cos3,eax

        ; mx11 - _cos2_cos3
        mov eax,_cos2
        imul _cos3
        sar eax,15
        mov [MatrixCamera+mx11],eax
        ; mx21 - -_sin3_cos1-_cos3_sin2_sin1)
        mov eax,_sin3
        imul _cos1
        mov d [_sin3_cos1],eax
        mov ebx,_cos3
        imul ebx,_sin1
        mov d [_cos3_sin1],ebx
        sar ebx,15
        imul ebx,_sin2
        neg eax
        sub eax,ebx
        sar eax,15
        mov [MatrixCamera+mx21],eax
        ; mx31 - -_sin3_sin1+_cos3_sin2_cos1
        mov ebx,_sin3
        imul ebx,_sin1
        mov d [_sin3_sin1],ebx
        neg ebx
        mov eax,_cos3
        imul _cos1
        mov d [_cos3_cos1],eax
        sar eax,15
        imul _sin2
        add eax,ebx
        sar eax,15
        mov [MatrixCamera+mx31],eax
        ; mx12 - _sin3_cos2
        mov eax,_sin3
        imul _cos2
        sar eax,15
        mov [MatrixCamera+mx12],eax
        ; mx22 - _cos3_cos1-_sin3_sin2_sin1
        mov eax,010001h
        _sin3_sin1=$-4
        sar eax,15
        imul _sin2
        mov ebx,010001h
        _cos3_cos1=$-4
        sub ebx,eax
        sar ebx,15
        mov [Matrixcamera+mx22],ebx
        ; mx32 - _cos3_sin1+_sin3_sin2_cos1
        mov eax,010001h
        _sin3_cos1=$-4
        sar eax,15
        imul _sin2
        add eax,010001h
        _cos3_sin1=$-4
        sar eax,15
        mov [Matrixcamera+mx32],eax
        ; mx13 - -_sin2
        mov eax,_sin2
        neg eax
        mov [matrixcamera+mx13],eax
        ; mx23 - -_cos2_sin1
        mov eax,_cos2
        imul _sin1
        sar eax,15
        neg eax
        mov [matrixcamera+mx23],eax
        ; mx33 - _cos2_cos1
        mov eax,_cos2
        imul _cos1
        sar eax,15
        mov [matrixcamera+mx33],eax
        ret
        _sin1  dd 0
        _cos1  dd 0
        _sin2  dd 0
        _cos2  dd 0
        _sin3  dd 0
        _cos3  dd 0
MakeCameraMatrix ENDP

ZeroMatrix PROC
        xor eax,eax
        mov ecx,16
        rep stosd
        ret
ZeroMatrix ENDP


;camera position
CameraX         dd 0 ;07eh
CameraY         dd 0
CameraZ         dd 0fffff7feh
;eye's anglez
EyeAX           dd 0 ;0f5h
EyeAY           dd 0 ;0feh
EyeAZ           dd 0

MatrixCamera dd 4*4 DUP (0)

;matrix'ez Constants
mx11=0
mx21=16
mx31=32
mx41=48
mx12=4
mx22=20
mx32=36
mx42=52
mx13=8
mx23=24
mx33=40
mx43=56
mx14=12
mx24=28
mx34=44
mx44=60

INCLUDE world.inc

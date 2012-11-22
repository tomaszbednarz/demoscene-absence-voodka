
p_num           =       602
f_num           =       1156
zoom            =       400

                .386

CODE32          SEGMENT PUBLIC PARA 'CODE' USE32
                ASSUME  CS:CODE32,DS:CODE32,ES:CODE32

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; INCLUDES
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

                include eos.inc
                include macro.inc
                include ..\inc\engine.inc
                include ..\inc\txtr.inc
                include ..\inc\our
                include ..\inc\system.pm
                include ..\inc\video.pm
                include ..\inc\pal
                include ..\inc\file
                include ..\inc\vodka
                include ..\inc\scr.inc

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; DATA
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

scr_sel         dw      0
map_sel         dw      0
scr_addr        dd      0
scr2_addr       dd      0

pal             label   byte
                include rm_eye.pal

pal2            label   byte
                include rm_eye.pal

map             dd      0
logo1           dd      0
logo2           dd      0
logo3           dd      0
logo4           dd      0

extrn sinus:word
extrn len:dword

shape           label   word
                include ..\datas\shape3.inc

con             label   word
                include ..\datas\constr3.inc

n_vert          dw      p_num dup (0,0,0)
n_add           dw      p_num dup (0)
rcalc           dw      p_num dup (0,0,0)
n_rot           dw      p_num dup (0,0)
plane           dw      p_num dup (0,0)
zet_tab         dd      f_num dup (0)

p_tab           dd      5-1
                dw      160-68,0
                dw      142-68,60
                dw      168-68,82
                dw      153-68,142
                dw      167-68,200

p_tab2          dd      6-1
                dw      160+68,0
                dw      142+68,60
                dw      168+68,82
                dw      153+68,122
                dw      167+68,169
                dw      142+68,200

cut_tab1        dw      200*2 dup (0)

tab2len         dd      0

logo_addr       dd      logo_tab

logo_tab        label   dword
                rept    30
                dd      o logo1,166+(152*320),140,42
                endm
                dd      o logo2,6+(12*320),231,42
                dd      o logo1,166+(152*320),140,42
                dd      o logo2,6+(12*320),231,42
                rept    31
                dd      o logo2,6+(12*320),231,42
                endm

                rept    30
                dd      o logo3,158+(152*320),150,42
                endm
                dd      o logo4,6+(12*320),162,42
                dd      o logo3,158+(152*320),150,42
                dd      o logo4,6+(12*320),162,42
                rept    31
                dd      o logo4,6+(12*320),162,42
                endm
                rept    32
                dd      o logo4,6+(12*320),162,42
                endm

l_addr          dd      o logo1
l_add           dd      2
l_x             dd      2
l_y             dd      2
l_sub           dd      2

ramki           dd      0

_Znik1          dd      ?
_Znik2          dd      ?
_Znik3          dd      ?
ZnikL           db      0
ZnikL2          db      0
ZnikL3          db      0

tablica         label   word
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100

                dw      200,140 ;c
                dw      200,140
                dw      140,60
                dw      168,170
                dw      160,100

                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100
                dw      160,100


;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; CODE
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

public part1

PART1:
                vodka 9,_znik1
                vodka 10,_znik2
                vodka 11,_znik3

                vodka 4,map
                vodka 5,logo1
                vodka 6,logo2
                vodka 7,logo3
                vodka 8,logo4

                mov     ax,_scrSel
                mov     scr_sel,ax
                mov     eax,_scr_addr
                mov     scr_addr,eax

                mov     ah,Allocate_Selector
                mov     esi,map
                add     esi,Code32_Addr
                mov     edi,256*200
                Int_EOS
                mov     map_sel,bx

                mov     len,81

                mov     shape_addr,o shape
                mov     srot_addr,o rcalc
                mov     n_addr,o n_vert
                mov     nrot_addr,o n_rot
                mov     inc_addr,o n_add
                mov     con_addr,o con
                mov     sort_addr,o zet_tab
                mov     points,p_num
                mov     faces,f_num

                call    prepare
                call    n_calc
                call    calc_cut
                call    clear

;                v_mode  13h
                set_pal pal,0,256

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

                mov     znikL,0
                mov     znikL2,0
                mov     znikL3,0

main_loop:      call    copy

                call    GetModPos
                cmp     ModPos,400h
                jg      virtual
                cmp     ModPos,0100h
                jge     i_nie_znika
                cmp     ModPos,0010h
                jle     nie_drawujemy
                cmp     ModPos,0030h
                jg      Znika3
                cmp     ModPos,0020h
                jg      Znika2
                cmp     ModPos,0010h
                jg      Znika1
I_nie_znika:
                mov     esi,scr_addr
                mov     edi,_0a0000h
                mov     ecx,16000*2
                rep     movsw       ;bo jest szybsze

                cmp     ModPos,0300h
                jl      yogi
                mov     ax,ModPos
                and     ax,63
                mov     bl,al
                mov     edi,o white
                call    pal_fadein10
                lea     esi,pal
                call    pal_set
yogi:

nie_drawujemy:  call    clear

                call    rotate_shape
                neg     r_x
                neg     r_y
                neg     r_z
                call    rotate_normals
                neg     r_x
                neg     r_y
                neg     r_z
                call    bit_sort

                cmp     ModPos,0200h
                jl      akio

                movzx   ebx,ModPos
                and     bx,031
                mov     ax,tablica[ebx*4]
                mov     sh_x,ax
                mov     ax,tablica[ebx*4+2]
                mov     sh_y,ax

akio:           call    p_calc

                mov     ah,wait_vbl
                Int_EOS
                mov     ramki,eax

                mov     eax,ramki
                shl     ax,1
                add     r_z,ax
                add     r_y,ax
                shl     ax,1
                add     r_x,ax

                call    GetModPos
                call    show

                cmp     ModPos,0200h
                jl      zenek
                movzx   eax,ModPos
                and     ax,0ffh
                shl     ax,4
                lea     esi,logo_tab[eax]

                movzx   ebx,ModPos
                and     bx,0ff00h
                sub     bh,2
                shl     bx,2
                add     esi,ebx

                mov     eax,[esi]
                mov     l_addr,eax
                mov     eax,[esi+4]
                mov     l_add,eax
                mov     eax,[esi+8]
                mov     l_x,eax
                mov     ebx,320
                sub     ebx,eax
                mov     l_sub,ebx
                mov     eax,[esi+12]
                mov     l_y,eax
zenek:
                jmp     Main_Loop

ilefadow db 0

virtual:
                lea     esi,white
                call    pal_set

                mov     ah,DeAllocate_Selector
                mov     bx,map_sel
                Int_EOS
                ret

;---------------------------------------------------------------------------
znika1:
                mov     ebp,[scr_addr]
                mov     esi,[_znik1]
                mov     ecx,64000
znika:          mov     al,[ebp]
                cmp     al,80
                jb      zero
                cmp     al,80+80-1
                ja      zero
                mov     al,[esi]
                cmp     al,znikL
                ja      zero
                jmp     _ous
zero:           mov     b [ebp],0
_ous:           inc     ebp
                inc     esi
                dec     ecx
                jnz     znika

                mov     eax,ramki
                cmp     eax,4
                jge     q1q1
                mov     eax,1
                jmp     qqq1
q1q1:           shr     eax,2
qqq1:
                cmp     znikL,63
                jbe     EndFck
                mov     znikL,63
                jmp     Fuc1
EndFck:         add     znikL,al
Fuc1:           jmp     i_nie_znika
;---------------------------------------------------------------------------
znika2:
                mov     ebp,[scr_addr]
                mov     esi,[_znik2]
                mov     ecx,64000
znikaa:         mov     al,[ebp]
                cmp     al,80+80-1
                ja      zeroa
                cmp     al,80
                jae      _ousa
                mov     al,[esi]
                cmp     al,znikL2
                jb      _ousa
zeroa:          mov     b [ebp],0
_ousa:          inc     ebp
                inc     esi
                dec     ecx
                jnz     znikaa

                mov     eax,ramki
                cmp     eax,4
                jge     q1q2
                mov     eax,1
                jmp     qqq2
q1q2:           shr     eax,2
qqq2:
                cmp     znikL2,63
                jb      EndFcka
                mov     znikL2,63
                jmp     Fuc1a
EndFcka:        add     znikL2,al
Fuc1a:          jmp     i_nie_znika
;---------------------------------------------------------------------------
znika3:
                mov     ebp,[scr_addr]
                mov     esi,[_znik3]
                mov     ecx,64000
znikaq:         mov     al,[ebp]
                cmp     al,80+80
                jb      _ous3
                mov     al,[esi]
                cmp     al,znikL3
                jb      _ous3
zero3:          mov     b [ebp],0
_ous3:          inc     ebp
                inc     esi
                dec     ecx
                jnz     znikaq

                mov     eax,ramki
                cmp     eax,4
                jge     q1q3
                mov     eax,1
                jmp     qqq3
q1q3:           shr     eax,2
qqq3:
                cmp     znikL3,63
                jb      EndFck3
                mov     znikL3,63
                jmp     Fuc13
EndFck3:        add     znikL3,al
Fuc13:          jmp     i_nie_znika
;---------------------------------------------------------------------------

prepare:        lea     esi,con
                mov     edi,esi
                mov     ecx,f_num*3
pr_lo:          lodsw
                add     ax,ax
                stosw
                loop    pr_lo
                ret

;---------------------------------------------------------------------------
sx              dd      256
sy              dd      260

ampx            dw      16
ampy            dw      16

move:           mov     ebx,sx
                and     ebx,3ffh
                mov     ax,ampx
                imul    sinus[ebx*2]
                add     dx,160
                mov     sh_x,dx

                mov     ebx,sy
                and     ebx,3ffh
                mov     ax,ampy
                imul    sinus[ebx*2+512]
                add     dx,100
                mov     sh_y,dx

                mov     eax,ramki
                add     sx,eax
                add     eax,2
                add     sy,eax

                mov     eax,ramki
                cmp     ampx,0
                jle     al1
                sub     ampx,ax
al1:            cmp     ampy,0
                jle     al2
                sub     ampy,ax
al2:            ret

;---------------------------------------------------------------------------

copy:           lea     esi,cut_tab1
                mov     edi,scr_addr
                xor     ebx,ebx
                mov     ecx,200

lo1:            mov     bx,[esi]
                push    ebx
                mov     bp,bx
                inc     bp
lo2:            add     b [edi+ebx],80
                dec     bx
                dec     bp
                jnz     lo2
                pop     ebx
                mov     b [edi+ebx],80+52
                mov     b [edi+ebx+1],80+52

                mov     bx,[esi+2]
                push    ebx
                mov     bp,320
                sub     bp,bx
lo3:            add     b [edi+ebx],160
                inc     bx
                dec     bp
                jnz     lo3
                pop     ebx
                mov     b [edi+ebx],160+52
                mov     b [edi+ebx+1],160+52

                add     esi,4
                add     edi,320
                loop    lo1

                mov     esi,l_addr
                mov     esi,[esi]
                mov     edi,scr_addr
                add     edi,l_add
                mov     ecx,l_y
co1:            mov     ebp,l_x
co2:            lodsb
                or      al,al
                jz      empty
                add     al,240
                mov     b [edi],al
empty:          inc     edi
                dec     bp
                jnz     co2
                add     edi,l_sub
                loop    co1

om:             ret

;---------------------------------------------------------------------------

clear:          mov     edi,scr_addr
                mov     eax,01010101h
                mov     ecx,16000
                rep     stosd
                ret

;---------------------------------------------------------------------------

bit_sort:       mov     esi,con_addr
                lea     edi,zet_tab
                xor     eax,eax
                mov     ebp,srot_addr
                mov     ecx,faces

make_tab:       movzx   ebx,w [esi]
                lea     ebx,[ebx*2+ebx+4]
                mov     ax,[ebp+ebx]
                movzx   ebx,w [esi+2]
                lea     ebx,[ebx*2+ebx+4]
                add     ax,[ebp+ebx]
                movzx   ebx,w [esi+4]
                lea     ebx,[ebx*2+ebx+4]
                add     ax,[ebp+ebx]
                add     ax,16000
                stosd
                add     esi,6
                add     eax,60000h
                loop    make_tab

                call    sort
                ret

;---------------------------------------------------------------------------
sh_x            dw      160
sh_y            dw      100
zoomx           dw      zoom+30
zoomy           dw      zoom

p_calc:         mov     esi,srot_addr
                lea     edi,plane
                mov     ecx,points

p_lop:          mov     bx,[esi+4]
                sub     bx,3600

                mov     ax,zoomx
                imul    w [esi]
                idiv    bx
                add     ax,sh_x
                stosw

                mov     ax,zoomy
                imul    w [esi+2]
                idiv    bx
                add     ax,sh_y
                stosw

                add     esi,6
                loop    p_lop
                ret

;---------------------------------------------------------------------------

show:           mov     fs,map_sel
                mov     gs,scr_sel

                lea     esi,zet_tab
                mov     ecx,faces

lop:            push    ecx esi
                movzx   edi,w [esi+2]

                movzx   ebx,w con[edi]
                movsx   eax,w plane[ebx*2]
                mov     x_1,eax
                movsx   eax,w plane[ebx*2+2]
                mov     y_1,eax
                mov     ax,n_rot[ebx*2]
                add     ax,128
                shl     ax,8
                mov     p_1,ax
                mov     ax,n_rot[ebx*2+2]
                add     ax,108
                shl     ax,8
                mov     p_1+2,ax

                movzx   ebx,w con[edi+2]
                movsx   eax,w plane[ebx*2]
                mov     x_2,eax
                movsx   eax,w plane[ebx*2+2]
                mov     y_2,eax
                mov     ax,n_rot[ebx*2]
                add     ax,128
                shl     ax,8
                mov     p_2,ax
                mov     ax,n_rot[ebx*2+2]
                add     ax,108
                shl     ax,8
                mov     p_2+2,ax

                movzx   ebx,w con[edi+4]
                movsx   eax,w plane[ebx*2]
                mov     x_3,eax
                movsx   eax,w plane[ebx*2+2]
                mov     y_3,eax
                mov     ax,n_rot[ebx*2]
                add     ax,128
                shl     ax,8
                mov     p_3,ax
                mov     ax,n_rot[ebx*2+2]
                add     ax,108
                shl     ax,8
                mov     p_3+2,ax

                mov     ax,w x_1
                sub     ax,w x_2
                mov     bx,w y_3
                sub     bx,w y_2
                imul    bx,ax
                mov     ax,w x_2
                sub     ax,w x_3
                mov     cx,w y_2
                sub     cx,w y_1
                imul    cx,ax
                sub     bx,cx
                jge     hide

                call    tm_face

hide:           pop     esi ecx
                add     esi,4
                loop    lop

                mov     fs,Zero_sel
                mov     gs,Zero_sel
                ret

;---------------------------------------------------------------------------

calc_cut:       lea     esi,p_tab+4
                xor     ebp,ebp
                mov     ecx,[esi-4]
_cut1:          push    cx
                mov     bx,[esi]
                mov     bp,[esi+2]
                mov     ax,[esi+4]
                mov     cx,[esi+6]
                lea     edi,cut_tab1[ebp*4]
                sub     ax,bx
                sub     cx,bp
                shl     ax,6
                shl     bx,6
                cwd
                idiv    cx
make:           mov     dx,bx
                shr     dx,6
                mov     [edi],dx
                add     edi,4
                add     bx,ax
                loop    make
                pop     cx
                add     esi,4
                loop    _cut1

                lea     esi,p_tab2+4
                xor     ebp,ebp
                mov     ecx,[esi-4]
_cut2:          push    cx
                mov     bx,[esi]
                mov     bp,[esi+2]
                mov     ax,[esi+4]
                mov     cx,[esi+6]
                lea     edi,cut_tab1[ebp*4]
                sub     ax,bx
                sub     cx,bp
                shl     ax,6
                shl     bx,6
                cwd
                idiv    cx
make2:          mov     dx,bx
                shr     dx,6
                mov     [edi+2],dx
                add     edi,4
                add     bx,ax
                loop    make2
                pop     cx
                add     esi,4
                loop    _cut2
                ret

;---------------------------------------------------------------------------

line:           cmp     bx,dx
                jle     norm
                xchg    ax,bp
                xchg    bx,dx

norm:           sub     dx,bx
                sub     bp,ax
                js      seco

                imul    bx,320
                add     bx,ax

                cmp     dx,bp
                jle     pro1

                movzx   ecx,dx
                or      cx,1
                mov     ax,dx
line1:          sub     dx,bp
                jg      no1
                add     dx,ax
                inc     bx
no1:            mov     [edi],bx
                add     edi,2
                inc     tab2len
                add     bx,320
                loop    line1
                ret

pro1:           movzx   ecx,bp
                or      cx,1
                mov     ax,bp
line2:          sub     bp,dx
                jg      no2
                add     bp,ax
                add     bx,320
no2:            mov     [edi],bx
                add     edi,2
                inc     tab2len
                inc     bx
                loop    line2
                ret

seco:           neg     bp

                imul    bx,320
                add     bx,ax

                cmp     dx,bp
                jle     pro2

                movzx   ecx,dx
                or      cx,1
                mov     ax,dx
line3:          sub     dx,bp
                jg      no3
                add     dx,ax
                dec     bx
no3:            mov     [edi],bx
                add     edi,2
                inc     tab2len
                add     bx,320
                loop    line3
                ret

pro2:           movzx   ecx,bp
                or      cx,1
                mov     ax,bp
line4:          sub     bp,dx
                jg      no4
                add     bp,ax
                add     bx,320
no4:            mov     [edi],bx
                add     edi,2
                inc     tab2len
                dec     bx
                loop    line4
                ret

white   db 768 dup (63)

CODE32          ENDS
                END

p_len           =       40+33+114+128+128+40
f_len           =       40+48+224+256+256+40

x1_min          =       -3400
x1_max          =       3400
y1_min          =       -3400
y1_max          =       3400
z1_min          =       -4200
z1_max          =       6100

x2_min          =       0
x2_max          =       320
y2_min          =       0
y2_max          =       200

rot_x           =       4
rot_y           =       4
rot_z           =       4
speed           =       42

zoom            =       160

                .386

CODE32          SEGMENT PUBLIC PARA 'CODE' USE32
                ASSUME  CS:CODE32,DS:CODE32,ES:CODE32

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; INCLUDES
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

                include eos.inc
                include macro.inc
                include ..\inc\engine.inc
                include ..\inc\our
                include ..\inc\scr.inc
                include ..\inc\vodka
                include ..\inc\pal

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; DATA
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

nazwa           db      "p8.pal",0

scr_addr        dd      0
scr_sel         dw      0
map1_sel        dw      0
map2_sel        dw      0

pal             label   byte
                include sw.pal

mpal            label   byte
                include metal.pal

map1            dd      0 ;sw.inc
map2            dd      0 ;metal.inc

src3            label   word
                include ..\datas\ob_s_1.inc ;114
src4            label   word
                include ..\datas\ob_s_2.inc ;128
src5            label   word
                include ..\datas\ob_s_3.inc ;128

shape           label   word
                include ..\datas\sw_s_1.inc ;40
s2              label   word
                include ..\datas\sw_s_2.inc ;33
s3              label   word
                include ..\datas\ob_s_1.inc ;114
s4              label   word
                include ..\datas\ob_s_2.inc ;128
s5              label   word
                include ..\datas\ob_s_3.inc ;128
s6              label   word
                include ..\datas\sw_s_1.inc ;40

con1            label   word
                include ..\datas\sw_c_1.inc ;40
c2              label   word
                include ..\datas\sw_c_2.inc ;48
c3              label   word
                include ..\datas\ob_c_1.inc ;224
c4              label   word
                include ..\datas\ob_c_2.inc ;256
c5              label   word
                include ..\datas\ob_c_3.inc ;256
c6              label   word
                include ..\datas\sw_c_1.inc ;40

con2            label   word
                rept    (40+48)/8
                dw      0*2,1*2,2*2
                dw      0*2,2*2,3*2
                dw      4*2,5*2,6*2
                dw      4*2,6*2,7*2
                dw      8*2,9*2,10*2
                dw      8*2,10*2,11*2
                dw      12*2,13*2,14*2
                dw      12*2,14*2,15*2
                endm

                rept    (224+256+256+40)/8
                dw      (0+16)*2,(1+16)*2,(2+16)*2
                dw      (0+16)*2,(2+16)*2,(3+16)*2
                dw      (4+16)*2,(5+16)*2,(6+16)*2
                dw      (4+16)*2,(6+16)*2,(7+16)*2
                dw      (8+16)*2,(9+16)*2,(10+16)*2
                dw      (8+16)*2,(10+16)*2,(11+16)*2
                dw      (12+16)*2,(13+16)*2,(14+16)*2
                dw      (12+16)*2,(14+16)*2,(15+16)*2
                endm

con3            label   dword
                rept    40/2
                dd      map1_sel
                db      0,0
                db      0,0
                dd      map1_sel
                dw      0
                db      0,0
                endm

                rept    16/2
                dd      map1_sel
                db      128,1
                db      1,0
                dd      map1_sel
                db      128,1
                db      1,0
                endm

                rept    32/2
                dd      map1_sel
                db      64,0
                db      1,0
                dd      map1_sel
                db      64,0
                db      1,0
                endm

                rept    224/2
                dd      map2_sel
                db      192,0
                db      1,1
                dd      map2_sel
                db      192,0
                db      1,1
                endm

                rept    256/2
                dd      map2_sel
                db      192,0
                db      1,1
                dd      map2_sel
                db      192,0
                db      1,1
                endm

                rept    256/2
                dd      map2_sel
                db      192,0
                db      1,1
                dd      map2_sel
                db      192,0
                db      1,1
                endm

                rept    40/2
                dd      map1_sel
                db      0,0
                db      0,0
                dd      map1_sel
                db      0,0
                db      0,0
                endm

pos             dw      10*256,8*256, 10*256,112*256, 63*256,112*256, 63*256,8*256
                dw      63*256,8*256, 63*256,112*256, 126*256,112*256, 126*256,8*256
                dw      126*256,8*256, 126*256,112*256, 189*256,112*256, 189*256,8*256
                dw      189*256,8*256, 189*256,112*256, 248*256,112*256, 248*256,8*256

                dw      10*256,112*256, 10*256,8*256, 63*256,8*256, 63*256,112*256
                dw      63*256,112*256, 63*256,8*256, 126*256,8*256, 126*256,112*256
                dw      126*256,112*256, 126*256,8*256, 189*256,8*256, 189*256,112*256
                dw      189*256,112*256, 189*256,8*256, 248*256,8*256, 248*256,112*256

extrn sinus:word
extrn len:dword

ro_1            dd      0
ro_2            dd      160
ro_3            dd      -70

cm_x            dw      0
cm_y            dw      0
cm_z            dw      0

s_x             dd      0
c_x             dd      0
s_y             dd      0
c_y             dd      0
s_z             dd      0
c_z             dd      0

ob1             dd      0
ob2             dd      0
ob3             dd      0
ob4             dd      0
ob5             dd      0
ob6             dd      0
ob7             dd      0
ob8             dd      0
ob9             dd      0

ca1             dd      0
ca2             dd      0
ca3             dd      0
ca4             dd      0
ca5             dd      0
ca6             dd      0
ca7             dd      0
ca8             dd      0
ca9             dd      0

t_x             dd      0
t_y             dd      0
t_z             dd      0

p_x             dd      0
p_y             dd      0
p_z             dd      0

o_x             dd      0
o_y             dd      0
o_z             dd      4400

pkt             dw      33*2 dup (0)

pts_src         dw      (224+256+256)*3 dup (0)
pts_tab         dw      f_len*3 dup (0)
rcalc           dw      p_len*2 dup (0)

ile             dd      0
draw_tab        dw      f_len*2 dup (0)
check           dw      p_len dup (0)

n_add           dw      128 dup (0)
n_src           dw      (114+128+128)*3 dup (0)
n_vert          dw      (114+128+128)*3 dup (0)
n_rot           dw      (114+128+128)*2 dup (0)

frames          dd      0

ruchy           dd      0
                ;label   dword
                ;include trasa.dat

ruchy_ptr       dd      0

white db 768 dup (3fh)

tablica         dw      64-15 dup (0,0)
                dw      1,0
                dw      0,0
                dw      1,0
                dw      1,0
                dw      1,0
                dw      0,0
                dw      1,0
                dw      1,0
                dw      1,0
                dw      0,0
                dw      1,0
                dw      1,0
                dw      1,0
                dw      0,0
                dw      1,0
                dw      0,0

last_pal        dd      0
last_pic        dd      0

sun dd 0
sun_step dd 0

ruchow equ 2497

mnoznik dd 1

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; CODE
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

PUBLIC PART8

PART8:          cld

                lea esi,bialy
                call pal_Set

                mov     eax,_scr_addr
                mov     scr_addr,eax
                mov     ax,_scrSel
                mov     scr_sel,ax

                mov     edi,scr_addr
                xor     eax,eax
                mov     ecx,16000
                rep     stosd

                vodka   24,map1
                vodka   27,map2

                vodka   70,last_pal
                vodka   71,last_pic

                vodka 73,sun

                vodka   75,ruchy

                mov     len,80

                mov     ah,Allocate_Selector
                mov     esi,map1
                add     esi,Code32_Addr
                mov     edi,0ffffh
                Int_EOS
                mov     map1_sel,bx

                mov     ah,Allocate_Selector
                mov     esi,map2
                add     esi,Code32_Addr
                mov     edi,0ffffh
                Int_EOS
                mov     map2_sel,bx

                mov     sort_addr,o draw_tab

                call    make_pos
                call    prepare

                mov     shape_addr,o src3
                mov     n_addr,o n_src
                mov     inc_addr,o n_add
                mov     con_addr,o c3
                mov     points,114
                mov     faces,224
                call    n_calc

                mov     shape_addr,o src4
                add     n_addr,114*6
                mov     con_addr,o c4
                mov     points,128
                mov     faces,256
                call    n_calc

                mov     shape_addr,o src5
                add     n_addr,128*6
                mov     con_addr,o c5
                call    n_calc

                mov     points,114+128+128
                mov     n_addr,o n_vert
                mov     nrot_addr,o n_rot

                call    co_prepare
                call    make_pts

                lea     esi,pal
                lea     edi,64*3[esi]
                mov     bh,-2
                mov     bl,4
                mov     dl,6
                call    make_pal

                lea     esi,pal
                lea     edi,128*3[esi]
                mov     bh,1
                mov     bl,-1
                mov     dl,3
                call    make_pal

                lea     esi,mpal
                lea     edi,pal+(192*3)
                mov     ecx,64*3
                rep     movsb

                ;lea    esi,pal
                ;mov    ecx,768
                ;lea    edx,nazwa
                ;mov    ah,write_external_file
                ;int_eos

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

m_loop:         mov     ah,wait_vbl
                int_eos
                mov     frames,eax

                call    GetModPos

                cmp     ModPos,2630h
                jl      spad
                call    brum

spad:           cmp     ruchy_ptr,ruchow
                jl      no_out
                mov     ruchy_ptr,ruchow
                neg     mnoznik
                jmp     no_out2

no_out:         cmp     ruchy_ptr,0
                jg      no_out2
                mov     ruchy_ptr,0
                neg     mnoznik

no_out2:        mov     esi,ruchy_ptr
                imul    esi,36
                add     esi,ruchy

                lodsd
                mov     o_x,eax
                lodsd
                mov     o_y,eax
                lodsd
                mov     o_z,eax

                lodsd
                mov     r_x,ax
                lodsd
                mov     r_y,ax
                lodsd
                mov     r_z,ax

                lodsd
                mov     cm_x,ax
                lodsd
                mov     cm_y,ax
                lodsd
                mov     cm_z,ax

                mov     eax,frames
                shl     eax,1
                mov     ebx,mnoznik
                imul    ebx
                add     ruchy_ptr,eax

                call    swap
                call    make_phong
                call    prep_rot1
                call    prep_rot2
                call    rotate
                neg     r_x
                neg     r_y
                neg     r_z
                call    rotate_normals
                neg     r_x
                neg     r_y
                neg     r_z
                call    bit_sort
                call    show
                call    sloneczko
                call    control

                mov     eax,frames
                shl     eax,2
                add     ro_1,eax

                add     eax,frames
                add     eax,frames
                add     eax,frames
                add     ro_2,eax

                mov     eax,frames
                shl     eax,3
                sub     ro_3,eax

                call    fade

                cmp     ModPos,2700h
                jl      m_loop

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

                lea     esi,bialy
                call    pal_set

                mov     edi,_0a0000h
                xor     eax,eax
                mov     ecx,16000
                rep     stosd

                mov     esi,last_pic
                mov     edi,_0a0000h
                mov     ecx,(320*100)/4
                rep     movsd

                mov     esi,last_pal
                call    pal_set

_wa1:           call    GetModPos
                cmp     ModPos,2705h
                jl      _wa1

                lea     esi,bialy
                call    pal_set

                mov     esi,last_pic
                add     esi,320*100
                mov     edi,_0a0000h
                add     edi,320*100
                mov     ecx,(320*60)/4
                rep     movsd

                v_sync
                v_sync

                mov     esi,last_pal
                call    pal_set

_wa2:           call    GetModPos
                cmp     ModPos,2708h
                jl      _wa2

                lea     esi,bialy
                call    pal_set

                mov     esi,last_pic
                add     esi,320*160
                mov     edi,_0a0000h
                add     edi,320*160
                mov     ecx,(320*39)/4
                rep     movsd

                mov     ile_fade,64

lopa:           mov     esi,last_pal
                lea     edi,white
                mov     ebx,ile_fade
                mov     ecx,768
astroPIC:       lodsb
                add     al,bl
                cmp     al,0
                jge     azxA
                xor     al,al
                jmp     noaX
azxA:           cmp     al,3fh
                jle     noaX
                mov     al,3fh
noaX:           stosb
                loop    astroPIC

                lea     esi,white
                call    pal_set

                dec     ile_fade
                cmp     ile_fade,-4
                jge     lopa

                mov     ah,Stop_module
                int_eos

                mov     ile_fade,0
_wait:
                mov     dx,3dah
sa1:            in      al,dx
                and     al,8
                jz      sa1
sa2:            in      al,dx
                and     al,8
                jnz     sa2

                inc     ile_fade
                cmp     ile_fade,274
                jl      _wait
;***
                mov     ile_fade,0

hopla:          mov     esi,last_pal
                lea     edi,white
                mov     ebx,ile_fade
                mov     ecx,768
astroPIC2:      lodsb
                sub     al,bl
                or      al,al
                jns     bres
                xor     al,al
bres:           stosb
                loop    astroPIC2

                lea     esi,white
                call    pal_set

                inc     ile_fade
                cmp     ile_fade,64
                jle     hopla

                mov     ah,DeAllocate_Selector
                mov     bx,map1_sel
                Int_EOS

                mov     ah,DeAllocate_Selector
                mov     bx,map2_sel
                Int_EOS
                ret

;---------------------------------------------------------------------------

prepare:        lea     esi,con1
                mov     edi,esi
                mov     ecx,40*3
pr_lo1:         lodsw
                add     ax,ax
                stosw
                loop    pr_lo1

                lea     esi,c2
                mov     edi,esi
                mov     ecx,48*3
pr_lo2:         lodsw
                add     ax,40
                add     ax,ax
                stosw
                loop    pr_lo2

                lea     esi,c3
                mov     edi,esi
                mov     ecx,(224+256+256)*3
pr_lo3:         lodsw
                add     ax,ax
                stosw
                loop    pr_lo3

                lea     esi,c6
                mov     edi,esi
                mov     ecx,40*3
pr_lo4:         lodsw
                add     ax,40+33+114+128+128
                add     ax,ax
                stosw
                loop    pr_lo4

                lea     esi,s6
                mov     edi,esi
                mov     ecx,40
as:             movsw
                lodsw
                sub     ax,1620
                stosw
                movsw
                loop    as
                ret

;---------------------------------------------------------------------------

co_prepare:     lea     esi,c3
                mov     edi,esi
                mov     ecx,224*3
copr_lo1:       lodsw
                add     ax,(40+33)*2
                stosw
                loop    copr_lo1

                lea     esi,c4
                mov     edi,esi
                mov     ecx,256*3
copr_lo2:       lodsw
                add     ax,(40+33+114)*2
                stosw
                loop    copr_lo2

                lea     esi,c5
                mov     edi,esi
                mov     ecx,256*3
copr_lo3:       lodsw
                add     ax,(40+33+114+128)*2
                stosw
                loop    copr_lo3

                lea     esi,s3
                mov     edi,esi
                mov     ecx,114
copr_lo4:       movsw
                lodsw
                add     ax,-640
                stosw
                movsw
                loop    copr_lo4
                ret

;---------------------------------------------------------------------------

make_pts:       lea     esi,con1
                lea     edi,pts_tab
                mov     bx,3
                mov     ecx,f_len

calc_pts:       movzx   ebp,w [esi]
                mov     ax,shape[ebp*2+ebp]
                movzx   ebp,w [esi+2]
                add     ax,shape[ebp*2+ebp]
                movzx   ebp,w [esi+4]
                add     ax,shape[ebp*2+ebp]
                cwd
                idiv    bx
                stosw                           ;x

                movzx   ebp,w [esi]
                mov     ax,shape[ebp*2+ebp+2]
                movzx   ebp,w [esi+2]
                add     ax,shape[ebp*2+ebp+2]
                movzx   ebp,w [esi+4]
                add     ax,shape[ebp*2+ebp+2]
                cwd
                idiv    bx
                stosw                           ;y

                movzx   ebp,w [esi]
                mov     ax,shape[ebp*2+ebp+4]
                movzx   ebp,w [esi+2]
                add     ax,shape[ebp*2+ebp+4]
                movzx   ebp,w [esi+4]
                add     ax,shape[ebp*2+ebp+4]
                cwd
                idiv    bx
                stosw                           ;z

                add     esi,6
                loop    calc_pts

                lea     esi,pts_tab+((40+48)*6)
                lea     edi,pts_src
                mov     ecx,(224+256+256)*3
                rep     movsw
                ret

;---------------------------------------------------------------------------

make_pos:       mov     r_x,256
                call    prep_rot1
                mov     r_x,0

                lea     esi,s2
                lea     edi,pkt
                mov     ecx,33

pp_ro:          movsx   eax,w [esi]
                imul    ob1
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob2
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob3
                sar     eax,15
                add     ebp,eax
                mov     p_x,ebp

                movsx   eax,w [esi]
                imul    ob4
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob5
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob6
                sar     eax,15
                add     ebp,eax
                mov     p_y,ebp

                movsx   eax,w [esi]
                imul    ob7
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob8
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob9
                sar     eax,15
                add     ebp,eax

                sub     ebp,8000

                mov     eax,226+16
                imul    p_x
                idiv    ebp
                add     ax,96
                shl     ax,8
                mov     [edi],ax

                mov     eax,226
                imul    p_y
                idiv    ebp
                add     ax,60
                shl     ax,8
                mov     [edi+2],ax

                add     esi,6
                add     edi,4
                loop    pp_ro
                ret

;---------------------------------------------------------------------------

make_pal:       mov     ecx,64
f_lo:           lodsb
                add     al,bh
                jns     pa_1
                xor     al,al
pa_1:           cmp     al,63
                jle     pa_2
                mov     al,63
pa_2:           stosb
                lodsb
                add     al,bl
                jns     pa_3
                xor     al,al
pa_3:           cmp     al,63
                jle     pa_4
                mov     al,63
pa_4:           stosb
                lodsb
                add     al,dl
                jns     pa_5
                xor     al,al
pa_5:           cmp     al,63
                jle     pa_6
                mov     al,63
pa_6:           stosb
                loop    f_lo
                ret

;---------------------------------------------------------------------------

swap:           mov     esi,scr_addr
                mov     edi,_0a0000h
                mov     ecx,16000
                rep     movsd
                mov     edi,scr_addr
                xor     eax,eax
                mov     ecx,16000
                rep     stosd
                ret

;---------------------------------------------------------------------------
shf             dd      0

sin             dd      0
cos             dd      0

make_phong:     mov     ebx,ro_1
                and     ebx,3ffh
                movsx   eax,sinus[ebx*2]
                mov     sin,eax
                movsx   eax,sinus[ebx*2+512]
                mov     cos,eax

                lea     esi,src3
                lea     edi,s3
                mov     shf,-640
                mov     ecx,114
                call    sub_rot

                lea     esi,pts_src
                lea     edi,pts_tab+((40+48)*6)
                mov     ecx,224
                call    sub_rot

                lea     esi,n_src
                lea     edi,n_vert
                mov     shf,0
                mov     ecx,114
                call    sub_rot

                mov     ebx,ro_2
                and     ebx,3ffh
                movsx   eax,sinus[ebx*2]
                mov     sin,eax
                movsx   eax,sinus[ebx*2+512]
                mov     cos,eax

                lea     esi,src4
                lea     edi,s4
                mov     shf,-640
                mov     ecx,128
                call    sub_rot

                lea     esi,pts_src+(224*6)
                lea     edi,pts_tab+((40+48+224)*6)
                mov     ecx,256
                call    sub_rot

                lea     esi,n_src+(114*6)
                lea     edi,n_vert+(114*6)
                mov     shf,0
                mov     ecx,128
                call    sub_rot

                mov     ebx,ro_3
                and     ebx,3ffh
                movsx   eax,sinus[ebx*2]
                mov     sin,eax
                movsx   eax,sinus[ebx*2+512]
                mov     cos,eax

                lea     esi,src5
                lea     edi,s5
                mov     shf,-640
                mov     ecx,128
                call    sub_rot

                lea     esi,pts_src+((224+256)*6)
                lea     edi,pts_tab+((40+48+224+256)*6)
                mov     ecx,256
                call    sub_rot

                lea     esi,n_src+((114+128)*6)
                lea     edi,n_vert+((114+128)*6)
                mov     shf,0
                mov     ecx,128
                call    sub_rot
                ret

; rotate routine -----------------------------------------------------------

sub_rot:        movsx   eax,w [esi]
                imul    cos
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    sin
                sar     eax,15
                sub     ebp,eax
                mov     [edi],bp

                movsx   eax,w [esi]
                imul    sin
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    cos
                sar     eax,15
                add     ebp,eax
                add     ebp,shf
                mov     [edi+2],bp

                mov     ax,[esi+4]
                mov     [edi+4],ax

                add     esi,6
                add     edi,6
                loop    sub_rot
                ret

;---------------------------------------------------------------------------

prep_rot1:      lea     esi,sinus
                lea     edi,[esi+512]

                movsx   ebx,w r_x
                and     ebx,3ffh
                movsx   eax,w [esi+ebx*2]
                mov     s_x,eax
                movsx   eax,w [edi+ebx*2]
                mov     c_x,eax

                movsx   ebx,w r_y
                and     ebx,3ffh
                movsx   eax,w [esi+ebx*2]
                mov     s_y,eax
                movsx   eax,w [edi+ebx*2]
                mov     c_y,eax

                movsx   ebx,w r_z
                and     ebx,3ffh
                movsx   eax,w [esi+ebx*2]
                mov     s_z,eax
                movsx   eax,w [edi+ebx*2]
                mov     c_z,eax

                mov     eax,c_y
                imul    c_z
                sar     eax,15
                mov     ob1,eax
                mov     eax,c_x
                imul    s_z
                mov     ebx,s_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,c_z
                sub     ebx,eax
                sar     ebx,15
                mov     ob2,ebx
                mov     eax,s_x
                imul    s_z
                mov     ebx,c_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,c_z
                add     ebx,eax
                sar     ebx,15
                mov     ob3,ebx
                mov     eax,c_y
                imul    s_z
                sar     eax,15
                mov     ob4,eax
                mov     eax,c_x
                imul    c_z
                mov     ebx,s_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,s_z
                add     ebx,eax
                sar     ebx,15
                mov     ob5,ebx
                mov     eax,s_x
                imul    c_z
                mov     ebx,c_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,s_z
                sub     ebx,eax
                sar     ebx,15
                mov     ob6,ebx
                mov     eax,s_y
                neg     eax
                mov     ob7,eax
                mov     eax,s_x
                imul    c_y
                sar     eax,15
                mov     ob8,eax
                mov     eax,c_x
                imul    c_y
                sar     eax,15
                mov     ob9,eax
                ret

;---------------------------------------------------------------------------

prep_rot2:      lea     esi,sinus
                lea     edi,[esi+512]

                movsx   ebx,w cm_x
                and     ebx,3ffh
                movsx   eax,w [esi+ebx*2]
                mov     s_x,eax
                movsx   eax,w [edi+ebx*2]
                mov     c_x,eax

                movsx   ebx,w cm_y
                and     ebx,3ffh
                movsx   eax,w [esi+ebx*2]
                mov     s_y,eax
                movsx   eax,w [edi+ebx*2]
                mov     c_y,eax

                movsx   ebx,w cm_z
                and     ebx,3ffh
                movsx   eax,w [esi+ebx*2]
                mov     s_z,eax
                movsx   eax,w [edi+ebx*2]
                mov     c_z,eax

                mov     eax,c_y
                imul    c_z
                sar     eax,15
                mov     ca1,eax
                mov     eax,c_x
                imul    s_z
                mov     ebx,s_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,c_z
                sub     ebx,eax
                sar     ebx,15
                mov     ca2,ebx
                mov     eax,s_x
                imul    s_z
                mov     ebx,c_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,c_z
                add     ebx,eax
                sar     ebx,15
                mov     ca3,ebx
                mov     eax,c_y
                imul    s_z
                sar     eax,15
                mov     ca4,eax
                mov     eax,c_x
                imul    c_z
                mov     ebx,s_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,s_z
                add     ebx,eax
                sar     ebx,15
                mov     ca5,ebx
                mov     eax,s_x
                imul    c_z
                mov     ebx,c_x
                imul    ebx,s_y
                sar     ebx,15
                imul    ebx,s_z
                sub     ebx,eax
                sar     ebx,15
                mov     ca6,ebx
                mov     eax,s_y
                neg     eax
                mov     ca7,eax
                mov     eax,s_x
                imul    c_y
                sar     eax,15
                mov     ca8,eax
                mov     eax,c_x
                imul    c_y
                sar     eax,15
                mov     ca9,eax
                ret

;---------------------------------------------------------------------------

rotate:         lea     edi,check
                xor     ax,ax
                mov     ecx,p_len
                rep     stosw

                mov     ile,0

                lea     esi,pts_tab
                lea     edi,draw_tab
                xor     ebx,ebx
                mov     ecx,f_len

ro:             movsx   eax,w [esi]
                imul    ob1
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob2
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob3
                sar     eax,15
                add     ebp,eax
                mov     t_x,ebp

                movsx   eax,w [esi]
                imul    ob4
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob5
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob6
                sar     eax,15
                add     ebp,eax
                mov     t_y,ebp

                movsx   eax,w [esi]
                imul    ob7
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob8
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob9
                sar     eax,15
                add     ebp,eax
                mov     t_z,ebp

                mov     eax,t_x
                imul    ca1
                sar     eax,15
                mov     ebp,eax
                mov     eax,t_y
                imul    ca2
                sar     eax,15
                add     ebp,eax
                mov     eax,t_z
                imul    ca3
                sar     eax,15
                add     ebp,eax
                add     ebp,o_x
                mov     p_x,ebp

                mov     eax,t_x
                imul    ca4
                sar     eax,15
                mov     ebp,eax
                mov     eax,t_y
                imul    ca5
                sar     eax,15
                add     ebp,eax
                mov     eax,t_z
                imul    ca6
                sar     eax,15
                add     ebp,eax
                add     ebp,o_y
                mov     p_y,ebp

                mov     eax,t_x
                imul    ca7
                sar     eax,15
                mov     ebp,eax
                mov     eax,t_y
                imul    ca8
                sar     eax,15
                add     ebp,eax
                mov     eax,t_z
                imul    ca9
                sar     eax,15
                add     ebp,eax
                add     ebp,o_z
                mov     p_z,ebp

                cmp     p_x,x1_min
                jl      no_face
                cmp     p_x,x1_max
                jg      no_face
                cmp     p_y,y1_min
                jl      no_face
                cmp     p_y,y1_max
                jg      no_face
                cmp     p_z,z1_min
                jl      no_face
                cmp     p_z,z1_max
                jg      no_face

                add     bp,8000
                mov     [edi],bp                ;zet
                mov     [edi+2],bx              ;index
                add     edi,4
                inc     ile

                push    esi edi ebx ecx

                mov     ecx,3
lo:             movzx   esi,w con1[ebx]

                cmp     check[esi],0
                jne     skip
                inc     check[esi]

                lea     edi,rcalc[esi*2]
                lea     esi,shape[esi*2+esi]

                movsx   eax,w [esi]
                imul    ob1
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob2
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob3
                sar     eax,15
                add     ebp,eax
                mov     t_x,ebp

                movsx   eax,w [esi]
                imul    ob4
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob5
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob6
                sar     eax,15
                add     ebp,eax
                mov     t_y,ebp

                movsx   eax,w [esi]
                imul    ob7
                sar     eax,15
                mov     ebp,eax
                movsx   eax,w [esi+2]
                imul    ob8
                sar     eax,15
                add     ebp,eax
                movsx   eax,w [esi+4]
                imul    ob9
                sar     eax,15
                add     ebp,eax
                mov     t_z,ebp

                mov     eax,t_x
                imul    ca1
                sar     eax,15
                mov     ebp,eax
                mov     eax,t_y
                imul    ca2
                sar     eax,15
                add     ebp,eax
                mov     eax,t_z
                imul    ca3
                sar     eax,15
                add     ebp,eax
                add     ebp,o_x
                mov     p_x,ebp

                mov     eax,t_x
                imul    ca4
                sar     eax,15
                mov     ebp,eax
                mov     eax,t_y
                imul    ca5
                sar     eax,15
                add     ebp,eax
                mov     eax,t_z
                imul    ca6
                sar     eax,15
                add     ebp,eax
                add     ebp,o_y
                mov     p_y,ebp

                mov     eax,t_x
                imul    ca7
                sar     eax,15
                mov     ebp,eax
                mov     eax,t_y
                imul    ca8
                sar     eax,15
                add     ebp,eax
                mov     eax,t_z
                imul    ca9
                sar     eax,15
                add     ebp,eax
                add     ebp,o_z
                mov     p_z,ebp

                sub     ebp,7600

                mov     eax,zoom+32
                imul    p_x
                idiv    ebp
                add     ax,160
                mov     [edi],ax

                mov     eax,-zoom
                imul    p_y
                idiv    ebp
                add     ax,100
                mov     [edi+2],ax

skip:           add     ebx,2
                loop    lo

                pop     ecx ebx edi esi

no_face:        add     esi,6
                add     ebx,6
                loop    ro
                ret

;---------------------------------------------------------------------------

bit_sort:       cmp     ile,0
                je      exit
                push    faces
                mov     eax,ile
                mov     faces,eax
                call    sort
                pop     faces
                ret

;---------------------------------------------------------------------------

show:           cmp     ile,0
                je      exit

                mov     es,scr_sel

                mov     eax,ile
                lea     esi,draw_tab ;[eax*4-4]
lop:            push    esi

                movzx   eax,w [esi+2]
                mov     ebx,6
                xor     edx,edx
                div     ebx
                shl     eax,3

                mov     ebx,con3[eax]
                mov     fs,[ebx]                ;map
                mov     bx,w con3[eax+4]
                mov     col,bx                  ;color
                mov     cl,b con3[eax+6]        ;visibility
                mov     dl,b con3[eax+7]        ;phong shading

                movzx   edi,w [esi+2]

als:            or      bh,bh
                jz      no_plane

                movzx   ebx,w con1[edi]
                movsx   eax,w rcalc[ebx*2]
                mov     x_1,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_1,eax
                sub     ebx,40*2
                mov     eax,d pkt[ebx*2]
                mov     d p_1,eax

                movzx   ebx,w con1[edi+2]
                movsx   eax,w rcalc[ebx*2]
                mov     x_2,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_2,eax
                sub     ebx,40*2
                mov     eax,d pkt[ebx*2]
                mov     d p_2,eax

                movzx   ebx,w con1[edi+4]
                movsx   eax,w rcalc[ebx*2]
                mov     x_3,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_3,eax
                sub     ebx,40*2
                mov     eax,d pkt[ebx*2]
                mov     d p_3,eax

                jmp     drawing

no_plane:       or      dl,dl
                jz      nshading

                movzx   ebx,w con1[edi]
                movsx   eax,w rcalc[ebx*2]
                mov     x_1,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_1,eax
                sub     ebx,(40+33)*2
                mov     ax,n_rot[ebx*2]
                add     ax,128
                shl     ax,8
                mov     p_1,ax
                mov     ax,n_rot[ebx*2+2]
                add     ax,108
                shl     ax,8
                mov     p_1+2,ax

                movzx   ebx,w con1[edi+2]
                movsx   eax,w rcalc[ebx*2]
                mov     x_2,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_2,eax
                sub     ebx,(40+33)*2
                mov     ax,n_rot[ebx*2]
                add     ax,128
                shl     ax,8
                mov     p_2,ax
                mov     ax,n_rot[ebx*2+2]
                add     ax,108
                shl     ax,8
                mov     p_2+2,ax

                movzx   ebx,w con1[edi+4]
                movsx   eax,w rcalc[ebx*2]
                mov     x_3,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_3,eax
                sub     ebx,(40+33)*2
                mov     ax,n_rot[ebx*2]
                add     ax,128
                shl     ax,8
                mov     p_3,ax
                mov     ax,n_rot[ebx*2+2]
                add     ax,108
                shl     ax,8
                mov     p_3+2,ax

                jmp     drawing

nshading:       movzx   ebx,w con1[edi]
                movsx   eax,w rcalc[ebx*2]
                mov     x_1,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_1,eax
                movzx   ebx,w con2[edi]
                mov     eax,d pos[ebx*2]
                mov     d p_1,eax

                movzx   ebx,w con1[edi+2]
                movsx   eax,w rcalc[ebx*2]
                mov     x_2,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_2,eax
                movzx   ebx,w con2[edi+2]
                mov     eax,d pos[ebx*2]
                mov     d p_2,eax

                movzx   ebx,w con1[edi+4]
                movsx   eax,w rcalc[ebx*2]
                mov     x_3,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_3,eax
                movzx   ebx,w con2[edi+4]
                mov     eax,d pos[ebx*2]
                mov     d p_3,eax

drawing:        or      cl,cl
                jz      draw

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
                jle     hide

draw:           call    face

hide:           pop     esi
                add     esi,4
                dec     ile
                jne     lop

                mov     es,DATA32_sel
                mov     fs,Zero_sel
                ret

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�

x_1             dd      0
x_s             dd      0
y_1             dd      0
p_1             dw      0,0
x_2             dd      0
y_2             dd      0
p_2             dw      0,0
x_3             dd      0
y_3             dd      0
p_3             dw      0,0

dx_1            dd      0
dy_1            dd      0
dx_2            dd      0
dy_2            dd      0
dy_3            dd      0
pd_1            dw      0,0
pd_2            dw      0,0

pom             dw      0
mem             dw      0,0

col             dw      0

face:           mov     pom,0

                mov     eax,y_1
                cmp     eax,y_2
                jle     pr_1

                mov     eax,x_1
                xchg    x_2,eax
                mov     x_1,eax
                mov     eax,y_1
                xchg    y_2,eax
                mov     y_1,eax
                mov     eax,d p_1
                xchg    d p_2,eax
                mov     d p_1,eax

pr_1:           mov     eax,y_1
                cmp     eax,y_3
                jle     pr_2

                mov     eax,x_1
                xchg    x_3,eax
                mov     x_1,eax
                mov     eax,y_1
                xchg    y_3,eax
                mov     y_1,eax
                mov     eax,d p_1
                xchg    d p_3,eax
                mov     d p_1,eax

pr_2:           mov     eax,y_2
                cmp     eax,y_3
                jle     pr_3

                mov     eax,x_2
                xchg    x_3,eax
                mov     x_2,eax
                mov     eax,y_2
                xchg    y_3,eax
                mov     y_2,eax
                mov     eax,d p_2
                xchg    d p_3,eax
                mov     d p_2,eax

pr_3:           cmp     w y_1,y2_max-1
                jge     sk
                cmp     w y_3,y2_min
                jl      sk

                mov     eax,y_2
                sub     eax,y_1
                jne     pr_4
                inc     eax
                mov     pom,1
pr_4:           mov     dy_1,eax

                mov     eax,y_3
                sub     eax,y_2
                jne     pr_5
                inc     eax
pr_5:           mov     dy_2,eax

                mov     eax,y_3
                sub     eax,y_1
                jne     pr_6
                inc     eax
pr_6:           mov     dy_3,eax

                mov     eax,x_3
                sub     eax,x_1
                shl     eax,16
                cdq
                idiv    dy_3
                mov     dx_2,eax

                movzx   ebx,p_1
                movzx   eax,p_3
                sub     eax,ebx
                cdq
                idiv    dy_3
                mov     pd_1,ax

                movzx   ebx,p_1+2
                movzx   eax,p_3+2
                sub     eax,ebx
                cdq
                idiv    dy_3
                mov     pd_2,ax

                cmp     pom,1
                jne     no

                mov     eax,x_1
                mov     pom,ax
                shl     eax,16
                mov     x_s,eax
                mov     eax,x_2
                shl     eax,16
                mov     x_1,eax
                mov     eax,d p_1
                mov     d mem,eax
                jmp     go

no:             mov     eax,x_2
                sub     eax,x_1
                shl     eax,16
                cdq
                idiv    dy_1
                mov     dx_1,eax

                mov     eax,dy_1
                imul    dx_2
                shr     eax,16
                add     eax,x_1
                mov     pom,ax

                mov     eax,dy_1
                imul    d pd_1
                add     ax,p_1
                mov     mem,ax

                mov     eax,dy_1
                imul    d pd_2
                add     ax,p_1+2
                mov     mem+2,ax

                mov     eax,x_1
                shl     eax,16
                mov     x_1,eax
                mov     x_s,eax

go:             mov     eax,y_1
                imul    eax,320
                mov     y_1,eax
                mov     eax,y_2
                imul    eax,320
                mov     y_2,eax

                mov     ax,p_1
                xchg    p_1+2,ax
                mov     p_1,ax

                cmp     y_3,y2_max-1
                jl      no_da
                sub     y_3,y2_max-1
                mov     eax,y_3
                sub     dy_3,eax

no_da:          xor     ebx,ebx

                mov     bx,w x_2
                sub     bx,pom
                jnz     okay
                inc     bx
okay:           jg      norm
                neg     bx

                movzx   ecx,mem
                movzx   eax,p_2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     si,ax

                shl     esi,16

                movzx   ecx,mem+2
                movzx   eax,p_2+2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     si,ax

                mov     cx,col

draw_1:         mov     ebx,y_1
                cmp     y_2,ebx
                jne     no_1

                mov     eax,x_3
                sub     eax,x_2
                shl     eax,16
                cdq
                idiv    dy_2
                mov     dx_1,eax

no_1:           cmp     ebx,y2_min*320
                jl      go_1

                mov     di,w x_1+2
                mov     bp,w x_s+2

                cmp     di,x2_max
                jge     go_1
                cmp     bp,x2_min
                jl      go_1

                mov     edx,d p_1

                cmp     bp,x2_max-1
                jl      no_c3

add_2:          add     edx,esi
                dec     bp
                cmp     bp,x2_max-1
                jg      add_2

no_c3:          cmp     di,x2_min
                jge     no_c4
                mov     di,x2_min

no_c4:          sub     bp,di
                jl      go_1

                add     di,bp
                add     di,w y_1
                inc     bp

fo_1:           mov     bl,dh
                shld    ebx,edx,8
                mov     al,fs:[bx]
                add     al,cl
                mov     es:[di],al
                dec     di
                add     edx,esi
                dec     bp
                jnz     fo_1

go_1:           mov     eax,dx_1
                add     x_1,eax
                mov     eax,dx_2
                add     x_s,eax
                mov     ax,pd_2
                add     p_1,ax
                mov     ax,pd_1
                add     p_1+2,ax
                add     y_1,320

                dec     dy_3
                jne     draw_1
sk:             ret

norm:           movzx   ecx,mem
                movzx   eax,p_2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     si,ax

                shl     esi,16

                movzx   ecx,mem+2
                movzx   eax,p_2+2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     si,ax

                mov     cx,col

draw_2:         mov     ebx,y_1
                cmp     y_2,ebx
                jne     no_2

                mov     eax,x_3
                sub     eax,x_2
                shl     eax,16
                cdq
                idiv    dy_2
                mov     dx_1,eax

no_2:           cmp     ebx,y2_min*320
                jl      go_2

                mov     di,w x_s+2
                mov     bp,w x_1+2

                cmp     di,x2_max
                jge     go_2
                cmp     bp,x2_min
                jl      go_2

                mov     edx,d p_1

                cmp     di,x2_min
                jge     no_c1

add_1:          add     edx,esi
                inc     di
                jl      add_1

no_c1:          cmp     bp,x2_max-1
                jl      no_c2
                mov     bp,x2_max-1

no_c2:          sub     bp,di
                jl      go_2

                add     di,w y_1
                inc     bp

fo_2:           mov     bl,dh
                shld    ebx,edx,8
                mov     al,fs:[bx]
                add     al,cl
                mov     es:[di],al
                inc     di
                add     edx,esi
                dec     bp
                jnz     fo_2

go_2:           mov     eax,dx_1
                add     x_1,eax
                mov     eax,dx_2
                add     x_s,eax
                mov     ax,pd_2
                add     p_1,ax
                mov     ax,pd_1
                add     p_1+2,ax
                add     y_1,320

                dec     dy_3
                jne     draw_2
                ret

;---------------------------------------------------------------------------

speed           =       64
rot             =       8

control:        cmp     Key_Map[Up],On
                jne     co_1
                add     o_y,speed

co_1:           cmp     Key_Map[Down],On
                jne     co_2
                sub     o_y,speed

co_2:           cmp     Key_Map[Left],On
                jne     co_3
                add     o_x,speed

co_3:           cmp     Key_Map[Right],On
                jne     co_4
                sub     o_x,speed

co_4:           cmp     Key_Map[Key_C],On
                jne     co_5
                add     o_z,speed

co_5:           cmp     Key_Map[Key_X],On
                jne     co_6
                sub     o_z,speed

co_6:           cmp     Key_Map[Key_W],On
                jne     co_7
                add     o_z,speed

co_7:           cmp     Key_Map[Key_Q],On
                jne     co_8
                sub     o_z,speed

co_8:
                cmp     Key_Map[Key_F1],On        ;object
                jne     co_9
                sub     r_x,rot

co_9:           cmp     Key_Map[Key_F2],On
                jne     co_10
                add     r_x,rot

co_10:          cmp     Key_Map[Key_F3],On
                jne     co_11
                sub     r_y,rot

co_11:          cmp     Key_Map[Key_F4],On
                jne     co_12
                add     r_y,rot

co_12:          cmp     Key_Map[Key_F5],On
                jne     co_13
                sub     r_z,rot

co_13:          cmp     Key_Map[Key_F6],On
                jne     co_14
                add     r_z,rot

co_14:          cmp     Key_Map[Key_F7],On        ;camera
                jne     co_15
                sub     cm_x,rot

co_15:          cmp     Key_Map[Key_F8],On
                jne     co_16
                add     cm_x,rot

co_16:          cmp     Key_Map[Key_F9],On
                jne     co_17
                sub     cm_y,rot

co_17:          cmp     Key_Map[Key_F10],On
                jne     co_18
                add     cm_y,rot

co_18:          cmp     Key_Map[Key_F11],On
                jne     co_19
                sub     cm_z,rot

co_19:          cmp     Key_Map[Key_F12],On
                jne     exit
                add     cm_z,rot

exit:           ret

;***************************************************************************
ile_fade        dd      64

fade:           cmp     ile_fade,0
                jle     plum

                lea     esi,pal
                lea     edi,white
                mov     ebx,ile_fade
                mov     ecx,768
astro:          lodsb
                add     al,bl
                cmp     al,3fh
                jle     noa
                mov     al,3fh
noa:            stosb
                loop  astro

                lea     esi,white
                call    pal_set

                mov     eax,frames
                sub     ile_fade,eax

plum:           ret

brum:           mov     ax,ModPos
                and     eax,03fh
                cmp     tablica[eax*4],0
                je      no_flash
                cmp     tablica[eax*4+2],1
                je      no_flash
                mov     tablica[eax*4+2],1
                lea     esi,bialy
                call    pal_set
                lea     esi,white
                call    pal_set
no_flash:       ret

sloneczko:
        cmp sun_step,19
        jl sun_ok1
        sub sun_step,18
sun_ok1:
        cmp sun_step,0
        jg sun_ok2
        add sun_step,18
sun_ok2:
        mov esi,sun_step
        shl esi,12
        add esi,sun
        mov edi,scr_addr
        add edi,(-2*320)+254
        mov ecx,64
sp1:    mov ebp,64
sp2:    lodsb
        or al,al
        jz sun_sk
        mov [edi],al
sun_sk: inc edi
        dec ebp
        jnz sp2
        add edi,320-64
        dec ecx
        jnz sp1

        mov eax,frames
        cmp eax,4
        jle plo
        shr eax,2
        jmp doit
plo:    mov eax,1
doit:   add sun_step,eax
        ret

bialy           db      768 dup (3fh)

CODE32          ENDS
                END

p_len           =       222+81+8+256
f_len           =       440+158+12+384

x1_min          =       -4600
x1_max          =       4600
y1_min          =       -4600
y1_max          =       4600
z1_min          =       -6600
z1_max          =       4000

x2_min          =       0
x2_max          =       320
y2_min          =       0
y2_max          =       200

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
                include ..\inc\vodka
                include ..\inc\scr.inc
                include ..\inc\pal
                include ..\inc\our

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; DATA
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

scr_addr        dd      0
scr_sel         dw      0
map1_sel        dw      0
map2_sel        dw      0
map3_sel        dw      0
map4_sel        dw      0

pal             db      256*3 dup (0)

spal1           label   byte
                include sw.pal ;jup.pal

spal2           label   byte
                include v_txr1.pal

spal3           label   byte
                include proc.pal

spal4           label   byte
                include metal.pal

map1            dd      0
map2            dd      0
map3            dd      0
map4            dd      0

src1            label   word
                include ..\datas\vws_2.inc ;81
src2            label   word
                include ..\datas\vws_3.inc ;8
src3            label   word
                include ..\datas\vws_4.inc ;256

shape           label   word
                include ..\datas\vws_1.inc ;222
s1              dw      81*3 dup (0)  ;81
s2              dw      8*3 dup (0)   ;8
s3              dw      256*3 dup (0) ;256

con1            label   word
                include ..\datas\vwc_1.inc ;440
c1              label   word
                include ..\datas\vwc_2.inc ;158
c2              label   word
                include ..\datas\vwc_3.inc ;12
c3              label   word
                include ..\datas\vwc_4.inc ;384

con2            label   word
                rept    440/8
                dw      0*2,1*2,2*2
                dw      0*2,2*2,3*2
                dw      4*2,5*2,6*2
                dw      4*2,6*2,7*2
                dw      8*2,9*2,10*2
                dw      8*2,10*2,11*2
                dw      12*2,13*2,14*2
                dw      12*2,14*2,15*2
                endm

                rept    158/2
                dw      0*2,1*2,2*2
                dw      0*2,2*2,3*2
                endm

                dw      16*2,17*2,18*2
                dw      16*2,18*2,19*2

                dw      20*2,21*2,22*2
                dw      20*2,22*2,23*2

                dw      20*2,21*2,22*2
                dw      20*2,22*2,23*2

                dw      20*2,21*2,22*2
                dw      20*2,22*2,23*2

                dw      20*2,21*2,22*2
                dw      20*2,22*2,23*2

                dw      20*2,21*2,22*2
                dw      20*2,22*2,23*2

con3            label   dword
                rept    440/2
                dd      map1_sel
                db      0*16,0
                db      0,0
                dd      map1_sel
                db      0*16,0
                db      0,0
                endm

                rept    (158-14)/2
                dd      map2_sel
                db      8*16,0
                db      1,0
                dd      map2_sel
                db      8*16,0
                db      1,0
                endm

                rept    14/2
                dd      map1_sel
                db      64,1
                db      1,0
                dd      map1_sel
                db      64,1
                db      1,0
                endm

                rept    12/2
                dd      map3_sel
                db      9*16,0
                db      1,0
                dd      map3_sel
                db      9*16,0
                db      1,0
                endm

                rept    384/2
                dd      map4_sel
                db      12*16,0
                db      1,1
                dd      map4_sel
                db      12*16,0
                db      1,1
                endm

pos             dw      10*256,8*256, 10*256,112*256, 63*256,112*256, 63*256,8*256
                dw      63*256,8*256, 63*256,112*256, 126*256,112*256, 126*256,8*256
                dw      126*256,8*256, 126*256,112*256, 189*256,112*256, 189*256,8*256
                dw      189*256,8*256, 189*256,112*256, 248*256,112*256, 248*256,8*256

                dw      8*256,26*256, 8*256,92*256, 236*256,92*256, 236*256,26*256
                dw      8*256,84*256, 8*256,154*256, 236*256,154*256, 236*256,84*256

extrn sinus:word
extrn len:dword

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
o_z             dd      0

pkt             dw      81*2 dup (0)

pts_src         dw      (158+12+384)*3 dup (0)
pts_tab         dw      f_len*3 dup (0)
rcalc           dw      p_len*2 dup (0)

ile             dd      0
draw_tab        dw      f_len*2 dup (0)
check           dw      p_len dup (0)

n_add           dw      256 dup (0)
n_vert_src      dw      256*3 dup (0)
n_vert          dw      256*3 dup (0)
n_rot           dw      256*2 dup (0)

jcount          dd      0

frames          dd      0

ruchy           dd      0
                ;label   dword
                ;include trasa.dat

ruchy_ptr       dd      0

extrn _screen:dword
extrn _scrSel:word

znacznik        dd      0
znacznik2       dd      0
znacznik3       dd      0

logo            dd      0

sun_step        dd      0
stary           dw      1
ciota           dd      1

pic_data        dd      0
pic_pal         dd      0

ile_fade dd 64

tablica         dw      64-6 dup (0,0)
                dw      1,0
                dw      1,0
                dw      1,0
                dw      0,0
                dw      1,0
                dw      0,0

ruchow equ 2951

mnoznik dd 1

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; CODE
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

public PART4

krowa db 'plik.pal',0

PART4:          cld

                lea     esi,white
                call    pal_set

                rept    4
                v_sync
                endm

                vodka   24,map1
                vodka   25,map2
                vodka   26,map3
                vodka   27,map4

                vodka   28,logo

                vodka   29,pic_data
                vodka   30,pic_pal

                vodka   74,ruchy

                mov     eax,_scr_addr
                mov     scr_addr,eax
                mov     ax,_scrSel
                mov     scr_sel,ax

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

                mov     ah,Allocate_Selector
                mov     esi,map3
                add     esi,Code32_Addr
                mov     edi,0ffffh
                Int_EOS
                mov     map3_sel,bx

                mov     ah,Allocate_Selector
                mov     esi,map4
                add     esi,Code32_Addr
                mov     edi,0ffffh
                Int_EOS
                mov     map4_sel,bx

                mov     sort_addr,o draw_tab
                ;call    prep_sort

                call    prepare

                mov     shape_addr,o src3
                mov     n_addr,o n_vert_src
                mov     inc_addr,o n_add
                mov     con_addr,o c3
                mov     len,80
                mov     points,256
                mov     faces,384
                call    n_calc

                mov     n_addr,o n_vert
                mov     nrot_addr,o n_rot

                call    co_prepare
                call    make_chip
                call    make_pts
                call    make_pos

                lea     esi,spal1
                lea     edi,pal+(64*3)
                mov     bh,-2
                mov     bl,4
                mov     dl,6
                mov     ecx,64
                call    make_pal

                lea     esi,spal2
                lea     edi,pal+(128*3)
                mov     bh,-22
                mov     bl,-22
                mov     dl,-22
                mov     ecx,22
                call    make_pal

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

m_loop:         mov     ah,wait_vbl
                int_eos
                mov     frames,eax

                call    GetModPos

                cmp     ModPos,01200h
                jge     spadaj

                mov     ax,ModPos
                cmp     stary,ax
                je      bolek
                and     ax,3fh
                cmp     ax,1
                jne      prs1
                mov     znacznik3,1
                neg     ciota

prs1:           cmp     znacznik2,1
                je      noz
                cmp     znacznik,1
                jne     noz

bolek:          mov     ax,ModPos
                mov     stary,ax

                v_sync
                set_pal pal,0,256
                set_pal spal1,0,64
                set_pal spal3,128+16,33
                set_pal spal4,256-64,64
                mov     znacznik2,1

noz:            cmp     ruchy_ptr,ruchow
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
                add     eax,frames
                mov     ebx,mnoznik
                imul    ebx
                add     ruchy_ptr,eax

                call    swap
                call    prep_rot1
                call    prep_rot2
                call    make_chip
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
                call    show_logo

                mov     eax,frames
                shl     eax,1
                add     ro_z,ax

                inc     jcount
                mov     znacznik,1
                jmp     m_loop

spadaj:         lea     esi,white
                call    pal_set

                mov     esi,pic_data
                mov     edi,_0a0000h
                mov     ecx,16000
                rep     movsd

pic_lo:         v_sync

                lea     esi,white
                mov     edi,pic_pal
                mov     ecx,768
co:             lodsb
                cmp [edi],al
                je zkip
                dec al
                mov [esi-1],al
zkip:           inc edi
                loop co

                lea     esi,white
                call    pal_set

                dec ile_fade
                jnz pic_lo

                lea     edi,white
                mov     al,3fh
                mov     ecx,768
                rep     stosb

_wa:            call    GetModPos
                cmp     ModPos,1338h
                jl      _wa

brum:           call    GetModPos
                mov     ax,ModPos
                and     eax,03fh
                cmp     tablica[eax*4],0
                je      no_flash
                cmp     tablica[eax*4+2],1
                je      no_flash
                mov     tablica[eax*4+2],1
                rept    2
                lea     esi,white
                call    pal_set
                endm
                mov     esi,pic_pal
                call    pal_set
no_flash:       cmp     ModPos,1400h
                jl      brum

                mov     ah,DeAllocate_Selector
                mov     bx,map1_sel
                Int_EOS

                mov     ah,DeAllocate_Selector
                mov     bx,map2_sel
                Int_EOS

                mov     ah,DeAllocate_Selector
                mov     bx,map3_sel
                Int_EOS

                mov     ah,DeAllocate_Selector
                mov     bx,map4_sel
                Int_EOS
                ret

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

make_pos:       mov     r_x,0
                call    prep_rot1
                mov     r_x,328

                lea     esi,src1
                lea     edi,pkt
                mov     ecx,81

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

make_pal:
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

prepare:        lea     esi,con1
                mov     edi,esi
                mov     ecx,440*3
pr_lo1:         lodsw
                add     ax,ax
                stosw
                loop    pr_lo1

                lea     esi,src1
                mov     edi,esi
                mov     ecx,81*3
pr_lo2:         lodsw
                sar     ax,1
                stosw
                loop    pr_lo2

                lea     esi,c1
                mov     edi,esi
                mov     ecx,158*3
pr_lo3:         lodsw
                add     ax,222
                add     ax,ax
                stosw
                loop    pr_lo3

                lea     esi,src2
                mov     edi,esi
                mov     ecx,8*3
pr_lo4:         lodsw
                sar     ax,1
                stosw
                loop    pr_lo4

                lea     esi,c2
                mov     edi,esi
                mov     ecx,12*3
pr_lo5:         lodsw
                add     ax,222+81
                add     ax,ax
                stosw
                loop    pr_lo5

                lea     esi,src3
                mov     edi,esi
                mov     ecx,256*3
pr_lo6:         lodsw
                sar     ax,1
                stosw
                loop    pr_lo6

                lea     esi,c3
                mov     edi,esi
                mov     ecx,384*3
pr_lo7:         lodsw
                add     ax,ax
                stosw
                loop    pr_lo7
                ret

;---------------------------------------------------------------------------

co_prepare:     lea     esi,c3
                mov     edi,esi
                mov     ecx,384*3
pr_lo8:         lodsw
                add     ax,(222+81+8)*2
                stosw
                loop    pr_lo8
                ret

;---------------------------------------------------------------------------

make_pts:       mov     bx,3

                lea     esi,con1
                lea     edi,pts_tab
                mov     ecx,440
                call    calc_pts

                lea     esi,c1
                lea     edi,pts_src
                mov     ecx,158+12+384
                call    calc_pts
                ret

; calc subroutine ----------------------------------------------------------

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
ro_z            dw      0
z_offs          dw      0
j_offs          dd      1
j_add           dd      9

make_chip:      movsx   ebx,w ro_z
                and     ebx,3ffh

                mov     z_offs,0

                lea     esi,src1
                lea     edi,s1
                mov     ecx,81
                call    ro_chip

                ;cmp     jcount,160
                ;jl      pj_2

                cmp     znacznik3,1
                jne     pj_2

                push    ebx
                mov     ebp,j_offs
                mov     ebx,1320
                movsx   eax,sinus[ebp*2]
                imul    ebx
                sar     eax,15
                mov     z_offs,ax
                pop     ebx

                mov     eax,j_add
                imul    eax,frames
                add     j_offs,eax

                cmp     j_offs,0
                jge     pj_1
                mov     znacznik3,0
                mov     j_offs,0
                neg     j_add
pj_1:           cmp     j_offs,256-1
                jl      pj_2
                mov     j_offs,256-1
                neg     j_add

pj_2:           lea     esi,src2
                lea     edi,s2
                mov     ecx,8+256
                call    ro_chip

                mov     z_offs,0

                lea     esi,pts_src
                lea     edi,pts_tab+(440*6)
                mov     ecx,158+12+384
                call    ro_chip

                lea     esi,n_vert_src
                lea     edi,n_vert
                mov     ecx,256
                call    ro_chip
                ret

; rotate subroutine --------------------------------------------------------

ro_chip:        mov     ax,[esi]
                imul    sinus[ebx*2+512]
                mov     bp,dx
                mov     ax,[esi+2]
                imul    sinus[ebx*2]
                sub     bp,dx
                add     bp,bp
                mov     [edi],bp

                mov     ax,[esi]
                imul    sinus[ebx*2]
                mov     bp,dx
                mov     ax,[esi+2]
                imul    sinus[ebx*2+512]
                add     bp,dx
                add     bp,bp
                mov     [edi+2],bp

                mov     ax,[esi+4]
                add     ax,z_offs
                mov     [edi+4],ax

                add     esi,6
                add     edi,6
                loop    ro_chip
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
                mov     cx,p_len
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

                add     bp,12000
                mov     [edi],bp                ;zet
                mov     [edi+2],bx              ;index
                add     edi,4
                inc     ile

                push    esi edi ebx cx

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

                mov     ebp,p_z
                add     ebp,7600

                mov     eax,zoom+32
                imul    p_x
                idiv    ebp
                add     ax,160
                mov     [edi],ax

                mov     eax,zoom
                imul    p_y
                idiv    ebp
                add     ax,100
                mov     [edi+2],ax

skip:           add     ebx,2
                loop    lo

                pop     cx ebx edi esi

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
                lea     esi,draw_tab[eax*4-4]
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

                or      bh,bh
                jz      no_plane

                movzx   ebx,w con1[edi]
                movsx   eax,w rcalc[ebx*2]
                mov     x_1,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_1,eax
                sub     ebx,222*2
                mov     eax,d pkt[ebx*2]
                mov     d p_1,eax

                movzx   ebx,w con1[edi+2]
                movsx   eax,w rcalc[ebx*2]
                mov     x_2,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_2,eax
                sub     ebx,222*2
                mov     eax,d pkt[ebx*2]
                mov     d p_2,eax

                movzx   ebx,w con1[edi+4]
                movsx   eax,w rcalc[ebx*2]
                mov     x_3,eax
                movsx   eax,w rcalc[ebx*2+2]
                mov     y_3,eax
                sub     ebx,222*2
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
                sub     ebx,(222+81+8)*2
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
                sub     ebx,(222+81+8)*2
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
                sub     ebx,(222+81+8)*2
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
                js      hide

draw:           call    face

hide:           pop     esi
                sub     esi,4
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
exit:           ret

white   db 768 dup (3fh)

show_logo:
        cmp sun_step,15
        jl sun_ok1
        sub sun_step,14
sun_ok1:
        cmp sun_step,0
        jg sun_ok2
        add sun_step,14
sun_ok2:
        mov esi,sun_step
        imul esi,64*50
        add esi,logo
        mov edi,scr_addr
        add edi,(4*320)+255
        mov ecx,50
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
        cmp eax,2
        jle plo
        shr eax,1
        jmp doit
plo:    mov eax,1
doit:   imul ciota
        add sun_step,eax
        ret

CODE32          ENDS
                END
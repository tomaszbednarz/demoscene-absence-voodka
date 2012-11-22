
ile             =       32

step_1          =       3
step_2          =       24

p_num           =       341 ;270
f_num           =       646 ;516

zoom            =       216

x2_min          =       0
x2_max          =       320
y2_min          =       0
y2_max          =       200

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
                include ..\inc\our
                include ..\inc\pal

public prepare_twist

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; DATA
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

map_sel         dw      0
lgmap_sel       dw      0

spal            label   byte
                include jup.pal

tunel_pal       label byte
                include tn.pal


flesze          dd 0,0  ;0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0  ;0ah
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0  ;10h
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 0,0
                dd 1,0  ;20h
                dd 1,0
                dd 0,0
                dd 0,0
                dd 1,0  ;24h
                dd 0,0
                dd 1,0  ;26h
                dd 0,0
                dd 1,0  ;28h
                dd 1,0  ;29h
                dd 1,0  ;2ah
                dd 0,0
                dd 1,0  ;2ch
                dd 1,0  ;2dh
                dd 1,0  ;2eh
                dd 0,0
                dd 1,0  ;30h
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0
                dd 1,0


extrn sinus:word
extrn len:dword

map             dd      0
lgmap           dd      0

shape           label   word
                include ..\DATAS\log_s.inc

con             label   word
                include ..\DATAS\log_c.inc


pal             db      256*3 dup (0)

n_vert          dw      p_num dup (0,0,0)
n_add           dw      p_num dup (0)
rcalc           dw      p_num dup (0,0,0)
n_rot           dw      p_num dup (0,0)
plane           dw      p_num dup (0,0)
pos             dw      p_num dup (0,0)
zet_tab         dd      f_num dup (0)

scr_tab         dd      ile dup (0)
step            dd      0

tablica         label   dword

                rept    4
                dd      0,0,1,0
                endm

                rept    8
                dd      80,20,-1,0
                endm

                rept    8
                dd      -60,-30,1,0
                endm

                rept    8
                dd      -30,20,-1,0
                endm

                rept    8
                dd      40,70,1,0
                endm

                rept    8
                dd      -80,-20,-1,0
                endm

                rept    8
                dd      -20,30,1,0
                endm

                rept    8
                dd      50,-50,-1,0
                endm

                rept    4
                dd      -80,80,1,0
                endm

count           dd      ile

or_x            dw      0
or_y            dw      0
or_z            dw      0

skrin   dd      0
sun dd 0
sun_step dd 0
ramki dd 0
_mulek dd 0

znacznik dd 0
znacznik2 dd 0

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; CODE
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

EXTRN _tableToonel       : DWORD
licznik                 dw 0 ;do tunela

public PART3

PART3:          v_sync
                set_pal white,0,256

                mov     ah,Allocate_Memory
                mov     edx,320*200
                Int_EOS
                mov     skrin,edx

                vodka 22,_yayo
                vodka 23,sun

                mov     esi,_yayo
                mov     edi,esi
                mov     ecx,256*256
makl:           lodsb
                add     al,256-16
                stosb
                loop  makl

                mov     shape_addr,o shape
                mov     srot_addr,o rcalc
                mov     n_addr,o n_vert
                mov     nrot_addr,o n_rot
                mov     inc_addr,o n_add
                mov     con_addr,o con
                mov     sort_addr,o zet_tab
                mov     points,p_num
                mov     faces,f_num

                mov     ax,or_x
                mov     r_x,ax
                mov     ax,or_y
                mov     r_y,ax
                mov     ax,or_z
                mov     r_z,ax

                mov     len,32
                call    n_calc
                call    prep_pos
                mov     len,72
                call    n_calc

;컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

main_loop:      mov     ah,wait_vbl
                Int_EOS
                mov     ramki,eax

                cmp     znacznik2,1
                je      noz
                cmp     znacznik,1
                jne     noz

                v_sync
                mov     esi,o pal
                mov     b [esi],0
                mov     b [esi+1],0
                mov     b [esi+2],0
                set_pal pal,0,256
                set_pal tunel_pal,256-16,16
                mov     znacznik2,1

noz:            call    GetModPos
                mov     ax,ModPos
                and     eax,03fh
                add     eax,eax
                mov     ebx,tablica[eax*8]
                mov     p_x,ebx
                mov     ebx,tablica[eax*8+4]
                mov     p_y,ebx
                mov     ebx,tablica[eax*8+8]
                mov     _mulek,ebx

                call    tooneling
                call    copy
                call    sloneczko
                v_sync
                mov     esi,skrin
                mov     edi,_0a0000h
                mov     ecx,16000
                rep     movsd
                call    clear

                call    rotate_shape
                neg     r_x
                neg     r_y
                neg     r_z
                call    rotate_normals
                neg     r_x
                neg     r_y
                neg     r_z
                call    bit_sort
                call    p_calc
                call    show
                call    roll

                mov     znacznik,1

                mov     eax,ramki
                add     r_z,ax
                ;add     ax,ax
                add     r_y,ax
                add     r_x,ax

                add     step,step_2

                call    GetModPos
                cmp     ModPos,0d3eh
                jg      part_4
                mov     ax,ModPos
                cmp     ax,0d19h
                jle     bez_fleszy
                movzx   eax,ax
                and eax,3fh
                cmp [flesze+eax*8],0
                je bez_fleszy
                cmp [flesze+eax*8+4],0
                jne bez_fleszy
                mov [flesze+eax*8+4],0
                lea esi,white
                call pal_set
                v_sync
                set_pal pal,0,256
                set_pal tunel_pal,256-16,16
 bez_fleszy:


                jmp     Main_loop
 part_4:

                mov     ah,deallocate_memory
                int_eos
                mov     ah,deallocate_memory
                int_eos
                ret

;---------------------------------------------------------------------------

prepare_twist:  vodka   20,map
                vodka   21,lgmap

                mov     ah,Allocate_Memory
                mov     edx,320*200*ile
                Int_EOS
                mov     eax,edx
                jnc     mem_ok
                mov     dl,7
                mov     ah,2
                DosInt  21h

mem_ok:         lea     edi,scr_tab
                mov     ecx,ile
make_scr:       stosd
                add     eax,320*200
                loop    make_scr

                mov     edi,scr_tab
                xor     eax,eax
                mov     ecx,16000*ile
                rep     stosd

                mov     ah,Allocate_Selector
                mov     esi,map
                add     esi,Code32_Addr
                mov     edi,0ffffh
                Int_EOS
                mov     map_sel,bx

                mov     ah,Allocate_Selector
                mov     esi,lgmap
                add     esi,Code32_Addr
                mov     edi,0ffffh
                Int_EOS
                mov     lgmap_sel,bx

                mov     shape_addr,o shape
                mov     srot_addr,o rcalc
                mov     n_addr,o n_vert
                mov     nrot_addr,o n_rot
                mov     inc_addr,o n_add
                mov     con_addr,o con
                mov     sort_addr,o zet_tab
                mov     points,p_num
                mov     faces,f_num

                call    make_pal
                call    prepare
                mov     len,42
                call    n_calc
                call    prep_pos
                mov     len,72
                call    n_calc

;---------------------------------------------------------------------------

make_anim:      call    rotate_shape
                neg     r_x
                neg     r_y
                neg     r_z
                call    rotate_normals
                neg     r_x
                neg     r_y
                neg     r_z
                call    bit_sort
                call    p_calc
                call    show
                call    roll

                mov     ah,wait_vbl
                Int_EOS

                add     r_z,ax
                add     r_y,ax
                add     r_x,ax

                add     step,step_2

                dec     count
                jnz     make_anim

                mov     ax,r_x
                mov     or_x,ax
                mov     ax,r_y
                mov     or_y,ax
                mov     ax,r_z
                mov     or_z,ax
                ret

;---------------------------------------------------------------------------

make_pal:       lea     edi,pal
                mov     bl,63
                mov     ecx,16
f_lo1:          push    ecx
                lea     esi,spal
                mov     cx,16*3
f_lo2:          lodsb
                add     al,bl
                jns     pa_1
                xor     al,al
pa_1:           cmp     al,63
                jle     pa_2
                mov     al,63
pa_2:           stosb
                loop    f_lo2
                sub     bl,11
                pop     ecx
                loop    f_lo1
                ret

;---------------------------------------------------------------------------

prepare:        lea     esi,con
                mov     edi,esi
                mov     ecx,f_num*3
pr_lo1:         lodsw
                add     ax,ax
                stosw
                loop    pr_lo1

                mov     esi,lgmap
                mov     edi,esi
                mov     ecx,256*199
pr_lo2:         lodsb
                shl     al,4
                stosb
                loop    pr_lo2
                ret

;---------------------------------------------------------------------------

prep_pos:       lea     esi,n_vert
                lea     edi,pos
                mov     ecx,p_num
prep:           lodsw
                add     ax,128
                shl     ax,8
                stosw
                lodsw
                add     ax,96
                shl     ax,8
                stosw
                add     esi,2
                loop    prep
                ret

;---------------------------------------------------------------------------
p_x             dd      0
p_y             dd      0
_size           dd      0
_skip1          dd      0
_skip2          dd      0

copy:           mov     _size,320
                mov     eax,p_x
                cmp     eax,0
                jge     p1
                add     _size,eax
                neg     eax
                mov     _skip1,eax
                mov     _skip2,0

;                mov     edx,eax
;                mov     edi,320
;                sub     edi,eax
;                mov     esi,edi
;                add     edi,skrin ;_0a0000h
;                xor     eax,eax
;                mov     ebp,200
;co1:            mov     ecx,edx
;                rep     stosb
;                add     edi,esi
;                dec     ebp
;                jnz     co1

                jmp     cp1

p1:             sub     _size,eax
                mov     _skip1,0
                mov     _skip2,eax

;                mov     edx,eax
;                mov     edi,skrin ;_0a0000h
;                mov     esi,320
;                sub     esi,eax
;                xor     eax,eax
;                mov     ebp,200
;co2:            mov     ecx,edx
;                rep     stosb
;                add     edi,esi
;                dec     ebp
;                jnz     co2

cp1:            mov     ecx,200
                mov     eax,p_y
                cmp     eax,0
                jl      p2
                sub     ecx,eax
                ;push    ecx
                ;mov     edi,skrin ;_0a0000h
                ;mov     ecx,eax
                ;imul    ecx,80
                ;xor     eax,eax
                ;rep     stosd
                ;pop     ecx
                jmp     cp2

p2:             ;push    ecx
                ;neg     eax
                ;mov     edi,200
                ;sub     edi,eax
                ;imul    edi,320
                ;add     edi,skrin ;_0a0000h
                ;mov     ecx,eax
                ;imul    ecx,80
                ;xor     eax,eax
                ;rep     stosd
                ;pop     ecx

cp2:            xor     esi,esi
                mov     edi,skrin
                mov     eax,p_y
                imul    eax,320
                add     eax,p_x
                add     edi,eax
                mov     ebx,step
                and     ebx,3ffh
                mov     ebp,ile-4

c_lop:          cmp     p_y,0
                jge     gosp
                add     edi,320
                jmp     cosp

gosp:           push    ecx esi
                movsx   eax,sinus[ebx*2]
                neg     eax
                imul    ebp
                sar     eax,16
                add     eax,ile/2
                add     esi,scr_tab[eax*4]
                mov     ecx,_size
                add     esi,_skip1
                add     edi,_skip1
copa:           lodsb
                or    al,al
                jz pusty
                mov [edi],al
pusty:          inc edi
                dec ecx
                jnz copa
                add     esi,_skip2
                add     edi,_skip2
                pop     esi ecx

cosp:           add     ebx,step_1
                and     ebx,3ffh
                add     esi,320
                inc     p_y
                loop    c_lop
                ret

;---------------------------------------------------------------------------

clear:          mov     edi,scr_tab
                xor     eax,eax
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

p_calc:         mov     esi,srot_addr
                lea     edi,plane
                mov     ecx,points

p_lop:          mov     bx,[esi+4]
                sub     bx,6200

                mov     ax,zoom+32
                imul    w [esi]
                idiv    bx
                add     ax,sh_x
                stosw

                mov     ax,zoom
                imul    w [esi+2]
                idiv    bx
                add     ax,sh_y
                stosw

                add     esi,6
                loop    p_lop
                ret

;---------------------------------------------------------------------------

show:           mov     es,lgmap_sel
                mov     fs,map_sel

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
                mov     eax,d pos[ebx*2]
                mov     d m_1,eax

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
                mov     eax,d pos[ebx*2]
                mov     d m_2,eax

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
                mov     eax,d pos[ebx*2]
                mov     d m_3,eax

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

                xor     edi,edi
                call    face

hide:           pop     esi ecx
                add     esi,4
                loop    lop

                mov     es,Data32_Sel
                mov     fs,Zero_sel
                ret

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�

x_1             dd      0
x_s             dd      0
y_1             dd      0
p_1             dw      0,0
m_1             dw      0,0
x_2             dd      0
y_2             dd      0
p_2             dw      0,0
m_2             dw      0,0
x_3             dd      0
y_3             dd      0
p_3             dw      0,0
m_3             dw      0,0

dx_1            dd      0
dy_1            dd      0
dx_2            dd      0
dy_2            dd      0
dy_3            dd      0
pd_1            dw      0,0
md_1            dw      0,0
pd_2            dw      0,0
md_2            dw      0,0

pom             dw      0
mem             dw      0,0,0,0

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
                mov     eax,d m_1
                xchg    d m_2,eax
                mov     d m_1,eax

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
                mov     eax,d m_1
                xchg    d m_3,eax
                mov     d m_1,eax

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
                mov     eax,d m_2
                xchg    d m_3,eax
                mov     d m_2,eax

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

                movzx   ebx,m_1
                movzx   eax,m_3
                sub     eax,ebx
                cdq
                idiv    dy_3
                mov     md_1,ax

                movzx   ebx,m_1+2
                movzx   eax,m_3+2
                sub     eax,ebx
                cdq
                idiv    dy_3
                mov     md_2,ax

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
                mov     eax,d m_1
                mov     d mem+4,eax
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

                mov     eax,dy_1
                imul    d md_1
                add     ax,m_1
                mov     mem+4,ax

                mov     eax,dy_1
                imul    d md_2
                add     ax,m_1+2
                mov     mem+6,ax

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
                mov     ax,m_1
                xchg    m_1+2,ax
                mov     m_1,ax

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

                movzx   ecx,mem+4
                movzx   eax,m_2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     bp,ax

                shl     ebp,16

                movzx   ecx,mem+6
                movzx   eax,m_2+2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     bp,ax

                mov     d v1+2,ebp
                mov     d v2+2,ebp

                mov     eax,scr_tab
                mov     d a1+2,eax

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
                mov     ecx,d m_1

                cmp     bp,x2_max-1
                jl      no_c3

add_2:          add     edx,esi
v1:             add     ecx,10000001
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
                mov     al,es:[bx]
                mov     bl,ch
                shld    ebx,ecx,8
                mov     ah,fs:[bx]
                add     al,ah
a1:             mov     [edi+10000001],al
                dec     edi
                add     edx,esi
v2:             add     ecx,10000001
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
                mov     ax,md_2
                add     m_1,ax
                mov     ax,md_1
                add     m_1+2,ax
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

                movzx   ecx,mem+4
                movzx   eax,m_2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     bp,ax

                shl     ebp,16

                movzx   ecx,mem+6
                movzx   eax,m_2+2
                sub     eax,ecx
                cdq
                idiv    ebx
                mov     bp,ax

                mov     d v3+2,ebp
                mov     d v4+2,ebp

                mov     eax,scr_tab
                mov     d a2+2,eax

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
                mov     ecx,d m_1

                cmp     di,x2_min
                jge     no_c1

add_1:          add     edx,esi
v3:             add     ecx,10000001
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
                mov     al,es:[bx]
                mov     bl,ch
                shld    ebx,ecx,8
                mov     ah,fs:[bx]
                add     al,ah
a2:             mov     [edi+10000001],al
                inc     edi
                add     edx,esi
v4:             add     ecx,10000001
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
                mov     ax,md_2
                add     m_1,ax
                mov     ax,md_1
                add     m_1+2,ax
                add     y_1,320

                dec     dy_3
                jne     draw_2
                ret

;---------------------------------------------------------------------------

roll:           lea     esi,scr_tab
                mov     edi,esi
                mov     ecx,ile-1
                lodsd
                rep     movsd
                stosd
                ret

_yayo   dd ?
tooneling:
        mov edi,skrin
        mov ebp,_yayo
        mov edx,[_tableToonel]
        xor ebx,ebx
        xor ecx,ecx
        mov esi,32000
 Spier:
        mov cx,w [edx+esi*2-2]
        mov bx,w [edx+64000+esi*2-2]
        add bx,licznik
        add cx,licznik
        mov al,[ebp+ebx]
        mov ah,[ebp+ecx]
        mov [edi],ax
        add edi,2
        dec esi
        jnz Spier
        mov eax,ramki
        mov ebx,256
        add ebx,_mulek
        add ebx,_mulek
        imul ebx
        add licznik,ax
        ret

sloneczko:
        cmp sun_step,36
        jl sun_ok1
        sub sun_step,35
sun_ok1:
        cmp sun_step,0
        jg sun_ok2
        add sun_step,35
sun_ok2:
        mov esi,sun_step
        shl esi,12
        add esi,sun
        mov edi,skrin
        add edi,((206-64)*320)+254
        mov ecx,64
sp1:    mov ebp,64
sp2:    lodsb
        cmp al,60h
        jz sun_sk
        mov [edi],al
sun_sk: inc edi
        dec ebp
        jnz sp2
        add edi,320-64
        dec ecx
        jnz sp1

        mov eax,ramki
        cmp eax,4
        jle plo
        shr eax,2
        jmp doit
plo:    mov eax,1
doit:   add sun_step,eax
        ret

white db 768 dup (3fh)

CODE32          ENDS
                END
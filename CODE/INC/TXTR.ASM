
                .386

CODE32          SEGMENT PUBLIC PARA 'CODE' USE32
                ASSUME  CS:CODE32,DS:CODE32,ES:CODE32

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; INCLUDES
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

                include eos.inc

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; PUBLIC & EXTENNAL SYMBOLS
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

                public  tm_face

                public  x_1
                public  y_1
                public  p_1
                public  x_2
                public  y_2
                public  p_2
                public  x_3
                public  y_3
                public  p_3

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; DATA
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

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

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; tm_face - texture-mapped face (triangle)
; in:
;   fs - texture selector
;   gs - virtual screen selector
;   x_1.d - x1
;   y_1.d - y1
;   p_1.w - tx1
;   p_1.w+2 - ty1
;   x_2.d - x2
;   y_2.d - y2
;   p_2.w - tx2
;   p_2.w+2 - ty2
;   x_3.d - x3
;   y_3.d - y3
;   p_3.w - tx3
;   p_3.w+2 - ty3
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

x_min           =       0
y_min           =       0
x_max           =       320
y_max           =       200

tm_face:        mov     pom,0

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

pr_3:           cmp     w y_1,y_max-1
                jge     sk
                cmp     w y_3,y_min
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

                cmp     y_3,y_max-1
                jl      no_da
                sub     y_3,y_max-1
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

draw_1:         mov     ebx,y_1
                cmp     y_2,ebx
                jne     no_1

                mov     eax,x_3
                sub     eax,x_2
                shl     eax,16
                cdq
                idiv    dy_2
                mov     dx_1,eax

no_1:           cmp     ebx,y_min*320
                jl      go_1

                mov     di,w x_1+2
                mov     cx,w x_s+2

                cmp     di,x_max
                jge     go_1
                cmp     cx,x_min
                jl      go_1

                mov     edx,d p_1

                cmp     cx,x_max-1
                jl      no_c3

add_2:          add     edx,esi
                dec     cx
                cmp     cx,x_max-1
                jg      add_2

no_c3:          cmp     di,x_min
                jge     no_c4
                mov     di,x_min

no_c4:          sub     cx,di
                jl      go_1

                add     di,cx
                add     di,w y_1
                inc     cx

fo_1:           mov     bl,dh
                shld    ebx,edx,8
                mov     al,fs:[bx]
                mov     gs:[di],al
                dec     di
                add     edx,esi
                dec     cx
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

draw_2:         mov     ebx,y_1
                cmp     y_2,ebx
                jne     no_2

                mov     eax,x_3
                sub     eax,x_2
                shl     eax,16
                cdq
                idiv    dy_2
                mov     dx_1,eax

no_2:           cmp     ebx,y_min*320
                jl      go_2

                mov     di,w x_s+2
                mov     cx,w x_1+2

                cmp     di,x_max
                jge     go_2
                cmp     cx,x_min
                jl      go_2

                mov     edx,d p_1

                cmp     di,x_min
                jge     no_c1

add_1:          add     edx,esi
                inc     di
                jl      add_1

no_c1:          cmp     cx,x_max-1
                jl      no_c2
                mov     cx,x_max-1

no_c2:          sub     cx,di
                jl      go_2

                add     di,w y_1
                inc     cx

fo_2:           mov     bl,dh
                shld    ebx,edx,8
                mov     al,fs:[bx]
                mov     gs:[di],al
                inc     di
                add     edx,esi
                dec     cx
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

CODE32          ENDS
                END
; vector engine for Eclipse Operating System (EOS)

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

                public  n_calc
                public  sqrt
                public  rotate_shape
                public  rotate_normals
                public  prep_sort
                public  sort

                public  shape_addr
                public  srot_addr
                public  n_addr
                public  nrot_addr
                public  inc_addr
                public  con_addr
                public  sort_addr
                public  points
                public  faces

                public  r_x
                public  r_y
                public  r_z

                extrn   sinus:dword
                extrn   len:dword

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; DATA
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

shape_addr      dd      0
srot_addr       dd      0
n_addr          dd      0
nrot_addr       dd      0
inc_addr        dd      0
con_addr        dd      0
sort_addr       dd      0
points          dd      0
faces           dd      0

x1              dd      0
y1              dd      0
z1              dd      0
x2              dd      0
y2              dd      0
z2              dd      0
x3              dd      0
y3              dd      0
z3              dd      0

n_x             dd      0
n_y             dd      0
n_z             dd      0

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

r_x             dw      0
r_y             dw      0
r_z             dw      0

sort_mem        dd      0

addr_tab        dd      16 dup (0)
tab_len         dd      16 dup (0)

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; n_calc - calculate object normals
; in:
;   shape_addr - address of shape table
;   con_addr - address of construction table
;   n_addr - address of normals table
;   points - amount of vertex
;   faces - amount of faces
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

n_calc:         push    points faces

                mov     edi,inc_addr
                xor     ax,ax
                mov     ecx,points
                rep     stosw

                mov     esi,con_addr

calc_1:         movzx   ebx,w [esi]
                lea     ebx,[ebx*2+ebx]
                add     ebx,shape_addr
                movsx   eax,w [ebx]
                sar     eax,4
                mov     x1,eax
                movsx   eax,w [ebx+2]
                sar     eax,4
                mov     y1,eax
                movsx   eax,w [ebx+4]
                sar     eax,4
                mov     z1,eax

                movzx   ebx,w [esi+2]
                lea     ebx,[ebx*2+ebx]
                add     ebx,shape_addr
                movsx   eax,w [ebx]
                sar     eax,4
                mov     x2,eax
                movsx   eax,w [ebx+2]
                sar     eax,4
                mov     y2,eax
                movsx   eax,w [ebx+4]
                sar     eax,4
                mov     z2,eax

                movzx   ebx,w [esi+4]
                lea     ebx,[ebx*2+ebx]
                add     ebx,shape_addr
                movsx   eax,w [ebx]
                sar     eax,4
                mov     x3,eax
                movsx   eax,w [ebx+2]
                sar     eax,4
                mov     y3,eax
                movsx   eax,w [ebx+4]
                sar     eax,4
                mov     z3,eax

                mov     eax,y2
                sub     eax,y1
                mov     ebp,z3
                sub     ebp,z1
                imul    ebp
                mov     ebx,eax
                mov     eax,y3
                sub     eax,y1
                mov     ebp,z2
                sub     ebp,z1
                imul    ebp
                sub     ebx,eax
                neg     ebx
                mov     n_x,ebx

                mov     eax,x2
                sub     eax,x1
                mov     ebp,z3
                sub     ebp,z1
                imul    ebp
                mov     ebx,eax
                mov     eax,x3
                sub     eax,x1
                mov     ebp,z2
                sub     ebp,z1
                imul    ebp
                sub     ebx,eax
                mov     n_y,ebx

                mov     eax,y2
                sub     eax,y1
                mov     ebp,x3
                sub     ebp,x1
                imul    ebp
                mov     ebx,eax
                mov     eax,y3
                sub     eax,y1
                mov     ebp,x2
                sub     ebp,x1
                imul    ebp
                sub     ebx,eax
                neg     ebx
                mov     n_z,ebx

                mov     eax,n_x
                imul    eax,eax
                mov     ebx,n_y
                imul    ebx,ebx
                mov     ecx,n_z
                imul    ecx,ecx
                add     eax,ebx
                add     eax,ecx
                jnz     skip
                mov     ecx,len
                jmp     cont

skip:           call    sqrt

cont:           mov     ebx,len

                mov     eax,n_x
                imul    ebx
                idiv    ecx
                mov     w n_x,ax
                mov     eax,n_y
                imul    ebx
                idiv    ecx
                mov     w n_y,ax
                mov     eax,n_z
                imul    ebx
                idiv    ecx
                mov     w n_z,ax

                mov     ax,w n_x
                mov     bx,w n_y
                mov     cx,w n_z

                movzx   ebp,w [esi]
                mov     edx,inc_addr
                inc     w [edx+ebp]
                lea     ebp,[ebp*2+ebp]
                add     ebp,n_addr
                add     [ebp],ax
                add     [ebp+2],bx
                add     [ebp+4],cx

                movzx   ebp,w [esi+2]
                mov     edx,inc_addr
                inc     w [edx+ebp]
                lea     ebp,[ebp*2+ebp]
                add     ebp,n_addr
                add     [ebp],ax
                add     [ebp+2],bx
                add     [ebp+4],cx

                movzx   ebp,w [esi+4]
                mov     edx,inc_addr
                inc     w [edx+ebp]
                lea     ebp,[ebp*2+ebp]
                add     ebp,n_addr
                add     [ebp],ax
                add     [ebp+2],bx
                add     [ebp+4],cx

                add     esi,6
                dec     faces
                jne     calc_1

                mov     esi,inc_addr
                mov     edi,n_addr
calc_2:         mov     bx,[esi]

                or      bx,bx
                jz      zero

                mov     ax,[edi]
                cwd
                idiv    bx
                mov     [edi],ax
                mov     ax,[edi+2]
                cwd
                idiv    bx
                mov     [edi+2],ax
                mov     ax,[edi+4]
                cwd
                idiv    bx
                mov     [edi+4],ax

zero:           add     esi,2
                add     edi,6
                dec     points
                jne     calc_2

                pop     faces points
                ret

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; sqrt - calculate square root
; in:
;   eax - value
; out:
;   ecx - square root
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

sqrt:           mov     ebp,eax
                bsr     ecx,eax
                shr     cl,1
                shr     eax,cl

                mov     ecx,eax

                xor     edx,edx
                mov     eax,ebp
                div     ecx
                add     ecx,eax
                shr     ecx,1

                xor     edx,edx
                mov     eax,ebp
                div     ecx
                add     ecx,eax
                shr     ecx,1

                xor     edx,edx
                mov     eax,ebp
                div     ecx
                add     ecx,eax
                shr     ecx,1
                ret

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; rotate_shape - rotate object vertex
; in:
;   shape_addr - addres of vertex table
;   srot_addr - address of temporary table (rotated vertex)
;   points - amount of vertex
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

rotate_shape:   lea     esi,sinus

                movsx   ebx,word ptr r_x
                and     ebx,3ffh
                movsx   eax,word ptr [esi+ebx*2]
                mov     s_x,eax
                movsx   eax,word ptr [esi+512+ebx*2]
                mov     c_x,eax

                movsx   ebx,word ptr r_y
                and     ebx,3ffh
                movsx   eax,word ptr [esi+ebx*2]
                mov     s_y,eax
                movsx   eax,word ptr [esi+512+ebx*2]
                mov     c_y,eax

                movsx   ebx,word ptr r_z
                and     ebx,3ffh
                movsx   eax,word ptr [esi+ebx*2]
                mov     s_z,eax
                movsx   eax,word ptr [esi+512+ebx*2]
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

                mov     esi,shape_addr
                mov     edi,srot_addr
                mov     ecx,points

ro_1:           movsx   eax,w [esi]
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
                mov     [edi],bp

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
                mov     [edi+2],bp

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
                mov     [edi+4],bp

                add     esi,6
                add     edi,6
                loop    ro_1
                ret

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; rotate_normals - rotate object normals
; in:
;   n_addr - addres of normals table
;   nrot_addr - address of temporary table (rotated normals)
;   points - amount of vertex
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

rotate_normals: lea     esi,sinus

                movsx   ebx,word ptr r_x
                and     ebx,3ffh
                movsx   eax,word ptr [esi+ebx*2]
                mov     s_x,eax
                movsx   eax,word ptr [esi+512+ebx*2]
                mov     c_x,eax

                movsx   ebx,word ptr r_y
                and     ebx,3ffh
                movsx   eax,word ptr [esi+ebx*2]
                mov     s_y,eax
                movsx   eax,word ptr [esi+512+ebx*2]
                mov     c_y,eax

                movsx   ebx,word ptr r_z
                and     ebx,3ffh
                movsx   eax,word ptr [esi+ebx*2]
                mov     s_z,eax
                movsx   eax,word ptr [esi+512+ebx*2]
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

                mov     esi,n_addr
                mov     edi,nrot_addr
                mov     ecx,points

ro_2:           movsx   eax,w [esi]
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
                mov     [edi],bp

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
                mov     [edi+2],bp

                add     esi,6
                add     edi,4
                loop    ro_2
                ret

;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
; sort - sort table (bit sort)
; in:
;   sort_addr - address of table to sort
;   points - amount of values to sort
;같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같

drawers         =       1200

prep_sort:      mov     ah,Allocate_Memory
                mov     edx,drawers*16*4
                Int_EOS
                mov     sort_mem,edx

sort_prep:      lea     edi,addr_tab
                mov     eax,sort_mem
                mov     ecx,16
make_addr:      stosd
                add     eax,drawers*4
                loop    make_addr
                ret

; main sort 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

sort:           val     =0
                rept    4
                local   main_sort,norm,skip

                lea     edi,tab_len
                xor     eax,eax
                mov     ecx,16
                rep     stosd

                mov     esi,sort_addr
                mov     ecx,faces
main_sort:      lodsd
                mov     ebx,eax
                shr     ebx,val
                and     ebx,0fh
                mov     edx,tab_len[ebx*4]
                inc     tab_len[ebx*4]
                mov     edi,addr_tab[ebx*4]
                mov     [edi+edx*4],eax
                loop    main_sort

                lea     ebx,tab_len
                mov     esi,sort_mem
                mov     edi,sort_addr
                mov     bp,16
norm:           push    esi
                mov     ecx,[ebx]
                or      cx,cx
                jz      skip
                rep     movsd
skip:           pop     esi
                add     ebx,4
                add     esi,drawers*4
                dec     bp
                jnz     norm

                val     =val+4
                endm
                ret

CODE32          ENDS
                END
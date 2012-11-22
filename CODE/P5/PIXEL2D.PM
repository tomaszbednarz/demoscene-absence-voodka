
; draws 2d pixels
;		ecx 	- number of points
;		esi	- source 2d points (dw x,y);
;		edi	- screen table
;		al	- color

Pixel2d:

	mov ebx,[esi]
	mov edx,[esi+4]

	cmp ebx,0
	jl nP2d
	cmp ebx,319 ;clipRight
	jg nP2d
	cmp edx,0
	jl nP2d
	cmp edx,199 ;clipDown
	jg nP2d

	mov edx,d [pom_tab+edx*4]
	lea ebx,[edx+ebx]
	mov b [edi+ebx],al
 nP2d:
	add esi,8
	dec ecx
	jnz Pixel2d

	ret

pom_tab:	t=0
		REPT 200
		dd t
		t=t+320
		ENDM

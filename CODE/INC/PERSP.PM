
xmove 	dd 160
ymove 	dd 100
Zdelta	dd 185

; wejscia: 	ecx 	- number_of_points
;		esi	- source 3d (dw x,y,z)
;		edi	- target 2d (dw x,y)

persp:
	mov ebx,[esi+8]
	add ebx,185*16
	or ebx,ebx
	jnz dddde
	inc ebx
dddde:

	mov eax,[esi] ;x
	imul Zdelta
	idiv ebx
	add eax,Xmove
	mov [edi],eax

	mov eax,[esi+4] ;y
	imul zDelta
	idiv ebx
	add eax,Ymove
	mov [edi+4],eax
	add esi,12
	add edi,8
	
	dec ecx
	jnz persp

	ret


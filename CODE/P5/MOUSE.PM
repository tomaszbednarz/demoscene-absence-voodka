

initMouse:
	mov ax,0
	DosInt 33h
	test ax,1
	jz gownoNieMysz
	mov jestMysz,1
 gownoNieMysz:
	ret

	jestmysz db 0

Mouse:
	cmp jestmysz,0
	je Metallica2
	mov ax,3
	DosInt 33h
	xor eax,eax
	mov ax,cx
	shr ax,1
	mov xmove,eax
	mov ax,dx
	mov ymove,eax
	mov ax,5
	DosInt 33h
	test ax,1
	jz Metallica1
	add Zdelta,2
 Metallica1:	
	test ax,2
	jz Metallica2
	jmp Mouse
	sub zDelta,2
 Metallica2:
	ret



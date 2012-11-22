calculateWater:
	mov eax,nPage
	and eax,1
	or eax,eax
	jz Ches1
	mov edi,[_bufor2]
	mov esi,[_bufor1]
	jmp Ches2 
 Ches1:	mov edi,[_bufor1]
	mov esi,[_bufor2]
 Ches2:	add esi,321*2
	add edi,321*2

	mov ebp,198-98-20 ;y Count
 loop1:	mov ecx,318	;x Count
 loop2:	mov ax,[edi+320*2]
	add ax,[edi-320*2]
	add ax,[edi+1*2]
	add ax,[edi-1*2] 
	sar ax,1	
	sub ax,[esi]
	mov dx,ax
	sar dx,06h
	DESTINY=$-1
	sub ax,dx
	mov [esi],ax
	add esi,2
	add edi,2
	dec ecx
	jnz loop2
	add esi,4
	add edi,4
	dec ebp
	jnz loop1
	ret


MUL160 LABEL WORD
	uuu=0
	REPT 200
		dw uuu
		uuu=uuu+320
	ENDM

; ebx must be free :)
DrawWater:
	xor ebx,ebx
	mov ebp,[_obrazek2]
	add ebp,60*320
	mov edi,[_screen]
	add edi,60*320
	test nPage,1
	jz vamp1
	mov esi,[_bufor2]
	jmp @draw
 vamp1:	mov esi,[_bufor1]
 @draw:
	mov ecx,(-80*65536)  ;0ff9c0000h ;-100
	mov w [WaterY],0
 @loop0:
	mov cx,320
	mov w [WaterX],0
 @loop1:
	mov ax,[esi]
	mov dx,ax
	sub ax,[esi+640]
	sub dx,[esi+2]

	mov bx,ax
	lea eax,[128-eax]
	and eax,0ffffh		
	mov b [innerWater],al 
	sar bx,3		
	sar dx,3
	add bx,0101h
	WaterY=$-2
	add dx,0101h
	WaterX=$-2
	mov ax,mul160[ebx*2]
	add ax,dx
	mov al,[ebp+eax]	

	mov ah,01h 
	innerWater=$-1
	mul ah
	mov [edi+320],ah
;	mov [edi+321],ah
;	mov [edi+640],ah
;	mov [edi+641],ah

	inc edi
;	inc edi
	add esi,2
	inc w [WaterX]
	dec cx
	jnz @loop1

;	add edi,160
;	add edi,320
	inc w [WaterY]
	add ecx,00010000h
	js @loop0
	ret


include water\tab
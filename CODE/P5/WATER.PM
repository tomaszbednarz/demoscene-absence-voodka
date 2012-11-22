
nPage dd 0

calculateWater:

	INCLUDE rip

	mov eax,nPage
	and eax,1
	or eax,eax
	jz Ches1
	mov edi,[_bufor2]
	mov esi,[_bufor1]
	jmp Ches2 
 Ches1:	mov edi,[_bufor1]
	mov esi,[_bufor2]
 Ches2:	add esi,129*2
	add edi,129*2

	INC nPage
	mov ebp,126	;x Count
 loop1:	mov ecx,126	;y Count
 loop2:	mov ax,[edi+128*2]
	add ax,[edi-128*2]
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


; ebx must be free :)
DrawWater:
	xor ebx,ebx
	mov ebp,[_obrazek]
	mov edi,[_waterWorld]
	test nPage,1
	jz vamp1
	mov esi,[_bufor2]
	jmp @draw
 vamp1:	mov esi,[_bufor1]
 @draw:
	mov ecx,-128*65536
	mov w [WaterY],0
 @loop0:
	mov cx,128
	mov w [WaterX],0
 @loop1:
	mov ax,[esi]
	mov dx,ax
	sub ax,[esi+128*2]
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
	mov ax,bx
	shl ax,7
	add ax,dx
	mov al,[ebp+eax]	

	mov ah,01h 
	innerWater=$-1
	mul ah
	and ah,31
	mov [edi+256],ah
	mov [edi+257],ah
	mov [edi+256+256],ah
	mov [edi+257+256],ah

	inc edi
	inc edi
	add esi,2
	inc w [WaterX]
	dec cx
	jnz @loop1

	add edi,256
	inc w [WaterY]
	add ecx,00010000h
	js @loop0
	ret


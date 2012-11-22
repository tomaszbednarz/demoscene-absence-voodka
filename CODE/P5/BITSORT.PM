

	SortAdd equ 15000 
	SortDrawers equ 1000 ;przydzielamy n szufladek
	SortMemory  equ SortDrawers*4*16 ;czyli 16 dwordow
	Satan1 equ 0
	Satan2 equ 4
	Satan3 equ 8
	Satan4 equ 12

	_sortAddress dd ?

	ALIGN 16
	SortAddress  dd 16 DUP (?) ;adresy do kolejnych 16 szufladek
	SortCounter  dd 16 DUP (?)


SortMem:
	mov ah,Allocate_Memory
	mov edx,SortMemory
	Int_Eos
	mov [_sortAddress],edx
	lea edi,SortAddress
	mov ecx,16
 ffAdd:	mov [edi],edx
	add edx,SortDrawers*4
	add edi,4
	dec ecx
	jnz ffAdd
	ret

Sort:
	push ebp

	mov esi,[ebp+40] ;adr_to_faces
	mov edx,[ebp+60] ;kopie3d
	mov edi,[ebp+80] ;kolejnosc/sumaZ
	xor ebx,ebx
	mov ecx,[ebp+8]	 ;nof
 SumZ:	
	mov eax,[esi] ;face[1]
	lea eax,[eax*2+eax]
	mov ebp,[edx+eax*4+8]
	sar ebp,4
	mov bx,bp
	mov eax,[esi+4] ;face[2]
	lea eax,[eax*2+eax]
	mov ebp,[edx+eax*4+8]
	sar ebp,4
	add bx,bp
	mov eax,[esi+8] ;face[3]
	lea eax,[eax*2+eax]
	mov ebp,[edx+eax*4+8]
	sar ebp,4
	add bx,bp
	add bx,SortAdd
	mov [edi],ebx
	add edi,4
	add esi,12
	add ebx,010000h
 	dec ecx
	jnz SumZ

	pop ebp

	IRPC roxi,<1234>
	LOCAL BSort,ShiftSort,powZ,puSta

	lea edi,SortCounter
	xor eax,eax
	mov ecx,16
	rep stosd

	mov esi,[ebp+80]
	mov ecx,[ebp+8]
 BSort:	
	lodsd ;suma zeta
	mov ebx,eax
	shr ebx,satan&roxi
	and ebx,0fh
	mov edx,SortCounter[ebx*4]	
	inc SortCounter[ebx*4]
	mov edi,SortAddress[ebx*4]
	mov [edi+edx*4],eax
	dec ecx
	jnz BSort

	lea edx,SortCounter
	mov edi,[ebp+80]
	mov ebx,[_SortAddress]
	AntyClock=15*4
	Kwark=15*SortDrawers*4
	REPT 16
	LOCAL KaPusta ;) z chlebkiem i vodeczka ;)
	lea esi,[ebx+Kwark]
	mov ecx,[edx+AntyClock]
	or ecx,ecx
	jz KaPusta
	rep movsd
 KaPusta:
	AntyClock=AntyClock-4
	Kwark=Kwark-SortDrawers*4
	ENDM

	ENDM

	mov esi,[ebp+80]
	mov edi,esi
	mov ecx,[ebp+8]
 NaGut:	lodsd
	shr eax,16
	stosd
	dec ecx
	jnz NaGut

	ret

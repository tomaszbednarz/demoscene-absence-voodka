

;sortowanie objektow w swiecie wg.ich zet'a (nie RAD|A:)

VirSort:
	lea esi,WorldZet
	lea edi,WorldKol	;kolejnosc/sumaZ
	xor ebx,ebx
	mov ecx,WorldsObjects 	;noobjects
 VirSumZ:	
	mov bx,w [esi]	;zet
	sar bx,4
;;;	add bx,SortAdd
	mov [edi],ebx
	add edi,4
	add esi,4
	add ebx,010000h
 	dec ecx
	jnz VirSumZ


	IRPC roxi2,<1234>
	LOCAL BSort2,ShiftSort2,powZ2,puSta2

	lea edi,SortCounter
	xor eax,eax
	mov ecx,16
	rep stosd

	lea esi,WorldKol
	mov ecx,worldsObjects
 BSort2:	
	lodsd 	;our zet
	mov ebx,eax
	shr ebx,satan&roxi2
	and ebx,0fh
	mov edx,SortCounter[ebx*4]	
	inc SortCounter[ebx*4]
	mov edi,SortAddress[ebx*4]
	mov [edi+edx*4],eax
	dec ecx
	jnz BSort2

	lea edx,SortCounter
	lea edi,WorldKol
	mov ebx,[_SortAddress]
	AntyClock2=15*4
	Kwark2=15*SortDrawers*4
	REPT 16
	LOCAL KaPusta2 ;) z chlebkiem i vodeczka ;)
	lea esi,[ebx+Kwark2]
	mov ecx,[edx+AntyClock2]
	or ecx,ecx
	jz KaPusta2
	rep movsd
 KaPusta2:
	AntyClock2=AntyClock2-4
	Kwark2=Kwark2-SortDrawers*4
	ENDM

	ENDM

	lea esi,WorldKol ;SortKol ;[ebp+80]
	mov edi,esi
	mov ecx,worldsobjects ;[ebp+8]
 NaGut2:
	lodsd
	shr eax,16
	stosd
	dec ecx
	jnz NaGut2

	ret


include ..\inc\sin
comment #
;buildSin / comes from Xtoto
;;; sinus generator - taylor's function in using
;;;	in:	nothing
;;;	out:	sinus table in [_sinus] etc...
_sinus   dd ? 
_cosinus dd ?
buildSin:
	mov ah,Allocate_Memory
	mov edx,64*4*5
	Int_EOS
	mov d [_sinus],edx	
	add edx,64*4
	mov [_cosinus],edx
	xor edi,edi
	xor ecx,ecx
 Sinlp:		
	mov ebx,3373259426  ;pi/2*65536/2
	mov eax,ecx ;x
	mul ebx
	shrd eax,edx,7
	mov esi,eax
	mov ebp, eax ;+x
	mov ebx, 6/2 ;-x^3/3!
	call taylor
	sub ebp,eax
	mov bl,20/2 ;+x^5/5!
	call taylor
	add ebp, eax
	mov bl,42/2 ;-x^7/7!
	call taylor
	sub ebp,eax
	mov bl,72/2 ;+x^9/9!
	call taylor
	add ebp,eax
	mov bl,110/2 ;-x^11/11!
	call taylor
	sub ebp,eax
	mov bl,156/2 ;+x^13/13!
	call taylor
	add ebp, eax
	mov bl,210/2 ;-x^15/15!
	call taylor
	sub ebp,eax
	sar ebp,15 ;sin*32768
	dec ebp
	mov esi,d [_sinus]
	mov [esi+edi*4],ebp		;sin(x)
	mov [esi+edi*4+64*4*4],ebp	;sin(2pi+x)
	neg edi
	mov [esi+edi*4+64*4*2],ebp	;-sin(2pi-x)
	neg ebp
	mov [esi+edi*4+64*4*4],ebp	;-sin(pi+x)
	neg edi
	mov [esi+edi*4+64*4*2],ebp	;-sin(pi+x)
	inc edi
	inc ecx
	cmp ecx,64
	jna Sinlp
	ret
 taylor:
	mul esi
	shrd eax,edx,30
	mul esi
	shrd eax,edx,31
	xor edx,edx
	div ebx
	ret

#
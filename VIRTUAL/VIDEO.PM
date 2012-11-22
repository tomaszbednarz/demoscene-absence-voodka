
; v 1.001

;ShowPicture(rozmx,rozmy,skad) (M)
;Screen0 (m) - zeroing _screen tab :)
;Set13h(m) - holly shit
;Set3h(m) 
;SetPal - ustaw palete
;VSynch - rameczka

ShowPicture MACRO rozmx,rozmy,skad
 LOCAL @qrwa001
	mov esi,[skad]
	mov edi,[_screen]
	mov edx,rozmy
 @qrwa001:
	mov ecx,rozmx
	rep movsb
	add edi,320-rozmx
	dec edx
	jnz @qrwa001
   ENDM

Ekran MACRo
	mov esi,[_screen]
	mov edi,[_0a0000h]
	mov ecx,32000
	rep movsw
   ENDM

Screen0 MACRO
	call VSynch
	mov edi,[_screen]
	xor eax,eax
	mov ecx,16000
	rep stosd
   ENDM

;in:<--esi
SetPal:
	call VSynch
	xor ax,ax
	mov dx,3c8h
	out dx,al
	inc dx
	mov ecx,768
 @spal:
	outsb
	dec ecx
	jnz @spal
	ret
	
VSynch:
	mov dx,03dah
 @vs1:
	in al,dx
	test al,8
	jne @vs1
 @vs2:
	in al,dx
	test al,8
	je @vs2
	ret

Set13h MACRO
	mov ax,13h
	DosInt 10h
    ENDM

Set3h MACRO
	mov ax,3
	DosInt 10h
    ENDM

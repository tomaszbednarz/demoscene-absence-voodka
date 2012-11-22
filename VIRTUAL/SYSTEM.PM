
; v 1.002

;AllocateMemory (m)
;LoadFile (MACRO) - plik(bez offsetu tylko nazwa), adres gdzie siedzi
;Key (MACRO) - czekamy na nacisniecie klawisza for exapm. "Key Escape"
;KeyTo (MACRO) - czekamy na nacisniecie klawisza ze skok.do Main fex.
;Allocate_System - pamiec etc...jednym slowem start systemu :)

AllocateMemoryFree MACRO howMany,where
	mov ah,Allocate_Memory
	mov edx,howMany
	int_eos
	mov [where],edx
	xor eax,eax
	mov edi,edx
	mov ecx,howMany
	rep stosb
   ENDM

AllocateMemory MACRO howMany,where
	mov ah,Allocate_Memory
	mov edx,howMany
	int_eos
	mov [where],edx
   ENDM

LoadFile MACRO plik,adres_do
 LOCAL @duck,@Ubik
	mov ah,Load_internal_file
	mov edx,o @Ubik
	int_eos
	mov [adres_do],eax
	jmp @duck
 @ubik	db plik,0
 @duck:
    ENDM	

KeyTo MACRO klawisz,where
	cmp Key_Map[klawisz],On
	jne where
    ENDM

Key MACRO klawisz
 LOCAL @Arpi
 @arpi:	
	cmp Key_Map[klawisz],On
	jne @arpi
    ENDM

ALIGN 16
_screen dd ?

Allocate_System:
	mov ah,Use_Int_09
	mov bx,On
	int_Eos
	mov ah,Use_Int_08
	mov bx,On
	int_Eos

	mov ah,Allocate_Memory
	mov edx,64000
	int_eos
	mov [_screen],edx

	mov edi,edx
	xor eax,eax
	mov ecx,16000
	rep stosd
	ret


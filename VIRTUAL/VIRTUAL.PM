
_virtualObjects	dd ?

LoadVirtualObjects MACRO plik
	LOCAL get_out,ple
		mov 	ah,Load_internal_file
		mov 	edx,o ple
		int_eos
		mov	[_virtualObjects],eax
		jmp 	get_out
	ple	db 	plik,0
	get_out:
		mov 	ebp,_virtualObjects
		mov	ecx,[ebp]
		xor	edx,edx
	TyleObj:
		push 	ecx ebp edx
		mov	esi,ebp
		add	esi,[ebp+edx+4]
				


		pop 	edx ebp ecx
		add	edx,4
		dec 	ecx
		jnz TyleObj
   ENDM

world label dword
	dd 0, 0,0,0, 0, 0,0,0, 0,0,0, 0,0

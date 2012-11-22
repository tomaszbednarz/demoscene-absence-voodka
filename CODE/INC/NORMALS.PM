
ALIGN 16
xn1 dd ?
yn1 dd ?
zn1 dd ?
xn2 dd ?
yn2 dd ?
zn2 dd ?
xn3 dd ?
yn3 dd ?
zn3 dd ?
v1x dd ?
v1y dd ?
v1z dd ?
v2x dd ?
v2y dd ?
v2z dd ?
v3x dd ?
v3y dd ?
v3z dd ?
floatStack dd ?

calcNormals:
	mov d [AdrNormals1],ebp
	mov d [AdrNormals2],ebp

	mov edi,[ebp+48];normals]
	mov ecx,[ebp+8] ;numberOfFaces]
	mov esi,[ebp+40];Faces]
	mov ebp,[ebp+36];Vertexes]
 LiczNorm:
	mov d [NormalneECX],ecx

	mov eax,[esi]	;face[0]
	lea eax,[eax*2+eax]
	mov ebx,[ebp+eax*4] ;x1
	mov xn1,ebx
	mov ebx,[ebp+eax*4+4] ;y1
	mov yn1,ebx
	mov ebx,[ebp+eax*4+8] ;z1
	mov zn1,ebx
	mov eax,[esi+4]
	lea eax,[eax*2+eax]
	mov ebx,[ebp+eax*4] ;x2
	mov xn2,ebx
	mov ebx,[ebp+eax*4+4] ;y2
	mov yn2,ebx
	mov ebx,[ebp+eax*4+8] ;z2
	mov zn2,ebx
	mov eax,[esi+8]
	lea eax,[eax*2+eax]
	mov ebx,[ebp+eax*4] ;x3
	mov xn3,ebx
	mov ebx,[ebp+eax*4+4] ;y3
	mov yn3,ebx
	mov ebx,[ebp+eax*4+8] ;z3
	mov zn3,ebx

	mov eax,xn2
	sub eax,xn1
	mov v1x,eax
	mov eax,yn2
	sub eax,yn1
	mov v1y,eax
	mov eax,zn2
	sub eax,zn1
	mov v1z,eax
	mov eax,xn3
	sub eax,xn1
	mov v2x,eax
	mov eax,yn3
	sub eax,yn1
	mov v2y,eax
	mov eax,zn3
	sub eax,zn1
	mov v2z,eax

	; norX=v1y*v2z-v1z*v2y
	mov eax,v1y
	imul eax,v2z
	mov ebx,v1z
	imul ebx,v2y
	sub eax,ebx
	mov [edi],eax
	; norY=-(v1x*v2z-v1z*v2x)=v1z*v2x-v1x*v2z
	mov eax,v1z
	imul eax,v2x
	mov ebx,v1x
	imul ebx,v2z
	sub eax,ebx
	mov [edi+4],eax
	; norZ=v1x*v2y-v1y*v2x
	mov eax,v1x
	imul eax,v2y
	mov ebx,v1y
	imul ebx,v2x
	sub eax,ebx
	mov [edi+8],eax

	push esi
	mov esi,o floatStack
	fild d [edi]
	fimul d [edi] ;st(0)=norX*norX
	fild d [edi+4]
	fimul d [edi+4] ;st(1)=norY*norY
	fadd st(0),st(1) ;st(0)=(norX*norX)+(norY*norY)
	fild d [edi+8]
	fimul d [edi+8] ;st(0)=norZ*norZ
	fadd st(0),st(1) ;st(0)=(nX*nX)+(nY*nY)+(nZ*nZ)
	fsqrt	;sqrt(st)
	fistp d [esi]	
	fstp st
	fstp st
	pop esi	
	mov ebx,d [FloatStack]

	or ebx,ebx
	jne PlePlePle
	mov d [edi],0
	mov d [edi],0
	mov d [edi],0
	jmp plepleple2
 plepleple:
	mov eax,[edi] ;norX
	imul eax,250
	cdq
;	shld eax,edx,8
	idiv ebx
	mov [edi],eax
	mov eax,[edi+4] ;norY
	imul eax,250
	cdq
;	shld eax,edx,8
	idiv ebx
	mov [edi+4],eax
	mov eax,[edi+8] ;norZ
	imul eax,250
	cdq
;	shld eax,edx,8
	idiv ebx
	mov [edi+8],eax
 plepleple2:
	add esi,12
	add edi,12
	mov ecx,00010001h
	NormalneECX=$-4
	dec ecx
	jnz LiczNorm	

	mov ebp,00010001h
	AdrNormals1=$-4	
	mov edi,[ebp+60]
	mov ecx,[ebp+4]
	xor eax,eax
	rep stosd
	mov edi,[ebp+wersory]
	mov ecx,[ebp+4]
	lea ecx,[ecx*2+ecx]
	xor eax,eax
	rep stosd
	mov esi,[ebp+normals]
	mov edi,[ebp+wersory]
	mov edx,[ebp+60] ;copy vertex
 	mov ecx,[ebp+numberOffaces]
	mov ebp,[ebp+Faces]
 ZliczNormalne:
	mov eax,[ebp]
	inc d [edx+eax*4]
	lea eax,[eax*2+eax]
	mov ebx,[esi] ;normalx
	add [edi+eax*4],ebx
	mov ebx,[esi+4] ;normaly
	add [edi+eax*4+4],ebx
	mov ebx,[esi+8] ;normalz
	add [edi+eax*4+8],ebx
	mov eax,[ebp+4]
	inc d [edx+eax*4]
	lea eax,[eax*2+eax]
	mov ebx,[esi] ;normalx
	add [edi+eax*4],ebx
	mov ebx,[esi+4] ;normaly
	add [edi+eax*4+4],ebx
	mov ebx,[esi+8] ;normalz
	add [edi+eax*4+8],ebx
	mov eax,[ebp+8]
	inc d [edx+eax*4]
	lea eax,[eax*2+eax]
	mov ebx,[esi] ;normalx
	add [edi+eax*4],ebx
	mov ebx,[esi+4] ;normaly
	add [edi+eax*4+4],ebx
	mov ebx,[esi+8] ;normalz
	add [edi+eax*4+8],ebx
	add ebp,12
	add esi,12
	dec ecx
	jnz ZliczNormalne	

	mov ebp,00010001h
	AdrNormals2=$-4
	mov esi,[ebp+wersory]
	mov edi,[ebp+60]
	mov ecx,[ebp+4]
 dizie:
	mov ebx,[edi]
	or ebx,ebx
	jnz dizio
	mov d [esi],0
	mov d [esi+4],0
	mov d [esi+8],0
	jmp diziomo
 dizio:
	mov eax,[esi]
	cdq
	idiv ebx
	mov [esi],eax
	mov eax,[esi+4]
	cdq
	idiv ebx
	mov [esi+4],eax
	mov eax,[esi+8]
	cdq
	idiv ebx
	mov [esi+8],eax
 diziomo:
	add esi,12
	add edi,4
	loop dizie
	ret

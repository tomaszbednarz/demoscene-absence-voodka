
	angleX	dd 0
	angleY	dd 0
	angleZ	dd 0

PrepareRotationMatrix:
	push edx

	mov eax,angleX
	and eax,03ffh
	mov ebx,[sin+eax*4]
	mov sin1,ebx
	add eax,256
	and eax,03ffh
	mov ebx,[sin+eax*4]
	mov cos1,ebx

	mov eax,angleY
	and eax,03ffh
	mov ebx,[sin+eax*4]
	mov sin2,ebx
	add eax,256
	and eax,03ffh
	mov ebx,[sin+eax*4]
	mov cos2,ebx

	mov eax,angleZ
	and eax,03ffh
	mov ebx,[sin+eax*4]
	mov sin3,ebx
	add eax,256
	and eax,03ffh
	mov ebx,[sin+eax*4]
	mov cos3,ebx
	mov eax,cos3

	imul [cos2]
	shrd eax,edx,15
	mov [matrix],eax
	mov eax,sin2
	neg eax
	mov [matrix+24],eax
	mov eax,sin3
	imul [cos2]
	shrd eax,edx,15
	mov [matrix+12],eax
	mov eax,sin3
	imul [cos1]
	shrd eax,edx,15
	mov s3c1,eax
	mov eax,sin3
	imul [sin1]
	shrd eax,edx,15
	mov s3s1,eax
	mov eax,cos3
	imul [sin2]
	shrd eax,edx,15
	mov c3s2,eax
	imul [sin1]
	shrd eax,edx,15
	neg eax
	sub eax,s3c1
	mov [matrix+4],eax
	mov eax,c3s2
	imul [cos1]
	shrd eax,edx,15
	sub eax,s3s1
	mov [matrix+8],eax
	mov eax,s3s1
	imul [sin2]
	shrd eax,edx,15
	mov ebx,eax
	mov eax,cos3
	imul [cos1]
	shrd eax,edx,15
	sub eax,ebx
	mov [matrix+16],eax
	mov eax,cos2
	imul [sin1]
	shrd eax,edx,15
	neg eax
	mov [matrix+28],eax
	mov eax,cos2
	imul [cos1]
	shrd eax,edx,15
	mov [matrix+32],eax
	mov eax,s3c1
	imul [sin2]
	shrd eax,edx,15
	mov ebx,eax
	mov eax,cos3
	imul [sin1]
	shrd eax,edx,15
	add eax,ebx
	mov [matrix+20],eax		
	mov eax,[matrix]
	imul [matrix+4]
	mov ab1,eax
	mov eax,[matrix+12]
	imul eax,[matrix+16]
	mov ab2,eax
	mov eax,[matrix+24]
	imul [matrix+28]
	mov ab3,eax
	pop edx
	ret

mrotate:
	push ebp edx
 rotloop:
	mov eax,[esi]
	mov ebx,[esi+4]
	imul ebx
	mov xy,eax	;next constant:) per 3d-point!
	mov eax,[esi]
	mov ebx,[esi+4]
	add eax,[matrix+4]
	add ebx,[matrix]
	imul ebx
	sub eax,xy
	sub eax,ab1
	sar eax,15
	mov ebx,eax
	mov eax,[esi+8]
	imul eax,[matrix+8]
	sar eax,15
	add ebx,eax	;==>xr
	mov eax,[esi]
	mov ebp,[esi+4]
	add eax,[matrix+16]
	add ebp,[matrix+12]
	imul ebp
	sub eax,xy
	sub eax,ab2
	sar eax,15
	mov ebp,eax
	mov eax, [esi+8]
	imul eax,[matrix+20]
	sar eax,15
	add ebp,eax ;==>yr
	mov eax, [esi]
	mov edi, [esi+4]
	add eax,[matrix+28]
	add edi,[matrix+24]
	imul edi
	sub eax,xy
	sub eax,ab3
	sar eax,15
	mov edi,eax
	mov eax,[esi+8]
	imul eax,[matrix+32]
	sar eax,15
	add edi,eax ;==>zr
        mov [esi],ebx
	mov [esi+4],ebp
	mov [esi+8],edi
	add esi,12
	loop rotloop		
	pop edx ebp
	ret

mrotateNormals:
	push ebp edx
 rotloop2:
	mov eax,[esi]
	mov ebx,[esi+4]
	imul ebx
	mov xy,eax	;next constant:) per 3d-point!
	mov eax,[esi]
	mov ebx,[esi+4]
	add eax,[matrix+4]
	add ebx,[matrix]
	imul ebx
	sub eax,xy
	sub eax,ab1
	sar eax,15
	mov ebx,eax
	mov eax,[esi+8]
	imul eax,[matrix+8]
	sar eax,15
	add ebx,eax	;==>xr
	mov eax,[esi]
	mov ebp,[esi+4]
	add eax,[matrix+16]
	add ebp,[matrix+12]
	imul ebp
	sub eax,xy
	sub eax,ab2
	sar eax,15
	mov ebp,eax
	mov eax, [esi+8]
	imul eax,[matrix+20]
	sar eax,15
	add ebp,eax ;==>yr
        mov [esi],ebx
	mov [esi+4],ebp
	add esi,12
	loop rotloop2
	pop edx ebp
	ret

	;revolt's variables suxx
	matrix label dword
	dd 9 DUP (?)	;  c3c2  -s3c1-c3s2s1  -s3s1+c3s2c1
		    	;  s3c2   c3c1-s3s2s1   c3s1+s3s2c1
		    	;   -s2     -c2s1          c2c1
	xy	dd ?
	s3c1	dd ?
	c3s2	dd ?
	s3s1	dd ?
	IRPC	roxi,<123>
	sin&roxi 	dd ?
	cos&roxi	dd ?
	ab&roxi		dd ?
	ENDM


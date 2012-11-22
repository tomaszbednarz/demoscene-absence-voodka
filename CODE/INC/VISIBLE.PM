
visible db 0            ; 1 = true      0 = false
isVisible:
          mov visible,0
          mov ax,w [Y_2]
          sub ax,w [Y_1]
          mov bx,w [X_3]
          sub bx,w [X_1]
          imul ax,bx
          mov cx,ax
          mov ax,w [Y_3]
          sub ax,w [Y_1]
          mov bx,w [X_2]
          sub bx,w [X_1]
          imul ax,bx
          sub cx,ax
          neg cx
          js noVis
          mov visible,1
	  ret
  noVis:  ret



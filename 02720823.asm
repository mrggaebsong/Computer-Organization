<<<<<<< HEAD
.model  tiny

		.data			
		line	dw	0		; Line count
		y     	db  0		; y number
		x  		db  0		; x number

        .code
        org     0100h

main:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		
;;;;;;;;;;;; PATTERN1 ;;;;;;;;;;;;;;;;;

LP1:    mov     dx, 0		; dx = 0	;PATTERN1
		mov 	ax, line	; ax = 0
		and 	ax, 1  		; mod 2
		cmp		ax, 0 		; check mod value
		je		LP11		; if(ax==0){jump to LP11}
		jmp     LP12		; else{jump to LP12}
	
LP11:	mov     x, 0		; x = 0
		inc		line 		; line++
		cmp		line, 26	; check line count
		jl		LP21 		; if(line<26){jump to LP21}
		jmp     EXIT1		; else{jump to EXIT1}

LP12:	mov     x, 79		; x = 79
		inc		line		; line++
		cmp		line, 26	; check line count
		jl		LP22		; if(line<26){jump to LP22}
		jmp     EXIT1		; else{jump to EXIT1}
	
LP21:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write a char
        mov     al, 79      ; write 'a' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h

		inc 	x			; x++
		cmp		x, 79		; check x
		jle		LP21		; if(x<=79){jump to LP21}
		inc     y			; y++
		jmp     LP1			; jump to LP1

LP22:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79		; write 'O' (ASCII)  
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
		
		dec     x 			; x--
		cmp		x, -1		; check x
		jne		LP22		; if(x>-1){jump to LP22}
		inc     y			; y++
		jmp     LP1			; jump to LP1
	
EXIT1:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		
		mov		y, 24
		mov		x, 79
		mov     dh, y  		; dh = y
		mov     dl, x 		; dl = x
		mov		line, 0		; line = 0	; reset

;;;;;;;;;;;; PATTERN2 ;;;;;;;;;;;;;;;;;

LP3:    mov		dx, 0			; PATTERN2
		mov 	ax, line
		and 	ax, 1  		; mod 2
		cmp		ax, 0 			; check mod answer
		je		LP32
		jmp     LP31
	
LP31:	mov     x, 0		; check line 1st case
		inc		line
		cmp		line, 26
		jl		LP41
		jmp     EXIT2

LP32:	mov     x, 79		; check line 2nd case
		inc		line
		cmp		line, 26
		jl		LP42
		jmp     EXIT2
	
LP41:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h

		inc 	x
		cmp		x, 79		; check x
		jle		LP41		; x loop
		dec     y	
		jmp     LP3

LP42:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
	
		dec     x
		cmp		x, -1		; check x
		jne		LP42		; x loop
		dec     y
		jmp     LP3
	
EXIT2:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		mov		y, 24
		mov		x, 0
		mov     dh, y  
        mov     dl, x
		mov		line, 0		; reset
	
;;;;;;;;;;;; PATTERN3 ;;;;;;;;;;;;;;;;;

LP5:    mov		dx, 0			; PATTERN3
		mov 	ax, line
		and 	ax, 1  		; mod 2
		cmp		ax, 0 		; check mod answer
		je		LP52
		jmp     LP51
	
LP51:	mov     y, 0		; check line 1st case
		inc		line 	
		cmp		line, 81
		jl		LP61 		
		jmp     EXIT3

LP52:	mov     y, 24		; check line 2nd case
		inc		line
		cmp		line, 81
		jl		LP62
		jmp     EXIT3
	
LP61:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		

		inc 	y
		cmp		y, 24		; check y
		jle		LP61		; y loop
		inc     x	
		jmp     LP5

LP62:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
		
		dec     y 		
		cmp		y, -1		; check y
		jne		LP62		; y loop
		inc     x
		jmp     LP5
	
EXIT3:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		mov		y, 0
		mov		x, 79
		mov     dh, y  		; dh = y
		mov     dl, x 		; dl = x
		mov		line, 0		; reset
		
	
;;;;;;;;;;;; PATTERN4 ;;;;;;;;;;;;;;;;;

LP7:    mov		dx, 0			; PATTERN4
		mov 	ax, line
		and 	ax, 1  		; mod 2
		cmp		ax, 0 		; check mod answer
		je		LP71
		jmp     LP72
	
LP71:	mov     y, 0		; check line 1st case
		inc		line
		cmp		line, 81
		jl		LP81 
		jmp     EXIT4

LP72:	mov     y, 24		; check line 2nd case
		inc		line
		cmp		line, 81
		jl		LP82
		jmp     EXIT4
	
LP81:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		

		inc 	y
		cmp		y, 24		; check y
		jle		LP81		; y loop
		dec     x	
		jmp     LP7

LP82:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
		mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
		
		dec     y
		cmp		y, -1		; check y
		jne		LP82		; y loop
		dec     x
		jmp     LP7
	
EXIT4:	mov     ah, 00h     ; Set to 80x25
        mov     al, 03h
        int     10h

		ret
		end	main
=======
.model  tiny

		.data			
		line	dw	0		; Line count
		y     	db  0		; y number
		x  		db  0		; x number

        .code
        org     0100h

main:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		
;;;;;;;;;;;; PATTERN1 ;;;;;;;;;;;;;;;;;

LP1:    mov     dx, 0		; dx = 0	;PATTERN1
		mov 	ax, line	; ax = 0
		and 	ax, 1  		; mod 2
		cmp		ax, 0 		; check mod value
		je		LP11		; if(ax==0){jump to LP11}
		jmp     LP12		; else{jump to LP12}
	
LP11:	mov     x, 0		; x = 0
		inc		line 		; line++
		cmp		line, 26	; check line count
		jl		LP21 		; if(line<26){jump to LP21}
		jmp     EXIT1		; else{jump to EXIT1}

LP12:	mov     x, 79		; x = 79
		inc		line		; line++
		cmp		line, 26	; check line count
		jl		LP22		; if(line<26){jump to LP22}
		jmp     EXIT1		; else{jump to EXIT1}
	
LP21:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write a char
        mov     al, 79      ; write 'a' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h

		inc 	x			; x++
		cmp		x, 79		; check x
		jle		LP21		; if(x<=79){jump to LP21}
		inc     y			; y++
		jmp     LP1			; jump to LP1

LP22:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79		; write 'O' (ASCII)  
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
		
		dec     x 			; x--
		cmp		x, -1		; check x
		jne		LP22		; if(x>-1){jump to LP22}
		inc     y			; y++
		jmp     LP1			; jump to LP1
	
EXIT1:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		
		mov		y, 24
		mov		x, 79
		mov     dh, y  		; dh = y
		mov     dl, x 		; dl = x
		mov		line, 0		; line = 0	; reset

;;;;;;;;;;;; PATTERN2 ;;;;;;;;;;;;;;;;;

LP3:    mov		dx, 0			; PATTERN2
		mov 	ax, line
		and 	ax, 1  		; mod 2
		cmp		ax, 0 			; check mod answer
		je		LP32
		jmp     LP31
	
LP31:	mov     x, 0		; check line 1st case
		inc		line
		cmp		line, 26
		jl		LP41
		jmp     EXIT2

LP32:	mov     x, 79		; check line 2nd case
		inc		line
		cmp		line, 26
		jl		LP42
		jmp     EXIT2
	
LP41:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h

		inc 	x
		cmp		x, 79		; check x
		jle		LP41		; x loop
		dec     y	
		jmp     LP3

LP42:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
	
		dec     x
		cmp		x, -1		; check x
		jne		LP42		; x loop
		dec     y
		jmp     LP3
	
EXIT2:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		mov		y, 24
		mov		x, 0
		mov     dh, y  
        mov     dl, x
		mov		line, 0		; reset
	
;;;;;;;;;;;; PATTERN3 ;;;;;;;;;;;;;;;;;

LP5:    mov		dx, 0			; PATTERN3
		mov 	ax, line
		and 	ax, 1  		; mod 2
		cmp		ax, 0 		; check mod answer
		je		LP52
		jmp     LP51
	
LP51:	mov     y, 0		; check line 1st case
		inc		line 	
		cmp		line, 81
		jl		LP61 		
		jmp     EXIT3

LP52:	mov     y, 24		; check line 2nd case
		inc		line
		cmp		line, 81
		jl		LP62
		jmp     EXIT3
	
LP61:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		

		inc 	y
		cmp		y, 24		; check y
		jle		LP61		; y loop
		inc     x	
		jmp     LP5

LP62:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
		
		dec     y 		
		cmp		y, -1		; check y
		jne		LP62		; y loop
		inc     x
		jmp     LP5
	
EXIT3:	mov		ah, 06h    	; Scroll up function
		xor		al, al     	; Clear entire screen
		xor		cx, cx     	; Upper left corner CH=y, CL=x
		mov		dx, 184fh  	; lower right corner DH=y, DL=x 
		mov		bh, 1Eh    	; Yellow on Blue
		int		10h
		mov		y, 0
		mov		x, 79
		mov     dh, y  		; dh = y
		mov     dl, x 		; dl = x
		mov		line, 0		; reset
		
	
;;;;;;;;;;;; PATTERN4 ;;;;;;;;;;;;;;;;;

LP7:    mov		dx, 0			; PATTERN4
		mov 	ax, line
		and 	ax, 1  		; mod 2
		cmp		ax, 0 		; check mod answer
		je		LP71
		jmp     LP72
	
LP71:	mov     y, 0		; check line 1st case
		inc		line
		cmp		line, 81
		jl		LP81 
		jmp     EXIT4

LP72:	mov     y, 24		; check line 2nd case
		inc		line
		cmp		line, 81
		jl		LP82
		jmp     EXIT4
	
LP81:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
        mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		

		inc 	y
		cmp		y, 24		; check y
		jle		LP81		; y loop
		dec     x	
		jmp     LP7

LP82:	mov     ah, 02h     ; Move cursor XY
        mov     bh, 00h
		mov     dh, y
		mov     dl, x
        int     10h
	
		mov     ah, 0Ah     ; Write O char
		mov     al, 79      ; write 'O' (ASCII)   
		mov     cx, 1
        mov     bh, 00h
        int     10h

		mov     cx, 00h		; delay
		mov     dx, 4240h
		mov     ah, 86h
		int     15h		
		
		dec     y
		cmp		y, -1		; check y
		jne		LP82		; y loop
		dec     x
		jmp     LP7
	
EXIT4:	mov     ah, 00h     ; Set to 80x25
        mov     al, 03h
        int     10h

		ret
		end	main
>>>>>>> 32cbb69def7cb336c8167e1e9e6dabf28348aa4e
		exit
    .model  tiny

    .data
HeadCol		db 	-8, -6, -33, -76, -21, -20, -65, -2, -35, -47, -71, -80, -55, -39, -73, -28, -44, -46, -61, -77, -69, -60, -16, -9, -64, -4, -12, -36, -57, -10, -75, -79, -40, -22, -17, -14, -78, -67, -48, -34, -26, -15, -52, -5, -18, -27, -19, -59, -63, -41, -58, -72, -45, -51, -54, -68, -53, -38, -74, 0, -56, -43, -31, -23, -70, -32, -24, -30, -13, -49, -66, -11, -3, -37, -7, -29, -1, -42, -62, -50	; random the head numbers in each x from generator
j			dw	0				; counter
rnum		db	0				; random number
char		db  0				; character (ASCII)
y			db	0				; y number
x  			db  0				; x number
color		db	0				; color number
count		db	0				; position of matrix rain's colors

    .code
	org     0100h

main:   
	mov     ah, 00h         	; set to 80x25
	mov     al, 03h
    int     10h

	push    ax              	; random number with Ticks of the Day
    mov     ah, 00h
    int     1Ah
    pop     ax
	mov		rnum, dl
		
CheckCol:						; check x (x range 0 to 79)
	mov		y, 0
	mov		count, 0
	mov		j, 0
	cmp		x, 80
	jl		CheckHeadCol
	mov		x, 0
	jmp		IncHeadCol

CheckHeadCol:					; check head of matrix rain in each x >= 0
	mov		cl, x
	mov		ch, 00h
	mov		di, cx
	cmp		HeadCol[di], 0
	jge		MoveCursor
	inc		x
	jmp		CheckCol
	
IncHeadCol:						; increase head of matrix rain in each x if it's less than 35
	cmp		j, 80
	jae		CheckCol
	mov		di, j
	inc		HeadCol[di]
	cmp		HeadCol[di], 35
	jge		ResetHeadCol
	inc		j
	jmp		IncHeadCol

ResetHeadCol:					; reset head of matrix rain in each x to 0 if it's 35 or more
	mov		di, j
	mov		HeadCol[di], 0
	inc		j
	jmp		IncHeadCol
	
delay:							; delay
	mov     cx, 00h			
	mov     dx, 01h
	mov     ah, 86h
	int     15h
	
	inc		x
	jmp		CheckCol

MoveCursor:						; move cursor XY
	mov		cl, x
	mov		ch, 00h
	mov		di, cx
	mov		cl, HeadCol[di]
	cmp		y, cl
	jg		delay
	
	mov     ah, 02h         	
    mov     bx, 00h
	mov     dh, y
	mov     dl, x
    int     10h
	
	mov		cl, x
	mov		ch, 00h
	mov		di, cx
	mov		cl, HeadCol[di]
	mov		count, cl
	mov		cl, y
	sub		count, cl
	jmp		SetColor

SetColor:						; jump to set color label due to count
	cmp		count, 0
	je		SetWhite
	cmp		count, 2
	jle		SetLightGreen
	cmp		count, 7
	jle		SetGreen
	cmp		count, 8
	je		SetLightGray
	cmp		count, 9
	je		SetDarkGray
	jmp		SetBlack
	

SetWhite:						; set color to white
	mov		color, 0Fh
	jmp		Print

SetLightGreen:					; set color to light green
	mov		color, 0Ah
	jmp		Print

SetGreen:						; set color to green
	mov		color, 02h
	jmp		Print

SetLightGray:					; set color to light gray
	mov		color, 07h
	jmp		Print

SetDarkGray:					; set color to dark gray
	mov		color, 08h
	jmp		Print

SetBlack:						; set color to black
	mov		color, 00h
	jmp		Print

Print:							; print character at cursor position
	mov     ah, 00h 
    mov     al, rnum 

    mov     cx, 95           	; linear congruent generator 
    mul     cx 
    add     ax, 17 

    mov     cx, 94           	; mod 94 
    xor     dx, dx 
    div     cx 

    mov     rnum, dl 
    mov     ah,rnum 
    add     ah,33            	;random number between 33-126
	mov		char, ah
	
	mov     ah, 09h         	; write a char
    mov     al, char			; write random character (ASCII)  
    mov     bh, 00h
	mov     bl, color
	mov     cx, 1
    int     10h

	inc		y
	jmp		MoveCursor
	
	ret
	
	end main
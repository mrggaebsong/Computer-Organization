		.model tiny
		
		.data
	
	; INTRO MENU		
	str1 db "                         AAAAAA  b      cccccc$", 0
	str2 db "                         AA  AA  bbbbb  cc$", 0
	str3 db "                         AAAAAA  b   b  cc$", 0
	str4 db "                         AA  AA  bbbbb  cccccc$", 0
	str_en db "                                                                     $", 0
	str5 db "          M   M   AAAAA  TTTTTT  RRRR   IIIIII  XX  XX$", 0
	str6 db "          MM MM   A   A    TT    R   R    II      XX$", 0
	str7 db "          M M M   AAAAA    TT    RRRR     II      XX      ooo$", 0
	str8 db "          M   M   A   A    TT    R   R  IIIIII  XX  XX    ooo$", 0
	str9 db "=======================================================================$", 0
	str_menu db "Select Game Mode >>$", 0
	str_easy db "	Mode 1: EASY$", 0
	str_med db "	Mode 2: MEDIUM$", 0
	str_hard db "	Mode 3: HARD$", 0
	str_esc db "Or press ESC to EXIT$", 0
	
	.code
	org		0100h

main:
	mov ah,00h
    mov al,03h
    int 10h

    call intro

    mov ah,00h
    mov al,03h
    int 10h

	
intro:
 

	mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,3
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str1[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,4
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str2[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,5
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str3[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,6
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str4[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,7
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str_en[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,8
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str5[0]
    int 21h
	
	mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,9
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str6[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,10
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str7[0]
    int 21h
	
	mov ah,02h
	mov bl,0Bh
	mov bh,00h
	mov dh,11
	mov dl,3
	int 10h
	
	mov ah, 09h
	mov dx, offset str8[0]
	int 21h
	
	mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,12
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str_en[0]
    int 21h
	
	mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,13
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset str9[0]
    int 21h
	
	mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,15
	mov dl,15
	int 10h

	mov ah, 09h
    mov dx, offset str_menu[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,17
	mov dl,20
	int 10h

    mov ah, 09h
    mov dx, offset str_easy[0]
    int 21h

    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,19
	mov dl,20
	int 10h

    mov ah, 09h
    mov dx, offset str_med[0]
    int 21h
     
     
    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,21
	mov dl,20
	int 10h
    
    mov ah, 09h
    mov dx, offset str_hard[0]
    int 21h

   
    mov ah,02h
    mov bl,0Bh
	mov bh,00h
	mov dh,23
	mov dl,15
	int 10h

	mov ah, 09h
    mov dx, offset str_esc[0]
    int 21h


    ret
	end main
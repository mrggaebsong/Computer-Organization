		.model tiny
		.data
		
		;GAME OVER
		end1 db "GGGGGG  AAAAAAA  MM     MM  EEEEE      OOOOOO  VV   VV  EEEEE  RRRRRR$", 0
		end2 db "GG      AA   AA  MMM   MMM  EE         OO  OO  VV   VV  EE     RR   R$", 0
		end3 db "GG  GG  AAAAAAA  MM MMM MM  EEEEE      OO  OO  VV   VV  EEEEE  RRRRRR$", 0
		end4 db "GG   G  AA   AA  MM  M  MM  EE         OO  OO   VV VV   EE     RR  R$", 0
		end5 db "GGGGGG  AA   AA  MM     MM  EEEEE      OOOOOO    VVV    EEEEE  RR  RR$", 0
		end6 db "See you next game...$", 0
		
		.code
		org	0100h
		
main:
	mov ah,00h
    mov al,03h
    int 10h

    call gameover

    mov ah,00h
    mov al,03h
    int 10h
	
gameover:
	mov ah,00h
    mov al,03h
    int 10h

    mov ah,02h
	mov bh,00h
	mov dh,4
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset end1[0]
    int 21h

    mov ah,02h
	mov bh,00h
	mov dh,5
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset end2[0]
    int 21h

    mov ah,02h
	mov bh,00h
	mov dh,6
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset end3[0]
    int 21h

     mov ah,02h
	mov bh,00h
	mov dh,7
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset end4[0]
    int 21h

     mov ah,02h
	mov bh,00h
	mov dh,8
	mov dl,3
	int 10h

	mov ah, 09h
    mov dx, offset end5[0]
    int 21h
	
	mov ah,02h
	mov bh,00h
	mov dh,15
	mov dl,15
	int 10h
	
	mov ah,09h
	mov dx, offset end6[0]
	int 21h

 
	
	ret
	end main
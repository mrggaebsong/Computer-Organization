    .model tiny

    .data

    char db 0
    position_y db 0                 ; for random axis y 
    position_x db 0                 ; for random axis x
    check db 0


    left db 61h         ;charater is 'a'
	right db 64h		;charater is 'd'
	shoot db 20h
	position db 38		;position of ship

	bullet_position db 17h
	bullet_position_mid db 00h
	bullet_char db 00f8h
	bullet_status db 0

	life_point dw 9

	cls_ship db 0

    count_possition db 0

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
	str_easy db "	Mode A: EASY$", 0
	str_med db "	Mode B: MEDIUM$", 0
	str_hard db "	Mode C: HARD$", 0
	str_esc db "Or press ESC to EXIT$", 0

	;GAME OVER
	end1 db "GGGGGG  AAAAAAA  MM     MM  EEEEE      OOOOOO  VV   VV  EEEEE  RRRRRR$", 0
	end2 db "GG      AA   AA  MMM   MMM  EE         OO  OO  VV   VV  EE     RR   R$", 0
	end3 db "GG  GG  AAAAAAA  MM MMM MM  EEEEE      OO  OO  VV   VV  EEEEE  RRRRRR$", 0
	end4 db "GG   G  AA   AA  MM  M  MM  EE         OO  OO   VV VV   EE     RR  R$", 0
	end5 db "GGGGGG  AA   AA  MM     MM  EEEEE      OOOOOO    VVV    EEEEE  RR  RR$", 0
	end6 db "See you next game...$", 0

	
	;intro song
	delaytime   dw  0 ; keep added time for check with current time
	delayselect db  0 ; keep delay from user input


	MIDI_CONTROL_PORT dw 0331h
    MIDI_DATA_PORT dw 0330h
    MIDI_UART_MODE db 3Fh
    MIDI_PIANO_INSTRUMENT db 93h
    delaynote dw ?
    .code

    org 0100h



main:
    
    mov ah ,0h		                ;text mode
	mov al ,3h
	int 10h

	call intro
	call music_intro
	mov ah,00h                       ;input control 
    int 16h


	cmp al,1bh                      
    je doExitExitExit

	cmp al,61h                       
    je init_main
	
	cmp al,62h                       
    je init_main

	cmp al,63h                       
    je init_main
	

no_a_b_c:
	jmp main

doExitExitExit:
    jmp doExitExit

init_main:

	mov ah ,0h		                ;text mode
	mov al ,3h
	int 10h
	
 	mov si,0
    call draw_ship


random_y:

    push ax
    mov ah,00h                      ; interrupts to get system time    
    int 1ah                         ; CX:DX now hold number of clock ticks since midnight
    pop ax                          ; CX:DX now hold number of clock ticks since midnight

    mov  ax, dx
    xor  dx, dx
    mov  cx, 80   
    div  cx                         ; here dx contains the remainder of the division - from 0 to 9
    ;add  dl,'0'                    ; to ascii from '0' to '9'
    mov position_y,dl
    ret

loop_1:

    mov si,0

    mov ah,02h           			;Set cursor position	
	mov bh,00h
	mov bl,0eh
	mov dh,18h         	 			;row
	mov dl,00h		 	 			;colum
	int 10h

	mov ah,09h
	mov cx,9
	mov bl,00h
	mov al,00h               		; erase red <3 
	int 10h

    mov ah,09h
	mov cx,life_point	
	mov bl,0ch
	mov al,03h               		; print red <3 
	int 10h

random_char:

    push ax
    mov ah,00h                      ; interrupts to get system time    
    int 1ah                         ; CX:DX now hold number of clock ticks since midnight
    pop ax

    mov  ax, dx
    xor  dx, dx
    mov  cx, 122   
    div  cx                         ; here dx contains the remainder of the division - from 0 to 9
    add  dl,'0'                     ; to ascii from '0' to '9'
    cmp dl,char
    je random_char
    mov char,dl
    inc si

    cmp life_point,0
    je doExitExitExit

input:
    
    mov ah,1h                       ;input control 
    int 16h

    jz print
    
    cmp al,1bh                      ;go doExit when ah = esc
    je doExitExitExit

    mov ah,00h          		    ;input control shit
    int 16h

	mov cls_ship,00h    		    ; cls_ship = 0

	cmp al,left        		        ;if input  == a
	je _left
		
	cmp al,right        		    ;if input  == d jump
	je _right

	cmp al,shoot        		    ;if input  == spacebar jump
	je init_shoot_0

    xor ax,ax
    int 16h


print:

    mov ah,02h              ;Set cursor position	
	mov bh,00h
	mov dh,position_x       ;row
	mov dl,position_y		;colum
	int 10h
	
	
    mov ah,09h
	mov cx,1	
	mov bl,0fh
	mov al,char             ; print char
	int 10h

    mov ah,position_x
    mov check,ah

    jmp print_2



_left:

	cmp position,00h  			;check this position is 0 ?
	je _left_0

	dec position
	jmp draw_ship

_left_0:
	mov position,00h
	jmp random_char

random_char_char:
    jmp random_char
	

_right:
	cmp position,4ah  			;check this position is 79 ?
	je _right_0

	inc position
	jmp draw_ship

_right_0:
	mov position,4ah
	jmp random_char


init_shoot_0:
    jmp init_shoot

random_char_char_char:
	jmp random_char_char	
	
	
print_2:
	
	
    mov ah,02h              ;Set cursor position	
	mov bh,0000h

    dec check               ; check += 6 for erase tail
    dec check               ; I AM THE BEST ;)
    call print_gray
    dec check
    call print_gray
    dec check
    call print_green
    dec check
    call print_green
    dec check

	mov dh,check            ;row
	mov dl,position_y		;colum
	int 10h

    mov ah,09h
	mov cx,1	
	mov bl,00h
	mov al,char             ; print the black bullet for clear
	int 10h

    inc position_x
    mov dl,position_x
    cmp dl,31
    jl random_char_char_char


erase:

    inc check

    mov ah,02h                  ;Set cursor position	
	mov bh,00h
	mov dh,check                ;row
	mov dl,position_y    		;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,00h
	mov al,00h                  ; print the black bullet
	int 10h
    

    mov al,check
    cmp al,position_x               ;tasm matrix.asm
    jl erase                        ;tlink matrix.obj \t
                                    ;matrix.com
    mov position_x,0

    dec life_point

    call random_y

    jmp loop_1

erase_0:

	inc check

    mov ah,02h                  ;Set cursor position	
	mov bh,00h
	mov dh,check                ;row
	mov dl,position_y    		;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,00h
	mov al,00h                  ; print the black bullet
	int 10h
    

    mov al,check
    cmp al,position_x               ;tasm matrix.asm
    jl erase_0                        ;tlink matrix.obj \t
                                    ;matrix.com
    mov position_x,0

    call random_y

    jmp loop_1

print_gray:

    mov ah,02h              ;Set cursor position	
	mov bh,00h
	mov dh,check            ;row
	mov dl,position_y		;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,7h
	mov al,char             ; print the gray char
	int 10h

    ret

print_green:

    mov ah,02h              ;Set cursor position	
	mov bh,00h
	mov dh,check            ;row
	mov dl,position_y		;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,2h
	mov al,char             ; print the green char
	int 10h

    ret
	

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

erase_0_0:
	jmp erase_0
	
	
init_shoot:

	pop ax
	mov ah,position
	mov bullet_position_mid,ah
	push ax
	add bullet_position_mid,2

	mov     al, 182         ; meaning that we're about to load
    out     43h, al         ; a new countdown value

    mov     ax, 2153        ; countdown value is stored in ax. It is calculated by 
                            ; dividing 1193180 by the desired frequency (with the
                            ; number being the frequency at which the main system
                            ; oscillator runs
    out     42h, al         ; Output low byte.
    mov     al, ah          ; Output high byte.
    out     42h, al               

    in      al, 61h         
                            	   ; to connect the speaker to timer 2
    or      al, 00000011b  
    out     61h, al         	   ; Send the new value

    jmp shooting


doExitExit:
    jmp gameover



check_bullet:
	cmp dl,position_y
	je	erase_0_0
	
shooting:

	dec bullet_position

	add al, 00000000b  
    out 61h, al         		   ; Send the new value of buzzer

	mov ah,02h           		   ;Set cursor position	
	mov bh,00h
	mov dh,bullet_position         ;row
	mov dl,bullet_position_mid     ;colum
	int 10h
	
	cmp dh,position_x
	je	check_bullet

	mov ah,09h
	mov cx,1	
	mov bl,0eh
	mov al,bullet_char             ; print the yellow bullet
	int 10h


	;mov ax, 0B800h                ;use diract vram 
    ;mov es, ax

    ;mov di,(80*24+79)*2
    ;mov cx,0001h                  ;print 1 time
    ;mov ah,0fh                    ;ah set color first 4 bit set the color backgound of text second 4 bit set the color of text
    ;mov al,char                   ;set ascii
    ;rep stosw



	push dx                         ;delay 20480 ?
	mov ah,86h
	mov cx,0000h
	mov dx,5000h
	int 15h
	pop dx

	mov ah,02h           			;Set cursor position for delete last	
	mov bh,00h
	mov dh,bullet_position          ;row
	mov dl,bullet_position_mid  	;colum
	int 10h

    mov dl,00h                		;print space bar for cls bullet
	int 21h

	cmp bullet_position,00h
	jge shooting

	mov bullet_position,17h
	jmp random_char


erase_ship:

	mov ah,02h           			;Set cursor position	
	mov bx,0000h
	mov dh,17h         	 			;row
	mov dl,cls_ship		 			;colum
	int  10h

	mov dl,00h      				;print
	int 21h

	inc cls_ship    				; cls_ship++
	jmp draw_ship


draw_ship:

	cmp cls_ship,4fh
	jl erase_ship

    mov al,position
    mov count_possition,al 

	mov ah,02h           			;Set cursor position	
	mov bh,00h
	mov bl,0eh
	mov dh,17h         	 			;row
	mov dl,count_possition		 			;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,7h
	mov al,28h             ; print char
	int 10h

    mov ah,02h           			;Set cursor position	
	mov bh,00h
	mov bl,0eh
	mov dh,17h
    inc count_possition         	 			;row
	mov dl,count_possition		 			;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,7h
	mov al,95h             ; print char
	int 10h

    
    mov ah,02h           			;Set cursor position	
	mov bh,00h
	mov bl,0eh
	mov dh,17h
    inc count_possition         	 			;row
	mov dl,count_possition		 			;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,7h
	mov al,0ech             ; print char
	int 10h

    
    mov ah,02h           			;Set cursor position	
	mov bh,00h
	mov bl,0eh
	mov dh,17h
    inc count_possition         	 			;row
	mov dl,count_possition		 			;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,7h
	mov al,0a2h             ; print char
	int 10h

    
    mov ah,02h           			;Set cursor position	
	mov bh,00h
	mov bl,0eh
	mov dh,17h
    inc count_possition         	 			;row
	mov dl,count_possition		 			;colum
	int 10h
	
    mov ah,09h
	mov cx,1	
	mov bl,7h
	mov al,29h             ; print char
	int 10h

    jmp loop_1
	
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
	
	call kfc
		
	jmp endend

kfc:
	;koisuru fortune cookie
	mov delaynote, 250
	call E5 ;koi
	mov delaynote, 150
	call F5s
	mov delaynote, 180
	call E5
	mov delaynote, 400
	call D5
	mov delaynote, 300
	call F5s ;for
	mov delaynote, 320
	call A5
	mov delaynote, 260
	call F5s
	mov delaynote, 280
	call B5
	mov delaynote, 800
	call E5
	;ma loon doo si art ja jur kwam wang tee yang raw yoo
	mov delaynote, 200
	call E5
	mov delaynote, 200
	call F5s
	mov delaynote, 200
	call E5
	mov delaynote, 450
	call D5
	mov delaynote, 200
	call F5s
	mov delaynote, 200
	call F5s
	mov delaynote, 200
	call A5
	mov delaynote, 200
	call F5s
	mov delaynote, 200
	call B5
	mov delaynote, 200
	call B5
	mov delaynote, 200
	call A5
	mov delaynote, 1000
	call F5s

	;c'mon c'mon c'mon c'mon baby
	mov delaynote, 50
	call E5
	mov delaynote, 70
	call F5s
	mov delaynote, 5
	call C0
	mov delaynote, 50
	call E5
	mov delaynote, 70
	call F5s
	mov delaynote, 5
	call C0
	mov delaynote, 50
	call E5
	mov delaynote, 70
	call F5s
	mov delaynote, 5
	call C0
	mov delaynote, 50
	call E5
	mov delaynote, 70
	call F5s
	mov delaynote, 5
	call C0
	mov delaynote, 200
	call F5s
	mov delaynote, 700
	call E5
	;hai cookie tum nai gun
	mov delaynote, 200
	call F5s
	mov delaynote, 200
	call A5
	mov delaynote, 200
	call E5
	mov delaynote, 200
	call D5
	mov delaynote, 200
	call D5
	mov delaynote, 200
	call D5

	mov delayselect,150
	call delay
	

	ret



  ;===========================Piano Sound=====================================

PauseIt proc near uses ax cx es
        mov  cx, delaynote
        mov  ax,0040h
        mov  es,ax

        ; wait for it to change the first time
        mov  al,es:[006Ch]
@a:     cmp  al,es:[006Ch]
        je   short @a

        ; wait for it to change again
loop_it:mov  al,es:[006Ch]
@b:     cmp  al,es:[006Ch]

        je   short @b

        sub  cx,55
        jns  short loop_it
        
        ret
PauseIt endp

play_note:
    add al, ch;             apply the octave
    out dx, al;             DX will already contain MIDI_DATA_PORT from the setup_midi function
    mov al, 7Fh;            note duration
    out dx, al
    ret

setup_midi:
    push ax

    mov dx, MIDI_CONTROL_PORT
    mov al, MIDI_UART_MODE; play notes as soon as they are recieved
    out dx, al

    mov dx, MIDI_DATA_PORT
    mov al, MIDI_PIANO_INSTRUMENT
    out dx, al

    pop ax
    ret

;octave 4 = 0*12 + 60 = 60
;octave 5 = 1*12 + 60 = 72
;octave 6 = 2*12 + 60 = 84
;octave 7 = 3*12 + 60 = 96
;=======================================================================================================================

C0: call setup_midi
    mov ch, 0;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

C1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G1: call setup_midi
    mov ch,24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B1: call setup_midi
    mov ch, 24;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E1s: jmp F1
     ret

F1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 6
     call play_note
     call PauseIt
     ret

G1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A1s: call setup_midi
     mov ch, 24;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B1s: jmp B1
     ret
     ;====1
C2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G2: call setup_midi
    mov ch,36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B2: call setup_midi
    mov ch, 36;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E2s: jmp F2
     ret

F2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 6
     call play_note
     call PauseIt
     ret

G2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A2s: call setup_midi
     mov ch, 36;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B2s: jmp B2
     ret
     ;====2
C3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G3: call setup_midi
    mov ch,48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B3: call setup_midi
    mov ch, 48;             default octave(0)
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E3s: jmp F3
     ret

F3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 6
     call play_note
     call PauseIt
     ret

G3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A3s: call setup_midi
     mov ch, 48;             default octave(0)
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B3s: jmp B3
     ret

;=======================================================================================================================
C4: call setup_midi
    mov ch, 60;
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D4: call setup_midi
    mov ch, 60;
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret

E4: call setup_midi
    mov ch, 60;
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret

F4: call setup_midi
    mov ch, 60;
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret

G4: call setup_midi
    mov ch, 60;
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret

A4: call setup_midi
    mov ch, 60;
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B4: call setup_midi
    mov ch, 60;
    mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C4s: call setup_midi
     mov ch, 60;
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D4s: call setup_midi
     mov ch, 60;
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E4s: jmp F4
     ret

F4s: call setup_midi
     mov ch, 60;
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 6
     call play_note
     call PauseIt
     ret

G4s: call setup_midi
     mov ch, 60;
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A4s: call setup_midi
     mov ch, 60;
     mov cl, 5;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B4s: jmp B4
     ret
;=============================================================================================================
C5: call setup_midi
    mov ch, 72;
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D5: call setup_midi
    mov ch, 72;
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret
E5: call setup_midi
    mov ch, 72;
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret
F5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret
G5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret
A5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B5: call setup_midi
    mov ch, 72;             default octave(1)
    mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C5s: call setup_midi
     mov ch, 72;             default octave(1)
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D5s: call setup_midi
     mov ch, 72;
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E5s: jmp F5
     ret

F5s: call setup_midi
     mov ch, 72;
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 6
     call play_note
     call PauseIt
     ret
G5s: call setup_midi
     mov ch, 72;
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A5s: call setup_midi
     mov ch, 72;
     mov cl, 6;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B5s: jmp B5
     ret

;=====================================================================================================================
C6: call setup_midi
    mov ch, 84;
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D6: call setup_midi
    mov ch, 84;
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret
E6: call setup_midi
    mov ch, 84;
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret
F6: call setup_midi
    mov ch, 84;
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret
G6: call setup_midi
    mov ch, 84;
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret
A6: call setup_midi
    mov ch, 84;
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B6: call setup_midi
    mov ch, 84;
    mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C6s: call setup_midi
     mov ch, 84;
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D6s: call setup_midi
     mov ch, 84;
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E6s: jmp F6
     ret

F6s: call setup_midi
     mov ch, 84;
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 6
     call play_note
     call PauseIt
     ret
G6s: call setup_midi
     mov ch, 84;
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A6s: call setup_midi
     mov ch, 84;
     mov cl, 7;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B6s: jmp B6
     ret

;=====================================================================

C7: call setup_midi
    mov ch, 96;
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 0
    call play_note
    call PauseIt
    ret

D7: call setup_midi
    mov ch, 96;
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 2
    call play_note
    call PauseIt
    ret
E7: call setup_midi
    mov ch, 96;
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 4
    call play_note
    call PauseIt
    ret
F7: call setup_midi
    mov ch, 96;
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 5
    call play_note
    call PauseIt
    ret
G7: call setup_midi
    mov ch, 96;
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 7
    call play_note
    call PauseIt
    ret
A7: call setup_midi
    mov ch, 96;
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 9
    call play_note
    call PauseIt
    ret

B7: call setup_midi
    mov ch, 96;
    mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
    mov al, 11
    call play_note
    call PauseIt
    ret

C7s: call setup_midi
     mov ch, 96;
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 1
     call play_note
     call PauseIt
     ret

D7s: call setup_midi
     mov ch, 96;
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 3
     call play_note
     call PauseIt
     ret

E7s: jmp F7
     ret

F7s: call setup_midi
     mov ch, 96;
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 6
     call play_note
     call PauseIt
     ret
G7s: call setup_midi
     mov ch, 96;
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 8
     call play_note
     call PauseIt
     ret

A7s: call setup_midi
     mov ch, 96;
     mov cl, 8;              used for making sure that the user does not go too low or too high with the octaves
     mov al, 10
     call play_note
     call PauseIt
     ret

B7s: jmp B7
     ret

;======================================================================================


		; start delay time
delay:
		mov ah, 2ch  	;get time from MS-DOS
 		int 21h

 		add dl, delayselect

 		cmp dl, 99		;if dl > 99		jump to incSec
 		ja incSec
 		jmp setTime		;else 			jump to setTime

incSec:		;for dl(hundredths of second) > 99 for increase 1 second
		sub dl, 99 	 	;decrease 99 hundredths of second to make it in range (0-99)
		add dh, 1 		;increase 1 second
		cmp dh, 59 		;if dl > 99		jump to delay2 (for next minute)
		ja setTime2

setTime:	;set time for delay
 		mov delaytime, dx  	;DH=seconds, DL=hundredths of second
 		call delayLoop 	;delay time
 		ret

setTime2: ;set time for delay to next minute
		sub dh, 59	;set time for delay
 		mov delaytime, dx
 		call delayLoop2	;delay time from this time to 0 second (next minute)
 		call delayLoop 	;delay time from 0 second to delaytime
 		ret

delayLoop:
		mov ah, 2ch  	;get time from MS-DOS
 		int 21h
		cmp delaytime, dx
		ja delayLoop
		ret

delayLoop2:
		mov ah, 2ch  	;get time from MS-DOS
 		int 21h
		;call keyboard_scan2
		cmp dh, 0
		ja delayLoop2
		ret



 ending:
	MOV		AH, 4Ch			; exit program
	MOV		AL, 00
	INT		21h

 endmain:
    ret

music_intro:
	;koisuru fortune cookie
	mov delaynote, 300
	call D3
	mov delaynote, 300
	call D3
	mov delaynote, 300
	call D3
	mov delaynote, 50
	call F5s
	mov delaynote, 50
	call E5
	mov delaynote, 50
	call G5
	mov delaynote, 50
	call A5
	mov delaynote, 300
	call C0
	mov delaynote, 300
	call B2
	mov delaynote, 300
	call B2
	mov delaynote, 300
	call B2
	mov delaynote, 50
	call D5
	mov delaynote, 50
	call C5s
	mov delaynote, 50
	call D5
	mov delaynote, 50
	call F5s
	mov delaynote, 300
	call C0
	mov delaynote, 300
	call D3
	mov delaynote, 300
	call D3
	mov delaynote, 300
	call D3
	mov delaynote, 50
	call F5s
	mov delaynote, 50
	call E5
	mov delaynote, 50
	call G5
	mov delaynote, 50
	call A5
	mov delaynote, 300
	call C0
	mov delaynote, 300
	call B2
	mov delaynote, 300
	call B2
	mov delaynote, 300
	call B2
	mov delaynote, 200
	call C5s
	mov delaynote, 200
	call D5
	mov delaynote, 200
	call E5
	mov delaynote, 200
	call F5s
	mov delaynote, 200
	call G5
	mov delaynote, 200
	call F5s
	mov delaynote, 200
	call G5
	mov delaynote, 200
	call A5
	mov delaynote, 200
	call D3
	mov delaynote, 200
	call D5
	mov delaynote, 200
	call B2
	mov delaynote, 200
	call E5
	mov delaynote, 200
	call D5
	mov delaynote, 200
	call E5
	mov delaynote, 200
	call F5s
	mov delaynote, 300
	call C0
	

	mov delayselect,150
	call delay

	;jmp music_intro

	ret

endend:
	mov ah,4ch                      ;clear
	mov al,00
	int 21h

	int     20h                     ; Job's done!
	ret
	end     main

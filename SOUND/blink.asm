        .model  tiny

        .data

delaytime   dw  0 ; keep added time for check with current time
delayselect db  0 ; keep delay from user input


	MIDI_CONTROL_PORT dw 0331h
    MIDI_DATA_PORT dw 0330h
    MIDI_UART_MODE db 3Fh
    MIDI_PIANO_INSTRUMENT db 93h
    delaynote dw ?

        .code
        org     0100h
main:
    mov ah,00h
    mov al,03h
    int 10h


    call blink

	jmp ending




blink:
	
	mov delaynote, 50
	call E5
	mov delaynote, 120
	call F5s
	mov delaynote, 50
	call E5
	mov delaynote, 100
	call F5s
	mov delaynote, 50
	call E5
	mov delaynote, 100
	call F5s
	mov delaynote, 50
	call E5
	mov delaynote, 100
	call F5s
	mov delaynote, 200
	call F5s
	mov delaynote, 700
	call E5
	
	
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
        end main

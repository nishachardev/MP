.model small 
.386 

.data 
ARRAY DB 10 DUP (?) 
DATA1 dw 0000H 

msg db 10,13,"Enter the size of the array :: $" 
msg2 db 10,13,"Enter the array :: $" 
msg3 db 10,13,"The entered array is :: $" 

.code 
.startup 

MOV AH,09 
MOV DX,OFFSET msg 
INT 21H 

MOV AH,01 
INT 21H
SUB AL,30H 
MOV AH,0 
MOV CX,AX
MOV DATA1,AX 

MOV AH,09 
MOV DX,OFFSET msg2 
INT 21H 

MOV AH, 0 
MOV SI, 0 
MOV BX, OFFSET ARRAY 
L1: MOV DL, 0AH ; jump onto next line 
MOV AH, 02H 
INT 21H 

MOV AH, 01H 
INT 21H 
SUB AL,30H 
mov ah, 00 
MOV [BX + SI], AX 
INC SI 
LOOP L1 

MOV AH, 09H 
MOV DX, OFFSET MSG3 
INT 21H 

MOV CX, DATA1 
MOV SI, 0  
L2:mov ah, 02h 
mov dl, 0ah 
int 21h 

mov dl, 0dh 
int 21h 

MOV DX, [BX+SI] 
ADD DL, 30h 
MOV AH, 02 
INT 21H 
INC SI 
LOOP L2 

.EXIT 
END 
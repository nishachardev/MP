.model small 
.386
.data 
A1 Db 100  DUP (?) 
DATA1 dw 0000H 
DATA2 Db 00h 
DATA3 Db 00h 
msg db 10,13,"Enter the size of the array :: $" 
msg2 db 10,13,"Enter the array :: $" 
msg3 db 10,13,"The entered array is :: $" 

.code 
.startup 

MOV AH,09 
MOV DX, OFFSET msg 
INT 21H 

MOV CX, 2 
L4: MOV AH,01 
INT 21H 
CMP AL,'A' 
JGE L7 
SUB AL,30H 
JMP L8 
L7: SUB AL,37H 
L8: SHL BX, 4 
ADD BL, AL 
LOOP L4 

MOV AL, BL 
;MOV CL, AL 
MOV AH, 0 
MOV DATA1, AX 
MOV CX, DATA1 

MOV AH,09 
MOV DX,OFFSET msg2 
INT 21H 

MOV AH,0 
LEA SI,  A1 
L1: MOV DL, 0AH ; jump onto next line 
MOV AH, 02H 
INT 21H 

Mov DATA2, CL 
NUM PROC 
MOV CL, 2 
AGAIN: MOV AH, 01H 
INT 21H 
SUB AL,30H 
SHL BL,4 
ADD BL,AL 
LOOP AGAIN 

ENDP NUM 

MOV CL, DATA2 

MOV [SI], BL 
INC SI 
LOOP L1 

MOV AH, 09H 
MOV DX, OFFSET MSG3 
INT 21H 

MOV CX, DATA1 
MOV SI, offset A1  
L2:mov ah, 02h 
mov dl, 0ah 
int 21h 

MOV DATA3, CL 
MOV CL, 2 
MOV BL, 00 
MOV BL, [SI]  
AGAIN2: ROL BL, 4   
MOV AL, BL 

AND AL, 0FH 
MOV DL, AL                  
ADD DX, 30h 
MOV AH, 02 
INT 21H
LOOP AGAIN2 

MOV CL, DATA3 
INC SI 
LOOP L2 

.EXIT 
END 
.model small

.386

.data
	msg DB 10,13,"Enter the First Number ::$"
	msg1 DB 10,13,"Enter the Second Number ::$"
	msg2 DB 10,13,"The Resultant Sum is ::$"

	A DD ?
	B DD ?
	C DD ?
	COUNT DB 04h 

.code
	.startup
		LEA DX,msg
		MOV AH,09
		INT 21H

		MOV EBX,0

		MOV CX,8
		AGAIN:	MOV AH,01 
				INT 21H
				CMP AL,'A'
				JGE L5
				SUB AL,30H
				JMP L6
				L5: SUB AL,37H
				L6: SHL EBX,4
				ADD BL,AL
		LOOP AGAIN

		MOV A,EBX

		LEA DX,msg1
		MOV AH,09
		INT 21H

		MOV EBX,0

		MOV CX,8
		AGAINS:	MOV AH,01 
				INT 21H
				CMP AL,'A'
				JGE L51
				SUB AL,30H
				JMP L61
				L51: SUB AL,37H
				L61: SHL EBX,4
				ADD BL,AL
		LOOP AGAINS
		
		MOV B,EBX

		MOV AX,WORD PTR A
		MOV BX,WORD PTR B

		ADD AL,BL
		DAA
		MOV BL,AL

		ADC AH,BH
		MOV AL,AH
		DAA
		MOV BH,AL 

		MOV WORD PTR C,BX

		MOV AX,WORD PTR A+2
		MOV BX,WORD PTR B+2
		ADC AL,BL
		DAA
		MOV BL,AL
		ADC AH,BH
		MOV AL,AH
		DAA
		MOV BH,AL
		MOV WORD PTR C+2,BX

		LEA DX,msg2
		MOV AH,09
		INT 21H

		MOV BX,WORD PTR C+2
		MOV DH,2

		L1: MOV CH,04H
		MOV CL,04H

		L2: ROL BX,CL
		MOV DL,BL
		AND DL,0FH
		CMP DL,09
		JBE L4
		ADD DL,07

		L4: ADD DL,30H
		MOV AH,02
		INT 21H
		DEC CH
		JNZ L2
		DEC DH
		CMP DH,0
		MOV BX,WORD PTR C
		JNZ L1

		MOV AH,4CH
		INT 21H
	.exit
end
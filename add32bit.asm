.model small										;define the size of your program (small for 1 data segment & 1 code segment)

.386

.stack 100H											;creating stack

.data												;data segment
	data1 dd 00000000H
	msg db 10,13,"Enter the first no.:: $"
	msg1 db 10,13,"Enter the second no.:: $"
	msg2 db 10,13,"The Resultant sum is :: $"

.code												;code segment
	.startup
		MOV EBX, 00									;clear garbage value of BX by moving 00 in it

		MOV AH,09									;09 in AH means output string
		MOV DX,OFFSET msg							;move the string you want to output in DX
		INT 21H										;interupt 21H will check AH and do accordingly (output string in this case)

		MOV CX, 8									;set CX to 8 to run the loop eight times
		AGAIN:  MOV AH, 01							;loop to Again part, set AH to 01 for input
				INT 21H								;interupt 21H and check AH, take input in this case
				CMP AL, 'A'							;compare the input value (AL) with 'A' (hex for 10)
				JGE P1								;jump to P1 if input is greater than or equal to 'A'
				SUB AL,30H							;sub 30H from AL (hex to ascii conversion for num<9)
				JMP P4								;jump to P4 (do not want to go to P1)
				P1: SUB AL, 37H						;sub 37H from AL (hex to ascii conversion for num>9)
				P4: SHL EBX, 4						;shift EBX to left by 4 bits (to store next digit at correct place)
				MOV AH, 00
                ADD EBX, EAX						;add the shifted digit and current digit input for 8 digit num
		LOOP AGAIN									;loop back to again until CX is 0

		MOV data1, EBX								;move EBX to data1 var, to store another input digit in EBX

		MOV AH,09									;09 in AH means output string
		MOV DX,OFFSET msg1							;move the string you want to output in DX
		INT 21H										;interupt 21H will check AH and do accordingly (output string in this case)

		MOV CX, 8							        ;set CX to 8 to run the loop eight times
		AGAIN2: MOV AH, 01							;loop to Again2 part, set AH to 01 for input
				INT 21H								;interupt 21H and check AH, take input in this case
				CMP AL, 'A'							;compare the input value (AL) with 'A' (hex for 10)
				JGE P2								;jump to P2 if input is greater than or equal to 'A'
				SUB AL,30H							;sub 30H from AL (hex to ascii conversion for num<9)
				JMP P3								;jump to P3 (do not want to go to P2)
				P2: SUB AL, 37H						;sub 37H from AL (hex to ascii conversion for num>9)
				P3: SHL EBX, 4						;shift EBX to left by 4 bits (to store next digit at correct place)
				MOV AH, 00
                ADD EBX,EAX							;add the shifted digit and current digit input for 8 digit num
		LOOP AGAIN2									;loop back to again2 until CX is 0

		ADD EBX, data1								;add data1 and EBX and store in EBX

		MOV AH,09									;set AH to 09 for output
		MOV DX,OFFSET msg2							;move output msg to DX
		INT 21H										;interupt 21H and output (since AH is 09)

		MOV DX, 00									;clear garbage value of DX by moving 00 to it

		MOV CX, 8									;set CX to 8 to run the loop eight times
		AGAIN3: ROL EBX, 4							;loop to again3 part, rotate BX to left by 4 bits
				MOV DL,BL							;move BL to DL
				AND DL, 0FH							;perform AND on DL and 0F (hex for 00001111)
				
				CMP DL, 09							;compare DL with 09
				JG L6								;jump to L6 if DL is greater than 09
				ADD DL,30H							;add 30H to DL (ascii to hex conversion for num<09)
				JMP L7								;jump to L7 (to skip L6)
				L6: ADD DL, 37H						;add 37H to DL (ascii to hex conversion for num>09)
				L7: MOV AH,02						;move 02 to AH (to output one digit)
				INT 21H								;interupt 21H to check AH (output in this case)
		LOOP AGAIN3									;loop back to again3 until CX is 0


		MOV AH, 4CH									;move 4CH in AH (to terminate the current process)
		INT 21H										;interupt 21H and terminate process (since AH is 4CH)
	.exit
end     

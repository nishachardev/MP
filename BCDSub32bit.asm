.model small 

.386 

.data 

    num1 DD 00000000H 
    num2 DD 00000000H 
    num3 DD 00000000H 
    msg db 10,13,"Enter the First no.:: $" 
    msg1 db 10,13,"Enter the Second no.:: $" 
    msg2 db 10,13,"The Resultant Difference is :: $" 

.code 
    .startup
        MOV AH,09 
        MOV DX,OFFSET msg 
        INT 21H 

        MOV EBX,0 

        MOV CX,8 
        AGAIN:  MOV AH,01 ;1ST NO. ENTERED 
                INT 21H 
                CMP AL,'A' 
                JGE L2 
                SUB AL,30H 
                SHL EBX,4 
                ADD BL,AL 
        LOOP AGAIN 

        MOV num1,EBX

        MOV AH,09
        MOV DX,OFFSET msg1
        INT 21H 

        MOV EBX,0 

        MOV CX,8
        AGAIN1: MOV AH,01 ;2nd NO. ENTERED 
                INT 21H 
                CMP AL,'A'
                JGE L2
                SUB AL,30H
                SHL EBX,4
                ADD BL,AL
        LOOP AGAIN1

        MOV num2, EBX 

        MOV AX, word ptr num1
        MOV DX, word ptr num2 

        SUB AL, DL
        DAS
        MOV BL, AL
 
        MOV AL, AH
        sbb al,dh
        DAS
        MOV BH,AL 

        MOV word ptr num3, BX 
        MOV AX, word ptr num1+2
        MOV DX, word ptr num2+2 

        SUB AL, DL
        DAS
        MOV BL, AL

        MOV AL, AH 
        SBB AL, DH
        DAS
        MOV BH, AL

        MOV word ptr num3+2, BX 
        MOV EBX,num3

        MOV AH, 09H
        MOV DX, offset msg2 
        INT 21H

        JNC l6 

        MOV AH, 02h 
        MOV DL, "1" 
        INT 21H  

    l6: MOV CX,8 
    AGAIN2: ROL EBX,4 
            MOV DL,BL 
            AND DL,0FH 
            ADD DL,30H 
            MOV AH,02 
            INT 21H 
    LOOP AGAIN2 

    L2: .EXIT
END 
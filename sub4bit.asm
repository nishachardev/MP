.model small                                      ;define the size of your program (small for 1 data segment & 1 code segment)

.stack 100H                                       ;creating stack
    
.data                                             ;data segment
    msg db 10,13,"Enter the first no.:: $"
    msg1 db 10,13,"Enter the second no.:: $"
    msg2 db 10,13,"The Resultant difference is :: $"

.code                                             ;code segment
    .startup
        MOV AH,09                                 ;09 in AH means output string
        MOV DX,OFFSET msg                         ;move the string you want to output in DX
        INT 21H                                   ;interupt 21H will check AH and do accordingly (output string in this case)

        MOV AH, 01                                ;01 in AH means input and store in AL
        INT 21H                                   ;interupt and check AH (input in this case)
        SUB AL,30H                                ;sub 30H from AL (input), for hex to ascii conversion
        MOV BL, AL                                ;move AL to BL to take another input in AL

        MOV AH,09                                 ;09 in AH means output string
        MOV DX,OFFSET msg1                        ;move the string you want to output in DX
        INT 21H                                   ;interupt 21H will check AH and do accordingly (output string in this case)

        MOV AH, 01                               ;01 in AH means input and store in AL
        INT 21H                                  ;interupt and check AH (input in this case)
        SUB AL,30H                               ;sub 30H from AL (input), for hex to ascii conversion
        SUB BL, AL                               ;sub AL from BL and store in BL

        MOV AH,09                                ;09 in AH means output string
        MOV DX,OFFSET msg2                       ;move the string you want to output in DX
        INT 21H                                  ;interupt 21H will check AH and do accordingly (output string in this case)

        MOV DL,BL                                 ;move BL to DL (for comparision)
        CMP DL, 09                                ;compare DL value with 09
        JG L6                                     ;if the value of DL is greater than 09, then jump to L6
        ADD DL,30H                                ;else add 30H to DL (ascii to hex conversion)
        JMP L7                                    ;now, jump to L6 (we do not want to go to L6)

        L6: ADD DL, 37H                           ;when DL is greater than 09, add 37H for ascii to hex conversion

        L7: MOV AH,02                             ;move 02 to AH for output
        INT 21H                                   ;interupt for output

        MOV AH, 4CH                              ;move 4CH to AH for termination of process
        INT 21H                                  ;interupt for termination (4CH)
    .exit
end
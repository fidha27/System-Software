ASSUME CS:CODE,DS:DATA
DATA SEGMENT
    STRING DB "MALAYALAM$", 0 ; Null-terminated string
    RESULT DB "PALINDROME", "$"
    NOTPAL DB "NOT A PALINDROME", "$"
DATA ENDS

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX

    LEA SI, STRING          ; SI points to start of string
    MOV CX, 0               ; Initialize counter

    ; Find length of string
FIND_LEN:
    MOV AL, [SI]
    CMP AL, '$'             ; Check for end of string
    JE  CHECK_PALINDROME
    INC SI                  ; Move to next character
    INC CX                  ; Increment length counter
    JMP FIND_LEN

CHECK_PALINDROME:
    DEC SI                  ; SI now points to last character
    LEA DI, STRING          ; DI points to start of string

COMPARE_LOOP:
    MOV AL, [SI]            ; Load character from end
    MOV BL, [DI]            ; Load character from start
    CMP AL, BL              ; Compare characters
    JNE NOT_A_PALINDROME    ; If not equal, it's not a palindrome
    DEC SI                  ; Move SI inward
    INC DI                  ; Move DI inward
    LOOP COMPARE_LOOP       ; Repeat for all characters

    ; If palindrome
    LEA DX, RESULT
    MOV AH, 09H
    INT 21H
    JMP END_PROGRAM

NOT_A_PALINDROME:
    LEA DX, NOTPAL
    MOV AH, 09H
    INT 21H

END_PROGRAM:
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START

.Model Small
.Stack 100H

.Code
MAIN Proc
; SET VIDEO MODE
	MOV AH, 0
	MOV AL, 3
	INT 10H
; SELECT DISPLAY PAGE
;	MOV AH, 5
;	MOV AL, 0
;	INT 10H
; SET DS TO ACTIVE DISPLAY PAGE
	MOV AX, 0B800H
	MOV DS, AX
	MOV CX, 2000
	MOV DI, 0
; FILL ACTIVE DISPLAY PAGE
FILL_BUF:
	MOV [DI], 1441H
	ADD DI, 2
	LOOP FILL_BUF
;DOS EXIT
	MOV AH, 4CH
	INT 21H
MAIN EndP
	End MAIN
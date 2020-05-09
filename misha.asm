.Model Small
.Stack 100h

.DATA
TTT DB "TIC TAC TOE$"
PLAY DB "Press 1 for New Game$"
EXIT DB "Press 2 for Exit$"
INPUT DB ?
.Code

main Proc
    MOV AX,@DATA
    MOV DS,AX
; set graphics mode 4
    MOV AH,0h
    MOV AL,4h
    INT 10h
    
; set background color to cyan
    MOV AH, 0BH
    MOV BH, 0
    MOV BL,5
    INT 10h

; select palette 0
    MOV BH, 1
    MOV BL, 12
    INT 10h
    
;FOR TIC TAC TOE
; move cursor to page 0, row 5, col 13
        MOV AH, 02
        MOV BH, 0
        MOV DH, 5
        MOV DL, 13
        INT 10h
;printing tic tac toe
        MOV AH,9
        MOV DX,offset TTT
        INT 21h
       
;FOR PLAY
; move cursor to page 0, row 10, col 10
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 10
        INT 10h
        
;printing press 1 for play

        MOV DX,offset PLAY
        MOV AH,9
        INT 21h
       
;FOR EXIT
; move cursor to page 0, row 13, col 12
        MOV AH, 02
        MOV BH, 0
        MOV DH, 13
        MOV DL, 12
        INT 10h
;printing press 2 for exit
        MOV DX,offset EXIT
        MOV AH,9
        INT 21h

;INPUT
        MOV AH,1
        INT 21H
        MOV INPUT,AL
        CMP AL,'2'
        JE EXITGAME
        CMP AL,'1'
        JE NEWGAME
        
EXITGAME:
        MOV AX,0003h ;CLEAR SCREEN
        INT 10H

        MOV AH,4CH
        INT 21H
        
NEWGAME:

    MOV AX,0003H    ;CLEAR SCREEN MODE
    INT 10H
    
    
;background colour    
    MOV AX,5     
    MOV BH,0
    MOV BL,30
    INT 10H  

; draw line pixel by pixel
    MOV AH,0CH
    MOV AL,2
    INT 10h    
;ROW1
    MOV CX,70 ; beginning col
    MOV DX,40 ; beginning row
    
    L1: 
        INT 10h
        INC CX
        CMP CX,250
        JLE L1
   
   ;ROW2     
   MOV CX,70
   MOV DX,80
   L2:
        INT 10h
        INC CX
        CMP CX, 250
        JLE L2
   
   ;ROW3     
   MOV CX,70
   MOV DX,120
   L3:
        INT 10h
        INC CX
        CMP CX, 250
        JLE L3
        
   ;ROW4     
   MOV CX,70
   MOV DX,160
   L4:
        INT 10h
        INC CX
        CMP CX, 250
        JLE L4
        
   ;COLUMN1
    MOV CX,70
    MOV DX,40
        
        C1:
        INT 10h
        INC DX
        CMP DX,160
        JNE C1
        
    ;COLUMN2
     MOV CX,130
     MOV DX,40
        
        C2:
        INT 10h
        INC DX
        CMP DX,160
        JNE C2
        
    ;COLUMN3
     MOV CX,190
     MOV DX,40
        
        C3:
        INT 10h
        INC DX
        CMP DX,160
        JNE C3
        
     ;COLUMN4
     MOV CX,250
     MOV DX,40
        
        C4:
        INT 10h
        INC DX
        CMP DX,160
        JNE C4
            
; getch     
        MOV AH,0
        INT 16h
; return to text mode
        MOV AX,3
        INT 10h
        
; return to dos
        MOV AH, 4CH
        INT 21h
main EndP
     End main


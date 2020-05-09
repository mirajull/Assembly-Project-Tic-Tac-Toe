.Model Small
.Stack 100h
.Code


main Proc 
 
; set CGA 640x200 high res mode
    MOV AX,6
    INT 10h
    
    MOV AH,0BH ;function OBh
    MOV BH,00H ;select background color
    Mov BL,4
    INT 10H
    
; draw line pixel by pixel  
    MOV AH, 0CH
    MOV AL, 1
    
    MOV CX, 200; beginning col
    MOV DX, 99 ; beginning row
    
    L1: INT 10h
        INC CX
        CMP CX, 438
        JLE L1
        
        MOV AH, 0
        INT 16h
        
        MOV AX, 3
        INT 10h
        
        MOV AH,1
        INT 21H
        CMP AL,'1'
        JE AREKTA
        
     AREKTA:
        MOV AX,6
        INT 10h
        MOV AH,0BH ;function OBh
        MOV BH,00H ;select background color
        Mov BL,4
        INT 10H
    
        
        
        MOV AH, 4CH
        INT 21h
main EndP
     End main

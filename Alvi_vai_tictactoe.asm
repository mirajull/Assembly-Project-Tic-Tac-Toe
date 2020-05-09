.Model Small

WHITE_BOX_ROW_DRAW MACRO A,B,C 
    LOCAL RAW
    MOV CX,A
    MOV DX,B
    MOV AL,15
    RAW:
     INT 10H
     INC CX
     CMP CX,C
     JLE RAW 
     ENDM
     
WHITE_BOX_COL_DRAW MACRO D,E,F
    LOCAL COL
    MOV CX,D
    MOV DX,E
    MOV AL,15
    COL:
      INT 10H
      INC DX
      CMP DX,F
      JLE COL
      ENDM

WHITE_FULL_DRAW MACRO G,H,I,J
    LOCAL RAW1
    LOCAL COL1
    XOR CX,CX
    XOR DX,DX
    XOR AL,AL 
    MOV CX,G
    MOV DX,H
    MOV AL,15
  RAW1: 
    COL1:
      INT 10H
      INC CX
      CMP CX,I
      JLE COL1
      MOV CX,G
      INC DX
      CMP DX,J
      JLE RAW1
      ENDM
WRITE_ZERO MACRO P,Q
    ;MOV AH,0h
;   MOV AL,4h
;   INT 10h

        MOV AH, 02
        MOV BH, 0
        MOV DH, P
        MOV DL, Q
        INT 10h
; write char        
        MOV AH, 9
        MOV AL, 'O'
        MOV BL, 14 ; color value from palette
        MOV CX, 1
        INT 10h
        ENDM
WRITE_CROSS MACRO R,S
   ; MOV AH,0h
;   MOV AL,4h
;   INT 10h
;
        MOV AH, 02
        MOV BH, 0
        MOV DH, R
        MOV DL, S
        INT 10h
; write char        
        MOV AH, 9
        MOV AL, 'X'
        MOV BL, 2 ; color value from palette
        MOV CX, 1
        INT 10h
        ENDM 
.Stack 100h 
.DATA
POS DB 1
Z1 DB ?
Z2 DB ?
Z3 DB ?
Z4 DB ?
Z5 DB ?
Z6 DB ?
Z7 DB ?
Z8 DB ?
Z9 DB ?
T1 DB 0
T2 DB 0
T3 DB 0
T4 DB 0
T5 DB 0
T6 DB 0
T7 DB 0
T8 DB 0
T9 DB 0
C DB 0  
F DB 1

.Code  
main Proc 
     MOV AX,@DATA
     MOV DS,AX
; set VGA 320*200 high res mode
    MOV AX,13h
    INT 10h
; draw line pixel by pixel

CALL DRAW_MAIN_BOX       
        ;WHITE BOX DRAW
        MOV AH,0CH
        MOV AL,7
         
        
        MOV CX,80
        MOV DX,50
    W_ROW_1:
        
        INT 10H
        INC CX
        CMP CX,130
        JLE W_ROW_1
        
        MOV CX,80
        MOV DX,90
    W_ROW_2:
        
        INT 10H
        INC CX
        CMP CX,130
        JLE W_ROW_2 
        
        
        MOV CX,80
        MOV DX,50
    W_COL_1:
        INT 10H
        INC DX
        CMP DX,90
        JLE W_COL_1 
        
            
        MOV CX,130
        MOV DX,50    
    W_COL_2:    
        INT 10H
        INC DX
        CMP DX,90
        JLE W_COL_2
         
    SCAN:
        MOV AH,0
        INT 16H
        CMP AH,72
        JE UP_ARROW
        CMP AH,75
        JE LEFT_ARROW
        CMP AH,77
        JE RIGHT_ARROW
        CMP AH,80
        JE DOWN_ARROW
        
        ZER:
        CMP AH,24 
        JNE CRO  
        CMP F,1
        JE ZERO1 
        
        CRO:
        CMP AH,45
        JNE SCAN
        CMP F,2
        JNE SCAN
     
      CROSS1:
        ;MOV F,1
        JMP CROSS  
      ZERO1:
        ;MOV F,2
        JMP ZERO
      
     
     UP_ARROW:
         SUB POS,3
         JMP DRAW_WHITE_BOX
         
     LEFT_ARROW:
         DEC POS
         JMP DRAW_WHITE_BOX
         
     RIGHT_ARROW:
         ;XOR AX,AX
         INC POS
        
         JMP DRAW_WHITE_BOX
         
     DOWN_ARROW:
         ADD POS,3
         JMP DRAW_WHITE_BOX
         
         
     DRAW_WHITE_BOX:
          CMP POS,1
          JNE DRAW2
          CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 80,50,130
          WHITE_BOX_ROW_DRAW 80,90,130
          WHITE_BOX_COL_DRAW 80,50,90
          WHITE_BOX_COL_DRAW 130,50,90 
          JMP SCAN
       DRAW2:
           CMP POS,2
           JNE DRAW3
         CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 130,50,180
          WHITE_BOX_ROW_DRAW 130,90,180
          WHITE_BOX_COL_DRAW 130,50,90
          WHITE_BOX_COL_DRAW 180,50,90
          JMP SCAN 
          
        DRAW3:
           CMP POS,3
           JNE DRAW4
         CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 180,50,230
          WHITE_BOX_ROW_DRAW 180,90,230
          WHITE_BOX_COL_DRAW 180,50,90
          WHITE_BOX_COL_DRAW 230,50,90
          JMP SCAN 
        
        DRAW4:
           CMP POS,4
           JNE DRAW5
         CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 80,90,130
          WHITE_BOX_ROW_DRAW 80,130,130
          WHITE_BOX_COL_DRAW 80,90,130
          WHITE_BOX_COL_DRAW 130,90,130   
          JMP SCAN
        
         DRAW5:
           CMP POS,5
           JNE DRAW6
         CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 130,90,180
          WHITE_BOX_ROW_DRAW 130,130,180
          WHITE_BOX_COL_DRAW 130,90,130
          WHITE_BOX_COL_DRAW 180,90,130  
          JMP SCAN 
           
         DRAW6:
           CMP POS,6
           JNE DRAW7
         CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 180,90,230
          WHITE_BOX_ROW_DRAW 180,130,230
          WHITE_BOX_COL_DRAW 180,90,130
          WHITE_BOX_COL_DRAW 230,90,130 
          JMP SCAN
          
         DRAW7:
           CMP POS,7
           JNE DRAW8
         CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 80,130,130
          WHITE_BOX_ROW_DRAW 80,170,130
          WHITE_BOX_COL_DRAW 80,130,170
          WHITE_BOX_COL_DRAW 130,130,170 
          JMP SCAN
          
            
         DRAW8:
           CMP POS,8
           JNE DRAW9
         CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 130,130,180
          WHITE_BOX_ROW_DRAW 130,170,180
          WHITE_BOX_COL_DRAW 130,130,170
          WHITE_BOX_COL_DRAW 180,130,170 
          JMP SCAN          
          DRAW9:
          CMP POS,9
          JNE SCAN1
          CALL DRAW_MAIN_BOX
          WHITE_BOX_ROW_DRAW 180,130,230
          WHITE_BOX_ROW_DRAW 180,170,230
          WHITE_BOX_COL_DRAW 180,130,170
          WHITE_BOX_COL_DRAW 230,130,170       
          JMP SCAN 
        
     SCAN1:
        JMP SCAN
                 
     ZERO: 
         CMP POS,1
         JNE ZERO2
         CMP T1,0
         JNE ZERO2
         WRITE_ZERO 8,12 
         MOV T1,1
         MOV Z1,1
         MOV F,2
         INC C
         JMP CHECK_ZERO1
         
         ZERO2:
           CMP POS,2
          JNE ZERO3 
          CMP T2,0
          JNE ZERO3
          WRITE_ZERO 8,18
          MOV T2,1
          MOV Z2,1
          MOV F,2
          INC C
          JMP CHECK_ZERO2 
         
         ZERO3:
           CMP POS,3
          JNE ZERO4 
          CMP T3,0
          JNE ZERO4
          WRITE_ZERO 8,24
          MOV T3,1
          MOV Z3,1
          MOV F,2
          INC C
          JMP CHECK_ZERO3
            
        ZERO4:
         CMP POS,4
          JNE ZERO5
          CMP T4,0
          JNE ZERO5
          WRITE_ZERO 13,12
          MOV T4,1
          MOV Z4,1
          MOV F,2 
          INC C
          JMP CHECK_ZERO4
          
        ZERO5: 
         CMP POS,5
          JNE ZERO6
          CMP T5,0
          JNE ZERO6
          WRITE_ZERO 13,18
          MOV T5,1
          MOV Z5,1
          MOV F,2  
          INC C
          JMP CHECK_ZERO5
        
        ZERO6: 
         CMP POS,6
          JNE ZERO7
          CMP T6,0
          JNE ZERO7
          WRITE_ZERO 13,24 
          MOV T6,1
          MOV Z6,1
          MOV F,2
          INC C  
          JMP CHECK_ZERO6
         
        ZERO7:
          CMP POS,7
          JNE ZERO8 
          CMP T7,0
          JNE ZERO8
          WRITE_ZERO 18,12
          MOV T7,1
          MOV Z7,1
          MOV F,2
          INC C
          JMP CHECK_ZERO7
          
        ZERO8:
         CMP POS,8
          JNE ZERO9
          CMP T8,0
          JNE ZERO9
          WRITE_ZERO 18,18
          MOV Z8,1 
          MOV T8,1
          MOV F,2 
          INC C
          JMP CHECK_ZERO8
         
        ZERO9:
         CMP POS,9
          JNE SCAN2
          CMP T9,0
          JNE SCAN2
          WRITE_ZERO 18,24
          MOV Z9,1 
          MOV T9,1
          MOV F,2
          INC C
          JMP CHECK_ZERO9   
        SCAN2:
        JMP SCAN
          
       CROSS:
         CMP POS,1
         JNE CROSS2
         CMP T1,0
         JNE CROSS2
         WRITE_CROSS 8,12
         MOV Z1,2  
         MOV T1,2
         MOV F,1 
         INC C
         JMP CHECK_CROSS1
         
         CROSS2:
          CMP POS,2
          JNE CROSS3
          CMP T2,0
          JNE CROSS3
          WRITE_CROSS 8,18
          MOV Z2,2  
          MOV T2,2
          MOV F,1 
          INC C
          JMP CHECK_CROSS2 
         
         CROSS3:
           CMP POS,3
          JNE CROSS4
          CMP T3,0
          JNE CROSS4
          WRITE_CROSS 8,24
          MOV Z3,2 
          MOV T3,2
          MOV F,1 
          INC C
          JMP CHECK_CROSS3
            
        CROSS4:
         CMP POS,4
          JNE CROSS5
          CMP T4,0
          JNE CROSS5
          WRITE_CROSS 13,12
          MOV Z4,2  
          MOV T4,2
          MOV F,1
          INC C
          JMP CHECK_CROSS4
          
        CROSS5: 
         CMP POS,5
          JNE CROSS6
          CMP T5,0
          JNE CROSS6
          WRITE_CROSS 13,18
          MOV Z5,2  
          MOV T5,2
          MOV F,1 
          INC C
          JMP CHECK_CROSS5
        
        CROSS6: 
         CMP POS,6
          JNE CROSS7
          CMP T6,0
          JNE CROSS7
          WRITE_CROSS 13,24
          MOV Z6,2  
          MOV T6,2
          MOV F,1
          INC C
          JMP CHECK_CROSS6
         
        CROSS7:
         CMP POS,7
          JNE CROSS8
          CMP T7,0
          JNE CROSS8
          WRITE_CROSS 18,12
          MOV Z7,2  
          MOV T7,2
          MOV F,1 
          INC C
         JMP CHECK_CROSS7
          
        CROSS8:
         CMP POS,8
          JNE CROSS9
          CMP T8,0
          JNE CROSS9
          WRITE_CROSS 18,18
          MOV Z8,2  
          MOV T8,2
          MOV F,1  
          INC C
         JMP CHECK_CROSS8
         
        CROSS9:
         CMP POS,9
          JNE SCAN3
          CMP T9,0
          JNE SCAN3
          WRITE_CROSS 18,24
          MOV Z9,2 
          MOV T9,2
          MOV F,1 
          INC C
          JMP CHECK_CROSS9   
        SCAN3:
        CMP C,9
        JNE S1
        CALL MATCH_DRAW
        JMP EXIT
        S1:
        JMP SCAN 
        
     CHECK_ZERO1:
        CMP Z2,1
        JNE CHECK_COL1
        CMP Z3,1
        JNE CHECK_COL1
       ; CALL WIN_PLAYER1
        WHITE_FULL_DRAW 80,50,130,90 
        WHITE_FULL_DRAW 130,50,180,90
        WHITE_FULL_DRAW 180,50,230,90
        JMP EXIT     
        CHECK_COL1:
          CMP Z4,1
          JNE CHECK_RIGHT_DIAGONAL
          CMP Z7,1                
          JNE CHECK_RIGHT_DIAGONAL
          ;CALL WIN_PLAYER1 
          WHITE_FULL_DRAW 80,50,130,90
          WHITE_FULL_DRAW 80,90,130,130
          WHITE_FULL_DRAW 80,130,130,170
       
          JMP EXIT          
        CHECK_RIGHT_DIAGONAL:
          CMP Z5,1
          JNE SCAN8
          CMP Z9,1
          JNE SCAN8
          ;CALL WIN_PLAYER1
            WHITE_FULL_DRAW 80,50,130,90 
         WHITE_FULL_DRAW 130,90,180,130
         WHITE_FULL_DRAW 180,130,230,170
          JMP EXIT
          
         SCAN8:
            JMP SCAN3 
          
     CHECK_ZERO2:
         CMP Z1,1
         JNE CHECK_COL2
         CMP Z3,1
         JNE CHECK_COL2
         ;CALL WIN_PLAYER1
          WHITE_FULL_DRAW 80,50,130,90 
        WHITE_FULL_DRAW 130,50,180,90
        WHITE_FULL_DRAW 180,50,230,90
         
         JMP EXIT
         
         CHECK_COL2:
           CMP Z5,1
           JNE SCAN8
           CMP Z8,1
           JNE SCAN8
           ;CALL WIN_PLAYER1
        WHITE_FULL_DRAW 130,50,180,90 
        WHITE_FULL_DRAW 130,90,180,130
        WHITE_FULL_DRAW 180,50,230,90   
           JMP EXIT
     
     CHECK_ZERO3:
         CMP Z1,1
         JNE CHECK_COL3
         CMP Z2,1
         JNE CHECK_COL3
         ;CALL WIN_PLAYER1
        WHITE_FULL_DRAW 80,50,130,90 
        WHITE_FULL_DRAW 130,50,180,90
        WHITE_FULL_DRAW 180,50,230,90
         
         JMP EXIT       
         CHECK_COL3:
           CMP Z6,1
           JNE CHECK_LEFT_DIAGONAL
           CMP Z9,1
           JNE CHECK_LEFT_DIAGONAL
           ;CALL WIN_PLAYER1
           WHITE_FULL_DRAW 180,50,230,90
           WHITE_FULL_DRAW 180,90,230,130
           WHITE_FULL_DRAW 180,130,230,170
           JMP EXIT          
         CHECK_LEFT_DIAGONAL: 
           CMP Z5,1
           JNE SCAN9
           CMP Z7,1
           JNE SCAN9
          ; CALL WIN_PLAYER1
           WHITE_FULL_DRAW 180,50,230,90
           WHITE_FULL_DRAW 130,90,180,130
           WHITE_FULL_DRAW 80,130,130,170
           JMP EXIT
         
         
         SCAN9:
            JMP SCAN4
            
     CHECK_ZERO4:
         CMP Z5,1
         JNE CHECK_COL11
         CMP Z6,1
         JNE CHECK_COL11
         ;CALL WIN_PLAYER1
         WHITE_FULL_DRAW 80,90,130,130
         WHITE_FULL_DRAW 130,90,180,130
         WHITE_FULL_DRAW 180,90,230,130
         JMP EXIT
         CHECK_COL11:
           CMP Z1,1
           JNE SCAN9
           CMP Z7,1
           JNE SCAN9
           ;CALL WIN_PLAYER1
         WHITE_FULL_DRAW 80,50,130,90
         WHITE_FULL_DRAW 80,90,130,130
         WHITE_FULL_DRAW 80,130,130,170
           JMP EXIT
      
     CHECK_ZERO5:
         CMP Z4,1
         JNE CHECK_COL22
         CMP Z6,1
         JNE CHECK_COL22
        ; CALL WIN_PLAYER1
          WHITE_FULL_DRAW 80,90,130,130
         WHITE_FULL_DRAW 130,90,180,130
         WHITE_FULL_DRAW 180,90,230,130
         JMP EXIT
         CHECK_COL22: 
           CMP Z2,1
           JNE SCAN4
           CMP Z8,1
           JNE SCAN4
          ; CALL WIN_PLAYER1
         WHITE_FULL_DRAW 130,50,180,90
         WHITE_FULL_DRAW 130,90,180,130
         WHITE_FULL_DRAW 130,130,180,170
           JMP EXIT
           
           SCAN4:
           CMP C,9
           JNE S2
           CALL MATCH_DRAW
           JMP EXIT
           S2:
             JMP SCAN
           
     CHECK_ZERO6:
         CMP Z4,1
         JNE CHECK_COL33
         CMP Z5,1
         JNE CHECK_COL33
        ; CALL WIN_PLAYER1
         WHITE_FULL_DRAW 80,90,130,130
         WHITE_FULL_DRAW 130,90,180,130
         WHITE_FULL_DRAW 180,90,230,130
         JMP EXIT
         CHECK_COL33:
           CMP Z3,1
           JNE SCAN4
           CMP Z9,1
           JNE SCAN10
          ; CALL WIN_PLAYER1 
            WHITE_FULL_DRAW 180,50,230,90
           WHITE_FULL_DRAW 180,90,230,130
           WHITE_FULL_DRAW 180,130,230,170
           JMP EXIT   
           
         SCAN10:
           JMP SCAN4
            
          
     CHECK_ZERO7:
         CMP Z8,1
         JNE CHECK_COL111
         CMP Z9,1
         JNE CHECK_COL111
         ;CALL WIN_PLAYER1
         WHITE_FULL_DRAW 80,130,130,170 
         WHITE_FULL_DRAW 130,130,180,170
         WHITE_FULL_DRAW 180,130,230,170
         JMP EXIT
         CHECK_COL111:
            CMP Z1,1
            JNE CHECK_LEFT_DIAGONAL1
            CMP Z4,1
            JNE CHECK_LEFT_DIAGONAL1
            ;CALL WIN_PLAYER1
         WHITE_FULL_DRAW 80,50,130,90
         WHITE_FULL_DRAW 80,90,130,130
         WHITE_FULL_DRAW 80,130,130,170 
            JMP EXIT
         CHECK_LEFT_DIAGONAL1:
            CMP Z5,1
            JNE SCAN11
            CMP Z3,1
            JNE SCAN11
            ;CALL WIN_PLAYER1
             CALL WIN_PLAYER1
           WHITE_FULL_DRAW 180,50,230,90
           WHITE_FULL_DRAW 130,90,180,130
           WHITE_FULL_DRAW 80,130,130,170
            JMP EXIT
          
          SCAN11:
           JMP SCAN4 
     CHECK_ZERO8:
          CMP Z7,1
          JNE CHECK_COL222
          CMP Z9,1
          JNE CHECK_COL222
          ;CALL WIN_PLAYER1  
          
          JMP EXIT
          CHECK_COL222:
            CMP Z5,1
            JNE SCAN12
            CMP Z2,1
            JNE SCAN12
            ;CALL WIN_PLAYER1
         WHITE_FULL_DRAW 130,50,180,90
         WHITE_FULL_DRAW 130,90,180,130
         WHITE_FULL_DRAW 130,130,180,170
           JMP EXIT
            JMP EXIT
           
          SCAN12:
            JMP SCAN5
           
     CHECK_ZERO9:
          CMP Z7,1
          JNE CHECK_COL333
          CMP Z8,1
          JNE CHECK_COL333
         ; CALL WIN_PLAYER1
          
          JMP EXIT
          CHECK_COL333:
            CMP Z3,1
            JNE CHECK_RIGHT_DIAGONAL1
            CMP Z6,1
            JNE CHECK_RIGHT_DIAGONAL1
           ; CALL WIN_PLAYER1
             WHITE_FULL_DRAW 180,50,230,90
           WHITE_FULL_DRAW 180,90,230,130
           WHITE_FULL_DRAW 180,130,230,170
            JMP EXIT
            CHECK_RIGHT_DIAGONAL1:
              CMP Z5,1
              JNE SCAN5
              CMP Z1,1
              JNE SCAN5
             ; CALL WIN_PLAYER1
          WHITE_FULL_DRAW 80,50,130,90 
         WHITE_FULL_DRAW 130,90,180,130
         WHITE_FULL_DRAW 180,130,230,170 
              JMP EXIT       
           
         SCAN5:
         CMP C,9
         JNE S3
         CALL MATCH_DRAW 
         JMP EXIT
         S3:
           JMP SCAN 
        
        
         CHECK_CROSS1:
        
        CMP Z2,2
        JNE CHECK_COLX1
        CMP Z3,2
        JNE CHECK_COLX1
        CALL WIN_PLAYER2
        JMP EXIT     
        CHECK_COLX1:
          CMP Z4,2
          JNE CHECK_RIGHT_DIAGONALX
          CMP Z7,2
          JNE CHECK_RIGHT_DIAGONALX
          CALL WIN_PLAYER2
          JMP EXIT          
        CHECK_RIGHT_DIAGONALX:
          CMP Z5,2
          JNE SCAN5
          CMP Z9,2
          JNE SCAN5
          CALL WIN_PLAYER2
          JMP EXIT
          
     CHECK_CROSS2:
         CMP Z1,2
         JNE CHECK_COLX2
         CMP Z3,2
         JNE CHECK_COLX2
         CALL WIN_PLAYER2
         JMP EXIT
         
         CHECK_COLX2:
           CMP Z5,2
           JNE SCAN5
           CMP Z8,2
           JNE SCAN5
           CALL WIN_PLAYER2
           JMP EXIT   
     
     CHECK_CROSS3:
         CMP Z1,2
         JNE CHECK_COLX3
         CMP Z2,2
         JNE CHECK_COLX3
         CALL WIN_PLAYER2
         JMP EXIT       
         CHECK_COLX3:
           CMP Z6,2
           JNE CHECK_LEFT_DIAGONALX
           CMP Z9,2
           JNE CHECK_LEFT_DIAGONALX
           CALL WIN_PLAYER2 
           JMP EXIT         
         CHECK_LEFT_DIAGONALX: 
           CMP Z5,2
           JNE SCAN6
           CMP Z7,2
           JNE SCAN6
           CALL WIN_PLAYER2
           JMP EXIT
     
     CHECK_CROSS4:
         CMP Z5,2
         JNE CHECK_COLX11
         CMP Z6,2
         JNE CHECK_COLX11
         CALL WIN_PLAYER2
         JMP EXIT
         CHECK_COLX11:
           CMP Z1,2
           JNE SCAN6
           CMP Z7,2
           JNE SCAN6
           CALL WIN_PLAYER2
           JMP EXIT
      
     CHECK_CROSS5:
         CMP Z4,2
         JNE CHECK_COLX22
         CMP Z6,2
         JNE CHECK_COLX22
         CALL WIN_PLAYER2
         JMP EXIT
         CHECK_COLX22: 
           CMP Z2,2
           JNE SCAN6
           CMP Z8,2
           JNE SCAN6
           CALL WIN_PLAYER2
           JMP EXIT
           
           SCAN6:
           CMP C,9
           JNE S4
           CALL MATCH_DRAW
           JMP EXIT
           S4:
             JMP SCAN
           
     CHECK_CROSS6:
         CMP Z4,2
         JNE CHECK_COLX33
         CMP Z5,2
         JNE CHECK_COLX33
         CALL WIN_PLAYER2
         JMP EXIT
         CHECK_COLX33:
           CMP Z3,2
           JNE SCAN6
           CMP Z9,2
           JNE SCAN6
           CALL WIN_PLAYER2
           JMP EXIT
          
     CHECK_CROSS7:
         CMP Z8,2
         JNE CHECK_COLX111
         CMP Z9,2
         JNE CHECK_COLX111
         CALL WIN_PLAYER2
         JMP EXIT
         CHECK_COLX111:
            CMP Z1,2
            JNE CHECK_LEFT_DIAGONALX1
            CMP Z4,2
            JNE CHECK_LEFT_DIAGONALX1
            CALL WIN_PLAYER2 
            JMP EXIT
         CHECK_LEFT_DIAGONALX1:
            CMP Z5,2
            JNE SCAN6
            CMP Z3,1
            JNE SCAN6
            CALL WIN_PLAYER2
            JMP EXIT
           
     CHECK_CROSS8:
          CMP Z7,2
          JNE CHECK_COLX222
          CMP Z9,2
          JNE CHECK_COLX222
          CALL WIN_PLAYER2 
          JMP EXIT
          CHECK_COLX222:
            CMP Z5,2
            JNE SCAN7
            CMP Z2,2
            JNE SCAN7
            CALL WIN_PLAYER2
            JMP EXIT
            
     CHECK_CROSS9:
          CMP Z7,2
          JNE CHECK_COLX333
          CMP Z8,2
          JNE CHECK_COLX333
          CALL WIN_PLAYER2
          JMP EXIT
          CHECK_COLX333:
            CMP Z3,2
            JNE CHECK_RIGHT_DIAGONALX1
            CMP Z6,2
            JNE CHECK_RIGHT_DIAGONALX1
            CALL WIN_PLAYER2 
            JMP EXIT
            CHECK_RIGHT_DIAGONALX1:
              CMP Z5,2
              JNE SCAN7
              CMP Z1,2
              JNE SCAN7
              CALL WIN_PLAYER2
              JMP EXIT        
           
         SCAN7:
         CMP C,9
         JNE S5
         CALL MATCH_DRAW 
         JMP EXIT
         S5:
           JMP SCAN 
      
       
            
DRAW_MAIN_BOX PROC  
    MOV AH, 0CH
    MOV AL, 4
    
    MOV CX, 80 ; beginning col
    MOV DX, 50 ; beginning row
    
   ROW_L1: INT 10h
        INC CX
        CMP CX,230
        JLE ROW_L1 
        
  
         
    MOV CX,80
    MOV DX,90
    
   ROW_L2:
        INT 10H
        INC CX
        CMP CX,230
        JLE ROW_L2
        
         
        
   MOV CX,80
   MOV DX,130   
   
   ROW_L3:
        INT 10H
        INC CX
        CMP CX,230
        JLE ROW_L3 
        
   MOV CX,80
   MOV DX,170
      
   ROW_L4:
        INT 10H
        INC CX
        CMP CX,230
        JLE ROW_L4   
        
        
        MOV CX,80
        MOV DX,50
   COL_L1:
    
        INT 10H
        INC DX
        CMP DX,170
        JLE COL_L1 
        
        MOV CX,130
        MOV DX,50
   COL_L2:
    
        INT 10H
        INC DX
        CMP DX,170
        JLE COL_L2 
        
        MOV CX,180
        MOV DX,50
   COL_L3:
    
        INT 10H
        INC DX
        CMP DX,170
        JLE COL_L3    
        
        
        MOV CX,230
        MOV DX,50
   COL_L4:
    
        INT 10H
        INC DX
        CMP DX,170
        JLE COL_L4 
        
        RET
         
WIN_PLAYER1 PROC
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 1
        INT 10h
; write char        
        MOV AH, 9
        MOV AL, 'P'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
         
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 2
        INT 10h  
        MOV AH, 9
        MOV AL, 'L'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 3
        INT 10h   
        MOV AH, 9
        MOV AL, 'A'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 4
        INT 10h    
        MOV AH, 9
        MOV AL, 'Y'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 5
        INT 10h 
        MOV AH, 9
        MOV AL, 'E'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 6
        INT 10h 
        MOV AH, 9
        MOV AL, 'R'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 7
        INT 10h    
        MOV AH, 9
        MOV AL, '1'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 8
        INT 10h 
        MOV AH, 9
        MOV AL, ' '
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 9
        INT 10h 
        MOV AH, 9
        MOV AL, 'W'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 10
        INT 10h 
        MOV AH, 9
        MOV AL, 'I'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 11
        INT 10h
        MOV AH, 9
        MOV AL, 'N'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 12
        INT 10h    
        MOV AH, 9
        MOV AL, 'S'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        ret
                
WIN_PLAYER2 PROC
       MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 1
        INT 10h
; write char        
        MOV AH, 9
        MOV AL, 'P'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
         
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 2
        INT 10h  
        MOV AH, 9
        MOV AL, 'L'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 3
        INT 10h   
        MOV AH, 9
        MOV AL, 'A'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 4
        INT 10h    
        MOV AH, 9
        MOV AL, 'Y'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 5
        INT 10h 
        MOV AH, 9
        MOV AL, 'E'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 6
        INT 10h 
        MOV AH, 9
        MOV AL, 'R'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 7
        INT 10h    
        MOV AH, 9
        MOV AL, '2'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 8
        INT 10h 
        MOV AH, 9
        MOV AL, ' '
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 9
        INT 10h 
        MOV AH, 9
        MOV AL, 'W'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 10
        INT 10h 
        MOV AH, 9
        MOV AL, 'I'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 11
        INT 10h
        MOV AH, 9
        MOV AL, 'N'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 12
        INT 10h    
        MOV AH, 9
        MOV AL, 'S'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        ret

MATCH_DRAW PROC
       MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 1
        INT 10h
; write char        
        MOV AH, 9
        MOV AL, 'M'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
         
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 2
        INT 10h  
        MOV AH, 9
        MOV AL, 'A'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 3
        INT 10h   
        MOV AH, 9
        MOV AL, 'T'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 4
        INT 10h    
        MOV AH, 9
        MOV AL, 'C'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 5
        INT 10h 
        MOV AH, 9
        MOV AL, 'H'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 6
        INT 10h 
        MOV AH, 9
        MOV AL, ' '
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 7
        INT 10h    
        MOV AH, 9
        MOV AL, 'D'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 8
        INT 10h 
        MOV AH, 9
        MOV AL, 'R'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 9
        INT 10h 
        MOV AH, 9
        MOV AL, 'A'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
         MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 10
        INT 10h 
        MOV AH, 9
        MOV AL, 'W'
        MOV BL, 1 
        MOV CX, 1
        INT 10h
        
        ret
                      
         EXIT:
         
        MOV AH,0
        INT 16h 
        
    
        MOV AX,3
        INT 10h
        
        MOV AH,4CH
        INT 21h
;main EndP
     End main

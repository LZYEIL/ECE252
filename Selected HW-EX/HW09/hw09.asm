; Filename:    hw09.asm
; Author(s):   Zhiyuan Li
;    
;
; Description: Performs control operations
;              
        .ORIG x0200
START

    ; YOUR CODE GOES BELOW HERE
    LD R0, ARRAY      ;Get the value from Array[0]
    LD R1, VAL1       ;Get the value from VAL1
    ADD R0, R0, R1    ;Result of sum between Array[0] and -254

    BRnp KMLOGIC      ;Go to the KM Logic block if Non-zero


KINIT  ST R0, K       ;Initialize K to 0
       LD R3, VAL2    ;Get the value -77 from VAL2
       LEA R4, ARRAY  ;Get the address of Array[0]
       LDR R4, R4, #1 ;Get the value of Array[1]
       ADD R4, R4, R3 ;Result of sum between Array[1] and -77

       BRnz MNLOGIC   ;Go to MN Logic Block if Not positive
       BRp  MLOGIC    ;Go to M Logic Block  otherwise  


KMLOGIC  AND R0, R0, #0  ;Clear R0
         ADD R0, R0, #1  ;Initialize R0 to 1
         ST R0, K        ;Initialize K = 1
         LD R5, P        ;Get the value of P
         ST R5, M        ;Set M = P

NINIT    ST R0, N        ;Set N = 1
         BR DONE         ;End the program

MLOGIC   ADD R0, R0, #1  ;Add 1 to R0 -->Set to 1
         ST R0, M        ;Set M = 1
         BR NINIT        ;Go to the N Logic


MNLOGIC  ST R0, M        ;Set M = 0
         AND R6, R6, #0  ;Clear R6
         ADD R6, R6, #10 ;Add 10 to R6
         ST R6, N        ;Set N = 10

    ; YOUR CODE GOES ABOVE HERE

DONE    BR DONE

K   .FILL  xFFFF      
M   .FILL  xFFFF     
N   .FILL  xFFFF       
P   .FILL  xCAFE 

ARRAY   .FILL 254
        .FILL 10  

; YOUR .FILLS GOES HERE

VAL1  .FILL -254   ;Define the value -254
VAL2  .FILL -77    ;Define the value 77

	.END

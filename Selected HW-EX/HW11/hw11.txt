; Filename:    hw11B.asm
;
; Description: Performs various operations on values in
;              various memory locations


        .ORIG x0200
START

        ;DO NOT MODIFY the function calls below 

        LEA R0, RT1
        JSR DRAW_RECTANGLE
        LEA R0, RT2
        JSR DRAW_RECTANGLE
        LEA R0, RT3
        JSR DRAW_RECTANGLE
        LEA R0, RT4
        JSR DRAW_RECTANGLE
        LEA R0, RT5
        JSR DRAW_RECTANGLE
        LEA R0, RT6
        JSR DRAW_RECTANGLE
        LEA R0, RT7
        JSR DRAW_RECTANGLE
        LEA R0, RT8
        JSR DRAW_RECTANGLE
        LEA R0, RT9
        JSR DRAW_RECTANGLE
        LEA R0, RT10
        JSR DRAW_RECTANGLE


HW11B_END    BR HW11B_END

RT1         .FILL x7C00 ; Color
            .FILL 10     ; Row 
            .FILL 10    ; Col 
            .FILL 10    ; Width
            .FILL 90   ; Height
            
RT2         .FILL x7C00 ; Color
            .FILL 10     ; Row 
            .FILL 10    ; Col 
            .FILL 100    ; Width
            .FILL 10   ; Height

RT3         .FILL x7C00 ; Color
            .FILL 10    ; Row
            .FILL 110    ; Col 
            .FILL 10    ; Width
            .FILL 90    ; Height

RT4         .FILL x7C00 ; Color
            .FILL 100    ; Row
            .FILL 10    ; Col 
            .FILL 110    ; Width
            .FILL 10    ; Height

RT5         .FILL x03E0 ; Color
            .FILL 30     ; Row 
            .FILL 30    ; Col 
            .FILL 10    ; Width
            .FILL 60   ; Height

RT6         .FILL x03E0 ; Color
            .FILL 30     ; Row 
            .FILL 30    ; Col 
            .FILL 70    ; Width
            .FILL 10   ; Height

RT7         .FILL x03E0 ; Color
            .FILL 80     ; Row 
            .FILL 30    ; Col 
            .FILL 70    ; Width
            .FILL 10   ; Height

RT8         .FILL x03E0 ; Color
            .FILL 30     ; Row 
            .FILL 90    ; Col 
            .FILL 10    ; Width
            .FILL 60   ; Height

RT9         .FILL x7FFF ; Color
            .FILL 60     ; Row 
            .FILL 50    ; Col 
            .FILL 10    ; Width
            .FILL 10   ; Height

RT10         .FILL x7FFF ; Color
            .FILL 60     ; Row 
            .FILL 70    ; Col 
            .FILL 10    ; Width
            .FILL 10   ; Height

;*****************************************************
; Draws a square based on the information stored at
; the memory location supplied in R0
;
; Parameter
;   R0 - Address of Rectangle Info
; Returns
;   Nothing 
;
; Author(s):   Zhiyuan Li
;              Reginald Yuan
;*****************************************************
DRAW_RECTANGLE

    ST R0, DRAW_RECTANGLE_R0   ;Context save
    ST R1, DRAW_RECTANGLE_R1   ;Context save
    ST R2, DRAW_RECTANGLE_R2   ;Context save
    ST R3, DRAW_RECTANGLE_R3   ;Context save
    ST R4, DRAW_RECTANGLE_R4   ;Context save
    ST R5, DRAW_RECTANGLE_R5   ;Context save
    ST R6, DRAW_RECTANGLE_R6   ;Context save
    ST R7, DRAW_RECTANGLE_R7   ;Context save


    AND R6, R0, R0             ;Copy address from R0 to R6
    LDR R0, R6, #0             ;Get the color of the Rectangle
    LDR R1, R6, #1             ;Get the row number of the Rectangle
    LDR R2, R6, #2             ;Get the col number of the Rectangle
    LDR R3, R6, #3             ;Get the width of the Rectangle
    BRz DRAW_RECTANGLE_EXIT    ;Invalid width, end the program
    LDR R4, R6, #4             ;Get the height of the Rectangle
    BRz DRAW_RECTANGLE_EXIT    ;Invalid height, end of the program

    ADD R6, R1, R4             ;Sum of row and height
    LD R5, INVALID_CONDITION1  ;Get the first invalid condition number
    ADD R5, R5, R6             ;row+height - 127
    BRp DRAW_RECTANGLE_EXIT    ;Invalid condition, end of the program

    ADD R6, R2, R3             ;Sum of col and width
    LD R5, INVALID_CONDITION2  ;Get the second invalid condition number
    ADD R5, R5, R6             ;col+width - 123
    BRp DRAW_RECTANGLE_EXIT    ;Invalid condition, end of the program

DRAW_RECTANGLE_LOOP
    JSR DRAW_ROW               ;Draw a single row inside a Rectangle
    ADD R1, R1, #1             ;Add one to row each time
    ADD R4, R4, #-1            ;Decrease the R4 each time(forward 1 height) 
    BRnp DRAW_RECTANGLE_LOOP   ;If not zero, continue looping

DRAW_RECTANGLE_EXIT

    LD R0, DRAW_RECTANGLE_R0   ;Context restore
    LD R1, DRAW_RECTANGLE_R1   ;Context restore
    LD R2, DRAW_RECTANGLE_R2   ;Context restore
    LD R3, DRAW_RECTANGLE_R3   ;Context restore
    LD R4, DRAW_RECTANGLE_R4   ;Context restore
    LD R5, DRAW_RECTANGLE_R5   ;Context restore
    LD R6, DRAW_RECTANGLE_R6   ;Context restore
    LD R7, DRAW_RECTANGLE_R7   ;Context restore


    RET

  INVALID_CONDITION1  .FILL #-127   ;Fill in the first condition check number
  INVALID_CONDITION2  .FILL #-123   ;Fill in the second condition check number

  DRAW_RECTANGLE_R0   .BLKW  1
  DRAW_RECTANGLE_R1   .BLKW  1
  DRAW_RECTANGLE_R2   .BLKW  1
  DRAW_RECTANGLE_R3   .BLKW  1
  DRAW_RECTANGLE_R4   .BLKW  1
  DRAW_RECTANGLE_R5   .BLKW  1
  DRAW_RECTANGLE_R6   .BLKW  1
  DRAW_RECTANGLE_R7   .BLKW  1

    



;**********************************************
; Draws a row on the LCD.  The left most
; pixel is located at (Row, Col).  The 
; last pixel is located at (Row, Col + Width)
;
; Parameters
; R0 - Color of the row
; R1 - Row Number
; R2 - Col Number
; R3 - Width
;
; Returns
; Nothing
;
; Author(s):   Zhiyuan Li
;              Reginald Yuan
;**********************************************
DRAW_ROW

    ST R0, DRAW_ROW_R0             ;Context save
    ST R1, DRAW_ROW_R1             ;Context save
    ST R2, DRAW_ROW_R2             ;Context save
    ST R3, DRAW_ROW_R3             ;Context save
    ST R4, DRAW_ROW_R4             ;Context save
    ST R5, DRAW_ROW_R5             ;Context save
    ST R7, DRAW_ROW_R7             ;Context save


    AND R4, R0, R0                 ;Copy the color to R4
    LD R5, ADD_FORMULA_CONSTANT    ;Copy the first constant to R5
    ADD R3, R3, #0                 ;Get the value of R3(Width)
    BRz DRAW_ROW_EXIT              ;Finish if no more pixel

DRAW_ROW_LOOP
    LD R0, ROW_FORMULA_CONSTANT    ;Copy the constant to R0
    JSR MULT                       ;Calculate row*x0080

    ADD R0, R0, R5                 ;Partial result of address
    ADD R0, R0, R2                 ;Full result of address

    STR R4, R0, #0                 ;Write the color to the pixel address
    ADD R2, R2, #1                 ;Add one to col each time
    ADD R3, R3, #-1                ;Decrease the R3 count(Forward 1 width) 
    BRnp DRAW_ROW_LOOP             ;Continue looping until no more pixel   


DRAW_ROW_EXIT
    LD R0, DRAW_ROW_R0             ;Context restore
    LD R1, DRAW_ROW_R1             ;Context restore
    LD R2, DRAW_ROW_R2             ;Context restore
    LD R3, DRAW_ROW_R3             ;Context restore
    LD R4, DRAW_ROW_R4             ;Context restore
    LD R5, DRAW_ROW_R5             ;Context restore
    LD R7, DRAW_ROW_R7             ;Context restore


        RET

    ROW_FORMULA_CONSTANT  .FILL  x0080  ;Fill in the constant number used in row calculation  
    ADD_FORMULA_CONSTANT  .FILL  xC000  ;Fill in the constant number at the front in formula

    DRAW_ROW_R0  .BLKW  1
    DRAW_ROW_R1  .BLKW  1
    DRAW_ROW_R2  .BLKW  1
    DRAW_ROW_R3  .BLKW  1
    DRAW_ROW_R4  .BLKW  1
    DRAW_ROW_R5  .BLKW  1
    DRAW_ROW_R7  .BLKW  1





;************************************
; Multiples two numbers AxB
;
; Parameters
;   R0 - A 
;   R1 - B 
;Returns 
;   R0 - AxB
;************************************
MULT

    ST R7, MULT_R7   ;Context save
    ST R5, MULT_R5   ;Context save
    ST R1, MULT_R1   ;Context save

    AND R5, R5, #0   ;Clear R5
    ADD R1, R1, #0   ;Get the value of B
    BRz MULT_EXIT    ;Go to exit condition if 0

MULT_LOOP
    ADD R5, R5, R0   ;A+A -> Store to R5
    ADD R1, R1, #-1  ;Decrese the number of times in B
    BRnp MULT_LOOP   ;Continue looping until B is 0

MULT_EXIT
    ADD R0, R5, #0   ;Copy value from R5 to R0

    LD R1, MULT_R1   ;Context restore
    LD R5, MULT_R5   ;Context restore
    LD R7, MULT_R7   ;Context restore

    RET

MULT_R1  .BLKW  1    
MULT_R5  .BLKW  1    
MULT_R7  .BLKW  1   


	.END


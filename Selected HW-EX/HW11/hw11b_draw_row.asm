; Filename:    hw11b_draw_row.asm
;
; Description: Performs various operations on values in
;              various memory locations


        .ORIG x0200
START

        
        LEA R6, TEST1
        LDR R0, R6, #0
        LDR R1, R6, #1
        LDR R2, R6, #2
        LDR R3, R6, #3
        JSR DRAW_ROW    ; Verify that a 30 pixel line is drawn in the 
                        ; middle of the screen 


HW11B_END    BR HW11B_END

LCD_START       .FILL xC000
LCD_ROW_OFFSET  .FILL x80

TEST1           .FILL x7C00 ; Color 
                .FILL 64    ; Row Number
                .FILL 52    ; Col Number
                .FILL 30    ; Width (Num Pixels) 
           
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
    ADD R3, R3, #0                 ;Get the value of R3
    BRz DRAW_ROW_EXIT              ;Finish if no more pixel

DRAW_ROW_LOOP
    LD R0, ROW_FORMULA_CONSTANT    ;Copy the constant to R0
    JSR MULT                       ;Calculate row*x0080

    ADD R0, R0, R5                 ;Partial result of address
    ADD R0, R0, R2                 ;Full result of address

    STR R4, R0, #0                 ;Write the color to the pixel address
    ADD R2, R2, #1                 ;Add one to col each time
    ADD R3, R3, #-1                ;Decrease the R3 count 
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


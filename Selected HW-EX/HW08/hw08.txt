; Filename:    hw08.asm
; Author(s):   Zhiyuan Li
;           
;
; Description: Performs various operations on values in
;              various memory locations


        .ORIG x0200
START
        LEA R0, ARRAY             ; get pointer to ARRAY array

        ; YOUR CODE GOES BELOW HERE
        LDR R1, R0, #0  ; Load value from Array[0] to R1
        ST R1, VAR1     ; Store the value back to VAR1

        LD R2, VAR2     ; Load value from VAR2 to R2
        ADD R2, R1, R2  ; Add value of VAR1/VAR2
        ST R2, VAR2     ; Store the sum back in memory

        LDR R3, R0, #1  ; Get the value of Array[1]
        NOT R2, R2      ; Negate R2 (The value of VAR2)
        ADD R2, R2, #1  ; Two's complement (-VAR2)
        ADD R3, R3, R2  ; Array[1] - VAR2 --> store in R3
        STR R3, R0, #3  ; Store back the value to memory



        ; YOUR CODE GOES ABOVE HERE

        BR START

        ; program ARRAY

VAR1       .FILL  #2  ; VAR1 = value 1 in decimal
VAR2       .FILL  10  ; VAR2 = value 10 in decimal      
VAR3       .FILL  x14 ; VAR3 = value 20 in decimal


      ; Note: normally we would not comment an array like this,
      ; but we wanted to make it easy to see which element is which
ARRAY    .FILL x0001 ; ARRAY[0]
         .FILL x000F ; ARRAY[1]
         .FILL xFFFF ; ARRAY[2]
         .FILL xFFFE ; ARRAY[3]
         .FILL x0101 ; ARRAY[4]

        .END


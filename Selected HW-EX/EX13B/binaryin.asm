; inputs a 16-bit binary value from the keyboard (one bit at a time)
; puts the resulting value into register R3
; assume the user only types 0 or 1 (no error handling!)

		.ORIG x3000
START

INIT
; initialize registers with values we will need
         LD R4, ASCIIDIFF          ; to convert ASCII code to numeric value	
         AND R3, R3, #0         ; initialize number value to 0
         LD R2, NBITS             ; # bits to input (loop control)

; output blank line to console
         LEA  R0, NEWLINE
         PUTS


; get a key from the keyboard and echo it to the screen (will be in R0)

GETKEY   GETC
         OUT

; convert ASCII code to numeric value

CONVERT	 ADD R0, R0, R4

; shift register one position to the left (same as multiply by 2)
; then add in new bit value at the least-significant position

APPEND	 ADD R3, R3, R3
         ADD R3, R3, R0

; decrement loop variable and iterate if non-zero

ITERATE	 ADD R2, R2, #-1
         BRnp GETKEY

; done with one word, but let's get another!

DO_IT_AGAIN	BRnzp INIT

; --- PROGRAM DATA ---

ASCIIDIFF  .FILL xFFD0     ; difference between ASCII and numeric values	
NBITS	   .FILL #16       ; # of bits to input
NEWLINE    .STRINGZ "\n\n" ; blank line between binary words

.END 

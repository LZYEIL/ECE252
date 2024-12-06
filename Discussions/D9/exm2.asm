; Description: starting at address x4000, check 1000 consecutive 
; memory locations and set any negative values to 0
   
; R0: ADDR (address pointer to current memory location)
; R1: COUNT (count of # locations remaining)

	.ORIG x0200

BEGIN
	;initialize
	AND R2, R2, #0 ;value 0
	LD R0, ADDR		;starting point
	LD R1, COUNT	; loading the count

LOOP 	BRz EXIT
		LDR R3, R0, #0 ;read the memory
		BRzp NOneg
		STR R2, R0, #0 ; clear that memory because it was negative
NOneg	
		ADD R0, R0, #1 ;update the addr
		ADD R1, R1, #-1 ; updateing the counter	
		BR LOOP
		



EXIT BR EXIT

	.END

ADDR 	.FILL  x4000 ;starting address
COUNT 	.FILL #1000 ; num of locations
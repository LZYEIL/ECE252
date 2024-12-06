; Description: starting at address x4000, initialize 1000
;              consecutive memory locations to -1    
; R0: ADDR (address pointer to current memory location)
; R1: COUNT (count of # locations remaining)
; R2: VALUE (value to write to memory)
	.ORIG x0200

BEGIN

	;initialize
	AND R2, R2, #0 ;clear 
	ADD R2, R2, #-1 ; value that we fill in the memory
	LD R0, ADDR		;starting point 
	LD R1, COUNT 	; cont value


LOOP 	BRz EXIT	
		STR R2, R0, #0  ; mem[ADD] <- -1
		ADD R0, R0, #1  ; update the addr, addr = addr +1 (addr++)
		ADD R1, R1, #-1 ; update the count, count = count -1
		BR LOOP 


EXIT BR EXIT
	.END

ADDR 	.FILL  x4000 ;starting address
COUNT 	.FILL #1000 ; num of locations
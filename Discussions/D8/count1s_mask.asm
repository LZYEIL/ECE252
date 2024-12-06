; Count the number of 1s in a word
; R0: word
; R1: count of 1s in the word
; R2: mask
; R3: temporary masked word
;
	.ORIG x0200
START
	
	AND R1, R1, #0 ;clear the count
	ADD R2, R1, #1 ;start masking at LSB

DOMASK
	AND R3, R0, R2 ;mask off the number
	BRz SHIFTMASK
	ADD R1, R1, #1 ;inc if there was a one


SHIFTMASK
	ADD R2, R2, R2 ;mask shift left = mask *2 = mask +mask
	BRnp DOMASK


	
DONE BR DONE	

	.END

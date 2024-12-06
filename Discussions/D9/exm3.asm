; Description: starting at address ARRAY, change all negative
;              values in the ARRAY to be 0
; R0: ADDR  (address pointer to current memory location)
; R1: COUNT (count of # locations remaining)
; R2: ZERO  (value to write to memory)
; R3: VALUE (value read from memory at current array location)
	.ORIG x0200

BEGIN
	;init state
	AND R2, R2, #0 ;value 0
	LEA R0, ARRAY ;get the addr to array
	LD R1, ARRAY_SIZE

LOOP 	LDR R3, R0, #0 ; get the current value from array
		BRzp NEXTVALUE
		STR R2, R0, #0 ; clear the value of the mmeory because it was negative

NEXTVALUE
		ADD R0, R0, #1 ; update the addr
		ADD R1, R1, #-1 ;update the count
		BRnp LOOP


EXIT BR EXIT
	
	; program data
ARRAY_SIZE	.FILL #8
ARRAY	.FILL #3
		.FILL #-7
		.FILL #0
		.FILL #2
		.FILL #-6
		.FILL #-3
		.FILL #-4
		.FILL #4

	.END

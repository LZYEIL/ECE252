        .orig x0200
START   
	LD	R0, TESTVAL
	LD	R1, COUNT
LOOP	JSR	ROR

	BRnzp	LOOP		; loop forever

; --- DATA FOR MAIN PROGRAM ---
TESTVAL	.FILL	x8000
COUNT	.FILL	4


; ROR
; rotates operand right N bits
; Assumes: R0 value to rotate
;          R1 rotate count
; Returns: R0 result
ROR
	ST	R1, ROR_R1	; context save
	ST	R7, ROR_R7
;
;	NOT	R1, R1		; get -N
;	ADD	R1, R1, #1
;	ADD	R1, R1, #15	; now have 15 - N
;	ADD	R1, R1, #1	; now have 16 - N
	NOT	R1, R1
	AND	R1, R1, x000F	; now have  15 - (N%16)	
	ADD	R1, R1, #1	; now have 16 - N
	JSR	ROL		; rotate left 16-N bit
ROR_exit
	LD	R7, ROR_R7	; context restore
	LD	R1, ROR_R1
	RET
ROR_R1	.BLKW	1
ROR_R7	.BLKW	1
		


; ROL
; rotates operand left N bits
; Assumes: R0 value to rotate
;          R1 rotate count
; Returns: R0 result
ROL
	ST	R1, ROL_R1	; context save
	ST	R7, ROL_R7
;
;	ADD	R1, R1, #0 	; test N
	AND	R1, R1, xF	; test and limit to 15 max
	BRz	ROL_exit	; do nothing if 0 
ROL_loop
	JSR	ROL1		; rotate left 1 bit
	ADD	R1, R1, #-1	; decrement count
	BRnp	ROL_loop	; keep going until down to 0
ROL_exit
	LD	R7, ROL_R7	; context restore
	LD	R1, ROL_R1
	RET
ROL_R1	.BLKW	1
ROL_R7	.BLKW	1
		
	

; ROL1
; rotates operand left 1 bit
; Assumes: R0 value to rotate
; Returns: R0 result
ROL1
	ADD R0, R0, #0		; test msb of operand
	BRzp ROL1_msb0

ROL1_msb1
	ADD R0, R0, R0		; msb was 1, so shift...
	ADD R0, R0, #1		;   ...then add 1 at lsb
	BR ROL1_exit

ROL1_msb0
	ADD R0, R0, R0;		; msb was 0, so just shift

ROL1_exit
	RET
		
	.end
        
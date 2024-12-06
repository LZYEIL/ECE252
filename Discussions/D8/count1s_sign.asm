; Count the number of 1s in a word
; R0: word
; R1: count of 1s in the word
; R2: working copy of word
;
	.ORIG x0200
START

	AND R1, R1, #0 ;clear the count
	ADD R2, R0, #0 ; set the flag based on MSB

LOOP ADD R2, R2, #0
BRzp SHIFTNUM
	ADD R1, R1, #1

SHIFTNUM
	ADD R2, R2, R2
	BRnp LOOP	


DONE BR DONE



	.END

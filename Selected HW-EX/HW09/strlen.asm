; Filename:    strend.asm
; Author:      252 Staff
; Description: test program for finding the end of
;              a null-terminated string

        .orig x0200

START   
	LEA	R1, S1
	JSR	STRLEN
	LEA	R1, S6
	JSR	STRLEN
	LEA	R1, S2
	JSR	STRLEN
	LEA	R1, S5
	JSR	STRLEN
	LEA	R1, S3
	JSR	STRLEN
	LEA	R1, S4
	JSR	STRLEN
	LEA	R1, S7
	JSR 	STRLEN
		
	BR	START	; loop forever

S1	.STRINGZ	"Ciao!"
S2	.STRINGZ	"Hi!"
S3	.STRINGZ	"Salve!"
S4	.STRINGZ	"Hello!"
S5	.STRINGZ	"Gelato!"
S6	.STRINGZ	""
S7	.STRINGZ	"Italiano"

; Subroutine:  STRLEN
; Description: Finds length of ASCIIZ STRING
; Assumes:     R1 = address of start of ASCIIZ string
; Returns:     R2 = alength of the string
STRLEN
	ST	R0, STRLEN_R0	; context save
	ST  R1, STRLEN_R1
	AND R2, R2, #0

STRLEN_LOOP
	LDR	R0, R1, #0	; get current character
	BRz	STRLEN_EXIT	; at null terminator?

	
	ADD	R1, R1, #1	; increment string pointer
	ADD
	BR	STRLEN_LOOP

STRLEN_EXIT
	LD	R0, STRLEN_R0	; context restore
	LD  R1, STRLEN_R1

	RET

STRLEN_R0	.BLKW	1	
STRLEN_R1   .BLKW   1

		
	.end
        
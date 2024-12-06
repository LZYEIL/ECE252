        .orig x3000

START   
	; first show initial strings before modification
	
        ; print all three strings on one line
	LEA	R0, LF	; print newline
	PUTS
	LEA	R0, S1	; print the strings
	PUTS
	LEA	R0, S2
	PUTS
	LEA	R0, S3
	PUTS
	LEA	R0, LF	; print newline
	PUTS

TEST1	; first test
	LEA	R1, S2
	LEA	R2, S3
	JSR	STRCAT	; append S2 to S3
			; after subroutine returns, S3 should be "horse+bird+"

        ; print all three strings on one line
	LEA	R0, S1	; print the strings
	PUTS
	LEA	R0, S2
	PUTS
	LEA	R0, S3
	PUTS
	LEA	R0, LF	; print newline
	PUTS

TEST2	; second test
	LEA	R1, S1
	LEA	R2, S3
	JSR	STRCAT	; append S1 to S3
			; after subroutine returns, S3 should be "horse+bird+cat+"

        ; print all three strings on one line
	LEA	R0, S1	; print the strings
	PUTS
	LEA	R0, S2
	PUTS
	LEA	R0, S3
	PUTS
	LEA	R0, LF	; print newline
	PUTS

	HALT		; end program

; test data
LF	.STRINGZ	"\n" 
S1	.STRINGZ	"cat+"
S2	.STRINGZ	"bird+"
S3	.STRINGZ	"horse+"
	.BLKW	16	; extra space



; STRCPY
; Copy source string to destination
; Assumes: R1 - source string address
;          R2 - destination address
; Returns: Nothing

; -- put your STRCPY subroutine and its data below here --
STRCPY
    ST R1, STRCPY_R1
    ST R2, STRCPY_R2
    ST R7, STRCPY_R7
	ST R3, STRCPY_R3	; context save

CPY_LOOP
   LDR R3, R1, #0  ;Get the first char to R3
   STR R3, R2, #0  ;Store the char to R2
   ADD R3, R3, #0  ;Check the contents of R3
   BRz STRCPY_EXIT ;If null, then exit the program

   ADD R1, R1, #1 ; Add one from source address
   ADD R2, R2, #1 ; Add one from destination address
   BR CPY_LOOP    ; Loop again


STRCPY_EXIT

    LD R3, STRCPY_R3 ;context restore
    LD R7, STRCPY_R7 
				
	RET

STRCPY_R3   .BLKW  #1 
STRCPY_R7   .BLKW  #1
STRCPY_R1   .BLKW  #1
STRCPY_R2   .BLKW  #1 

; -- put your STRCPY subroutine and its data above here --


; ONLY TURN IN YOUR STRCAT SUBROUTINE CODE AND ITS DATA.
; DO NOT TURN IN THE CALLER CODE AND DATA ABOVE

; DO NOT MODIFY ANYTHING ABOVE HERE *EXCEPT* FOR COPYING
; IN YOUR **TESTED AND WORKING** STRCPY SUBROUTINE

; STRCAT
; Append source string to destination
; Assumes: R1 - source string address
;          R2 - destination address
; Returns: Nothing
STRCAT
			
  ST	R0, STREND_R0 ; context save
  ST	R7, STREND_R7
  ST	R1, STREND_R1
  ST	R2, STREND_R2

STREND_LOOP
	LDR	R0, R2, #0	  ; get current character
	BRz	STRCPY_LOGIC  ; at null terminator?
	
	ADD	R2, R2, #1	; increment string pointer
	BR	STREND_LOOP


STRCPY_LOGIC
   JSR STRCPY      ;Copy the string to that address


STRCAT_EXIT
  LD	R0, STREND_R0	; context restore
  LD	R1, STREND_R1	; context restore
  LD	R2, STREND_R2	; context restore
  LD	R7, STREND_R7	; context restore

	RET
STREND_R0	.BLKW	1 
STREND_R7	.BLKW	1   
STREND_R1	.BLKW	1  
STREND_R2	.BLKW	1  

	.end
       
; Echo all key presses to console
;
; R2 - used to check status
; R1 - IO base address
; R0 - character from keyboard to display
;
        .orig x0200

START
	LD R1 , IO_BASE ; pointer to KBSR (got FE00)

POLL_KB
	LDR R2, R1, #0 ; Get keyboard status bit (KBSR)
	BRzp POLL_KB ;if not ready keep polling

	LDR R0, R1, #2 ; Get the char from keyboard (KBDR)

POLL_DS	LDR R2, R1, #4 ; Get display status reg (DSR)
	BRzp POLL_DS ; in not ready keep polling

	STR R0, R1, #6 ; write in Diplay Data Register (DDR)

	BR POLL_KB

	

.end

IO_BASE .FILL xFE00 ; base address for IO operation

;; xFE00  -> KBSR
;; xFE02  -> KBDR
;; xFE04  -> DSR
;; xFE06  -> DDR


;1000 0000 0000 0000 --> 8000

















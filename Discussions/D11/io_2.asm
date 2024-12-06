; Echo only lower case key presses to console
;
; R2 - used to check status
; R1 - IO base address
; R0 - character from keyboard to display
;
        .orig x0200

       .orig x0200

START
        LD R1 , IO_BASE ; pointer to KBSR (got FE00)

POLL_KB
        LDR R2, R1, #0 ; Get keyboard status bit (KBSR)
        BRzp POLL_KB ;if not ready keep polling

        LDR R0, R1, #2 ; Get the char from keyboard (KBDR)

        ; check to see if it is lower case
        ; check if less than 'a'
        LD R3, neg_a;
        ADD R5, R3, R0 ; check agains -a
        BRn  POLL_KB

        ; check if more than 'z'
        LD R3, neg_z ;load -z
        ADD R5, R3, R0 ;check against -z
        BRp POLL_KB

POLL_DS LDR R2, R1, #4 ; Get display status reg (DSR)
        BRzp POLL_DS ; in not ready keep polling

        STR R0, R1, #6 ; write in Diplay Data Register (DDR)

        BR POLL_KB

        

.end

IO_BASE .FILL xFE00 ; base address for IO operation
neg_a .FILL xFF9F
neg_z .FILL xFF86



; 'a'= x61 --> x0061 --> 0000 0000 0110 0001 -C-> 1111 1111 1001 1110 -add1-> 1111 1111 1001 1111  --> FF9F = -a
; 'z'= x7A --> x007A --> 0000 0000 0111 1010 -C-> 1111 1111 1000 0101 -add1-> 1111 1111 1000 0110  --> FF96 = -z
















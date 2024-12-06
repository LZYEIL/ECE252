; This is a program used in the ECE/CS 252
; PennSim tutorial.
;
; YOU SHOULD NOT COMMENT YOUR CODE LIKE THIS!
;
; In this case, the comments are not intended
; to be useful because we want you to run the
; code and answer questions about what happens
; in PennSim rather than focus on figuring out
; what the code does.

	.ORIG x0200
START   
	NOT  R2, R0     ; R2 <- NOT R0
	NOT  R3, R1     ; R3 <- NOT R1
	AND  R3, R0, R3 ; R3 <- R0 AND R3	
	AND  R2, R1, R2 ; R2 <- R1 AND R2	
	NOT  R2, R2     ; R2 <- NOT R2
	NOT  R3, R3     ; R3 <- NOT R3
	AND  R2, R2, R3 ; R2 <- R2 AND R3
	NOT  R2, R2     ; R2 <- NOT R2	

	BR START           ; repeat forever

	.END
        
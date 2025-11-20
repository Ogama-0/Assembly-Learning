		org $4
Vector_001 	dc.l Main
		org $500
	move.l #-1,d0         ; Initialise D0.
Main
	move.b #$76,d1
	add.b #$12,d1
	
Abs 	tst.l d0
		bmi IS_NEG
		jmp EXIT
		
IS_NEG	NEG.l d0
		;muls.l #-1,d0
		jmp EXIT

EXIT 	illegal

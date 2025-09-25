		org $4
Vector_001 	dc.l Main
		org $500
Main	move.l #-1,d0         ; Initialise D0.
Abs 	tst.l d0
		bmi IS_NEG
		jmp EXIT
		
IS_NEG	NEG.l d0
		;muls.l #-1,d0
		jmp EXIT

EXIT 	illegal

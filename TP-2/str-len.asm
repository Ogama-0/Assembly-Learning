                org         $4
Vector_001      dc.l        Main
                org         $500
Main            movea.l     #STRING,a0 ; Initialise A0 avec l'adresse de la chaîne.

StrLen          clr.l       D0
loop            tst.b       (a0)+   ; Compare D1 et D2.
                beq         exit ; D2 ≤ D1 (comparaison signée).
                addq.l      #1,D0
                jmp         loop
exit            illegal 

                org $550

STRING          dc.b "Cette chaine comporte 36 caracteres.",0

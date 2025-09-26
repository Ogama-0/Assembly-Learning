                org         $4
Vector_001      dc.l        Main
                org         $500
Main            movea.l     #STRING,a0 ; Initialise A0 avec l'adresse de la chaîne.

SpaceCount      clr.l       D0        ; clear D0
loop            tst.b       (a0)      ; *a0 == 0 si the last char
                beq         exit      ; si Z = 0 ie si *a0 == 0 is a0 == '\0'
                cmp.b       #32,(a0)+
                bne         loop      ; a0 != ' ' go to loop 
                add.l      #1,D0     ; D0 ++
                jmp         loop


exit            illegal 
                org $550

STRING          dc.b "Cette chaine comporte 4 espaces.",0

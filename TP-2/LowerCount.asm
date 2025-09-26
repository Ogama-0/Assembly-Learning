                org         $4
Vector_001      dc.l        Main
                org         $500
Main            movea.l     #STRING,a0 ; Initialise A0 avec l'adresse de la chaîne.

LowerCount      clr.l       D0
                add.l       #-1,a0     ; pour que la loop soit plus simple a gere
                
loop            add.l       #1,a0      ; vas a la prochaine lettre
                cmp.b       #0,(a0)
                beq         exit       ; if a0 == '\0' go exit

                cmp.b       #'a',(a0)
                blt         loop       ; if a0 > 'a' go loop
                cmp.b       #'z',(a0)
                bge         loop       ; if a0 < 'z' go loop
                add.l       #1,D0
                jmp         loop
exit            illegal
                org         $550
STRING         dc.b         "Cette chaine comporte 28 minuscules.",0

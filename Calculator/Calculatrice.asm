        ; ==============================
        ; Initialisation des vecteurs
        ; ==============================

                org         $4
vector_001      dc.l        Main

        ; ==============================
        ; Programme principal
        ; ==============================
                org $500

Main            movea.l     #RemoveSpaceString1,a0
                jsr         RemoveSpace

                movea.l     #RemoveSpaceString2,a0
                jsr         RemoveSpace

                illegal
        ; ==============================
        ; Sous-programmes
        ; ==============================
RemoveSpace     move.l      a0,-(a7)
                movea.l      a0,a1      ; copy a0 dans a1
                add.l       #-1,a0      ; pour que la loop soit plus simple a gere
                
\loop           add.l       #1,a0       ; vas a la prochaine lettre
                cmp.b       #0,(a0)
                beq         \quit       ; if a0 == '\0' go exit
                cmp.b       #' ',(a0)
                beq         \loop       ; if a0 = ' ' go loop
                                        ; ici ont doit copier (a0) dans (a1) et incrementer a1                        
                move.b      (a0),(a1)
                add.l       #1,a1
                jmp         \loop

                bra         \quit

\quit           move.b       #' ',(a1)
                move.l      (a7)+,a0

                rts


        ; ==============================
        ; Données
        ; ==============================


RemoveSpaceString1 dc.b " 5 + 12 ",0
RemoveSpaceString2 dc.b "9 + 45" ,0

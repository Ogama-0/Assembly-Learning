; ==============================
; Initialisation des vecteurs
; ==============================
                org         $4
vector_001      dc.l        Main
        ; ==============================
        ; Programme principal
        ; ==============================
                org $500

Main            movea.l     #String1,a0
                jsr         LowerCount

                movea.l     #String2,a0
                jsr         LowerCount

                illegal
        ; ==============================
        ; Sous-programmes
        ; ==============================
LowerCount      move.l     a0,(a7)+
                clr.l       d0
                add.l       #-1,a0     ; pour que la loop soit plus simple a gere
                
\loop           add.l       #1,a0      ; vas a la prochaine lettre
                cmp.b       #0,(a0)
                beq         \quit       ; if a0 == '\0' go exit

                cmp.b       #'a',(a0)
                blt         \loop       ; if a0 > 'a' go loop
                cmp.b       #'z',(a0)
                bge         \loop       ; if a0 < 'z' go loop
                add.l       #1,D0
                jmp         \loop
                move.l      (a7)+,a0
\quit           rts

        ; ==============================
        ; Données
        ; ==============================
String1 dc.b "Cette chaine comporte 28 minuscules.",0
String2 dc.b "Celle-ci en comporte 16.",0

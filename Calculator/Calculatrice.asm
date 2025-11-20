        ; ==============================
        ; Initialisation des vecteurs
        ; ==============================

                org         $4
vector_001      dc.l        Main

        ; ==============================
        ; Programme principal
        ; ==============================
                org $500

Main
                ; movea.l     #RemoveSpaceString1,a0
                ; jsr         RemoveSpace

                ; movea.l     #RemoveSpaceString2,a0
                ; jsr         RemoveSpace

                ; movea.l     #IsCharErrorString1,a0
                ; jsr         IsCharError

                ; movea.l     #IsCharErrorString2,a0
                ; jsr         IsCharError

                movea.l     #IsMaxErrorString1,a0
                jsr         IsMaxError

                movea.l     #IsMaxErrorString2,a0
                jsr         IsMaxError

                movea.l     #IsMaxErrorString3,a0
                jsr         IsMaxError

                movea.l     #IsMaxErrorString4,a0
                jsr         IsMaxError

                movea.l     #IsMaxErrorString5,a0
                jsr         IsMaxError

                

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

                
IsCharError     move.l      a0,-(a7)
                add.l       #-1,a0
                
\loop           add.l       #1,a0
                cmp.b       #0,(a0)
                beq         \false
                cmp.b       #'0',(a0)
                bmi         \true       ; branch si a0 - '0' < 0 ie  a0 < '0'
                cmp.b       #'9',(a0)
                bpl         \true       ; branch si a0 - '9' > 0 ie a0 > '9' 
                bra         \loop


\true           ori.b #%00000100,ccr ; Positionne le flag Z à 1 (true).
                bra         \quit

\false          andi.b #%11111011,ccr ; Positionne le flag Z à 0 (false).
                bra         \quit

\quit           move.l      (a7)+,a0
                rts

                
IsMaxError      movem.l      d0/a0,-(a7)

                jsr         StrLen
                cmp.l       #5,d0
                bhi         \true         ; branch si len(str) > 5
                blo         \false         ; branch si len(str) < 5
                                        
                cmp.b       #'3',(a0)+
                bhi         \true         ; branch si len(str) > 5
                blo         \false         ; branch si len(str) < 5
                
                cmp.b       #'2',(a0)+
                bhi         \true         ; branch si len(str) > 5
                blo         \false         ; branch si len(str) < 5
                
                cmp.b       #'7',(a0)+
                bhi         \true         ; branch si len(str) > 5
                blo         \false         ; branch si len(str) < 5

                cmp.b       #'6',(a0)+
                bhi         \true         ; branch si len(str) > 5
                blo         \false         ; branch si len(str) < 5

                cmp.b       #'7',(a0)+
                bhi         \true         ; branch si len(str) > 5
                blo         \false         ; branch si len(str) < 5

                bra \false


                
\true           ori.b #%00000100,ccr ; Positionne le flag Z à 1 (true).
                bra         \quit

\false          andi.b #%11111011,ccr ; Positionne le flag Z à 0 (false).
                bra         \quit

\quit           movem.l      (a7)+,d0/a0
                rts


StrLen          move.l a0,-(a7) ; Sauvegarde le registre A0 dans la pile.
                clr.l d0

\loop           tst.b (a0)+
                beq \quit
                addq.l #1,d0
                bra \loop

\quit           movea.l (a7)+,a0 ; Restaure la valeur du registre A0.
                rts

        ; ==============================
        ; Données
        ; ==============================


RemoveSpaceString1 dc.b " 5 + 12 ",0
RemoveSpaceString2 dc.b "9 + 45" ,0
IsCharErrorString1 dc.b "512",0
IsCharErrorString2 dc.b "78 bonjour " ,0

IsMaxErrorString1  dc.b "13" ,0
IsMaxErrorString2  dc.b "654654654" ,0
IsMaxErrorString3  dc.b "32000" ,0
IsMaxErrorString4  dc.b "32900" ,0
IsMaxErrorString5  dc.b "32767" ,0

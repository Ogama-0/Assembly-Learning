
; ==============================
; Initialisation des vecteurs
; ==============================
                org $0
vector_000      dc.l $ffb500
vector_001      dc.l Main

; ==============================
; Programme principal
; ==============================
                org $500
Main            lea sTest,a0
                move.b #24,d1
                move.b #20,d2

                jsr Print

                illegal

        ; ==============================
        ; Sous-programmes
        ; ==============================


Atoui ; Sauvegarde les registres dans la pile.
                movem.l d1/a0,-(a7)
                ; Initialise la variable de retour à 0.
                clr.l d0
                ; Initialise la variable de conversion à 0.
                clr.l d1
\loop ; On copie le caractère courant dans D1
                ; A0 pointe ensuite sur le caractère suivant (post incrémentation).
                move.b (a0)+,d1
                ; Si le caractère copié est nul,
                ; on quitte (fin de chaîne).
                beq \quit
                ; Sinon, on réalise la conversion numérique du caractère.
                subi.b #'0',d1
                ; On décale la variable de retour vers la gauche (x10),
                ; puis on y ajoute la valeur numérique du caractère.
                mulu.w #10,d0
                add.l d1,d0
                ; Passage au caractère suivant.
                bra \loop
\quit ; Restaure les registres puis sortie.
                movem.l (a7)+,d1/a0
                rts
; ==============================
; IsCharError
; ==============================
; IsCharError     move.l      a0,-(a7)
;                 add.l       #-1,a0
                
; \loop           add.l       #1,a0
;                 cmp.b       #0,(a0)
;                 beq         \false
;                 cmp.b       #'0',(a0)
;                 bmi         \true       ; branch si a0 - '0' < 0 ie  a0 < '0'
;                 cmp.b       #'9',(a0)
;                 bpl         \true       ; branch si a0 - '9' > 0 ie a0 > '9' 
;                 bra         \loop


; \true           ori.b #%00000100,ccr ; Positionne le flag Z à 1 (true).
;                 bra         \quit

; \false          andi.b #%11111011,ccr ; Positionne le flag Z à 0 (false).
;                 bra         \quit

; \quit           move.l      (a7)+,a0
;                 rts

                ; ----------------------------- IsMaxError -----------------------------

IsCharError ; Sauvegarde les registres dans la pile.
                movem.l d0/a0,-(a7)
\loop ; Charge un caractère de la chaîne dans D0 et incrémente A0.
                ; Si le caractère est nul, on renvoie false (pas d'erreur).
                move.b (a0)+,d0
                beq \false
                ; Compare le caractère au caractère '0'.
                ; S'il est inférieur, on renvoie true (ce n'est pas un chiffre).
                cmpi.b #'0',d0
                blo \true
                ; Compare le caractère au caractère '9'.
                ; S'il est inférieur ou égal, on reboucle (c'est un chiffre).
                ; S'il est supérieur, on renvoie true (ce n'est pas un chiffre).
                cmpi.b #'9',d0
                bls \loop
\true ; Sortie qui renvoie Z = 1 (erreur).
                ; (L'instruction BRA ne modifie pas le flag Z.)
                ori.b #%00000100,ccr
                bra \quit
\false ; Sortie qui renvoie Z = 0 (aucune erreur).
                andi.b #%11111011,ccr
\quit ; Restaure les registres puis sortie.
                ; (Les instructions MOVEM et RTS ne modifient pas le flag Z.)
                movem.l (a7)+,d0/a0
                rts

StrLen          move.l a0,-(a7) ; Sauvegarde le registre A0 dans la pile.
                clr.l d0

\loop           tst.b (a0)+
                beq \quit
                addq.l #1,d0
                bra \loop

\quit           movea.l (a7)+,a0 ; Restaure la valeur du registre A0.
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

                ; ----------------------------- CONVERT -----------------------------
Convert         move.l      a0,-(a7)

                cmp.b       #0,(a0)
                beq         \false      ; if a0 == '\0' go exit
                
                bsr        IsCharError   ;
                beq        \false
                
                bsr        IsMaxError   ;
                beq        \false

                move.l      (a7)+,a0    ;  Z renvoie true (1) on doit modif d0 avec la val AtoI de
                bsr         Atoui
                ori.b #%00000100,ccr    ; Positionne le flag Z à 1 (true).
                rts
\false                                  ;  Z renvoie false (0)            
                move.l      (a7)+,a0
                andi.b #%11111011,ccr   ; Positionne le flag Z à 0
                rts


Print           move.l      a0,-(a7)
                
                add.l       #-1,a0

\loop           add.l       #1,a0
                cmp.b       #0,(a0)
                
PrintChar       incbin "PrintChar.bin"
                ; ==============================
                ; Données
                ; ==============================
sTest           dc.b "Hello World",0

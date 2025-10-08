        ; ==============================
        ; Initialisation des vecteurs
        ; ==============================

                org $4
vector_001      dc.l Main

        ; ==============================
        ; Programme principal
        ; ==============================

                org $500

Main            
                movea.l     #String1,a0
                jsr         AtoUI
                movea.l     #String1,a0
                jsr         AtoUI

                illegal
        ; ==============================
        ; Sous-programmes
        ; ==============================

AtoUI           move.l      a0,-(a7)   ; Sauvegarde le registre A0 dans la pile.
                clr.l       d0
                add.l       #-1,a0     ; pour que la loop soit plus simple a gere
                
\loop           add.l       #1,a0      ; vas a la prochaine lettre
                tst.b       (a0)       ; Test si on est a la fin de la sting 
                beq         \quit
                move.b      (a0),d1    ; recupere le char dans d1
                subi.b      #'0',d1    ; traduit l'ascii en int 
                add.l       d1,d0      ; ajoute a d0
                mulu.l      #10,d0    ; Decale d0 pour stonks 
                bra         \loop
                
\quit           divu.l      #10,d0     ; diviste d0 par 10
                move.l      (a7)+,a0
                rts


        ; ==============================
        ; Données
        ; ==============================

String1         dc.b        "953142",0
String2         dc.b        "297300",0

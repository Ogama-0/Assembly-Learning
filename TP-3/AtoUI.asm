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
                jsr 

                illegal
        ; ==============================
        ; Sous-programmes
        ; ==============================

AtoUI           rts


        ; ==============================
        ; Données
        ; ==============================

String1         dc.b        "953142",0
String2         dc.b        "297300",0

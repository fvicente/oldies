SET SCOREBOARD OFF
CLEAR
PUBLIC SEL

BOX(10,1,68,22)
SET COLOR TO "N/W, W+/N"
PUBLIC NUM,NUMRX
NUM=0
NUMRX=0
SEL=1
@ 9, 13 SAY "FRECUENCIA RX:"
@ 4, 38 SAY "Mhz"
@ 9, 38 SAY "Mhz"

SET COLOR TO ("W+/BG")
@ 2, 11 SAY "       PROGRAMACION MATRIZ DE DIODOS MAXON SM-3010       "

SET COLOR TO ("W+/N")
@ 9, 28 SAY "   0.000 "

SET COLOR TO ("N/W")
@ 6, 17 SAY "A B C D E F G H I J K L M N O P"
@ 11,17 SAY "A B C D E F G H I J K L M N O P"

BOXI(13,16,65,20)
SET COLOR TO ("N/W")
@ 17, 15 SAY "RANGO  L  132-144 Mhz    (x) = Diodo Desconectado"
@ 18, 15 SAY "RANGO  M  148-161 Mhz"
@ 19, 15 SAY "RANGO  H  161-174 Mhz    (1) = Diodo Conectado"

DO WHILE (.T.)
SET COLOR TO ("N/W")

@ 4, 13 SAY "FRECUENCIA TX:" GET NUM PICTURE " 999.999 " VALID FUNCVALID(NUM)
READ
NUMRX=NUM

IF LASTKEY()==27
	SET COLOR TO ("")
	CLEAR
	RETURN
ENDIF

SET COLOR TO("W+/W")
@ 7, 17 SAY CALCULAR(NUM)
SET COLOR TO ("N/W")

@ 9, 13 SAY "FRECUENCIA RX:" GET NUMRX PICTURE " 999.999 " VALID FUNCVALID(NUMRX)
READ

IF LASTKEY()==27
	SET COLOR TO ("")
	CLEAR
	RETURN
ENDIF

SET COLOR TO("W+/W")
@ 12, 17 SAY CALCULAR(NUMRX-21.4)
ESP=' '

SET COLOR TO("N/W")
SET KEY 28 TO IMPRIMIR
@ 21, 13 SAY "             [F1] IMPRIMIR FRECUENCIAS"
@ 15, 11 SAY "            BUSCAR OTRA FRECUENCIA [S/N] ?" GET ESP VALID UPPER(ESP)=="S" .OR. UPPER(ESP)=="N"
READ
@ 21, 13 SAY "                                      "
SET KEY 28 TO

IF LASTKEY()==27
	SET COLOR TO ("")
	CLEAR
	RETURN
ENDIF

IF UPPER(ESP)=="N"
	SET COLOR TO ("")
	CLEAR
	RETURN
ENDIF

NUMRX=0
NUM=0
@ 15, 11 SAY "                                             "
@  7, 11 SAY "                                             "
@ 12, 11 SAY "                                             "

ENDDO

PROCEDURE BOX
PARAMETERS X1,Y1,X2,Y2
SET COLOR TO "W+/W"
@ Y1+1, X1+1 CLEAR TO Y2-1, X2-1
@ Y1,X1 SAY "Ú"+REPLICATE("Ä",(X2-X1)-1)
FOR A=Y1+1 TO Y2-1
@ A, X1 SAY "³"
NEXT A
@ Y2, X1 SAY"À"
SET COLOR TO "N/W"
@ Y1, X2 SAY "¿"
FOR A=Y1+1 TO Y2-1
@ A, X2 SAY "³"
NEXT A
@ Y2,X1+1 SAY REPLICATE("Ä",(X2-X1)-1)+"Ù"
RETURN

PROCEDURE BOXI
PARAMETERS X1,Y1,X2,Y2
SET COLOR TO "N/W"
@ Y1+1, X1+1 CLEAR TO Y2-1, X2-1
@ Y1,X1 SAY "Ú"+REPLICATE("Ä",(X2-X1)-1)
FOR A=Y1+1 TO Y2-1
@ A, X1 SAY "³"
NEXT A
@ Y2, X1 SAY"À"
SET COLOR TO "W+/W"
@ Y1, X2 SAY "¿"
FOR A=Y1+1 TO Y2-1
@ A, X2 SAY "³"
NEXT A
@ Y2,X1+1 SAY REPLICATE("Ä",(X2-X1)-1)+"Ù"
RETURN

FUNCTION CALCULAR
PARAMETERS NUMERO
NUMERO=((327675-(NUMERO*1000))*2)/10
DECLARE CADTX[16]
NUMERO=INT(NUMERO)
FOR ZZ=1 TO 15
	NUMERO=NUMERO/2
	IF NUMERO==INT(NUMERO)
		CADTX[ZZ]="x "
	ELSE
		CADTX[ZZ]="1 "
		NUMERO=INT(NUMERO)
	ENDIF

NEXT ZZ

IF NUMERO==1
	CADTX[16]="1 "
ELSE
	CADTX[16]="x "
ENDIF

CADFF=CADTX[11]+CADTX[12]+CADTX[13]+CADTX[14]+CADTX[15]+CADTX[16]+CADTX[2]+CADTX[3]+CADTX[1]+CADTX[4]+CADTX[5]+CADTX[6]+CADTX[7]+CADTX[10]+CADTX[8]+CADTX[9]

RETURN CADFF

FUNCTION FUNCVALID
PARAMETERS NUME
IF (NUME>=130.000) .AND. (NUME<=174.000) .AND. ((NUME*1000)/5==INT((NUME*1000)/5))
	RETURN .T.
ELSE
	SET CURSOR OFF
	SET COLOR TO ("GR+/R")
	@ 15, 11 SAY "     FRECUENCIA INCORRECTA !!! PRESIONE UNA TECLA...     "
	INKEY(0)
	SET CURSOR ON
	SET COLOR TO ("N/W")
	@ 15, 11 SAY "                                                         "
	RETURN .F.
ENDIF

PROCEDURE IMPRIMIR
@ 15, 13 SAY "                                                     "
ESP2=0
@ 21, 11 SAY "           DESEA IMPRIMIR ESTA FICHA [S/N] ?"
SET COLOR TO ("W+/N")
@ 21, COL()+1 SAY " "
@ 21, COL()-1 SAY ""

DO WHILE (ESP2!=ASC("S")) .AND. (ESP2!=ASC("N")) .AND. (ESP2!=27)
	ESP2=INKEY(0)
	ESP2=ASC(UPPER(CHR(ESP2)))
ENDDO

SET COLOR TO ("N/W")

IF LASTKEY()==27
	@ 21, 13 SAY "             [F1] IMPRIMIR FRECUENCIAS                "
	@ 15, 11 SAY "            BUSCAR OTRA FRECUENCIA [S/N] ?"
	RETURN
ENDIF

IF ESP2==ASC("N")
	@ 21, 13 SAY "             [F1] IMPRIMIR FRECUENCIAS                "
	@ 15, 11 SAY "            BUSCAR OTRA FRECUENCIA [S/N] ?"
	RETURN
ENDIF

SET CURSOR OFF
SET COLOR TO ("GR+/R")
@ 15, 11 SAY "                     IMPRIMIENDO...                      "

TXCAD=ALLTRIM(STR(NUM))
TXCAD=TXCAD+SPACE(41-LEN(TXCAD))+"³"
RXCAD=ALLTRIM(STR(NUMRX))
RXCAD=RXCAD+SPACE(41-LEN(RXCAD))+"³"

SET CONSOLE OFF
SET PRINT ON
SET DEVICE TO PRINT
? "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
? "³                                                         ³"
? "³       PROGRAMACION MATRIZ DE DIODOS MAXON SM-3010       ³"
? "³                                                         ³"
? "³ FRECUENCIA TX: "+TXCAD
? "³                                                         ³"
? "³ A B C D E F G H I J K L M N O P                         ³"
? "³ "+CALCULAR(NUM)+"                        ³"
? "³                                                         ³"
? "³ FRECUENCIA RX: "+RXCAD
? "³                                                         ³"
? "³ A B C D E F G H I J K L M N O P                         ³"
? "³ "+CALCULAR(NUMRX-21.4)+"                        ³"
? "³                                                         ³"
? "³ (x) = Diodo Desconectado    (1) = Diodo Conectado       ³"
? "³                                                         ³"
? "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
? ""
EJECT
SET PRINT OFF
SET DEVICE TO SCREEN
SET CONSOLE ON
SET CURSOR ON
SET COLOR TO ("N/W")
@ 15, 11 SAY "                                                         "
@ 21, 13 SAY "             [F1] IMPRIMIR FRECUENCIAS                "
@ 15, 11 SAY "            BUSCAR OTRA FRECUENCIA [S/N] ?"
RETURN

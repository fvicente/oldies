SET SCOREBOARD OFF
SET DECIMALS TO 3
CLEAR

BOX(10,1,68,22)

SET COLOR TO "N/W, W+/N"
PUBLIC NUM1TX[16], CADFF1, CADFF2, NUMFF1, NUMFF2
FOR X=1 TO 16
NUM1TX[X]=0
NUM1TX[X]=0
NUMFF1=0.000
NUMFF2=0.000
NEXT X

SET COLOR TO ("W+/BG")
@ 2, 11 SAY "       PROGRAMACION MATRIZ DE DIODOS MAXON SM-3010       "

SET COLOR TO ("N/W")
@  6, 17 SAY "A B C D E F G H I J K L M N O P"
@ 11, 17 SAY "A B C D E F G H I J K L M N O P"

BOXI(13,16,65,20)

SET COLOR TO ("N/W")
@ 17, 15 SAY "  INGRESE EL ESTADO DEL DIODO SEGUN LA LETRA   "
@ 19, 15 SAY " (0) = Desconectado            (1) = Conectado "

DO WHILE (.T.)

@ 4, 13 SAY "FRECUENCIA TX:          Mhz"
@ 9, 13 SAY "FRECUENCIA RX:          Mhz"

BIEN=.F.
DO WHILE (!BIEN)
SET COLOR TO("W+/W")
@ 7, 17 GET NUM1TX[1] PICTURE "9" VALID (NUM1TX[1]==1) .OR. (NUM1TX[1]==0)
@ 7, 19 GET NUM1TX[2] PICTURE "9" VALID (NUM1TX[2]==1) .OR. (NUM1TX[2]==0)
@ 7, 21 GET NUM1TX[3] PICTURE "9" VALID (NUM1TX[3]==1) .OR. (NUM1TX[3]==0)
@ 7, 23 GET NUM1TX[4] PICTURE "9" VALID (NUM1TX[4]==1) .OR. (NUM1TX[4]==0)
@ 7, 25 GET NUM1TX[5] PICTURE "9" VALID (NUM1TX[5]==1) .OR. (NUM1TX[5]==0)
@ 7, 27 GET NUM1TX[6] PICTURE "9" VALID (NUM1TX[6]==1) .OR. (NUM1TX[6]==0)
@ 7, 29 GET NUM1TX[7] PICTURE "9" VALID (NUM1TX[7]==1) .OR. (NUM1TX[7]==0)
@ 7, 31 GET NUM1TX[8] PICTURE "9" VALID (NUM1TX[8]==1) .OR. (NUM1TX[8]==0)
@ 7, 33 GET NUM1TX[9] PICTURE "9" VALID (NUM1TX[9]==1) .OR. (NUM1TX[9]==0)
@ 7, 35 GET NUM1TX[10] PICTURE "9" VALID (NUM1TX[10]==1) .OR. (NUM1TX[10]==0)
@ 7, 37 GET NUM1TX[11] PICTURE "9" VALID (NUM1TX[11]==1) .OR. (NUM1TX[11]==0)
@ 7, 39 GET NUM1TX[12] PICTURE "9" VALID (NUM1TX[12]==1) .OR. (NUM1TX[12]==0)
@ 7, 41 GET NUM1TX[13] PICTURE "9" VALID (NUM1TX[13]==1) .OR. (NUM1TX[13]==0)
@ 7, 43 GET NUM1TX[14] PICTURE "9" VALID (NUM1TX[14]==1) .OR. (NUM1TX[14]==0)
@ 7, 45 GET NUM1TX[15] PICTURE "9" VALID (NUM1TX[15]==1) .OR. (NUM1TX[15]==0)
@ 7, 47 GET NUM1TX[16] PICTURE "9" VALID (NUM1TX[16]==1) .OR. (NUM1TX[16]==0)
READ

IF LASTKEY()=27
	SET COLOR TO ("")
	CLEAR
	RETURN
ENDIF

SET COLOR TO ("N/W")
@ 4, 13 SAY "FRECUENCIA TX: "
NUMFF1=CALCULAR2()
CADFF1=CALCULAR(CALCULAR2())
BIEN=FUNCVA2(NUMFF1)
ENDDO
@ 4, 29 SAY CALCULAR2() PICTURE "999.999"

BIEN2=.F.
DO WHILE (!BIEN2)
SET COLOR TO("W+/W")
@ 12, 17 GET NUM1TX[1] PICTURE "9" VALID (NUM1TX[1]==1) .OR. (NUM1TX[1]==0)
@ 12, 19 GET NUM1TX[2] PICTURE "9" VALID (NUM1TX[2]==1) .OR. (NUM1TX[2]==0)
@ 12, 21 GET NUM1TX[3] PICTURE "9" VALID (NUM1TX[3]==1) .OR. (NUM1TX[3]==0)
@ 12, 23 GET NUM1TX[4] PICTURE "9" VALID (NUM1TX[4]==1) .OR. (NUM1TX[4]==0)
@ 12, 25 GET NUM1TX[5] PICTURE "9" VALID (NUM1TX[5]==1) .OR. (NUM1TX[5]==0)
@ 12, 27 GET NUM1TX[6] PICTURE "9" VALID (NUM1TX[6]==1) .OR. (NUM1TX[6]==0)
@ 12, 29 GET NUM1TX[7] PICTURE "9" VALID (NUM1TX[7]==1) .OR. (NUM1TX[7]==0)
@ 12, 31 GET NUM1TX[8] PICTURE "9" VALID (NUM1TX[8]==1) .OR. (NUM1TX[8]==0)
@ 12, 33 GET NUM1TX[9] PICTURE "9" VALID (NUM1TX[9]==1) .OR. (NUM1TX[9]==0)
@ 12, 35 GET NUM1TX[10] PICTURE "9" VALID (NUM1TX[10]==1) .OR. (NUM1TX[10]==0)
@ 12, 37 GET NUM1TX[11] PICTURE "9" VALID (NUM1TX[11]==1) .OR. (NUM1TX[11]==0)
@ 12, 39 GET NUM1TX[12] PICTURE "9" VALID (NUM1TX[12]==1) .OR. (NUM1TX[12]==0)
@ 12, 41 GET NUM1TX[13] PICTURE "9" VALID (NUM1TX[13]==1) .OR. (NUM1TX[13]==0)
@ 12, 43 GET NUM1TX[14] PICTURE "9" VALID (NUM1TX[14]==1) .OR. (NUM1TX[14]==0)
@ 12, 45 GET NUM1TX[15] PICTURE "9" VALID (NUM1TX[15]==1) .OR. (NUM1TX[15]==0)
@ 12, 47 GET NUM1TX[16] PICTURE "9" VALID (NUM1TX[16]==1) .OR. (NUM1TX[16]==0)
READ

IF LASTKEY()=27
	SET COLOR TO ("")
	CLEAR
	RETURN
ENDIF

SET COLOR TO ("N/W")
@ 9, 13 SAY "FRECUENCIA RX: "
NUMFF2=CALCULAR2()+21.4
CADFF2=CALCULAR((CALCULAR2()+21.4)-21.4)
BIEN2=FUNCVA2(NUMFF2)
ENDDO
@ 9, 29 SAY (CALCULAR2()+21.4) PICTURE "999.999"

ESP=' '
SET COLOR TO("N/W")
SET KEY 28 TO IMPRIMIR2
@ 21, 13 SAY "             [F1] IMPRIMIR FRECUENCIAS"
@ 15, 11 SAY "            BUSCAR OTRA FRECUENCIA [S/N] ?" GET ESP VALID UPPER(ESP)=="S" .OR. UPPER(ESP)=="N"
READ
@ 21, 13 SAY "                                      "
SET KEY 28 TO

IF LASTKEY()=27
	SET COLOR TO ("")
	CLEAR
	RETURN
ENDIF

IF UPPER(ESP)="N"
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

FUNCTION FUNCVA2
PARAMETERS NUME
IF (NUME>=130.000) .AND. (NUME<=174.000)
	RETURN .T.
ELSE
	SET CURSOR OFF
	SET COLOR TO ("GR+/R")
	@ 15, 11 SAY "   FRECUENCIA FUERA DE RANGO !!! PRESIONE UNA TECLA...   "
	INKEY(0)
	SET CURSOR ON
	SET COLOR TO ("N/W")
	@ 15, 11 SAY "                                                         "
	RETURN .F.
ENDIF
RETURN .T.

FUNCTION CALCULAR2
NUMxx=0.000
NUMFF=0.000
NUMFF=(NUM1TX[1]*1024)+(NUM1TX[2]*2048)+(NUM1TX[3]*4096)+(NUM1TX[4]*8192)+(NUM1TX[5]*16384)+(NUM1TX[6]*32768)+(NUM1TX[7]*2)
NUMFF=NUMFF+(NUM1TX[8]*4)+(NUM1TX[9]*1)+(NUM1TX[10]*8)+(NUM1TX[11]*16)+(NUM1TX[12]*32)+(NUM1TX[13]*64)+(NUM1TX[14]*512)+(NUM1TX[15]*128)+(NUM1TX[16]*256)
NUMxx=(327675-(NUMFF/2)*10)/1000
RETURN NUMxx

PROCEDURE IMPRIMIR2
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

TXCAD=ALLTRIM(STR(NUMFF1,7,3))
TXCAD=TXCAD+SPACE(41-LEN(TXCAD))+"³"
RXCAD=ALLTRIM(STR(NUMFF2,7,3))
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
? "³ "+CADFF1+"                        ³"
? "³                                                         ³"
? "³ FRECUENCIA RX: "+RXCAD
? "³                                                         ³"
? "³ A B C D E F G H I J K L M N O P                         ³"
? "³ "+CADFF2+"                        ³"
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

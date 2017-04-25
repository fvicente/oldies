SET SCOREBOAR OFF
SET CURSOR OFF
SET COLOR TO "N/N"
CLEAR

PUBLIC NUMHOJA
BOX(0,0,79,24)
SET COLOR TO "N/W, W+/N"

SET COLOR TO ("W+/BG")
@ 1, 1 SAY "                         CARACTERISTICAS DEL SM-3010                          "

BOXI(2,21,77,23)

SET COLOR TO ("N/W")
@ 22, 3 SAY "    <PgDwn> SIGUIENTE     <PgUp> ANTERIOR     <Esc> SALIR      HOJA:  /3"

NUMHOJA=1
TECLA=0
DO PINTAHOJA
DO WHILE(TECLA!=27)
	TECLA=INKEY(0)
	DO CASE
		* PGDWN
		CASE TECLA==3
			NUMHOJA=NUMHOJA+1
			IF NUMHOJA>3
				NUMHOJA=1
			ENDIF
			DO PINTAHOJA
		* PGUP
		CASE TECLA==18
			NUMHOJA=NUMHOJA-1
			IF NUMHOJA<1
				NUMHOJA=3
			ENDIF
			DO PINTAHOJA
	ENDCASE
ENDDO
SET CURSOR ON
RETURN

********************************************************************************
PROCEDURE PINTAHOJA
********************************************************************************
SET COLOR TO ("N/W")
@ 2, 1 CLEAR TO 20, 78
@ 22, 72 SAY ALLTRIM(STR(NUMHOJA))
SET COLOR TO ("W+/N")
DO CASE
	CASE NUMHOJA==1
		@ 3, 2 SAY " CARACTERISTICAS GENERALES: "
		SET COLOR TO "N/W"
		@ 5, 2 SAY "Rango de frecuencia:    "
		SET COLOR TO "W+/W"
		@ 5, COL() SAY "L: 136-144 MHz / M: 148-161 MHz / H: 161-174 MHz"
		SET COLOR TO "N/W"
		@ 6, 2 SAY "Canales:                "
		SET COLOR TO "W+/W"
		@ 6, COL() SAY "6"
		SET COLOR TO "N/W"
		@ 7, 2 SAY "Ancho del canal:        "
		SET COLOR TO "W+/W"
		@ 7, COL() SAY "25 kHz / 30 kHz"
		SET COLOR TO "N/W"
		@ 8, 2 SAY "Voltaje de entrada:     "
		SET COLOR TO "W+/W"
		@ 8, COL() SAY "13.8V DC negativo masa"
		SET COLOR TO "N/W"
		@ 9, 2 SAY "Consumo:                "
		SET COLOR TO "W+/W"
		@  9, 26 SAY "0.3 A Standby (nominal)"
		@ 10, 26 SAY "1.1 A Recepci¢n"
		@ 11, 26 SAY "8 A Transmisi¢n"
		SET COLOR TO "N/W"
		@ 12, 2 SAY "Rango de temperatura"
		@ 13, 2 SAY "de operaci¢n:           "
		SET COLOR TO "W+/W"
		@ 13, COL() SAY "-30ø hasta +60ø C"
		SET COLOR TO "N/W"
		@ 14, 2 SAY "Dimensiones:            "
		SET COLOR TO "W+/W"
		@ 14, COL() SAY "44 x 181 x 225 mm"
		SET COLOR TO "N/W"
		@ 15, 2 SAY "Peso aproximado:        "
		SET COLOR TO "W+/W"
		@ 15, COL() SAY "4.5 lbs. (2 Kg.), incluyendo mic."
		SET COLOR TO "N/W"
		@ 16, 2 SAY "FCC N£mero:             "
		SET COLOR TO "W+/W"
		@ 16, COL() SAY "F3JSM3010"
		SET COLOR TO "N/W"
		@ 17, 2 SAY "FCC cumple partes:      "
		SET COLOR TO "W+/W"
		@ 17, COL() SAY "15, 22, 74, 90"
	CASE NUMHOJA==2
		@ 3, 2 SAY " CARACTERISTICAS DE TRANSMISION: "
		SET COLOR TO "N/W"
		@ 5, 2  SAY "Potencia de salida de RF:    "
		SET COLOR TO "W+/W"
		@ 5,  COL() SAY "15 - 40 watts"
		SET COLOR TO "N/W"
		@ 6, 2  SAY "Impedancia de salida de RF:  "
		SET COLOR TO "W+/W"
		@ 6,  COL() SAY "50 ohms"
		SET COLOR TO "N/W"
		@ 7, 2  SAY "Espurias y harm¢nicas:       "
		SET COLOR TO "W+/W"
		@ 7, COL() SAY "-60 dBc m ximo"
		SET COLOR TO "N/W"
		@ 8, 2  SAY "Modulaci¢n:                  "
		SET COLOR TO "W+/W"
		@ 8, COL() SAY "16KOF3E"
		@ 9, 2  SAY "                             "
		@ 9, COL() SAY "16KOF2D"
		@ 10, 2  SAY "                             "
		@ 10, COL() SAY "15KOF1D"
		SET COLOR TO "N/W"
		@ 11, 2  SAY "Ruido FM:                    "
		SET COLOR TO "W+/W"
		@ 11, COL() SAY "-50 dB"
		SET COLOR TO "N/W"
		@ 12, 2 SAY "Distorci¢n de audio:         "
		SET COLOR TO "W+/W"
		@ 12, COL() SAY "< 6 %"
		SET COLOR TO "N/W"
		@ 13, 2 SAY "Estabilidad de frecuencia:   "
		SET COLOR TO "W+/W"
		@ 13, COL() SAY "ñ 0.0005 %"
		SET COLOR TO "N/W"
		@ 14, 2 SAY "Separaci¢n de canales:       "
		SET COLOR TO "W+/W"
		@ 14, COL() SAY "6 MHz"
	CASE NUMHOJA==3
		@ 3, 2 SAY " CARACTERISTICAS DE RECEPCION: "
		SET COLOR TO "N/W"
		@ 5, 2  SAY "Impedancia de entrada de RF: "
		SET COLOR TO "W+/W"
		@ 5,  COL() SAY "50 ohms"
		SET COLOR TO "N/W"
		@ 6, 2  SAY "Sensibilidad:"
		@ 7, 2  SAY "  EIA 12 dB SINAD            "
		SET COLOR TO "W+/W"
		@ 7, COL() SAY "0.3 æV"
		SET COLOR TO "N/W"
		@ 8, 2  SAY "  20 dB Silenciamiento       "
		SET COLOR TO "W+/W"
		@ 8, COL() SAY "0.5 æV"
		SET COLOR TO "N/W"
		@ 9, 2  SAY "Sensibilidad del Squelch:    "
		SET COLOR TO "W+/W"
		@ 9, COL() SAY "0.2 æV"
		SET COLOR TO "N/W"
		@ 10, 2 SAY "Aceptancia de modulaci¢n:    "
		SET COLOR TO "W+/W"
		@ 10, COL() SAY "ñ 7.5 kHz"
		SET COLOR TO "N/W"
		@ 11, 2 SAY "Selectividad:                "
		SET COLOR TO "W+/W"
		@ 11, COL() SAY "-70 dB"
		SET COLOR TO "N/W"
		@ 12, 2 SAY "Intermodulaci¢n:             "
		SET COLOR TO "W+/W"
		@ 12, COL() SAY "-70 dB"
		SET COLOR TO "N/W"
		@ 13, 2 SAY "Espurias y rechazo imagen:   "
		SET COLOR TO "W+/W"
		@ 13, COL() SAY "-70 dB"
		SET COLOR TO "N/W"
		@ 14, 2 SAY "Potencia de salida de audio: "
		SET COLOR TO "W+/W"
		@ 14, COL() SAY "5 watts @ < 10 % THD con carga de 3.2 ohms (ext)"
		@ 15, 2 SAY "                             "
		@ 15, COL() SAY "4 watts @ < 10 % THD con carga de 4.0 ohms (int)"
		SET COLOR TO "N/W"
		@ 16, 2 SAY "Estabilidad de frecuencia:   "
		SET COLOR TO "W+/W"
		@ 16, COL() SAY "ñ 0.0005 %"
		SET COLOR TO "N/W"
		@ 17, 2 SAY "Separaci¢n de canales:       "
		SET COLOR TO "W+/W"
		@ 17, COL() SAY "6 MHz"
ENDCASE
RETURN
*****************************************************************************
SET DATE TO FRENCH
SET DELETED ON
SET DECIMALS TO 1
SET FIXED ON
SET TALK OFF
SET BELL OFF
SET STATUS OFF
SET ESCAPE ON
SET EXACT ON
SET EXCLUSIVE ON
SET SCOREBOARD OFF
SET CURSOR ON
CLEAR ALL
********************************************************************************
PUBLIC PALAB[0],XX[0],YY[0],RAPIDA[0],POSK[0],POSSUB[0],MENSAJE[0],MONOCROMO
PUBLIC VARN1[0],VARN2[0],VARN3[0],VARN4[0],VARN5[0],VARC1[0],VARC2[0],VARC3[0],SEGUN,QUERELOJ
PUBLIC CNTBOT, POSBOT, YVEN1, YVEN2, X_MOUSE, Y_MOUSE, MOUSE, TECLA, CAMPO, SUPERFF, TEMPFF, FFBOOL
PUBLIC CNTMNU, POSMENU, SUBMENU, XX1, XX2, YY1, YY2, ACTUAL, XVEN1, XVEN2, FX, LIM, RENGLON[0],NUMCOM
PUBLIC LARGO,AGREGADO,TODO,CNTSEL,POSSEL,CNTV,TMP,HORTIM,POSCUR,PUNTO,TODOV,FRE,FGLOBAL,CADENAV,CONTCOM
FFBOOL=.T.
LIM=1
FRE=1
TODOV=0
PUNTO=0
POSCUR=0
TODO=.T.
GRUP=0
LARGO=0
AGREGADO=0
XX1=0
XX2=0
YY1=0
YY2=0
ACTUAL="ú"
CNTMNU=0
CNTBOT=0
CNTSEL=0
CNTBOX=0
CNTV=0
POSMENU=1
POSBOT=1
POSSEL=1
SUBMENU=.F.
VARSEL=0
VARSEL1=0
VARSEL2=0
VARTIEMPO=SECONDS()
MONOCROMO=.F.
MONOCROMO=!(ISCOLOR())
********************************************************************************
SELECT 1
USE FICHAS INDEX FDIST, FNOM, FAPE, FFECHA, FLOCA, FPROV, FPAIS, FCOMUN

SELECT 2
USE VENTANAS

SELECT 3
USE PREFIJOS INDEX PDESDE, PPAIS

SELECT 1
GO TOP
SELECT 2
GO 6
IF Y1==1
        DIFHOR=-X1
ELSE
        DIFHOR=X1
ENDIF
SEGUN=X2
QUERELOJ=Y2
GO TOP

DO PANT
SET COLOR TO ("N/W")
@  0, 0 SAY "                                                                                "
@ 24, 0 SAY "                                                                                "
DO DIBSUBTIT

ACUMMENU(0, 2, 2, " = ","") // 1
ACUMMENU(2, 3, 3, "~ Relojes             ","")
ACUMMENU(3, 3, 3, "~ Protector           ","")
ACUMMENU(4, 3, 3, "~ Block de notas      ","")
ACUMMENU(5, 3, 3, "~~","")
ACUMMENU(6, 3, 3, "~ Salir         <Esc> ","")

ACUMMENU(0, 6, 2, " Fichas ","") // 7
ACUMMENU(2, 7, 3, "~ Ingresar                 ","")
ACUMMENU(3, 7, 3, "~ Borrar / Modificar       ","")
ACUMMENU(4, 7, 3, "~ Reindexar bases de datos ","")
ACUMMENU(5, 7, 0, "~~","")
ACUMMENU(6, 7, 4, "~ Imprimir                 ","")

ACUMMENU(0, 15, 2," Busqueda ","") // 13
ACUMMENU(2, 16, 7,"~ Por Distintiva    ","")
ACUMMENU(3, 16, 7,"~ Por Nombre        ","")
ACUMMENU(4, 16, 7,"~ Por Apellido      ","")
ACUMMENU(5, 16, 7,"~ Por Fecha         ","")
ACUMMENU(6, 16, 7,"~ Por Ciudad        ","")
ACUMMENU(7, 16, 7,"~ Por Provincia     ","")
ACUMMENU(8, 16, 8,"~ Por Pa¡s          ","")

ACUMMENU(0, 26, 2," Prefijos ","") // 21
ACUMMENU(2, 27, 3,"~ Ingresar                ","")
ACUMMENU(3, 27, 3,"~ Borrar / Modificar      ","")
ACUMMENU(4, 27, 4,"~ Buscar por Pa¡s         ","")
ACUMMENU(5, 27, 5,"~ Buscar por Prefijo      ","")
ACUMMENU(6, 27, 0,"~~","")
ACUMMENU(7, 27, 4,"~ Imprimir                ","")

XRANDOMIZE()

DO WHILE .T.
   IF (TODO)
	   SET COLOR TO "N/W"
	   @  0, 0 SAY "                                                                                "
   ENDIF
   SET CURSOR OFF
   TODO=.T.
   SMENU(@VARSEL)
   DO CASE
   CASE VARSEL = 0
      SET COLOR TO ("")
      MOUSE_OFF()
      SET CURSOR ON
      CLEAR
      CLEAR ALL
      QUIT
   CASE VARSEL = 6
      SET COLOR TO ("")
      CLEAR
      CLEAR ALL
      QUIT
   CASE VARSEL==2
      RESETV()
      CNTBOT=0
      CNTV=0
      POSBOT=1
      FF=SAVESCREEN(0,0,23,79)
      // 1-Boton
      // 2-Seleccion
      // 3-Texto
      // 4-Box
      // 5-Ingreso
      // 6-Check-Box
      ACUMV(1, 5, 12, 5, "    Ok    ")
      ACUMV(1, 21, 12, 2, " Cancelar ")
      //      X1 Y1  X2 Y2
      ACUMV(4, 2, 2, 34, 6)
      ACUMV(4, 2, 8, 34, 10)
      //       Y  X  TEXTO
      ACUMV(3, 3, 2, " Ver ")
      ACUMV(3, 3, 8, " UTC ")
      ACUMV(3, 4, 8, "Diferencia horaria:")
      //       Y  X  TEXTO       GRUPO
      ACUMV(2, 4, 3, "HH:MM:SS", 1)
      ACUMV(2, 4, 4, "HH:MM", 1)
      ACUMV(2,18, 3, "UTC", 2)
      ACUMV(2,18, 4, "Local", 2)
      ACUMV(2,18, 5, "Local y UTC", 2)
      //       Y  X  PICTURE
      ACUMV(5, 4, 9, "99", 0,"HORAMAXI()")
      ACUMV(6,16, 9, "Dif. Negativa")
      ACUMV(3, 7, 9, "hora/s -")
      //        Y  X  R  NOMBRE
      SET DECIMALS TO 0
      IF SEGUN=5
	VARC2[8]="0"
	VARC2[9]="1"
      ENDIF
      IF QUERELOJ=2
        VARC2[10]="0"
        VARC2[11]="1"
        VARC2[12]="0"
      ELSE
        IF QUERELOJ=3
                VARC2[10]="0"
                VARC2[11]="0"
                VARC2[12]="1"
        ENDIF
      ENDIF

      VARC2[13]=PADL(ABS(DIFHOR),2,"0")
      SELECT 2
      GO 6
      VARC2[14]=ALLTRIM(STR(Y1))
      SET DECIMALS TO 1
      GO 1
      RESULT=VENTANAX(X1, Y1, X2, Y2)
      SELECT 2
      GO 1
      IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	    SET ORDER TO 0
	    REPLACE X1 WITH XVEN1
	    REPLACE Y1 WITH YVEN1
	    REPLACE X2 WITH XVEN2
	    REPLACE Y2 WITH YVEN2
	    COMMIT
      ENDIF
      IF RESULT==1
            SEGUN=5
	    IF VARC2[8]=="1"
		SEGUN=8
	    ENDIF
            QUERELOJ=1
            IF VARC2[11]=="1"
                QUERELOJ=2
	    ELSE
                    IF VARC2[12]=="1"
                        QUERELOJ=3
                    ENDIF
            ENDIF
	    GO 6
	    SET ORDER TO 0
	    REPLACE X1 WITH VAL(VARC2[13])
	    REPLACE Y1 WITH VAL(VARC2[14])
	    REPLACE X2 WITH SEGUN
            REPLACE Y2 WITH QUERELOJ
	    IF VAL(VARC2[14])==1
		DIFHOR=-VAL(VARC2[13])
	    ELSE
		DIFHOR=VAL(VARC2[13])
	    ENDIF
	    COMMIT
            DO DIBSUBTIT
      ENDIF
      RESTSCREEN(0,0,23,79,FF)
      INKEY()
      NEXTKEY()
      CLEAR TYPEAHEAD
      IF RESULT=10
	* OK
      ENDIF
      IF RESULT=11
	* CANCELO
      ENDIF
   CASE VARSEL==3
      RESETV()
      CNTBOT=0
      CNTV=0
      POSBOT=1
      FF=SAVESCREEN(0,0,23,79)
      ACUMV(1, 5, 12, 5, "    Ok    ")
      ACUMV(1, 21, 12, 2, " Cancelar ")
      //      X1 Y1  X2 Y2
      ACUMV(4, 2, 2, 34, 6)
      ACUMV(4, 2, 8, 34, 10)
      //       Y  X  TEXTO
      ACUMV(3, 3, 2, " Ver ")
      ACUMV(3, 3, 8, " UTC ")
      ACUMV(3, 4, 8, "Diferencia horaria:")
      //       Y  X  TEXTO       GRUPO
      ACUMV(2, 4, 3, "HH:MM:SS", 1)
      ACUMV(2, 4, 4, "HH:MM", 1)
      ACUMV(2,18, 3, "UTC", 2)
      ACUMV(2,18, 4, "Local", 2)
      ACUMV(2,18, 5, "Local y UTC", 2)
      //       Y  X  PICTURE
      ACUMV(5, 4, 9, "99", 0,"HORAMAXI()")
      ACUMV(6,16, 9, "Dif. Negativa")
      ACUMV(3, 7, 9, "hora/s -")
      //        Y  X  R  NOMBRE
      SET DECIMALS TO 0
      IF SEGUN=5
	VARC2[8]="0"
	VARC2[9]="1"
      ENDIF
      IF QUERELOJ=2
        VARC2[10]="0"
        VARC2[11]="1"
        VARC2[12]="0"
      ELSE
        IF QUERELOJ=3
                VARC2[10]="0"
                VARC2[11]="0"
                VARC2[12]="1"
        ENDIF
      ENDIF

      VARC2[13]=PADL(ABS(DIFHOR),2,"0")
      SELECT 2
      GO 6
      VARC2[14]=ALLTRIM(STR(Y1))
      SET DECIMALS TO 1
      GO 1
      RESULT=VENTANAX(X1, Y1, X2, Y2)
      SELECT 2
      GO 1
      IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	    SET ORDER TO 0
	    REPLACE X1 WITH XVEN1
	    REPLACE Y1 WITH YVEN1
	    REPLACE X2 WITH XVEN2
	    REPLACE Y2 WITH YVEN2
	    COMMIT
      ENDIF
      IF RESULT==1
            SEGUN=5
	    IF VARC2[8]=="1"
		SEGUN=8
	    ENDIF
            QUERELOJ=1
            IF VARC2[11]=="1"
                QUERELOJ=2
	    ELSE
                    IF VARC2[12]=="1"
                        QUERELOJ=3
                    ENDIF
            ENDIF
	    GO 6
	    SET ORDER TO 0
	    REPLACE X1 WITH VAL(VARC2[13])
	    REPLACE Y1 WITH VAL(VARC2[14])
	    REPLACE X2 WITH SEGUN
            REPLACE Y2 WITH QUERELOJ
	    IF VAL(VARC2[14])==1
		DIFHOR=-VAL(VARC2[13])
	    ELSE
		DIFHOR=VAL(VARC2[13])
	    ENDIF
	    COMMIT
            DO DIBSUBTIT
      ENDIF
      RESTSCREEN(0,0,23,79,FF)
      INKEY()
      NEXTKEY()
      CLEAR TYPEAHEAD
      IF RESULT=10
	* OK
      ENDIF
      IF RESULT=11
	* CANCELO
      ENDIF
   CASE VARSEL==8
	INGRESAR()
   CASE VARSEL==9
        MODIFICAR()
   CASE VARSEL==10
      RESETV()
      CNTBOT=0
      CNTV=0
      POSBOT=1
      RESULT=0
      FF=SAVESCREEN(0,0,23,79)
      ACUMV(1, 4, 5, 5, "    Si    ")
      ACUMV(1, 21, 5, 5, "    No    ")
      ACUMV(3, 6, 2, "¨ Est  seguro que desea")
      ACUMV(3, 4, 3, "reindexar la base de datos ?")
      RESULT=VENTANAX(20, 7, 55, 14)
      IF RESULT==1
	MOUSE_OFF()
	SET CURSOR OFF
	SET COLOR TO ("W+/W")
	@ YVEN1+1, XVEN1+1 CLEAR TO YVEN2-1, XVEN2-1
	@ YVEN1+3, XVEN1+11 SAY "Reindexando ...."
	@ 24, 1 SAY "                                                  "
	SET COLOR TO ("W/W")
	@ 24, 28 SAY "Û"
	@ 24, 28 SAY ""
	SELECT 1
	PACK
	INDEX ON DISTINTIVA TO FDIST
	INDEX ON NOMBRES TO FNOM
	INDEX ON APELLIDO TO FAPE
	INDEX ON FECHA TO FFECHA
	INDEX ON LOCALIDAD TO FLOC
	INDEX ON PROVINCIA TO FPROV
	INDEX ON PAIS TO FPAIS
	INDEX ON COMUN TO FCOMUN
	SELECT 3
	PACK
	INDEX ON DESDE TO PDESDE
	INDEX ON PAIS TO PPAIS
	SELECT 1
        USE FICHAS INDEX FDIST, FNOM, FAPE, FFECHA, FLOC, FPROV, FPAIS, FCOMUN
	SELECT 3
	USE PREFIJOS INDEX PDESDE, PPAIS
	MOUSE_ON()
        DO DIBSUBTIT
      ENDIF
      RESTSCREEN(0,0,23,79,FF)
   CASE VARSEL==14
	SELECT 1
	SET ORDER TO 1
	FUNREVISAR()
   CASE VARSEL==15
	SELECT 1
	SET ORDER TO 2
	FUNREVISAR()
   CASE VARSEL==16
	SELECT 1
	SET ORDER TO 3
	FUNREVISAR()
   CASE VARSEL==17
	SELECT 1
	SET ORDER TO 4
	FUNREVISAR()
   CASE VARSEL==18
	SELECT 1
	SET ORDER TO 5
	FUNREVISAR()
   CASE VARSEL==19
	SELECT 1
	SET ORDER TO 6
	FUNREVISAR()
   CASE VARSEL==20
	SELECT 1
	SET ORDER TO 7
	FUNREVISAR()
   CASE VARSEL==22
	INGPRE()
   CASE VARSEL==23
	MODPRE()
   CASE VARSEL==24
	SELECT 3
	SET ORDER TO 2
	SUPERFF=SAVESCREEN(0,0,23,79)
	BUSCAPRE2()
	SELECT 2
        GO 5
	IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	      SET ORDER TO 0
	      REPLACE X1 WITH XVEN1
	      REPLACE Y1 WITH YVEN1
	      REPLACE X2 WITH XVEN2
	      REPLACE Y2 WITH YVEN2
	      COMMIT
	ENDIF
	RESTSCREEN(0,0,23,79,SUPERFF)
   CASE VARSEL==25
	SELECT 3
	SET ORDER TO 1
	SUPERFF=SAVESCREEN(0,0,23,79)
	BUSCAPRE()
	SELECT 2
        GO 5
	IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	      SET ORDER TO 0
	      REPLACE X1 WITH XVEN1
	      REPLACE Y1 WITH YVEN1
	      REPLACE X2 WITH XVEN2
	      REPLACE Y2 WITH YVEN2
	      COMMIT
	ENDIF
	RESTSCREEN(0,0,23,79,SUPERFF)
   ENDCASE
   //MANTIENE()
   TODO=.F.
ENDDO WHILE .T.

********************************************************************************
PROCEDURE FUNREVISAR
********************************************************************************
	SUPERFF=SAVESCREEN(0,0,23,79)
	BUSCAR()
	SELECT 2
        GO 3
	IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	      SET ORDER TO 0
	      REPLACE X1 WITH XVEN1
	      REPLACE Y1 WITH YVEN1
	      REPLACE X2 WITH XVEN2
	      REPLACE Y2 WITH YVEN2
	      COMMIT
	ENDIF
	SELECT 1
	IF FRE==2
		REVISAR()
		SELECT 2
		GO 3
		IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	                SET ORDER TO 0
			REPLACE X1 WITH XVEN1
			REPLACE Y1 WITH YVEN1
			REPLACE X2 WITH XVEN2
			REPLACE Y2 WITH YVEN2
			COMMIT
		ENDIF
	ENDIF
	RESTSCREEN(0,0,23,79,SUPERFF)
RETURN

********************************************************************************
PROCEDURE REVISAR
********************************************************************************
FRE=-1
SSFF=SUPERFF
TODOV=0
FFBOOL=.T.
DO WHILE (FRE!=0) .AND. (FRE!=1)
	FRE=1
	RESETV()
	CNTBOT=0
	CNTV=0
	POSBOT=1
	MOUSE=0
	SELECT 2
	GO 3
	XVEN1=X1
	YVEN1=Y1
	XVEN2=X2
	YVEN2=Y2
	ACUMV(1, XVEN1+5, 13, 5, "    Ok    ")
        ACUMV(1, ((XVEN2-XVEN1)/2)-14, 13, 3, "  Imprimir  ")
        ACUMV(1, ((XVEN2-XVEN1)/2)+5, 13, 3, "  Pr¢ximo  ")
	ACUMV(1, XVEN2-18, 13, 2, " Anterior ")
	ACUMV(3,  3, 2, "Distintiva")
        ACUMV(3, 25, 2, "N§ Comunicado:")
	ACUMV(3, 59, 2, "Fecha")
	ACUMV(3,  3, 3, "Hora Inicio")
	ACUMV(3, 33, 3, "Hora Final")
	ACUMV(3, 62, 3, "Banda")
	ACUMV(3,  3, 4, "Nombres")
	ACUMV(3, 44, 4, "Apellido")
	ACUMV(3,  3, 5, "Domicilio")
	ACUMV(3, 43, 5, "Localidad")
	ACUMV(3,  3, 6, "Provincia")
        ACUMV(3, 48, 6, "Pa¡s")
	ACUMV(3,  3, 7, "RST RX")
	ACUMV(3, 16, 7, "RST TX")
	ACUMV(3, 30, 7, "QSL Enviada")
	ACUMV(3, 47, 7, "QSL Recibida")
	ACUMV(3, 65, 7, "Modo")
	ACUMV(3,  3, 8, "Nota:")
	SELECT 1
	IF FFBOOL
		DIBVEN1()
	ENDIF
	CADENAV=""
	SET COLOR TO ("W+/B")
	MOUSE_OFF()
	SET CURSOR OFF
	@ YVEN2-4, XVEN1+3 SAY SPACE(70)
	MOUSE_ON()
	CLEAR TYPEAHEAD
	KEYBOARD CHR(32)
	TECLA=32
	FRE=-1
	DO WHILE (FRE!=0) .AND. (FRE!=1) .AND. (FRE!=2)
		DIBITEM(1)
		TECLA=0
		MOUSE=0
		FRE=-1
		XQSL_ENVI="[ ]"
		XQSL_RECI="[ ]"
		IF VAL(QSL_ENVI)==1
			XQSL_ENVI="[X]"
		ENDIF
		IF VAL(QSL_RECI)==1
			XQSL_RECI="[X]"
		ENDIF
		SET COLOR TO ("W+/W")
		MOUSE_OFF()
		SET CURSOR OFF
		@ YVEN1+2, XVEN1+14 SAY DISTINTIVA
		SET DECIMALS TO 0
                @ YVEN1+2, XVEN1+40 SAY PADL(COMUN,5,"0")+"-"+PADL(VECES,3,"0")
		SET DECIMALS TO 1
		@ YVEN1+2, XVEN1+65 SAY FECHA
		@ YVEN1+3, XVEN1+15 SAY HORA_INICI
		@ YVEN1+3, XVEN1+44 SAY HORA_FINAL
		@ YVEN1+3, XVEN1+68 SAY BANDA
		@ YVEN1+4, XVEN1+11 SAY NOMBRES
		@ YVEN1+4, XVEN1+53 SAY APELLIDO
		@ YVEN1+5, XVEN1+13 SAY DOMICILIO
		@ YVEN1+5, XVEN1+53 SAY LOCALIDAD
		@ YVEN1+6, XVEN1+13 SAY PROVINCIA
		@ YVEN1+6, XVEN1+53 SAY PAIS
		@ YVEN1+7, XVEN1+10 SAY RST_RX
		@ YVEN1+7, XVEN1+23 SAY RST_TX
		@ YVEN1+7, XVEN1+42 SAY XQSL_ENVI
		@ YVEN1+7, XVEN1+60 SAY XQSL_RECI
		@ YVEN1+7, XVEN1+70 SAY MODO
		@ YVEN1+8, XVEN1+ 8 SAY NOTA_1
		@ YVEN1+9, XVEN1+ 8 SAY NOTA_2
		MOUSE_ON()
		FUNCVENT()
                IF FRE=2
		    IF (ISPRINTER())
			SET DECIMALS TO 0
        	        XQSL_ENVI="No"
	                XQSL_RECI="No"
			IF VAL(QSL_ENVI)==1
        	                XQSL_ENVI="Si"
			ENDIF
			IF VAL(QSL_RECI)==1
                	        XQSL_RECI="Si"
			ENDIF
			SET DEVICE TO PRINTER
        	        ?  "Distintiva: "+DISTINTIVA
                	?? "   N§ Comunicado:"+PADL(COMUN,5,"0")+"-"+PADL(VECES,3,"0")
	                ?? "   Fecha: "+DTOC(FECHA)
        	        ?  "Hora Inicio: "+HORA_INICI
                	?? "    Hora Final: "+HORA_FINAL
	                ?? "    Banda: "+ALLTRIM(STR(BANDA))
        	        ?? "    Modo: "+MODO
                	?  "Nombres: "+NOMBRES
	                ?? " Apellido: "+APELLIDO
        	        ?  "Domicilio: "+DOMICILIO
                	?? "         Localidad: "+LOCALIDAD
	                ?  "Provincia: "+PROVINCIA
        	        ?? "         Pa¡s: "+PAIS
                	?  "RST RX: "+RST_RX
	                ?? "   RST TX: "+RST_TX
        	        ?? "   QSL Enviada: "+XQSL_ENVI
                	?? "   QSL Recibida: "+XQSL_RECI
	                ? "Nota: "+NOTA_1
        	        ? "      "+NOTA_2
			EJECT
			SET DEVICE TO SCREEN
			SET DECIMALS TO 1
		    ELSE
			SX=SUPERFF
			SFF=SAVESCREEN(0,0,23,79)
			XTEMP1=XVEN1
			XTEMP2=XVEN2
			YTEMP1=YVEN1
			YTEMP2=YVEN2
			DIBITEM(1)
		        RESETV()
			CNTBOT=0
			CNTV=0
			POSBOT=1
		        XRESULT=0
			ACUMV(1,11, 6, 3, "  Aceptar  ")
		        ACUMV(3, 4, 2, "La impresora no est  lista")
		        ACUMV(3, 4, 3, "Verifique que la hoja est‚")
		        ACUMV(3,11, 4, "bien puesta.")
			TODOV=0
			FFBOOL=.T.
		        XRESULT=VENTANAX(22, 7, 55, 15)
			FFBOOL=.F.
			TODOV=1
			MOUSE_OFF()
			RESTSCREEN(0,0,23,79,SFF)
			SUPERFF=SX
			MOUSE_ON()
			XVEN1=XTEMP1
			XVEN2=XTEMP2
			YVEN1=YTEMP1
			YVEN2=YTEMP2
		    ENDIF
		ENDIF
		IF FRE=3
			IF !EOF()
				SKIP
				IF EOF()
					GO BOTTOM
					TONE(300,1)
				ENDIF
			ELSE
				GO BOTTOM
				TONE(300,1)
			ENDIF
		ENDIF
		IF FRE=4
			IF !BOF()
			SKIP-1
				IF BOF()
					GO TOP
					TONE(300,1)
				ENDIF
			ELSE
				GO TOP
				TONE(300,1)
			ENDIF
		ENDIF
	ENDDO
        TODOV=1
	FFBOOL=.F.
ENDDO
TODOV=0
SUPERFF=SSFF
SET CURSOR OFF
RETURN

********************************************************************************
PROCEDURE INGRESAR
********************************************************************************
RESULT=1
TODOV=0
FF=SAVESCREEN(0,0,23,79)
DO WHILE RESULT=1
      RESETV()
      CNTBOT=0
      CNTV=0
      POSBOT=3
      // 1-Boton
      // 2-Seleccion
      // 3-Texto
      // 4-Box
      // 5-Ingreso
      // 6-Check_Box
      // 7-Box_Relleno
      ACUMV(1, 10, 17, 3, "  Agrega  ")
      ACUMV(1, 30, 17, 5, "    Ok    ")
      ACUMV(1, 50, 17, 2, " Cancelar ")
      //       X  Y  PICTURE
      ACUMV(3,  2, 2, "Distintiva")
      ACUMV(3, 59, 2, "Fecha")
      ACUMV(3, 67, 2, "/"+SUBSTR(DTOC(DATE()),4,2)+"/", "W+/B")
      ACUMV(3,  2, 4, "Hora Inicio")
      ACUMV(3, 16, 4, ":", "W+/B")
      ACUMV(3, 33, 4, "Hora Final")
      ACUMV(3, 46, 4, ":", "W+/B")
      ACUMV(3, 64, 4, "Banda")
      ACUMV(3,  2, 6, "Nombres")
      ACUMV(3, 44, 6, "Apellido")
      ACUMV(3,  2, 8, "Domicilio")
      ACUMV(3, 43, 8, "Localidad")
      ACUMV(3,  2,10, "Provincia")
      ACUMV(3, 48,10, "Pa¡s")
      ACUMV(3,  2,12, "RST RX")
      ACUMV(3, 10,12, "- -", "W+/B")
      ACUMV(3, 16,12, "RST TX")
      ACUMV(3, 24,12, "- -", "W+/B")
      ACUMV(3, 65,12, "Modo")
      ACUMV(3,  2,14, "Nota:")
      ACUMV(5, 13, 2, "AAAAAAAAAA",0,"DISTIN()")
      ACUMV(5, 65, 2, "99",0,"DIAMAXI()") //25
      ACUMV(5, 68, 2, "99",1,"MESMAXI()")
      ACUMV(5, 71, 2, "99",1)
      ACUMV(5, 14, 4, "99",0,"HORAMAXI()")
      ACUMV(5, 17, 4, "99",1,"MINUMAXI()")
      ACUMV(5, 44, 4, "99",0,"HORAMAXI()") //30
      ACUMV(5, 47, 4, "99",1,"MINUMAXI()")
      ACUMV(5, 70, 4, "999",0)
      ACUMV(5, 12, 6, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0) 
      ACUMV(5, 53, 6, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 12, 8, "AAAAAAAAAAAAAAAAAAAA",0)//35
      ACUMV(5, 53, 8, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 12,10, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 53,10, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5,  9,12, "9",0)
      ACUMV(5, 11,12, "9",1)//40
      ACUMV(5, 13,12, "9",1)
      ACUMV(5, 23,12, "9",0)
      ACUMV(5, 25,12, "9",1)
      ACUMV(5, 27,12, "9",1)
      ACUMV(6, 30,12, "QSL Enviada")//45
      ACUMV(6, 47,12, "QSL Recibida")
      ACUMV(5, 70,12, "AAA",0)
      ACUMV(5,  8,14, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5,  8,15, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(3, 24, 2, "                                ")
      FER1=DTOC(DATE())
      VARC2[25]=SUBSTR(FER1,1,2)
      VARC2[26]=SUBSTR(FER1,4,2)
      VARC2[27]=SUBSTR(FER1,7,2)
      VARC2[28]=SUBSTR(TIME(),1,2)
      VARC2[29]=SUBSTR(TIME(),4,2)
      VARC2[30]=SUBSTR(TIME(),1,2)
      VARC2[31]=SUBSTR(TIME(),4,2)
      SELECT 2
      GO 2
      RESULT=VENTANAX(X1, Y1, X2, Y2)
      SELECT 2
      GO 2
      IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	      SET ORDER TO 0
	      REPLACE X1 WITH XVEN1
	      REPLACE Y1 WITH YVEN1
	      REPLACE X2 WITH XVEN2
	      REPLACE Y2 WITH YVEN2
	      COMMIT
      ENDIF
      SELECT 1
      TODOV=0
      IF (RESULT=1)
              SET CURSOR OFF
	      TODOV=1
	      CADF=VARC2[24]
	      IF (ALLTRIM(CADF)=="")
		      TONE(300, 1)
	      ELSE
		      APPEND BLANK
 		      SET ORDER TO 0
		      REPLACE DISTINTIVA WITH UPPER(VARC2[24])
		      REPLACE NOMBRES WITH VARC2[33]
		      REPLACE APELLIDO WITH VARC2[34]
		      REPLACE DOMICILIO WITH VARC2[35]
		      REPLACE LOCALIDAD WITH VARC2[36]
		      REPLACE PROVINCIA WITH VARC2[37]
		      REPLACE PAIS WITH VARC2[38]
		      REPLACE FECHA WITH CTOD(ALLTRIM(VARC2[25])+"/"+ALLTRIM(VARC2[26])+"/"+ALLTRIM(VARC2[27]))
		      REPLACE HORA_INICI WITH (ALLTRIM(VARC2[28])+":"+ALLTRIM(VARC2[29]))
		      REPLACE HORA_FINAL WITH (ALLTRIM(VARC2[30])+":"+ALLTRIM(VARC2[31]))
		      REPLACE RST_RX WITH (ALLTRIM(STR(VAL(VARC2[39])))+"-"+ALLTRIM(STR(VAL(VARC2[40])))+"-"+ALLTRIM(STR(VAL(VARC2[41]))))
		      REPLACE RST_TX WITH (ALLTRIM(STR(VAL(VARC2[42])))+"-"+ALLTRIM(STR(VAL(VARC2[43])))+"-"+ALLTRIM(STR(VAL(VARC2[44]))))
		      REPLACE QSL_ENVI WITH VARC2[45]
		      REPLACE QSL_RECI WITH VARC2[46]
		      REPLACE MODO WITH VARC2[47]
		      REPLACE BANDA WITH VAL(VARC2[32])
		      REPLACE NOTA_1 WITH VARC2[48]
		      REPLACE NOTA_2 WITH VARC2[49]
		      REPLACE COMUN WITH NUMCOM
		      REPLACE VECES WITH CONTCOM
		      COMMIT
	      ENDIF
      ENDIF
ENDDO

IF RESULT=2
      CADF=VARC2[24]
      IF (ALLTRIM(CADF)=="")
	      TONE(300, 1)
      ELSE
	      APPEND BLANK
	      SET ORDER TO 0
	      REPLACE DISTINTIVA WITH UPPER(VARC2[24])
	      REPLACE NOMBRES WITH VARC2[33]
	      REPLACE APELLIDO WITH VARC2[34]
	      REPLACE DOMICILIO WITH VARC2[35]
	      REPLACE LOCALIDAD WITH VARC2[36]
	      REPLACE PROVINCIA WITH VARC2[37]
	      REPLACE PAIS WITH VARC2[38]
	      REPLACE FECHA WITH CTOD(ALLTRIM(VARC2[25])+"/"+ALLTRIM(VARC2[26])+"/"+ALLTRIM(VARC2[27]))
	      REPLACE HORA_INICI WITH (ALLTRIM(VARC2[28])+":"+ALLTRIM(VARC2[29]))
	      REPLACE HORA_FINAL WITH (ALLTRIM(VARC2[30])+":"+ALLTRIM(VARC2[31]))
	      REPLACE RST_RX WITH (ALLTRIM(STR(VAL(VARC2[39])))+"-"+ALLTRIM(STR(VAL(VARC2[40])))+"-"+ALLTRIM(STR(VAL(VARC2[41]))))
	      REPLACE RST_TX WITH (ALLTRIM(STR(VAL(VARC2[42])))+"-"+ALLTRIM(STR(VAL(VARC2[43])))+"-"+ALLTRIM(STR(VAL(VARC2[44]))))
	      REPLACE QSL_ENVI WITH VARC2[45]
	      REPLACE QSL_RECI WITH VARC2[46]
	      REPLACE MODO WITH VARC2[47]
	      REPLACE BANDA WITH VAL(VARC2[32])
	      REPLACE NOTA_1 WITH VARC2[48]
	      REPLACE NOTA_2 WITH VARC2[49]
	      REPLACE COMUN WITH NUMCOM
	      REPLACE VECES WITH CONTCOM
	      COMMIT
      ENDIF
ENDIF
RESTSCREEN(0,0,23,79,FF)

RETURN

********************************************************************************
PROCEDURE MODIFICAR
********************************************************************************
RESULT=1
XRESULT=1
TODOV=0
FF=SAVESCREEN(0,0,23,79)
SELECT 1
DO WHILE (RESULT==2) .OR. (RESULT==1)
      RESETV()
      CNTBOT=0
      CNTV=0
      POSBOT=3
      // 1-Boton
      // 2-Seleccion
      // 3-Texto
      // 4-Box
      // 5-Ingreso
      // 6-Check_Box
      // 7-Box_Relleno
      ACUMV(1, 10, 17, 2, " Modifica ")
      ACUMV(1, 30, 17, 3, "  Borrar  ")
      ACUMV(1, 50, 17, 2, " Cancelar ")
      //       X  Y  PICTURE
      ACUMV(3,  2, 2, "Distintiva")
      ACUMV(3, 59, 2, "Fecha")
      ACUMV(3, 67, 2, "/"+SUBSTR(DTOC(FECHA),4,2)+"/", "W+/B")
      ACUMV(3,  2, 4, "Hora Inicio")
      ACUMV(3, 16, 4, ":", "W+/B")
      ACUMV(3, 33, 4, "Hora Final")
      ACUMV(3, 46, 4, ":", "W+/B")
      ACUMV(3, 64, 4, "Banda")
      ACUMV(3,  2, 6, "Nombres")
      ACUMV(3, 44, 6, "Apellido")
      ACUMV(3,  2, 8, "Domicilio")
      ACUMV(3, 43, 8, "Localidad")
      ACUMV(3,  2,10, "Provincia")
      ACUMV(3, 48,10, "Pa¡s")
      ACUMV(3,  2,12, "RST RX")
      ACUMV(3, 10,12, "-"+SUBSTR(RST_RX,3,1)+"-", "W+/B")
      ACUMV(3, 16,12, "RST TX")
      ACUMV(3, 24,12, "-"+SUBSTR(RST_TX,3,1)+"-", "W+/B")
      ACUMV(3, 65,12, "Modo")
      ACUMV(3,  2,14, "Nota:")
      ACUMV(5, 13, 2, "AAAAAAAAAA",0,"DISTIN2()")
      ACUMV(5, 65, 2, "99",0,"DIAMAXI()") //25
      ACUMV(5, 68, 2, "99",1,"MESMAXI()")
      ACUMV(5, 71, 2, "99",1)
      ACUMV(5, 14, 4, "99",0,"HORAMAXI()")
      ACUMV(5, 17, 4, "99",1,"MINUMAXI()")
      ACUMV(5, 44, 4, "99",0,"HORAMAXI()") //30
      ACUMV(5, 47, 4, "99",1,"MINUMAXI()")
      ACUMV(5, 70, 4, "999",0)
      ACUMV(5, 12, 6, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0) 
      ACUMV(5, 53, 6, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 12, 8, "AAAAAAAAAAAAAAAAAAAA",0)//35
      ACUMV(5, 53, 8, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 12,10, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 53,10, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5,  9,12, "9",0)
      ACUMV(5, 11,12, "9",1)//40
      ACUMV(5, 13,12, "9",1)
      ACUMV(5, 23,12, "9",0)
      ACUMV(5, 25,12, "9",1)
      ACUMV(5, 27,12, "9",1)
      ACUMV(6, 30,12, "QSL Enviada")//45
      ACUMV(6, 47,12, "QSL Recibida")
      ACUMV(5, 70,12, "AAA",0)
      ACUMV(5,  8,14, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5,  8,15, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",0)
      NUMCOM=COMUN
      CONTCOM=VECES
      SET DECIMALS TO 0
      ACUMV(3, 25, 2, "N§ Comunicado:"+PADL(NUMCOM,5,"0")+" / Cant.:"+PADL(CONTCOM,3,"0"),"W+/W")
      SET DECIMALS TO 1
      FER1=DTOC(FECHA)
      VARC2[24]=DISTINTIVA
      VARC2[25]=SUBSTR(FER1,1,2)
      VARC2[26]=SUBSTR(FER1,4,2)
      VARC2[27]=SUBSTR(FER1,7,2)
      VARC2[28]=SUBSTR(HORA_INICI,1,2)
      VARC2[29]=SUBSTR(HORA_INICI,4,2)
      VARC2[30]=SUBSTR(HORA_FINAL,1,2)
      VARC2[31]=SUBSTR(HORA_FINAL,4,2)
      VARC2[33]=NOMBRES
      VARC2[34]=APELLIDO
      VARC2[35]=DOMICILIO
      VARC2[36]=LOCALIDAD
      VARC2[37]=PROVINCIA
      VARC2[38]=PAIS
      VARC2[39]=SUBSTR(RST_RX,1,1)
      VARC2[40]=SUBSTR(RST_RX,3,1)
      VARC2[41]=SUBSTR(RST_RX,5,1)
      VARC2[42]=SUBSTR(RST_TX,1,1)
      VARC2[43]=SUBSTR(RST_TX,3,1)
      VARC2[44]=SUBSTR(RST_TX,5,1)
      VARC2[45]=QSL_ENVI
      VARC2[46]=QSL_RECI
      VARC2[47]=MODO
      VARC2[32]=ALLTRIM(STR(BANDA))
      VARC2[48]=NOTA_1
      VARC2[49]=NOTA_2
      SELECT 2
      GO 2
      FTMP1=X1
      FTMP2=Y1
      FTMP3=X2
      FTMP4=Y2
      SELECT 1
      SUPERFF=FF
      FFBOOL=.F.
      RESULT=VENTANAX(FTMP1, FTMP2, FTMP3, FTMP4)
      IF (XVEN1!=FTMP1) .OR. (XVEN2!=FTMP3) .OR. (YVEN1!=FTMP2) .OR. (YVEN2!=FTMP4)
              SELECT 2
	      SET ORDER TO 0
	      REPLACE X1 WITH XVEN1
	      REPLACE Y1 WITH YVEN1
	      REPLACE X2 WITH XVEN2
	      REPLACE Y2 WITH YVEN2
	      COMMIT
      ENDIF
      SELECT 1
      TODOV=0
      IF (RESULT=1)
              SET CURSOR OFF
	      CADF=VARC2[24]
	      IF (ALLTRIM(CADF)=="")
		      TONE(300, 1)
	      ELSE
		      SET ORDER TO 0
		      REPLACE DISTINTIVA WITH UPPER(VARC2[24])
		      REPLACE NOMBRES WITH VARC2[33]
		      REPLACE APELLIDO WITH VARC2[34]
		      REPLACE DOMICILIO WITH VARC2[35]
		      REPLACE LOCALIDAD WITH VARC2[36]
		      REPLACE PROVINCIA WITH VARC2[37]
		      REPLACE PAIS WITH VARC2[38]
		      REPLACE FECHA WITH CTOD(ALLTRIM(VARC2[25])+"/"+ALLTRIM(VARC2[26])+"/"+ALLTRIM(VARC2[27]))
		      REPLACE HORA_INICI WITH (ALLTRIM(VARC2[28])+":"+ALLTRIM(VARC2[29]))
		      REPLACE HORA_FINAL WITH (ALLTRIM(VARC2[30])+":"+ALLTRIM(VARC2[31]))
		      REPLACE RST_RX WITH (ALLTRIM(STR(VAL(VARC2[39])))+"-"+ALLTRIM(STR(VAL(VARC2[40])))+"-"+ALLTRIM(STR(VAL(VARC2[41]))))
		      REPLACE RST_TX WITH (ALLTRIM(STR(VAL(VARC2[42])))+"-"+ALLTRIM(STR(VAL(VARC2[43])))+"-"+ALLTRIM(STR(VAL(VARC2[44]))))
		      REPLACE QSL_ENVI WITH VARC2[45]
		      REPLACE QSL_RECI WITH VARC2[46]
		      REPLACE MODO WITH VARC2[47]
		      REPLACE BANDA WITH VAL(VARC2[32])
		      REPLACE NOTA_1 WITH VARC2[48]
		      REPLACE NOTA_2 WITH VARC2[49]
		      REPLACE COMUN WITH NUMCOM
		      REPLACE VECES WITH CONTCOM
		      COMMIT
	      ENDIF
	      TODOV=1
       ENDIF

     IF RESULT=2
             DIBITEM(1)
	     RESETV()
	     CNTBOT=0
	     CNTV=0
	     POSBOT=1
             XRESULT=0
	     ACUMV(1, 4, 5, 5, "    Si    ")
	     ACUMV(1, 21, 5, 5, "    No    ")
             ACUMV(3, 6, 2, "¨ Est  seguro que desea")
             ACUMV(3, 8, 3, "borrar ‚sta ficha ?")
             XRESULT=VENTANAX(20, 6, 55, 13)
	     TODOV=1
             IF XRESULT==1
		DELETE
		SKIP
		IF EOF()
			GO BOTTOM
		ENDIF
	     ENDIF
	     RESTSCREEN(0,0,23,79,SUPERFF)
     ENDIF
ENDDO
RESTSCREEN(0,0,23,79,FF)

RETURN

********************************************************************************
PROCEDURE INGPRE
********************************************************************************
RESULT=1
TODOV=0
FF=SAVESCREEN(0,0,23,79)
DO WHILE (RESULT==1)
      RESETV()
      CNTBOT=0
      CNTV=0
      POSBOT=2
      ACUMV(1,  5, 9, 3, "  Agrega  ")
      ACUMV(1, 27, 9, 2, " Cancelar ")

      ACUMV(3,  5, 2, "Desde")
      ACUMV(3, 27, 2, "Hasta")
      ACUMV(3,  5, 4, "Provincia")
      ACUMV(3,  5, 6, "Pa¡s")
      ACUMV(5, 12, 2, "AAA",0)
      ACUMV(5, 34, 2, "AAA",0,"FUNCVERI()")
      ACUMV(5, 17, 4, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 17, 6, "AAAAAAAAAAAAAAAAAAAA",0)
      SELECT 2
      GO 4
      RESULT=VENTANAX(X1, Y1, X2, Y2)
      SELECT 2
      GO 4
      IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	      SET ORDER TO 0
	      REPLACE X1 WITH XVEN1
	      REPLACE Y1 WITH YVEN1
	      REPLACE X2 WITH XVEN2
	      REPLACE Y2 WITH YVEN2
	      COMMIT
      ENDIF
      SELECT 3
      TODOV=0
      IF (RESULT=1)
              SET CURSOR OFF
	      TODOV=1
	      CADF=VARC2[7]
	      CADF2=VARC2[8]
	      IF (ALLTRIM(CADF)=="") .OR. (ALLTRIM(CADF2)=="")
		      TONE(300, 1)
	      ELSE
		      APPEND BLANK
 		      SET ORDER TO 0
		      REPLACE DESDE WITH UPPER(VARC2[7])
		      REPLACE HASTA WITH UPPER(VARC2[8])
		      REPLACE PROVINCIA WITH VARC2[9]
		      REPLACE PAIS WITH VARC2[10]
		      COMMIT
	      ENDIF
      ENDIF
ENDDO

RESTSCREEN(0,0,23,79,FF)

RETURN

********************************************************************************
PROCEDURE MODPRE
********************************************************************************
RESULT=1
XRESULT=1
TODOV=0
FF=SAVESCREEN(0,0,23,79)
SELECT 3
DO WHILE (RESULT==1) .OR. (RESULT==2)
      RESETV()
      CNTBOT=0
      CNTV=0
      POSBOT=3
      ACUMV(1,  3, 9, 3, " Modifica ")
      ACUMV(1, 16, 9, 5, "  Borrar  ")
      ACUMV(1, 29, 9, 2, " Cancelar ")

      ACUMV(3,  5, 2, "Desde")
      ACUMV(3, 27, 2, "Hasta")
      ACUMV(3,  5, 4, "Provincia")
      ACUMV(3,  5, 6, "Pa¡s")
      ACUMV(5, 12, 2, "AAA",0)
      ACUMV(5, 34, 2, "AAA",0)
      ACUMV(5, 17, 4, "AAAAAAAAAAAAAAAAAAAA",0)
      ACUMV(5, 17, 6, "AAAAAAAAAAAAAAAAAAAA",0)
      VARC2[8]=DESDE
      VARC2[9]=HASTA
      VARC2[10]=PROVINCIA
      VARC2[11]=PAIS
      SUPERFF=FF
      FFBOOL=.F.
      SELECT 2
      GO 4
      RESULT=VENTANAX(X1, Y1, X2, Y2)
      SELECT 2
      GO 4
      IF (XVEN1!=X1) .OR. (XVEN2!=X2) .OR. (YVEN1!=Y1) .OR. (YVEN2!=Y2)
	      SET ORDER TO 0
	      REPLACE X1 WITH XVEN1
	      REPLACE Y1 WITH YVEN1
	      REPLACE X2 WITH XVEN2
	      REPLACE Y2 WITH YVEN2
	      COMMIT
      ENDIF
      SELECT 3
      TODOV=0
      IF (RESULT==1)
              SET CURSOR OFF
	      TODOV=1
	      CADF=VARC2[8]
	      CADF2=VARC2[9]
	      IF (ALLTRIM(CADF)=="") .OR. (ALLTRIM(CADF2)=="")
		      TONE(300, 1)
	      ELSE
 		      SET ORDER TO 0
		      REPLACE DESDE WITH UPPER(VARC2[8])
		      REPLACE HASTA WITH UPPER(VARC2[9])
		      REPLACE PROVINCIA WITH VARC2[10]
		      REPLACE PAIS WITH VARC2[11]
		      COMMIT
	      ENDIF
      ENDIF

      IF RESULT==2
             DIBITEM(1)
	     RESETV()
	     CNTBOT=0
	     CNTV=0
	     POSBOT=1
             XRESULT=0
	     ACUMV(1, 4, 5, 5, "    Si    ")
	     ACUMV(1, 21, 5, 5, "    No    ")
             ACUMV(3, 6, 2, "¨ Est  seguro que desea")
             ACUMV(3, 8, 3, "borrar ‚sta ficha ?")
             XRESULT=VENTANAX(20, 6, 55, 13)
	     TODOV=1
             IF XRESULT==1
		DELETE
		SKIP
		IF EOF()
			GO BOTTOM
		ENDIF
	     ENDIF
	     RESTSCREEN(0,0,23,79,SUPERFF)
      ENDIF
ENDDO

RESTSCREEN(0,0,23,79,FF)

RETURN

********************************************************************************
PROCEDURE RELOJES
********************************************************************************
RETURN

********************************************************************************
PROCEDURE VENTANAX(XV1, YV1, XV2, YV2)
********************************************************************************
SET CURSOR OFF
FFV=0
TMP=""
XVEN1=XV1
YVEN1=YV1
XVEN2=XV2
YVEN2=YV2
VENTF=""
IF FFBOOL
	SUPERFF=SAVESCREEN(0,0,23,79)
ELSE
	FFBOOL=.T.
ENDIF

IF TODOV==0
	DESACTMENU()
	DIBVEN1()
ELSE
	IF TODOV==2
		DIBVEN1()
	ELSE
		IF TODOV==1
	        	DIBTODO()
		ENDIF
	ENDIF
ENDIF
TODOV=0
MOUSE_ON()
X_MOUAUX1=0
Y_MOUAUX1=0
TECLA=0
MOUSE=0
MANTIENE()
DO WHILE (TECLA!=27)
   MOUSE=0
   TECLA=0
   X_MOUAUX1=0
   Y_MOUAUX1=0
   SPAUSA()
   IF (MOUSE!=0)
   FOR G=1 TO CNTV
	IF (VARN1[G]==5) .AND. (MOUSE==1) .AND. (X_MOUSE>=VARN2[G]+XVEN1) .AND. (X_MOUSE<VARN2[G]+XVEN1+LEN(VARC1[G])) .AND. (Y_MOUSE==VARN3[G]+YVEN1)
		POSBOT=G
		EDITCAMPO()
		IF MOUSE!=0
			G=0
		ENDIF
		LOOP
	ENDIF
	IF (VARN1[G]==1) .AND. (MOUSE==1) .AND. (X_MOUSE>=VARN2[G]+XVEN1) .AND. (X_MOUSE<=VARN2[G]+LEN(VARC1[G])-1+XVEN1) .AND. (Y_MOUSE==VARN3[G]+YVEN1)
		POSBOT=G
		SET CURSOR OFF
		DIBUJAUND(G)
		MANTIENE()
		MOUSE=0
		IF (X_MOUSE>=VARN2[G]+XVEN1) .AND. (X_MOUSE<=VARN2[G]+LEN(VARC1[G])-1+XVEN1) .AND. (Y_MOUSE==VARN3[G]+YVEN1)
			MOUSE_OFF()
//                      RESTSCREEN(0,0,23,79,FF)
//			SET CURSOR ON
			RETURN (G)
		ENDIF
		DIBITEM(1)
		DIBITEM(2)
	ENDIF
	IF (VARN1[G]==2) .AND. (MOUSE==1) .AND. (X_MOUSE==VARN2[G]+XVEN1+1) .AND. (Y_MOUSE==VARN3[G]+YVEN1)
		POSBOT=G
		FFV=VARN4[POSBOT]
		FOR GGX=1 TO CNTV
			IF VARN1[GGX]==2 .AND. VARN4[GGX]==FFV
				VARC2[GGX]="0"
			ENDIF
		NEXT GGX
		VARC2[POSBOT]="1"
		DIBITEM(6)
		DIBITEM(2)
		MANTIENE()
	ENDIF
	IF (VARN1[G]==6) .AND. (MOUSE==1) .AND. (X_MOUSE==VARN2[G]+XVEN1+2+LEN(VARC1[G])) .AND. (Y_MOUSE==VARN3[G]+YVEN1)
		POSBOT=G
		IF VARC2[POSBOT]=="0"
			VARC2[POSBOT]="1"
		ELSE
			VARC2[POSBOT]="0"
		ENDIF
		DIBITEM(2)
		DIBITEM(6)
		MANTIENE()
	ENDIF
   NEXT G
   IF (Y_MOUSE=YVEN1) .AND. (X_MOUSE>XVEN1) .AND. (X_MOUSE<XVEN2) .AND. (MOUSE==1)
	VENTF=SAVESCREEN(YVEN1+1,XVEN1+1,YVEN2-1,XVEN2-1)
	IF X_MOUSE=XVEN1+2
		MOUSE_OFF()
		RETURN (0)
	ENDIF
	XREF1=X_MOUSE-XVEN1
	XREF2=XVEN2-X_MOUSE
	YREF=YVEN2-YVEN1
	DO WHILE (MOUSE!=0)
	   MOUSE=BOTR()
	   CADHORA2=SUBSTR(TIME(),1,SEGUN)
	   GMT=SUBSTR(TIME(),1,2)
	   NUMGMT=VAL(GMT)
	   NUMGMT=NUMGMT+DIFHOR
	   IF NUMGMT>24
		NUMGMT=NUMGMT-24
	   ENDIF
	   IF NUMGMT<0
		NUMGMT=24+NUMGMT
	   ENDIF
	   CADHORA1=""
	   IF NUMGMT<10
		   CADHORA1 = "0" + ALLTRIM(STR(NUMGMT))
	   ELSE
		   CADHORA1 = ALLTRIM(STR(NUMGMT))
	   ENDIF
	   CADHORA1 = SUBSTR(CADHORA1,1,2)
	   CADHORA1 = CADHORA1 + SUBSTR(TIME(),3,SEGUN)
	   IF QUERELOJ=1
		IF !(MONOCROMO)
			HORA2(CADHORA1,SEGUN)
		ELSE
			HORAMONO2(CADHORA1,SEGUN)
		ENDIF
	   ELSE
		IF QUERELOJ=2
			IF !(MONOCROMO)
		   	   HORA2(CADHORA2,SEGUN)
			ELSE
			   HORAMONO2(CADHORA2,SEGUN)
			ENDIF
		ELSE
			IF !(MONOCROMO)
			   HORA(CADHORA1,CADHORA2,SEGUN)
			ELSE
			   HORAMONO(CADHORA1,CADHORA2,SEGUN)
			ENDIF
		ENDIF
	   ENDIF
	   IF (VARTIEMPO+30<SECONDS())
		DO PROTECT
	   ENDIF
	   IF (POSX()/8!=X_MOUSE) .OR. (POSY()/8!=Y_MOUSE)
		VARTIEMPO=SECONDS()
	   ENDIF
	   X_MOUSE=POSX()/8
	   Y_MOUSE=POSY()/8
	   IF VARN1[POSBOT]==5
		SET CURSOR ON
	   ENDIF
	   IF (X_MOUSE!=POSX()/8) .OR. (Y_MOUSE!=POSY()/8) .OR. (X_MOUAUX1!=X_MOUSE) .OR. (Y_MOUAUX1!=Y_MOUSE)
		X_MOUAUX1=X_MOUSE
		Y_MOUAUX1=Y_MOUSE
		X_MOUSE=POSX()/8
		Y_MOUSE=POSY()/8
		MOUSE=BOTR()
		XVEN1=X_MOUSE-XREF1
		XVEN2=X_MOUSE+XREF2
		YVEN1=Y_MOUSE
		YVEN2=Y_MOUSE+YREF
		IF VARN1[POSBOT]==5
			SET CURSOR OFF
		ENDIF
        	DIBVEN()
		IF VARN1[POSBOT]==5
			SET CURSOR ON
		ENDIF
		SETPOS(VARN3[POSBOT]+YVEN1, VARN2[POSBOT]+XVEN1)
	   ENDIF
	ENDDO
	SET COLOR TO ("N/W")
	MOUSE_OFF()
	SET CURSOR OFF
	@ YVEN1, XVEN1 TO YVEN2, XVEN2
	@ YVEN1, XVEN1+1 SAY "["+CHR(254)+"]"
	MOUSE_ON()
   ENDIF
   IF VARN1[POSBOT]==5
	SET CURSOR ON
	MANTIENE()
	EDITCAMPO()
   ELSE
   MANTIENE()
   ENDIF
   ELSE
	MOUSE_OFF()
	DO CASE
	CASE TECLA=13 // ENTER
		IF (VARN1[POSBOT]!=6) .AND. (VARN1[POSBOT]!=2)
			MOUSE_OFF()
//                      RESTSCREEN(0,0,23,79,FF)
			SET CURSOR OFF
			DIBUJAUND(POSBOT)
			RETURN (POSBOT)
		ENDIF
	CASE TECLA=19  //IZQUIERDA
		CAMPOATRAS()
	CASE TECLA=4   //DERECHA
		KEYBOARD CHR(9)
		TECLA=9
	CASE TECLA=5   //ARRIBA
		CAMPOATRAS()
	CASE TECLA=24  //ABAJO
		KEYBOARD CHR(9)
		TECLA=9
	CASE TECLA=271 // SHIFT+TAB
		CAMPOATRAS()
	CASE TECLA=9 // TAB
		POSBOT=POSBOT+1
		IF POSBOT>CNTV
			POSBOT=1
		ENDIF
		DO WHILE (VARN1[POSBOT]==3 .OR. VARN1[POSBOT]==4 .OR. VARN1[POSBOT]==7)
			POSBOT=POSBOT+1
			IF POSBOT>CNTV
				POSBOT=1
			ENDIF
		ENDDO
		DO CASE
			CASE VARN1[POSBOT]==1
				DIBITEM(1)
				DIBITEM(2)
				DIBITEM(6)
			CASE VARN1[POSBOT]==2
				DIBITEM(2)
				DIBITEM(6)
			CASE VARN1[POSBOT]==5
				DIBITEM(2)
				DIBITEM(6)
				EDITCAMPO()
			CASE VARN1[POSBOT]==6
				DIBITEM(2)
				DIBITEM(6)
		ENDCASE
	CASE TECLA=32
		IF VARN1[POSBOT]==2
			FFV=VARN4[POSBOT]
			FOR GG=1 TO CNTV
				IF VARN1[GG]==2 .AND. VARN4[GG]==FFV
					VARC2[GG]="0"
				ENDIF
			NEXT GG
			VARC2[POSBOT]="1"
			DIBITEM(2)
		ENDIF
		IF VARN1[POSBOT]==6
			IF VARC2[POSBOT]=="0"
				VARC2[POSBOT]="1"
			ELSE
				VARC2[POSBOT]="0"
			ENDIF
			DIBITEM(6)
		ENDIF
	OTHERWISE
		FOR F=1 TO CNTV
			IF (VARN1[F]==1)
				IF UPPER(CHR(TECLA))==UPPER(SUBSTR(VARC1[F],VARN4[F],1))
					MOUSE_OFF()
//                                      RESTSCREEN(0,0,23,79,FF)
//					SET CURSOR ON
					RETURN (F)
				ENDIF
			ENDIF
		NEXT F
	ENDCASE
	MOUSE_ON()
   ENDIF
ENDDO
TECLA=0
MOUSE_OFF()
//RESTSCREEN(0,0,23,79,FF)
//SET CURSOR ON
RETURN (0)

********************************************************************************
PROCEDURE DIBVEN
********************************************************************************
ANCHO=XVEN2-XVEN1
ALTO=YVEN2-YVEN1
IF XVEN1<0
	XVEN1=0
	XVEN2=ANCHO
ENDIF
IF XVEN2>79
	XVEN2=79
	XVEN1=79-ANCHO
ENDIF
IF YVEN1<1
	YVEN1=1
	YVEN2=ALTO+1
ENDIF
IF YVEN2>23
	YVEN2=23
	YVEN1=YVEN2-ALTO
ENDIF
MOUSE_OFF()
RESTSCREEN(YVEN1+1,XVEN1+1,YVEN2-1,XVEN2-1,VENTF)
SET COLOR TO ("W+/W")
@ YVEN1, XVEN1 TO YVEN2, XVEN2

//CADAU=REPLICATE("°",80)
//SET COLOR TO ("B/W")
//FOR A=1 TO YVEN1-1
//@ A, 0 SAY CADAU
//NEXT A
//FOR A=YVEN2+2 TO 23
//@ A, 0 SAY CADAU
//NEXT A
//CADAU1=REPLICATE("°",XVEN1)
//CADAU2=REPLICATE("°",79-XVEN2)
//FOR A=YVEN1 TO YVEN2+1
//IF A!=24
//@ A, 0 SAY CADAU1
//@ A, XVEN2+2 SAY CADAU2
//ENDIF
//NEXT A
//MIREST(1,0,YVEN1-1,80,SUPERFF)
//MIREST(YVEN2+2,0,23,80,SUPERFF)
MIREST(2,XVEN1,YVEN1,XVEN2+1,SUPERFF)
SOMBRADEFF(YVEN1,XVEN1,YVEN2,XVEN2)
IF XVEN2<79
MIREST(YVEN1+1,XVEN2+1,YVEN1+1,XVEN2+1,"NOLEE")
ENDIF
IF YVEN2+1<24
	MIREST(YVEN2+2,XVEN1,YVEN2+2,XVEN1+1,"NOLEE")
ENDIF
MIREST(YVEN2+3,XVEN1,24,XVEN2+1,"NOLEE")
MIREST(2,0,24,XVEN1-1,"NOLEE")
MIREST(2,XVEN2+2,24,79,"NOLEE")
//MIREST(YVEN1,XVEN2+1,YVEN2+1,79,SUPERFF)
//@ YVEN1, XVEN2+1 SAY "°"
//IF YVEN2+1<24
//@ YVEN2+1, XVEN1 SAY "°°"
//ENDIF
//SET COLOR TO ("N+/N")
//IF YVEN2+1<24
//@ YVEN2+1, XVEN1+2 SAY REPLICATE("°",XVEN2-XVEN1)
//ENDIF
//FOR FG=YVEN1 TO YVEN2-1
//        @ FG+1, XVEN2+1 SAY "°"
//NEXT FG
//SET CURSOR ON

VENTF=SAVESCREEN(YVEN1+1,XVEN1+1,YVEN2-1,XVEN2-1)
MOUSE_ON()
RETURN

********************************************************************************
PROCEDURE DIBVEN1
********************************************************************************
ANCHO=XVEN2-XVEN1
ALTO=YVEN2-YVEN1
MOUSE_OFF()
IF XVEN1<0
	XVEN1=0
	XVEN2=ANCHO
ENDIF
IF XVEN2>79
	XVEN2=79
	XVEN1=79-ANCHO
ENDIF
IF YVEN1<1
	YVEN1=1
	YVEN2=ALTO+1
ENDIF
IF YVEN2>23
	YVEN2=23
	YVEN1=YVEN2-ALTO
ENDIF

SET COLOR TO ("N/W")
SET CURSOR OFF
@ YVEN1, XVEN1 CLEAR TO YVEN2, XVEN2
@ YVEN1, XVEN1 TO YVEN2, XVEN2
@ YVEN1, XVEN1+1 SAY "["+CHR(254)+"]"
LEEFF()
IF XVEN2<79
	MIREST(YVEN1+1,XVEN2+1,YVEN1+1,XVEN2+1,SUPERFF)
ENDIF
SOMBRADEFF(YVEN1,XVEN1,YVEN2,XVEN2)
//SET COLOR TO ("N+/N")
//IF YVEN2+1<24
//@ YVEN2+1, XVEN1+2 SAY REPLICATE("°",XVEN2-XVEN1)
//ENDIF
//FOR FG=YVEN1 TO YVEN2-1
//        @ FG+1, XVEN2+1 SAY "°"
//NEXT FG
DIBTODO()
DIBITEM(2)

MOUSE_ON()
VENTF=SAVESCREEN(YVEN1+1,XVEN1+1,YVEN2-1,XVEN2-1)
RETURN

********************************************************************************
PROCEDURE FUNCVENT
********************************************************************************
SET CURSOR OFF
FX=RECNO()
FFV=0
TMP=""
VENTF=""
X_MOUAUX1=0
Y_MOUAUX1=0
TECLA=0
MOUSE=0
CLEAR TYPEAHEAD
MANTIENE()
SET COLOR TO ("W+/B")
MOUSE_OFF()
@ YVEN2-4, XVEN1+3 SAY CADENAV
SET CURSOR ON
MOUSE_ON()
DO WHILE (TECLA!=27)
   MOUSE=0
   TECLA=0
   X_MOUAUX1=0
   Y_MOUAUX1=0
   SPAUSA2()
   IF (MOUSE!=0)
   SET CURSOR OFF
   FOR G=1 TO CNTV
	IF (VARN1[G]==1) .AND. (MOUSE==1) .AND. (X_MOUSE>=VARN2[G]+XVEN1) .AND. (X_MOUSE<=VARN2[G]+LEN(VARC1[G])-1+XVEN1) .AND. (Y_MOUSE==VARN3[G]+YVEN1)
		POSBOT=G
		DIBUJAUND(G)
		MANTIENE()
		MOUSE=0
		IF (X_MOUSE>=VARN2[G]+XVEN1) .AND. (X_MOUSE<=VARN2[G]+LEN(VARC1[G])-1+XVEN1) .AND. (Y_MOUSE==VARN3[G]+YVEN1)
			CADENAV=""
			MOUSE_OFF()
			SET CURSOR OFF
			SET COLOR TO ("W+/B")
			@ YVEN2-4, XVEN1+3 SAY SPACE(70)
			FRE=G
			DIBITEM(1)
			DIBITEM(2)
			RETURN (0)
		ENDIF
		DIBITEM(1)
		DIBITEM(2)
	ENDIF
   NEXT G
   SET CURSOR ON
   SETPOS(YVEN2-4, XVEN1+3+LEN(CADENAV))
   IF (Y_MOUSE=YVEN1) .AND. (X_MOUSE>XVEN1) .AND. (X_MOUSE<XVEN2) .AND. (MOUSE==1)
	SET CURSOR OFF
	VENTF=SAVESCREEN(YVEN1+1,XVEN1+1,YVEN2-1,XVEN2-1)
	IF X_MOUSE=XVEN1+2
		MOUSE_OFF()
		FRE=0
		RETURN (0)
	ENDIF
	XREF1=X_MOUSE-XVEN1
	XREF2=XVEN2-X_MOUSE
	YREF=YVEN2-YVEN1
	DO WHILE (MOUSE!=0)
//           SET CURSOR OFF
	   MOUSE=BOTR()
	   CADHORA2=SUBSTR(TIME(),1,SEGUN)
	   GMT=SUBSTR(TIME(),1,2)
	   NUMGMT=VAL(GMT)
           NUMGMT=NUMGMT+DIFHOR
	   IF NUMGMT>24
		NUMGMT=NUMGMT-24
	   ENDIF
	   IF NUMGMT<0
		NUMGMT=24+NUMGMT
	   ENDIF
	   CADHORA1=""
	   IF NUMGMT<10
		   CADHORA1 = "0" + ALLTRIM(STR(NUMGMT))
	   ELSE
		   CADHORA1 = ALLTRIM(STR(NUMGMT))
	   ENDIF
	   CADHORA1 = SUBSTR(CADHORA1,1,2)
	   CADHORA1 = CADHORA1 + SUBSTR(TIME(),3,SEGUN)
	   IF QUERELOJ=1
			IF !(MONOCROMO)
			   HORA2(CADHORA1,SEGUN)
			ELSE
			   HORAMONO2(CADHORA1,SEGUN)
			ENDIF
	   ELSE
		IF QUERELOJ=2
			IF !(MONOCROMO)
			   HORA2(CADHORA2,SEGUN)
			ELSE
			   HORAMONO2(CADHORA2,SEGUN)
			ENDIF
		ELSE
			IF !(MONOCROMO)
			   HORA(CADHORA1,CADHORA2,SEGUN)
			ELSE
			   HORAMONO(CADHORA1,CADHORA2,SEGUN)
			ENDIF
		ENDIF
	   ENDIF
	   IF (VARTIEMPO+30<SECONDS())
		SET CURSOR OFF
		DO PROTECT
		SET CURSOR ON
	   ENDIF
	   IF (POSX()/8!=X_MOUSE) .OR. (POSY()/8!=Y_MOUSE)
		VARTIEMPO=SECONDS()
	   ENDIF
	   X_MOUSE=POSX()/8
	   Y_MOUSE=POSY()/8
		SET CURSOR ON
	   IF (X_MOUSE!=POSX()/8) .OR. (Y_MOUSE!=POSY()/8) .OR. (X_MOUAUX1!=X_MOUSE) .OR. (Y_MOUAUX1!=Y_MOUSE)
		X_MOUAUX1=X_MOUSE
		Y_MOUAUX1=Y_MOUSE
		X_MOUSE=POSX()/8
		Y_MOUSE=POSY()/8
		MOUSE=BOTR()
		XVEN1=X_MOUSE-XREF1
		XVEN2=X_MOUSE+XREF2
		YVEN1=Y_MOUSE
		YVEN2=Y_MOUSE+YREF
		SET CURSOR OFF
		DIBVEN()
		SET CURSOR ON
		SETPOS(YVEN2-4, XVEN1+3+LEN(CADENAV))
	   ENDIF
	ENDDO
	SET COLOR TO ("N/W")
	MOUSE_OFF()
	SET CURSOR OFF
	@ YVEN1, XVEN1 TO YVEN2, XVEN2
	@ YVEN1, XVEN1+1 SAY "["+CHR(254)+"]"
	SET CURSOR ON
	MOUSE_ON()
	@ YVEN2-4, XVEN1+3+LEN(CADENAV) SAY ""
//      SETPOS(VARTMPA,VARTMPB)
   ENDIF
   MANTIENE()
   ELSE
	SETPOS(YVEN2-4, XVEN1+3+LEN(CADENAV))
	MOUSE_OFF()
	DO CASE
	CASE TECLA=13 // ENTER
//              IF (VARN1[POSBOT]==1)
//		MOUSE_OFF()
		SET COLOR TO ("W+/B")
//                      SET COLOR TO ("N/BG")
		MOUSE_OFF()
		CADENAV=""
		SET CURSOR OFF
		@ YVEN2-4, XVEN1+3 SAY SPACE(70)
		SET CURSOR ON
		MOUSE_ON()
		DIBUJAUND(POSBOT)
		FRE=POSBOT
		RETURN(0)
//              ENDIF
	CASE TECLA=271 // SHIFT+TAB
		CAMPOATRAS()
	CASE TECLA=9 // TAB
		POSBOT=POSBOT+1
		IF POSBOT>CNTV
			POSBOT=1
		ENDIF
		DO WHILE (VARN1[POSBOT]!=1 .AND. VARN1[POSBOT]!=2 .AND. VARN1[POSBOT]!=5 .AND. VARN1[POSBOT]!=6)
			POSBOT=POSBOT+1
			IF POSBOT>CNTV
				POSBOT=1
			ENDIF
		ENDDO
		DO CASE
			CASE VARN1[POSBOT]==1
				DIBITEM(1)
				DIBITEM(2)
				DIBITEM(6)
			CASE VARN1[POSBOT]==2
				DIBITEM(2)
				DIBITEM(6)
			CASE VARN1[POSBOT]==5
				DIBITEM(2)
				DIBITEM(6)
				EDITCAMPO()
			CASE VARN1[POSBOT]==6
				DIBITEM(2)
				DIBITEM(6)
		ENDCASE
	CASE TECLA=27
		MOUSE_OFF()
		FRE=0
		KEYBOARD CHR(32)
		TECLA=32
		RETURN(0)
	CASE TECLA=8
		IF LEN(CADENAV)>0
//                      SET COLOR TO ("N/BG")
			SET COLOR TO ("W+/B")
			CADENAV=STUFF(CADENAV,LEN(CADENAV),1,"")
			MOUSE_OFF()
			SET CURSOR OFF
			@ YVEN2-4, XVEN1+3 SAY CADENAV + " "
			@ YVEN2-4, XVEN1+3 SAY CADENAV
			SET CURSOR ON
			MOUSE_ON()
			SEEK(CADENAV)
			RETURN(2)
		ENDIF
	OTHERWISE
		FX=RECNO()
		IF (TECLA>=32) .AND. (TECLA<=254)
		SEEK(CADENAV+UPPER(CHR(TECLA)))
		IF FOUND()
//                      SET COLOR TO ("N/BG")
			SET COLOR TO ("W+/B")
			CADENAV=CADENAV+UPPER(CHR(TECLA))
			MOUSE_OFF()
			SET CURSOR OFF
			@ YVEN2-4, XVEN1+3 SAY CADENAV
			MOUSE_ON()
			SET CURSOR ON
			FX=RECNO()
//              ELSE
		ENDIF
		ELSE
			IF CADENAV==""
			ELSE
			SET COLOR TO ("W+/B")
//                      SET COLOR TO ("N/BG")
			MOUSE_OFF()
			CADENAV=""
			SET CURSOR OFF
			@ YVEN2-4, XVEN1+3 SAY SPACE(70)
			SET CURSOR ON
			MOUSE_ON()
			ENDIF
		ENDIF
		GO FX
		KEYBOARD CHR(TECLA)
		RETURN (2)
	ENDCASE
	SETPOS(YVEN2-4, XVEN1+3+LEN(CADENAV))
	SET CURSOR ON
	MOUSE_ON()
   ENDIF
ENDDO
MOUSE_OFF()
SET CURSOR OFF
RETURN(1)

********************************************************************************
PROCEDURE MIREST
********************************************************************************
PARAMETERS K1, K2, L1, L2, VARXX
IF K1>L1 .OR. K2>L2
	RETURN
ENDIF
IF VARXX=="NOLEE"
ELSE
VARTMP=SPACE(LEN(VARXX))
PUBLIC RENGLON[25]
FOR A=0 TO 23
	RENGLON[A+1]=SUBSTR(VARXX,A*160,161)
NEXT A
ENDIF
VARTMP=""
FOR A=K1 TO L1
	VARTMP=VARTMP+SUBSTR(RENGLON[A],(K2+1)*2,(L2-K2+1)*2)
NEXT
RESTSCREEN(K1-1,K2,L1-1,L2,VARTMP)
RETURN

********************************************************************************
PROCEDURE SOMBRA
********************************************************************************
PARAMETERS K1, K2, L1, L2
SET COLOR TO ("N+/N")
IF L1+1<24
FTMP=SAVESCREEN(L1+1,K2+2,L1+1,L2+1)
XXX=LEN(FTMP)/2
FOR S=2 TO XXX+1
	FTMP=STUFF(FTMP,S,1,"")
NEXT S
@ L1+1, K2+2 SAY FTMP
ENDIF
FOR FG=K1 TO L1-1
	FTMP=SAVESCREEN(FG+1,L2+1,FG+1,L2+1)
	FTMP=STUFF(FTMP,2,1,"")
        @ FG+1, L2+1 SAY FTMP
NEXT FG
RETURN

********************************************************************************
PROCEDURE LEEFF
********************************************************************************
PUBLIC RENGLON[25]
FOR A=0 TO 23
	RENGLON[A+1]=SUBSTR(SUPERFF,A*160,161)
NEXT A
RETURN

********************************************************************************
PROCEDURE SOMBRADEFF
********************************************************************************
PARAMETERS K1, K2, L1, L2
SET COLOR TO ("N+/N")
//DECLARE RENGLON[25]
//FOR A=0 TO 23
//	RENGLON[A+1]=SUBSTR(SUPERFF,A*160,161)
//NEXT A
IF L1+1<24
FTMP=SUBSTR(RENGLON[L1+2],(K2+3)*2,((L2-K2)*2))
//SAVESCREEN(L1+1,K2+2,L1+1,L2+1)
XXX=LEN(FTMP)/2
FOR S=2 TO XXX+1
	FTMP=STUFF(FTMP,S,1,"")
NEXT S
@ L1+1, K2+2 SAY FTMP
ENDIF
IF L2<79
FOR FG=K1 TO L1-1
//	FTMP=SAVESCREEN(FG+1,L2+1,FG+1,L2+1)
//	FTMP=STUFF(FTMP,2,1,"")
        @ FG+1, L2+1 SAY SUBSTR(RENGLON[FG+2],2*(L2+2),1)
NEXT FG
ENDIF
RETURN

********************************************************************************
PROCEDURE PROTECT
********************************************************************************
MOUSE_OFF()
SET CURSOR OFF
POTMP1=POSX()
POTMP2=POSY()
XCOL=COL()
XROW=ROW()
cPantalla = SAVESCREEN(0, 0, 24, 79)
SET COLOR TO "W+/N"
CLS
xrandomize()
cont = 0
cont2 = 0
aX = ARRAY(15)
aY = ARRAY(15)
cKeyPr := 0
DO WHILE (cKeyPr==0)
	cont = cont + 1
	aX[cont] = xrandom(80)
	aY[cont] = xrandom(25)
	cKeyPr = INKEY(0.1)
        @ aY[cont], aX[cont] SAY "ú"
	IF (cKeyPr != 0) .OR. (POTMP1!=POSX()) .OR. (POTMP2!=POSY())
		RESTSCREEN(0, 0, 24, 79, cPantalla)
		MOUSE_ON()
		VARTIEMPO=SECONDS()
		SETPOS(XROW,XCOL)
		RETURN
	ENDIF
	IF cont = 15
		DO WHILE (cKeyPr = 0)
		cont2 = cont2 + 1
		cKeyPr = INKEY(0.1)
		@ aY[cont2], aX[cont2] SAY ""
		IF (cKeyPr != 0) .OR. (POTMP1!=POSX()) .OR. (POTMP2!=POSY())
			RESTSCREEN(0, 0, 24, 79, cPantalla)
			MOUSE_ON()
			VARTIEMPO=SECONDS()
			SETPOS(XROW,XCOL)
			RETURN
		ENDIF
		cKeyPr = INKEY(0.1)
		@ aY[cont2], aX[cont2] SAY ""
		IF (cKeyPr != 0) .OR. (POTMP1!=POSX()) .OR. (POTMP2!=POSY())
			RESTSCREEN(0, 0, 24, 79, cPantalla)
			MOUSE_ON()
			VARTIEMPO=SECONDS()
			SETPOS(XROW,XCOL)
			RETURN
		ENDIF
		cKeyPr = INKEY(0.1)
		@ aY[cont2], aX[cont2] SAY " "
		aX[cont2] = xrandom(80)
		aY[cont2] = xrandom(25)
                @ aY[cont2], aX[cont2] SAY "ú"
		IF (cKeyPr != 0) .OR. (POTMP1!=POSX()) .OR. (POTMP2!=POSY())
			RESTSCREEN(0, 0, 24, 79, cPantalla)
			MOUSE_ON()
			VARTIEMPO=SECONDS()
			SETPOS(XROW,XCOL)
			RETURN
		ENDIF
		IF cont2 = 15
			cont2 = 0
		ENDIF
		ENDDO
	ENDIF
ENDDO
RESTSCREEN(0, 0, 24, 79, cPantalla)
MOUSE_ON()
VARTIEMPO=SECONDS()
SETPOS(XROW,XCOL)
RETURN

********************************************************************************
PROCEDURE PANT
********************************************************************************
MOUSE_OFF()
SET COLOR TO ("B/W")
FOR A=1 TO 23
@ A, 0 SAY REPLICATE("°",80)
NEXT A
SET COLOR TO ("")
MOUSE_ON()
RETURN

********************************************************************************
FUNCTION FUNCVERI
********************************************************************************
SELECT 3
SET ORDER TO 1
SET CURSOR OFF
SEEK(VARC2[7])
IF FOUND()
        IF VARC2[8]==HASTA
                TONE(300,1)
		SET CURSOR ON
                RETURN .F.
        ENDIF
ENDIF
IF VARC2[7]>VARC2[8]
	TONE(300,1)
	SET CURSOR ON
        RETURN .F.
ENDIF
RETURN .T.


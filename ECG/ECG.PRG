*  FILE NAME: ECG.PRG
*  BY: BERNARDO KATZ Y JUAN MATTEUCCI
*  DATE: July 26, 1995
*  DESC:
*  CALLED BY:
*  DATA FILES:
SET SCOREBOARD OFF
SET CURSOR OFF
*************
PUBLIC CNTMNU, POSMENU
CNTMNU=0
POSMENU=1
PUBLIC AUXY[2],AUXX[2],AUXPAL[2],YY[1],XX[1],PALAB[1],AUXRAPIDA[2],RAPIDA[1],AUXPOS[2],POSK[2]
*************
VAR=0
SELECT 1
USE ECG INDEX REEMP
CLEAR
DO PANT
ACUMMENU(0, 3, 2," Buscar ")
ACUMMENU(0, 12, 2," Ingresar ")
ACUMMENU(0, 23, 2," Modificar ")
ACUMMENU(0, 35, 2," Reindexar ")
ACUMMENU(0, 47, 2," Salir ")

SET COLOR TO ("N/W")
@  0, 0 SAY "                                                                               "
@ 24, 0 SAY "                                                                               "

SET COLOR TO ("W/N")
@ 3, 14 SAY "ллллллл"
@ 4, 14 SAY "ллппппп "
@ 5, 14 SAY "лл "
@ 6, 14 SAY "ллллл"
@ 7, 14 SAY "ллппп "
@ 8, 14 SAY "лл "
@ 9, 14 SAY "ллллллл"
@ 10,14 SAY "ппппппп "

@ 3, 35 SAY "ллллллл"
@ 4, 35 SAY "ллппппп "
@ 5, 35 SAY "лл "
@ 6, 35 SAY "лл "
@ 7, 35 SAY "лл "
@ 8, 35 SAY "лл "
@ 9, 35 SAY "ллллллл"
@ 10,35 SAY "ппппппп "

@ 3, 56 SAY "ллллллл"
@ 4, 56 SAY "ллппппп "
@ 5, 56 SAY "лл "
@ 6, 56 SAY "лл "
@ 6, 60 SAY "ллл"
@ 7, 56 SAY "лл "
@ 7, 60 SAY "плл "
@ 8, 56 SAY "лл "
@ 8, 61 SAY "лл "
@ 9, 56 SAY "ллллллл "
@ 10,56 SAY "ппппппп "


DO WHILE (.T.)
   SMENU(0, @VAR)
   DO CASE
   CASE VAR==1
      DO BUSCAR
   CASE VAR==2
      DO INGRESAR
   CASE VAR==3
      DO MODIFICAR
   CASE VAR==4
      DO REINDEXAR
   CASE VAR==5
      SET CURSOR ON
      SET COLOR TO ("")
      CLEAR
      QUIT
   ENDCASE
ENDDO

PROCEDURE PANT
SET COLOR TO ("B/W")
FOR A=0 TO 24
@ A, 0 SAY REPLICATE("А",79)
NEXT A
SET COLOR TO ("")
RETURN

PROCEDURE ACUMMENU
PARAMETERS Y, X, POSKEY, PALABRA
CARACTER=' '
CNTMNU=CNTMNU+1
PUBLIC PALAB[CNTMNU+1],XX[CNTMNU+1],YY[CNTMNU+1],RAPIDA[CNTMNU+1],POSK[CNTMNU+1]
AUXY[CNTMNU]=Y
AUXX[CNTMNU]=X
AUXPOS[CNTMNU]=POSKEY
AUXPAL[CNTMNU]=PALABRA
IF (POSKEY!=0)
   CARACTER=SUBSTR(PALABRA, POSKEY, 1)
   AUXRAPIDA[CNTMNU]=CARACTER
ENDIF
ACOPY(AUXPAL, PALAB)
ACOPY(AUXX, XX)
ACOPY(AUXY, YY)
ACOPY(AUXPOS, POSK)
ACOPY(AUXRAPIDA, RAPIDA)
PUBLIC AUXPAL[CNTMNU+2],AUXX[CNTMNU+2],AUXY[CNTMNU+2],AUXRAPIDA[CNTMNU+2],AUXPOS[CNTMNU+2]
ACOPY(PALAB, AUXPAL)
ACOPY(XX, AUXX)
ACOPY(YY, AUXY)
ACOPY(POSK, AUXPOS)
ACOPY(RAPIDA, AUXRAPIDA)
RETURN

PROCEDURE SMENU
PARAMETERS TIPO, DEVUELVO
TECLA=0
POSMENU=1
IF (TIPO==0)
   DO PINTAMENU
   DO WHILE (.T.)
      TECLA=INKEY(0)
      DO CASE
      CASE TECLA==13
	 DEVUELVO=POSMENU
	 RETURN
      CASE TECLA==27
	 DEVUELVO=27
	 RETURN
      CASE TECLA==4
	 IF POSMENU<CNTMNU
	    POSMENU=POSMENU+1
	    DO PINTAMENU
	 ELSE
	    IF POSMENU!=1
	       POSMENU=1
	       DO PINTAMENU
	    ENDIF
	 ENDIF
      CASE TECLA==19
	 IF POSMENU>1
	    POSMENU=POSMENU-1
	    DO PINTAMENU
	 ELSE
	    IF POSMENU==1 .AND. CNTMNU!=1
	       POSMENU=CNTMNU
	       DO PINTAMENU
	    ENDIF
	 ENDIF
      OTHERWISE
	 FOR N=1 TO CNTMNU
	 IF TECLA==ASC(RAPIDA[N]) .OR. UPPER(CHR(TECLA))==UPPER(RAPIDA[N])
	    POSMENU=N
	    DO PINTAMENU
	    DEVUELVO=POSMENU
	    RETURN
	 ENDIF
	 NEXT N
      ENDCASE
   ENDDO
   
ELSE
ENDIF
RETURN

********************************************************************************
PROCEDURE PINTAMENU
********************************************************************************
VARCOL="W"
FOR NN=1 TO CNTMNU
	IF NN==POSMENU
	   VARCOL="G"
	ELSE
	   VARCOL="W"
	ENDIF

	SET COLOR TO ("N/"+VARCOL)
	@ YY[NN], XX[NN] SAY PALAB[NN]
	SET COLOR TO ("R/"+VARCOL)
	IF POSK[NN]!=0
		SET COLOR TO ("R/"+VARCOL)
		@ YY[NN], XX[NN]+POSK[NN]-1 SAY RAPIDA[NN]
	ENDIF
NEXT NN

RETURN

PROCEDURE MODIFICAR
PANTALLA=SAVESCREEN(6,20,12,60)
SET COLOR TO ("N/W")
@ 24, 0 SAY " ESC - Salir                                                                   "
SET COLOR TO ("GR+/R")
@ 8, 21 CLEAR TO 10, 59
@ 7, 20 TO 11, 60 DOUBLE
BUS=SPACE(20)
SET CURSOR ON
@ 9, 22 SAY "Comp Buscado: " GET BUS
READ
IF LASTKEY()=27
	SET COLOR TO ("")
	RESTSCREEN(6,20,12,60,PANTALLA)
	SET COLOR TO ("N/W")
	@ 24, 0 SAY "                                                                               "
	SET CURSOR OFF
	RETURN
ENDIF

SEEK (BUS)
IF (!FOUND())
	@ 8, 21 CLEAR TO 11, 59
	@ 7, 20 TO 12, 60 DOUBLE
	@ 9, 25 SAY " NO SE ENCONTRO EL COMPONENTE"
	@ 10, 22 SAY "PRESIONE UNA TECLA PARA CONTINUAR..."
	INKEY(0)
	SET COLOR TO ("")
	RESTSCREEN(6,20,12,60,PANTALLA)
	SET COLOR TO ("N/W")
	@ 24, 0 SAY "                                                                               "
	SET CURSOR OFF
	RETURN
ELSE
	@ 7, 21 CLEAR TO 11, 59
	@ 6, 20 TO 12, 60 DOUBLE
	SET CURSOR ON
	COMP=A_reemplaz
	REEM=Reemplazo
	@ 8, 22 SAY "Componente: " GET COMP
	@ 10, 22 SAY "Reemplazo: " GET REEM
	READ
	IF LASTKEY()=27
		SET COLOR TO ("")
		RESTSCREEN(6,20,12,60,PANTALLA)
		SET COLOR TO ("N/W")
		@ 24, 0 SAY "                                                                               "
		SET CURSOR OFF
		RETURN
	ENDIF
	REPLACE A_reemplaz WITH COMP
	REPLACE Reemplazo  WITH REEM
	COMMIT
	SET COLOR TO ("")
	RESTSCREEN(6,20,12,60,PANTALLA)
	SET COLOR TO ("N/W")
	@ 24, 0 SAY "                                                                               "
	SET CURSOR OFF
	RETURN
ENDIF
RETURN

PROCEDURE INGRESAR
PANTALLA=SAVESCREEN(6,20,12,60)
SET COLOR TO ("N/W")
@ 24, 0 SAY " ESC - Salir                                                                   "
SET COLOR TO ("GR+/R")
@ 7, 21 CLEAR TO 11, 59
@ 6, 20 TO 12, 60 DOUBLE
SET CURSOR ON
DO WHILE (.T.)
COMP=SPACE(20)
REEM=SPACE(20)
@ 8, 22 SAY "Componente: " GET COMP
@ 10, 22 SAY "Reemplazo: " GET REEM
READ
IF LASTKEY()=27
	SET COLOR TO ("")
	RESTSCREEN(6,20,12,60,PANTALLA)
	SET COLOR TO ("N/W")
	@ 24, 0 SAY "                                                                               "
	SET CURSOR OFF
	RETURN
ENDIF
APPEND BLANK
REPLACE A_reemplaz WITH COMP
REPLACE Reemplazo  WITH REEM
COMMIT
ENDDO
RETURN

PROCEDURE REINDEXAR
PANTALLA=SAVESCREEN(6,20,12,60)
SET COLOR TO ("N/W")
@ 24, 0 SAY " ESC - Salir                                                                   "
SET COLOR TO ("GR+/R")
@ 8, 21 CLEAR TO 10, 59
@ 7, 20 TO 11, 60 DOUBLE
ESP=' '
SET CURSOR ON
@ 9, 23 SAY "ESTA SEGURO QUE DESEA REINDEXAR ? " GET ESP
READ
IF LASTKEY()=27 .OR. UPPER(ESP)!="S"
	SET COLOR TO ("")
	RESTSCREEN(6,20,12,60,PANTALLA)
	SET COLOR TO ("N/W")
	@ 24, 0 SAY "                                                                               "
	SET CURSOR OFF
	RETURN
ELSE
	SET CURSOR OFF
	@ 9, 22 SAY "         REINDEXANDO   .....          "
	REINDEX
	SET COLOR TO ("")
	RESTSCREEN(6,20,12,60,PANTALLA)
	SET COLOR TO ("N/W")
	@ 24, 0 SAY "                                                                               "
ENDIF

RETURN

PROCEDURE BUSCAR
DO BUSCAF
RETURN

**********************************
PROCEDURE BUSCAF
**********************************
CNOMBRE=SPACE(50)
CNOMBRE=ALLTRIM(CNOMBRE)
POSBAR=1
TECLA=0
NO=0
	SET COLOR TO W+/B
	SAVE SCREEN
	SELECT 1
	@ 5, 18 CLEAR TO 16, 62
	@ 5, 18 TO 16, 62 DOUBLE
	GO TOP
	@ 24, 0 SAY SPACE(79)
	FOR A=1 TO 10
		IF A==POSBAR
			SET COLOR TO ("N/W")
		ENDIF
		@ 5+A, 20 SAY A_REEMPLAZ+'К'+REEMPLAZO
		SET COLOR TO W+/B
		SKIP
	NEXT
	@ 24, 2 SAY "NOMBRE: "
	SET CURSOR ON
	GO TOP
	TECLA=0
	LIMITE=10
	IF RECCOUNT()<11
		LIMITE=RECCOUNT()
	ENDIF
	DO WHILE ((TECLA!=27).AND.(TECLA!=4).AND.(TECLA!=19))
	TECLA=INKEY(0)
	DO CASE
		CASE TECLA==8
		IF (LEN(CNOMBRE)!=0)
			CNOMBRE=LEFT(CNOMBRE, LEN(CNOMBRE)-1)
			KEYBOARD(CHR(255))
		ENDIF
		CASE TECLA==24
			CNOMBRE=""
			@ 24, 10 SAY SPACE(68)
			IF POSBAR<LIMITE
				POSBAR=POSBAR+1
			ELSE
				SKIP LIMITE
				IF (EOF())
					SKIP -(LIMITE)
				ELSE
					SKIP -(LIMITE-1)
				ENDIF
			ENDIF
		CASE TECLA==13
			IF POSBAR>1
				SKIP POSBAR-1
			ENDIF
			RESTORE SCREEN
			RETURN
		CASE TECLA==5
			CNOMBRE=""
			@ 24, 10 SAY SPACE(68)
			IF POSBAR>1
				POSBAR=POSBAR-1
			ELSE
				SKIP -1
			ENDIF
		CASE TECLA==18
			CNOMBRE=""
			@ 24, 10 SAY SPACE(68)
			SKIP -LIMITE
		CASE TECLA==3
			CNOMBRE=""
			@ 24, 10 SAY SPACE(68)
			SKIP LIMITE*2
			IF (EOF())
				SKIP -LIMITE
				POSBAR=LIMITE
			ELSE
				SKIP -LIMITE
			ENDIF
		CASE TECLA==1
			POSBAR=1
		CASE TECLA==6
			POSBAR=LIMITE
		CASE TECLA==31
			GO TOP
			POSBAR=1
		CASE TECLA==30
			GO BOTTOM
			SKIP -(LIMITE-1)
			POSBAR=LIMITE
		OTHERWISE
			IF TECLA!=255
				CNOMBRE=CNOMBRE+UPPER(CHR(TECLA))
			ENDIF
			SEEK(CNOMBRE)
			IF FOUND()
				POSBAR=1
				SET CURSOR OFF
				FOR A=1 TO LIMITE
					IF (EOF())
						POSBAR=POSBAR+1
					ENDIF
					SKIP
				NEXT
				SKIP -LIMITE
				SET CURSOR ON
			ELSE
				CNOMBRE=LEFT(CNOMBRE, LEN(CNOMBRE)-1)
				SEEK(CNOMBRE)
				NO=1
			ENDIF
	ENDCASE
	IF NO==0
	SET CURSOR OFF
	FOR A=1 TO LIMITE
		IF A==POSBAR
			SET COLOR TO ("N/W")
		ENDIF   
		@ 5+A, 20 SAY A_REEMPLAZ+'К'+REEMPLAZO
		SET COLOR TO W+/B
		SKIP
	NEXT
	SKIP -LIMITE
	SET CURSOR ON
	ENDIF
NO=0

@ 24, 2 SAY "NOMBRE: " + LTRIM(CNOMBRE) + " "
@ 24, 10+LEN(LTRIM(CNOMBRE)) SAY ""

ENDDO
SET CURSOR OFF
RESTORE SCREEN
RETURN

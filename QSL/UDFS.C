#include <dos.h>
#include <time.h>
#include <conio.h>
#include <extend.h>
#include <stdlib.h>

CLIPPER XRANDOMIZE()
{
    randomize();
    _ret();
}

CLIPPER XRANDOM()
{
    int numero;
    if (PCOUNT == 1 && ISNUM(1))
	numero = random(_parni(1));
    else
	numero = 0;

    _retni(numero);
}

CLIPPER MOUSE_ON()
{
  _AX = 0x01;
  geninterrupt(0x33);
  _ret();
}

CLIPPER MOUSE_OFF()
{
  _AX = 0x02;
  geninterrupt(0x33);
  _ret();
}

CLIPPER MOUSE_MOV()
{
  _DX = _parni(2);
  _CX = _parni(1);
  _AX = 0x04;
  geninterrupt(0x33);
  _ret();
}

CLIPPER MOUSE_LIMX()
{
  _DX = _parni(2);
  _CX = _parni(1);
  _AX = 0x07;
  geninterrupt(0x33);
  _ret();
}

CLIPPER MOUSE_LIMY()
{
  _DX = _parni(2);
  _CX = _parni(1);
  _AX = 0x08;
  geninterrupt(0x33);
  _ret();
}

CLIPPER POSX()
{
  _AX = 0x03;
  geninterrupt(0x33);
  _retni(_CX);
}

CLIPPER POSY()
{
  _AX = 0x03;
  geninterrupt(0x33);
  _retni(_DX);
}

CLIPPER BOTR()
{
  _AX = 0x03;
  geninterrupt(0x33);
  _retni(_BL);
}

CLIPPER MOUSE_INST()
{
  _ES = 0;
  _DX = 0;
  _CX = 0;
  _AX = 0x14;
  geninterrupt(0x33);
  _ret();
}

CLIPPER HORA()
{
       unsigned int far *screen1;
       unsigned int far *screen2;
       char *cad1=_parc(1);
       char *cad2=_parc(2);
       int xx=_parni(3);
       int i;

       screen2 = (unsigned int *) MK_FP(0xB8F1, 0);
       screen1 = (unsigned int *) MK_FP(0xB8F3, 0);
       for (i=0;i<xx;i++)
       {
		screen1[i] = 0x7000 + cad1[i];
		screen2[i] = 0x7000 + cad2[i];
       }

       _ret();
}

CLIPPER HORA2()
{
       unsigned int far *screen1;
       char *cad1=_parc(1);
       int xx=_parni(2);
       int i;

       screen1 = (unsigned int *) MK_FP(0xB8F1, 0);
       for (i=0;i<xx;i++)
       {
		screen1[i] = 0x7000 + cad1[i];
       }

       _ret();
}

CLIPPER HORAMONO()
{
       unsigned int far *screen1;
       unsigned int far *screen2;
       char *cad1=_parc(1);
       char *cad2=_parc(2);
       int xx=_parni(3);
       int i;

       screen2 = (unsigned int *) MK_FP(0xB0F1, 0);
       screen1 = (unsigned int *) MK_FP(0xB0F3, 0);
       for (i=0;i<xx;i++)
       {
		screen1[i] = 0x7000 + cad1[i];
		screen2[i] = 0x7000 + cad2[i];
       }

       _ret();
}

CLIPPER HORAMONO2()
{
       unsigned int far *screen1;
       char *cad1=_parc(1);
       int xx=_parni(2);
       int i;

       screen1 = (unsigned int *) MK_FP(0xB0F1, 0);
       for (i=0;i<xx;i++)
       {
		screen1[i] = 0x7000 + cad1[i];
       }

       _ret();
}

CLIPPER REDEF()
{
	char far *punt="�����������  ";
/*
	asm {
		mov ax,0x1100 //Subfuncion de la INT 0x10 (Definir caracteres)
		mov bh,16     //bytes por caracter
		mov bl,0      //Uno de los 8 bloques de la zona de video
		mov cx,1      //N� de caracteres a definir
		mov dx,1  //Nro del caracter a redefinir
		les bp,punt   //En ES:BP la direcci�n del buffer con los news caracteres
		int 0x10      //INT 0x10 (Funciones del video)
	}
*/
//	int carac=_parni(1);
	struct REGPACK reg;
	reg.r_ax=0x1100;
//	reg.r_bh=16;
//	reg.r_bl=0;
	reg.r_cx=1;
	reg.r_dx=1;//carac
	reg.r_es=FP_SEG(punt);
	reg.r_bp=FP_OFF(punt);
	intr(0x10, &reg);

/*
	_AX=0x1100;
	_BL=0;
	_CX=1;
	_BH=16;
	_DX=1;
	_ES=FP_SEG(punt);
	_BP=FP_OFF(punt);
	geninterrupt(0x10);
*/
       _ret();
}

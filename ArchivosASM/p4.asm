;-------------------------------------------------------------------------------------------------
;	**Melyza Alejandra Rodriguez Contreras
;	**201314821
;	**Practica 4
;	**Arquitectura de computadoras y Ensambladores 1
;-------------------------------------------------------------------------------------------------

;-------------------------------------------------------------------------------------------------
;macros
;-------------------------------------------------------------------------------------------------
include m4.asm

;-------------------------------------------------------------------------------------------------
;modelo 
;-------------------------------------------------------------------------------------------------
.model small

;-------------------------------------------------------------------------------------------------
;segmento de pila
;-------------------------------------------------------------------------------------------------
.stack 100h
;-------------------------------------------------------------------------------------------------
;segmento de dato
;-------------------------------------------------------------------------------------------------
.data
;variables----------------------------------------------------------------------------------------
	;encabezado
	enc1		db 0ah, 0dh, 	"UNIVERSIDAD DE SAN CARLOS DE GUATEMALA",'$'
	enc2		db 0ah, 0dh, 	"FACULTAD DE INGENIERIA",'$'
	enc3		db 0ah, 0dh, 	"CIENCIAS Y SISTEMAS",'$'
	enc4		db 0ah, 0dh, 	"ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1",'$'
	enc5		db 0ah, 0dh, 	"NOMBRE: MELYZA ALEJANDRA RODRIGUEZ CONTRERAS",'$'
	enc6		db 0ah, 0dh, 	"CARNET: 201314821",'$'
	enc7		db 0ah, 0dh, 	"SECCION: A", 0ah,'$'
	;menu inicial
	mi1			db 0ah, 0dh, 	"1) Iniciar Juego",'$'
	mi2			db 0ah, 0dh, 	"2) Cargar Juego",'$'
	mi3			db 0ah, 0dh, 	"3) Salir", 0ah,'$'
	mi4			db 0ah, 0dh, 	"   Ingrese una opcion: ",'$'
	;mensajes
	msj1		db 0ah, 0dh,	"   ******** Ingrese una opcion correcta ********", '$'
	msj2		db 0ah, 0ah, 0dh,	"   ******** Saliendo ********", 0ah, '$'
	msj3		db 0ah, 0dh,	"   ******** Posicion incorrecta ********", 0ah, '$'
	msj4		db 0ah, 0dh,	"   No se pudo crear el archivo!!", 0ah, '$'
	msj5		db 0ah, 0dh,	"     El juego ha terminado", 0ah, '$'
	;iniciar Juego
	in1			db 0ah, 0dh,	"   ******** Inicio de juego ********", '$'
	;carga de juego
	ca1			db 0ah, 0dh,	"   ******** Carga de juego ********", '$'
	;tablero
	vf1			db 9 dup('$')	
	vf2			db 9 dup('$')
	vf3			db 9 dup('$')
	vf4			db 9 dup('$')
	vf5			db 9 dup('$')
	vf6			db 9 dup('$')
	vf7			db 9 dup('$')
	vf8			db 9 dup('$')
	vf9			db 9 dup('$')
	Numero1     db "  1  ", '$'
	Numero2     db "  2  ", '$'
	Numero3     db "  3  ", '$'
	Numero4     db "  4  ", '$'
	Numero5     db "  5  ", '$'
	Numero6     db "  6  ", '$'
	Numero7     db "  7  ", '$'
	Numero8     db "  8  ", '$'
	Numero9     db "  9  ", '$'
	tablero1    db "---",'$'
	tablero2    db '|', '$'
	espacio     db "    ", '$'
	ints		db 0c5h, ' ', '$'
	fNegra		db 046h ,04eh, '$'
	fBlanca		db 046h ,042h, '$'
	salto 		db 0ah, '$'
	cEspacio	db  "         |    |    |    |    |    |    |    |    |      ", 0ah, '$'
	cLetras		db	"         A    B    C    D    E    F    G    H    J      ", 0ah, '$'
	posEscribir	db 00h
	;turnos
	cntTurno	db 4eh
	cntPass		db 00h
	movimiento	db 5 dup('$')
	cExit 		db 'EXIT', '$'
	cPass		db 'PASS', '$'
	cSave		db 'SAVE', '$'
	cShow		db 'SHOW', '$'
	;turno negras
	tnegras 	db 0ah, "Turno Negras: ", '$'
	;turno blancas
	tblancas 	db 0ah, "Turno Blancas: ", '$'
	;guardar archivo
	cGuardar	db 0ah, 0dh,	"   ******** Guardar archivo ********", '$'
	cNombre		db 0ah, 0dh,	"   Ingrese nombre para guardar: ", '$'
	cRuta		db 0ah, 0dh,	"   Ingrese la ruta del archivo: ", '$'
	cErrorAbrir	db 0ah, 0dh,	"   Error al abrir el archivo!", 0ah, '$'
	cErrorLeer	db 0ah, 0dh,	"   Error al leer el archivo!", 0ah, '$'
	nombreAr	db 50 dup('$')
	cGuardado	db 0ah, 0dh,	"   Guardado!", '$'
	cNoGuardado	db 0ah, 0dh,	"   No se ha podido guardar", '$'
	handlerE	dw ?
	bufferIn	db 100 dup('$')
	;Reporte html
	aHtml		db "estadoTablero.html",0
	bufferHTML	db 5000h	dup('$') 
	htmlEnca    db "<html>", 0ah, 09h, "<head>",  0ah, 09h, 09h, "<title>201314821</title>", 0ah, 09h, "</head>", 0ah, 09h, '<body bgcolor="#FAEACC"><font face="courier" color="#5F0239"><center>',0ah,"<br><h1>Estado del Tablero<h1>",'$'
	decTabla	db 0ah, 09h, 09, '<table width= "800" height="800"; border="1" cellspacing="2" cellpadding="2"><tr><td background="im0.png"><center><table width=', 22h,"675", 22h, " height=", 22h, "675", 22h, 3bh ," border=", 22h, "0", 22h ," cellspacing=", 22h, "0", 22h, " cellpadding=", 22h, "0", 22h," bgcolor=", 22h, "#000000", 22h, ">", '$'
	trAbre		db 0ah, 09h, 09h, 09h, "<tr  bgcolor=", 22h, "white", 22h, ">", '$'
	td1 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im1.png", 22h, "></td>", '$'
	td2 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im2.png", 22h, "></td>", '$'
	td3 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im3.png", 22h, "></td>", '$'
	td4 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im4.png", 22h, "></td>", '$'
	td5 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im5.png", 22h, "></td>", '$'
	td6 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im6.png", 22h, "></td>", '$'
	td7 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im7.png", 22h, "></td>", '$'
	td8 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im8.png", 22h, "></td>", '$'
	td9 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im9.png", 22h, "></td>", '$'
	td10 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im10.png", 22h, "></td>", '$'
	td11 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im11.png", 22h, "></td>", '$'
	td12 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im12.png", 22h, "></td>", '$'
	td13 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im13.png", 22h, "></td>", '$'
	td14 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im14.png", 22h, "></td>", '$'
	td15 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im15.png", 22h, "></td>", '$'
	td16 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im16.png", 22h, "></td>", '$'
	td17 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im17.png", 22h, "></td>", '$'
	td18 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im18.png", 22h, "></td>", '$'
	td19 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im19.png", 22h, "></td>", '$'
	td20 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im20.png", 22h, "></td>", '$'
	td21 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im21.png", 22h, "></td>", '$'
	td22 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im22.png", 22h, "></td>", '$'
	td23 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im23.png", 22h, "></td>", '$'
	td24 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im24.png", 22h, "></td>", '$'
	td25 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im25.png", 22h, "></td>", '$'
	td26 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im26.png", 22h, "></td>", '$'
	td27 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im27.png", 22h, "></td>", '$'
	td28 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im28.png", 22h, "></td>", '$'
	td29 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im29.png", 22h, "></td>", '$'
	td30 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "im30.png", 22h, "></td>", '$'
	fi1 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi1.png", 22h, "></td>", '$'
	fi2 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi2.png", 22h, "></td>", '$'
	fi3 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi3.png", 22h, "></td>", '$'
	fi4 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi4.png", 22h, "></td>", '$'
	fi5 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi5.png", 22h, "></td>", '$'
	fi6 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi6.png", 22h, "></td>", '$'
	fi7 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi7.png", 22h, "></td>", '$'
	fi8 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi8.png", 22h, "></td>", '$'
	fi9 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi9.png", 22h, "></td>", '$'
	fi10 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi10.png", 22h, "></td>", '$'
	fi11 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi11.png", 22h, "></td>", '$'
	fi12 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi12.png", 22h, "></td>", '$'
	fi13 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi13.png", 22h, "></td>", '$'
	fi14 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi14.png", 22h, "></td>", '$'
	fi15 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi15.png", 22h, "></td>", '$'
	fi16 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi16.png", 22h, "></td>", '$'
	fi17 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi17.png", 22h, "></td>", '$'
	fi18 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi18.png", 22h, "></td>", '$'
	fi19 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi19.png", 22h, "></td>", '$'
	fi20 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi20.png", 22h, "></td>", '$'
	fi21 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi21.png", 22h, "></td>", '$'
	fi22 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi22.png", 22h, "></td>", '$'
	fi23 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi23.png", 22h, "></td>", '$'
	fi24 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi24.png", 22h, "></td>", '$'
	fi25 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi25.png", 22h, "></td>", '$'
	fi26 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi26.png", 22h, "></td>", '$'
	fi27 		db 0ah, 09h, 09h, 09h, 09h, "<td background=", 22h, "fi27.png", 22h, "></td>", '$'

	h1abre		db "<h1 align=", 22h, "center", 22h, ">",'$'
	h1cierra	db "</h1>",'$'
	trCierra	db 0ah, 09h, 09h, 09h, "</tr>", '$'
	tablaCierra	db 0ah, 09h, 09, "</table></td></tr></table>", '$'
	finHTML 	db 0ah, 09h, "</body>",0ah,"</html",'$'
	horayF 		db "FECHA:            H:   M:   S:  ",'$'
	finTabla	db 0ah, 09h, 09h, "</table></td></tr></table>",'$'
	finHT 		db 0ah,09h, "</center></body>",0ah,"</html>",'$'
	valorSi		dw 00h
	valorDi		dw 00h
	
	posx		dw 00h
	posy		dw 00h
	libertadesA	dw 00h
	libertadesB	dw 00h
	libertadesI	dw 00h
	libertadesD	dw 00h
	msjSiLib	db 0ah, "Si hay libertades", '$'
	msjNoLin	db 0ah, "No hay libertades", '$'
	msjOcupada	db 0ah, "Posicion ocupada", '$'
	msjNoHab	db 0ah, "No se puede colocar en esta posicion", '$'

	puntosB		dw 00h
	puntosN		dw 00h
	finalJuego	dw 00h
	;final indicar puntero
	tablaF1		db 0ah, "----------------------------------" , '$'
	tablaF2		db 0ah, "|     Pieza     |     Punteo     |" , '$'
	tablaF3		db 0ah, "----------------------------------" , '$'
	tablaF4		db 0ah, "       Negro                      " , '$'
	tablaF5		db 0ah, "       Blanco                     " , '$'
	tablaF10	db 0ah, "                                  " , '$'
	tablaF6		db 0ah, "----------------------------------" , '$'
	tablaF8		db 0ah, "    El ganador es el color" , '$'
	tablaF9		db 0ah, "              Negro   " , '$'
	tablaF12	db 0ah, "              Blanco   " , '$'

	rep1		db 0ah,"    ",0a8h, "Desea realizar el reporte final? S/N: ", '$'
	rep2		db 0ah, 0ah, "        Generado! ",'$'
	rep3		db 0ah, "    Debe seleccionar S/N", 0ah,0ah, '$'

;-------------------------------------------------------------------------------------------------
;segmento de codigo
;-------------------------------------------------------------------------------------------------
.code
	main proc
		menuinicial:
			limpiarPantalla
			;ENCABEZADO
			print enc1
			print enc2
			print enc3
			print enc4
			print enc5
			print enc6
			print enc7
			;MENU
			print mi1
			print mi2
			print mi3
			print mi4
			getChar
			cmp al, 31h
			je inicio
			cmp al, 32h
			je cargarJuego
			cmp al, 33h
			je salida
			print msj1
			jmp menuinicial	
		cargarJuego:
			limpiarContenido handlerE
			limpiarContenido nombreAr
			limpiarPantalla
			print ca1
			print cRuta
			obtenerRuta nombreAr
  			abrir nombreAr, handlerE
  			leerArchivo handlerE, bufferIn, SIZEOF bufferIn
  			cerrar handlerE
  			llenarPosiciones vf1, vf2, vf3, vf4, vf5, vf6, vf7, vf8, vf9, bufferIn, cntTurno
  			limpiarContenido bufferIn
  			limpiarContenido handlerE
  			jmp menuinicial
  		errorAbrir:
  			print cErrorAbrir
  			getChar
  			jmp menuinicial
  		errorLeer:
  			print cErrorLeer
  			jmp menuinicial
		inicio:
			limpiarPantalla
		imprimirTablero:
			print cLetras
			print salto
			mostrarTablero vf9, tablero1, tablero2, espacio, Numero9, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf8, tablero1, tablero2, espacio, Numero8, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf7, tablero1, tablero2, espacio, Numero7, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf6, tablero1, tablero2, espacio, Numero6, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf5, tablero1, tablero2, espacio, Numero5, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf4, tablero1, tablero2, espacio, Numero4, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf3, tablero1, tablero2, espacio, Numero3, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf2, tablero1, tablero2, espacio, Numero2, salto, ints, cEspacio, fBlanca, fNegra
			print cEspacio
			mostrarTablero vf1, tablero1, tablero2, espacio, Numero1, salto, ints, cEspacio, fBlanca, fNegra
			print salto
			print cLetras
		turnoActual:
			cmp cntTurno, 4eh	;negro
			je turnoNegras
			cmp cntTurno, 42h	;blanco
			je turnoBlancas
		turnoNegras:
			print tnegras
			obtenerTexto movimiento
			;mov cntTurno,01h
			jmp validar
		turnoBlancas:
	 		print tblancas
			obtenerTexto movimiento
			;mov cntTurno,00h
			jmp validar
		validar:
			;comando EXIT
			xor si,si
			mov ax,ds
			mov es,ax
			mov cx,4
			lea si, cExit 
  			lea di, movimiento
  			repe cmpsb
  			je comandoExit
  			;comando PASS
  			xor si,si
			mov ax,ds
			mov es,ax
			mov cx,4
  			lea si, cPass
  			lea di, movimiento
  			repe cmpsb
  			je comandoPass
  			;comando SAVE
  			xor si,si
			mov ax,ds
			mov es,ax
			mov cx,4
  			lea si, cSave
  			lea di, movimiento
  			repe cmpsb
  			je comandoSave
  			;comando SHOW
  			xor si,si
			mov ax,ds
			mov es,ax
			mov cx,4
  			lea si, cShow
  			lea di, movimiento
  			repe cmpsb
  			je comandoShow
  			;validar movimiento
  			jmp validarMovimiento
  		comandoExit:
  			limpiarPantalla
  			limpiarTablero vf1, vf2, vf3, vf4, vf5, vf6, vf7, vf8, vf9
  			mov cntTurno, 4eh
  			jmp menuinicial
  		comandoPass:
  			inc cntPass
  			cmp cntPass, 01h
  			je cambioturno
  			cmp cntPass, 02h
  			je salidaPass
  		comandoShow:
  			jmp reporteHTML
  		comandoSave:
  			limpiarContenido handlerE
  			limpiarContenido nombreAr
  			print cGuardar
  			print cNombre
  			obtenerRuta nombreAr
  			crearArchivo nombreAr, handlerE
  			pasarInformacion bufferIn, vf1, vf2, vf3, vf4, vf5, vf6, vf7, vf8, vf9, cntTurno
  			escribirArchivo handlerE, bufferIn
  			cerrar handlerE
  			limpiarContenido bufferIn
  			limpiarContenido nombreAr
  			limpiarContenido handlerE
  			jmp inicio
  		errorCrear:
  			print msj4
  			getChar
  			jmp menuinicial
;Inicio de colocacion de piedra-------------------------------------------------------------------
  		validarMovimiento:
  			mov cntPass, 00h
  			mov si, 2
  			cmp movimiento[si], 24h
  			je movimientoCorrecto
  			jmp movimientoIncorrecto
  		movimientoCorrecto:
  			mov si, 1
  			cmp movimiento[si], 31h	;1
  			je escribir1
  			cmp movimiento[si], 32h	;2
  			je escribir2
  			cmp movimiento[si], 33h	;3
  			je escribir3
  			cmp movimiento[si], 34h	;4
  			je escribir4
  			cmp movimiento[si], 35h	;5
  			je escribir5
  			cmp movimiento[si], 36h	;6
  			je escribir6
  			cmp movimiento[si], 37h	;7
  			je escribir7
  			cmp movimiento[si], 38h	;8
  			je escribir8
  			cmp movimiento[si], 39h	;9
  			je escribir9
  			jmp movimientoIncorrecto
;Determinar corrdenada Y--------------------------------------------------------------------------
  		escribir1:
  			mov posy, 01h
  			jmp coordenadaX
  		escribir2:
  			mov posy, 02h
  			jmp coordenadaX
  		escribir3:
  			mov posy, 03h
  			jmp coordenadaX
  		escribir4:
  			mov posy, 04h
  			jmp coordenadaX
  		escribir5:
  			mov posy, 05h
  			jmp coordenadaX
  		escribir6:
  			mov posy, 06h
  			jmp coordenadaX
  		escribir7:
  			mov posy, 07h
  			jmp coordenadaX
  		escribir8:
  			mov posy, 08h
  			jmp coordenadaX
  		escribir9:
  			mov posy, 09h
  			jmp coordenadaX
;Determinar coodenada X---------------------------------------------------------------------------
 		coordenadaX:
  			xor si, si 
  			cmp movimiento[si], 41h	;A
			je E1
			cmp movimiento[si], 42h ;B
			je E2
			cmp movimiento[si], 43h ;C
			je E3
			cmp movimiento[si], 44h	;D
			je E4
			cmp movimiento[si], 45h	;E
			je E5
			cmp movimiento[si], 46h	;F
			je E6
			cmp movimiento[si], 47h	;G
			je E7
			cmp movimiento[si], 48h	;H
			je E8
			cmp movimiento[si], 4ah	;J
			je E9
			jmp movimientoIncorrecto
 		E1:
 			mov posx, 01h
  			jmp finalCoordenadas
 		E2:
 			mov posx, 02h
  			jmp finalCoordenadas
 		E3:
 			mov posx, 03h
  			jmp finalCoordenadas
 		E4:
 			mov posx, 04h
  			jmp finalCoordenadas
 		E5:
 			mov posx, 05h
  			jmp finalCoordenadas
 		E6:
 			mov posx, 06h
  			jmp finalCoordenadas
 		E7:
 			mov posx, 07h
  			jmp finalCoordenadas
 		E8:
 			mov posx, 08h
  			jmp finalCoordenadas
 		E9:
 			mov posx, 09h
  			jmp finalCoordenadas
;Determinar accion ya teniendo coordenadas--------------------------------------------------------
 		finalCoordenadas:
 			;valores estan en posx, posy
 			mov libertadesA, 00h
 			mov libertadesB, 00h
 			mov libertadesI, 00h
 			mov libertadesD, 00h
 			cmp posy, 01h
 			je verificar1
 			cmp posy, 02h
 			je verificar2
 			cmp posy, 03h
 			je verificar3
 			cmp posy, 04h
 			je verificar4
 			cmp posy, 05h
 			je verificar5
 			cmp posy, 06h
 			je verificar6
 			cmp posy, 07h
 			je verificar7
 			cmp posy, 08h
 			je verificar8
 			cmp posy, 09h
 			je verificar9
 			jmp movimientoIncorrecto
;1 y----------------------------------------------------------------------------------------------
 		verificar1:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf1[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar1EsquinaIzquierda
 			cmp posx, 09h
 			je verificar1EsquinaDerecha
 			jmp verificar1EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar1EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar1
 			jmp NoColocar
		verificar1EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesI
 			add ax, libertadesA
 			cmp ax, 00h
 			jg colocar1
 			jmp NoColocar
		verificar1EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesI
 			add ax, libertadesD
 			cmp ax, 01h
 			jg colocar1
 			jmp NoColocar
 		colocar1:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf1[si], al
 			jmp cambioturno
;2 y----------------------------------------------------------------------------------------------
 		verificar2:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf2[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar2EsquinaIzquierda
 			cmp posx, 09h
 			je verificar2EsquinaDerecha
 			jmp verificar2EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar2EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar2
 			jmp NoColocar
		verificar2EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar2
 			jmp NoColocar
		verificar2EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar2
 			jmp NoColocar
 		colocar2:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf2[si], al
 			jmp cambioturno
;3 y----------------------------------------------------------------------------------------------
 		verificar3:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf3[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar3EsquinaIzquierda
 			cmp posx, 09h
 			je verificar3EsquinaDerecha
 			jmp verificar3EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar3EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar3
 			jmp NoColocar
		verificar3EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar3
 			jmp NoColocar
		verificar3EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar3
 			jmp NoColocar
 		colocar3:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf3[si], al
 			jmp cambioturno
;4 y----------------------------------------------------------------------------------------------
 		verificar4:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf4[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar4EsquinaIzquierda
 			cmp posx, 09h
 			je verificar4EsquinaDerecha
 			jmp verificar4EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar4EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar4
 			jmp NoColocar
		verificar4EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar4
 			jmp NoColocar
		verificar4EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar4
 			jmp NoColocar
 		colocar4:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf4[si], al
 			jmp cambioturno
;5 y----------------------------------------------------------------------------------------------
 		verificar5:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf5[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar5EsquinaIzquierda
 			cmp posx, 09h
 			je verificar5EsquinaDerecha
 			jmp verificar5EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar5EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar5
 			jmp NoColocar
		verificar5EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar5
 			jmp NoColocar
		verificar5EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar5
 			jmp NoColocar
 		colocar5:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf5[si], al
 			xor si, si
 			jmp cambioturno
;6 y----------------------------------------------------------------------------------------------
 		verificar6:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf6[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar6EsquinaIzquierda
 			cmp posx, 09h
 			je verificar6EsquinaDerecha
 			jmp verificar6EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar6EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar6
 			jmp NoColocar
		verificar6EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar6
 			jmp NoColocar
		verificar6EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar6
 			jmp NoColocar
 		colocar6:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf6[si], al
 			jmp cambioturno
;7 y----------------------------------------------------------------------------------------------
 		verificar7:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf7[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar7EsquinaIzquierda
 			cmp posx, 09h
 			je verificar7EsquinaDerecha
 			jmp verificar7EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar7EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar7
 			jmp NoColocar
		verificar7EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar7
 			jmp NoColocar
		verificar7EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar7
 			jmp NoColocar
 		colocar7:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf7[si], al
 			jmp cambioturno
;8 y----------------------------------------------------------------------------------------------
 		verificar8:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf8[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar8EsquinaIzquierda
 			cmp posx, 09h
 			je verificar8EsquinaDerecha
 			jmp verificar8EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar8EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar8
 			jmp NoColocar
		verificar8EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar8
 			jmp NoColocar
		verificar8EnMedio:
 			mov ax, 00h
 			add ax, libertadesA
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar8
 			jmp NoColocar
 		colocar8:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf8[si], al
 			jmp cambioturno
;9 y----------------------------------------------------------------------------------------------
 		verificar9:;Primero verifico si la posicion esta vacia, si no esta vacia pido otra 
 			mov si, posx
 			dec si
 			cmp vf9[si], 24h
 			jne posOcupada
 			call verificarLibertadesArriba
 			call verificarLibertadesAbajo
 			call verificarLibertadesIzquierda
 			call verificarLibertadesDerecha
 			cmp posx, 01h
 			je verificar9EsquinaIzquierda
 			cmp posx, 09h
 			je verificar9EsquinaDerecha
 			jmp verificar9EnMedio
			;Verificar cuantas libertades tiene como cadena
			;casos si esta esquinas o en medio
		verificar9EsquinaIzquierda:
			mov ax, 00h
 			add ax, libertadesB
 			add ax, libertadesD
 			cmp ax, 00h
 			jg colocar9
 			jmp NoColocar
		verificar9EsquinaDerecha:
			mov ax, 00h
 			add ax, libertadesB
 			add ax, libertadesI
 			cmp ax, 00h
 			jg colocar9
 			jmp NoColocar
		verificar9EnMedio:
 			mov ax, 00h
 			add ax, libertadesB
 			add ax, libertadesD
 			add ax, libertadesI
 			cmp ax, 01h
 			jg colocar9
 			jmp NoColocar
 		colocar9:;Despues del analisis solo se escribe en la posicion
 			mov cntPass,00h
 			mov si, posx
 			dec si
 			mov al, cntTurno
 			mov vf9[si], al
 			jmp cambioturno
;Verifica libertades arriba-----------------------------------------------------------------------
 		verificarLibertadesArriba:
 			cmp posy, 01h
 			je vA1
 			cmp posy, 02h
 			je vA2
 			cmp posy, 03h
 			je vA3
 			cmp posy, 04h
 			je vA4
 			cmp posy, 05h
 			je vA5
 			cmp posy, 06h
 			je vA6
 			cmp posy, 07h
 			je vA7
 			cmp posy, 08h
 			je vA8
 			cmp posy, 09h
 			je vA9
 			ret
 		vA1:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf2[si], 24h 
 			je vA2
 			mov al, cntTurno
 			cmp vf2[si], al
 			je vA2
 			jmp retorno
 		vA2:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf3[si], 24h 
 			je vA3
 			mov al, cntTurno
 			cmp vf3[si], al
 			je vA3
 			jmp retorno
 		vA3:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf4[si], 24h 
 			je vA4
 			mov al, cntTurno
 			cmp vf4[si], al
 			je vA4
 			jmp retorno
 		vA4:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf5[si], 24h 
 			je vA5
 			mov al, cntTurno
 			cmp vf5[si], al
 			je vA5
 			jmp retorno
 		vA5:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf6[si], 24h 
 			je vA6
 			mov al, cntTurno
 			cmp vf6[si], al
 			je vA6
 			jmp retorno
 		vA6:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf7[si], 24h 
 			je vA7
 			mov al, cntTurno
 			cmp vf7[si], al
 			je vA7
 			jmp retorno
 		vA7:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf8[si], 24h 
 			je vA8
 			mov al, cntTurno
 			cmp vf8[si], al
 			je vA8
 			jmp retorno
 		vA8:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf9[si], 24h 
 			je sumLibArriba
 			mov al, cntTurno
 			cmp vf9[si], al
 			je sumLibArriba
 			jmp retorno
 		vA9:
 			jmp retorno
 		sumLibArriba:
 			inc libertadesA
 			jmp retorno
;Verifica libertades abajo------------------------------------------------------------------------
 		verificarLibertadesAbajo:
 			xor si, si
 			cmp posy, 01h
 			je vB1
 			cmp posy, 02h
 			je vB2
 			cmp posy, 03h
 			je vB3
 			cmp posy, 04h
 			je vB4
 			cmp posy, 05h
 			je vB5
 			cmp posy, 06h
 			je vB6
 			cmp posy, 07h
 			je vB7
 			cmp posy, 08h
 			je vB8
 			cmp posy, 09h
 			je vB9
 			ret
 		vB1:
 			jmp retorno
		vB2:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf1[si], 24h 
 			je sumLibAbajo
 			mov al, cntTurno
 			cmp vf1[si], al
 			je sumLibAbajo
 			jmp retorno
 		vB3:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf2[si], 24h 
 			je vB2
 			mov al, cntTurno
 			cmp vf2[si], al
 			je vB2
 			jmp retorno
 		vB4:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf3[si], 24h 
 			je vB3
 			mov al, cntTurno
 			cmp vf3[si], al
 			je vB3
 			jmp retorno
 		vB5:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf4[si], 24h 
 			je vB4
 			mov al, cntTurno
 			cmp vf4[si], al
 			je vB4
 			jmp retorno
 		vB6:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf5[si], 24h 
 			je vB5
 			mov al, cntTurno
 			cmp vf5[si], al
 			je vB5
 			jmp retorno
 		vB7:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf6[si], 24h 
 			je vB6
 			mov al, cntTurno
 			cmp vf6[si], al
 			je vB6
 			jmp retorno
 		vB8:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf7[si], 24h 
 			je vB7
 			mov al, cntTurno
 			cmp vf7[si], al
 			je vB7
 			jmp retorno
 		vB9:
 			xor si, si
 			mov si, posx
 			dec si
 			cmp vf8[si], 24h 
 			je vB8
 			mov al, cntTurno
 			cmp vf8[si], al
 			je vB8
 			jmp retorno
 		sumLibAbajo:
 			inc libertadesB
 			jmp retorno	
;verifica libertades izquierda--------------------------------------------------------------------
	verificarLibertadesIzquierda:
		xor si, si
		cmp posy, 01h
		je vI1
		cmp posy, 02h
		je vI2
		cmp posy, 03h
		je vI3
		cmp posy, 04h
		je vI4
		cmp posy, 05h
		je vI5
		cmp posy, 06h
		je vI6
		cmp posy, 07h
		je vI7
		cmp posy, 08h
		je vI8
		cmp posy, 09h
		je vI9
		ret
	VI1:
		libertadesIzquierdaVerificar vf1, posx, cntTurno
		jmp retorno
	VI2:
		libertadesIzquierdaVerificar vf2, posx, cntTurno
		jmp retorno
	VI3:
		libertadesIzquierdaVerificar vf3, posx, cntTurno
		jmp retorno
	VI4:
		libertadesIzquierdaVerificar vf4, posx, cntTurno
		jmp retorno
	VI5:
		libertadesIzquierdaVerificar vf5, posx, cntTurno
		jmp retorno
	VI6:
		libertadesIzquierdaVerificar vf6, posx, cntTurno
		jmp retorno
	VI7:
		libertadesIzquierdaVerificar vf7, posx, cntTurno
		jmp retorno
	VI8:
		libertadesIzquierdaVerificar vf8, posx, cntTurno
		jmp retorno
	VI9:
		libertadesIzquierdaVerificar vf9, posx, cntTurno
		jmp retorno
	sumLibIzquierda:
		inc libertadesI
		jmp retorno	
;Verificar libertades derecha---------------------------------------------------------------------
	verificarLibertadesDerecha:
		xor si, si
		cmp posy, 01h
		je vD1
		cmp posy, 02h
		je vD2
		cmp posy, 03h
		je vD3
		cmp posy, 04h
		je vD4
		cmp posy, 05h
		je vD5
		cmp posy, 06h
		je vD6
		cmp posy, 07h
		je vD7
		cmp posy, 08h
		je vD8
		cmp posy, 09h
		je vD9
		ret
	VD1:
		libertadesDerechaVerificar vf1, posx, cntTurno
		jmp retorno
	VD2:
		libertadesDerechaVerificar vf2, posx, cntTurno
		jmp retorno
	VD3:
		libertadesDerechaVerificar vf3, posx, cntTurno
		jmp retorno
	VD4:
		libertadesDerechaVerificar vf4, posx, cntTurno
		jmp retorno
	VD5:
		libertadesDerechaVerificar vf5, posx, cntTurno
		jmp retorno
	VD6:
		libertadesDerechaVerificar vf6, posx, cntTurno
		jmp retorno
	VD7:
		libertadesDerechaVerificar vf7, posx, cntTurno
		jmp retorno
	VD8:
		libertadesDerechaVerificar vf8, posx, cntTurno
		jmp retorno
	VD9:
		libertadesDerechaVerificar vf9, posx, cntTurno
		jmp retorno
	sumLibDerecha:
		inc libertadesD
		jmp retorno	

;retorno y mensajes-------------------------------------------------------------------------------
 		retorno:
 			xor si, si 
 			ret
 		posOcupada:;Indica que la posicion esta ocupada
 			print msjOcupada
 			getChar
 			jmp inicio
 		NoColocar:;La cadena no tiene libertades
 			print msjNoHab
 			getChar
 			jmp inicio
;final de colocar piedras-------------------------------------------------------------------------
  		movimientoIncorrecto:
  			xor ax, ax
  			print msj3
  			getChar
  			jmp inicio
  		cambioturno:
  			xor ax, ax
  			cmp cntTurno, 4eh
  			je tN
  			cmp cntTurno, 42h
  			je tB
		tN:
			mov cntTurno, 42h
			jmp inicio
		tB:
			mov cntTurno, 4eh
			jmp inicio
;realizar reporte final---------------------------------------------------------------------------
		calcularTerritorio1:
			;para cada posicion se debe calcular las libertades, si las libertades son 0
			;calcular que ficha lo encierra y si mas de una lo encierra, es neutro
			xor si, si 
			xor di, di
		calcularTerritorio11:
			mov cntTurno, 4eh
			jmp ct1
		ct1:
			mov posy, 00h
			mov posx, 00h
		ct1F:
			libertadesPos posx, vf1
			inc posx
			cmp posx, 09h
			je ct2
			jmp ct1F

		ct2:
			mov posy, 01h
			mov posx, 00h
		ct2F:
			libertadesPos posx, vf2
			inc posx
			cmp posx, 09h
			je ct3
			jmp ct2F

		ct3:
			mov posy, 02h
			mov posx, 00h
		ct3F:
			libertadesPos posx, vf3
			inc posx
			cmp posx, 09h
			je ct4
			jmp ct3F

		ct4:
			mov posy, 03h
			mov posx, 00h
		ct4F:
			libertadesPos posx, vf4
			inc posx
			cmp posx, 09h
			je ct5
			jmp ct4F

		ct5:
			mov posy, 04h
			mov posx, 00h
		ct5F:
			libertadesPos posx, vf5
			inc posx
			cmp posx, 09h
			je ct6
			jmp ct5F

		ct6:
			mov posy, 05h
			mov posx, 00h
		ct6F:
			libertadesPos posx, vf6
			inc posx
			cmp posx, 09h
			je ct7
			jmp ct6F

		ct7:
			mov posy, 06h
			mov posx, 00h
		ct7F:
			libertadesPos posx, vf7
			inc posx
			cmp posx, 09h
			je ct8
			jmp ct7F

		ct8:
			mov posy, 07h
			mov posx, 00h
		ct8F:
			libertadesPos posx, vf8
			inc posx
			cmp posx, 09h
			je ct9
			jmp ct8F


		ct9:
			mov posy, 08h
			mov posx, 00h
		ct9F:
			libertadesPos posx, vf9
			inc posx
			cmp posx, 09h
			;je calcularTerritorio2
			je calcularTerritorio2
			jmp ct9F


		calcularTerritorio2:
			;para cada posicion se debe calcular las libertades, si las libertades son 0
			;calcular que ficha lo encierra y si mas de una lo encierra, es neutro
			xor si, si 
			xor di, di
		calcularTerritorio22:
			mov cntTurno, 42h
			jmp ct12
		ct12:
			mov posy, 00h
			mov posx, 00h
		ct12F:
			libertadesPos posx, vf1
			inc posx
			cmp posx, 09h
			je ct22
			jmp ct12F

		ct22:
			mov posy, 01h
			mov posx, 00h
		ct22F:
			libertadesPos posx, vf2
			inc posx
			cmp posx, 09h
			je ct32
			jmp ct22F

		ct32:
			mov posy, 02h
			mov posx, 00h
		ct32F:
			libertadesPos posx, vf3
			inc posx
			cmp posx, 09h
			je ct42
			jmp ct32F

		ct42:
			mov posy, 03h
			mov posx, 00h
		ct42F:
			libertadesPos posx, vf4
			inc posx
			cmp posx, 09h
			je ct52
			jmp ct42F

		ct52:
			mov posy, 04h
			mov posx, 00h
		ct52F:
			libertadesPos posx, vf5
			inc posx
			cmp posx, 09h
			je ct62
			jmp ct52F

		ct62:
			mov posy, 05h
			mov posx, 00h
		ct62F:
			libertadesPos posx, vf6
			inc posx
			cmp posx, 09h
			je ct72
			jmp ct62F

		ct72:
			mov posy, 06h
			mov posx, 00h
		ct72F:
			libertadesPos posx, vf7
			inc posx
			cmp posx, 09h
			je ct82
			jmp ct72F

		ct82:
			mov posy, 07h
			mov posx, 00h
		ct82F:
			libertadesPos posx, vf8
			inc posx
			cmp posx, 09h
			je ct92
			jmp ct82F


		ct92:
			mov posy, 08h
			mov posx, 00h
		ct92F:
			libertadesPos posx, vf9
			inc posx
			cmp posx, 09h
			je reporteHTML
			jmp ct92F


;Salida por Comando PASS consecutivo--------------------------------------------------------------
		salidaPass:
			mov finalJuego, 01h
			;sale cuando dos veces se ha pasado de turno
			mov puntosN, 00h
			mov puntosB, 00h
			;hacer el calculo de territorios
			;retirar piedras muerta
		;cuando ya se calcularon los dos territorios solo habra $ en el neutro
			print rep1
			getChar
			cmp al, 53h
			je calcularTerritorio1
			cmp al, 4eh
			je reporteHTML
			print rep3
			jmp salidaPass
			;reiniciar todooooooo
;final por pass-----------------------------------------------------------------------------------
			finalPorPass:
				xor si, si
				xor di, di
				jmp contarPuntosB
			contarPuntosB:
				conteoB vf1, puntosB
				conteoB vf2, puntosB
				conteoB vf3, puntosB
				conteoB vf4, puntosB
				conteoB vf5, puntosB
				conteoB vf6, puntosB
				conteoB vf7, puntosB
				conteoB vf8, puntosB
				conteoB vf9, puntosB
				jmp contarPuntosN
			contarPuntosN:
				conteoN vf1, puntosN
				conteoN vf2, puntosN
				conteoN vf3, puntosN
				conteoN vf4, puntosN
				conteoN vf5, puntosN
				conteoN vf6, puntosN
				conteoN vf7, puntosN
				conteoN vf8, puntosN
				conteoN vf9, puntosN

				mov si, 18h
				xor ax, ax
				mov dx, puntosN
				mov al, dl
		   		aam  
		   		add ah, 30h 
		   		mov tablaF4[si], ah
		   		inc si 
		    	add al, 30h 
				mov tablaF4[si], al
				inc si 
				inc si 
				inc si 
				mov tablaF4[si], 24h

				mov si, 18h
				xor ax, ax
				xor dx, dx
				mov dx, puntosB
				mov al, dl
		   		aam  
		   		add ah, 30h 
		   		mov tablaF5[si], ah
		   		inc si 
		    	add al, 30h 
				mov tablaF5[si], al
				inc si 
				inc si 
				inc si 
				mov tablaF5[si], 24h
				jmp tablaPunteo
			tablaPunteo:
				limpiarPantalla
				print tablaF1
				print tablaF2
				print tablaF3
				print tablaF10
				print tablaF4
				print tablaF10
				print tablaF5
				print tablaF10
				print tablaF6
				print tablaF8
				mov ax, puntosB
				cmp puntosN, ax
				je ganaNegro
				jg ganaNegro
				jl ganaBlanco
			ganaNegro:
				print tablaF9
				print tablaF10
				jmp reinicioPass
			ganaBlanco:
				print tablaF12
				print tablaF10
				jmp reinicioPass
			reinicioPass:
				print msj5
				getChar
				mov cntTurno, 4eh
				mov cntPass, 00h
				mov puntosB, 00h
				mov puntosN, 00h
				mov finalJuego, 00h
				limpiarContenido bufferHTML
				limpiarContenido bufferIn
				limpiarTablero vf1, vf2, vf3, vf4, vf5, vf6, vf7, vf8, vf9
				xor si, si
				xor di, di
				xor ax, ax
				xor cx, cx
				xor dx, dx
				jmp menuinicial		
;*************************************************************************************************
;Parte de HTML
;*************************************************************************************************
		reporteHTML:
			;int 3
			xor si, si
			xor di, di
			jmp escribirEncabezado
		escribirEncabezado:
			;cmp htmlEnca[si], 24h
			;je declararTabla
			cmp htmlEnca[si], 024h
			je declararTabla
			mov al,htmlEnca[si]
			mov bufferHTML[si],al
			inc si
			jmp escribirEncabezado
		declararTabla:
			;cmp si, 300h
			;je HtmlVector9
			cmp decTabla[di], 024h
			je HtmlVector9
			mov al,decTabla[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp declararTabla
;---------------------------------------Vector9---------------------------------------------------
		HtmlVector9:
			xor di, di
			jmp inicio9
		inicio9:
			cmp trAbre[di], 24h
			je Detalle9
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio9
		Detalle9:
			xor di, di
			jmp verificarVector9
		verificarVector9:
			cmp di, 09h
			je final9
			mov valorDi, di
			cmp vf9[di], 24h
			je celdaVacia9
			cmp vf9[di], 4eh
			je celdaNegra9
			cmp vf9[di], 42h
			je celdaBlanca9
			cmp vf9[di], 45h ;E
			je tBlanco9
			cmp vf9[di], 43h ;C
			je tNegro9
			cmp vf9[di], 54h ;T
			je tNeutro9

		tNeutro9:
			cmp di, 00h
			je tNeutroEI1
			cmp di, 08h
			je tNeutroED1
			jmp tNeutroM1
		tNeutroEI1:
			xor di, di
			jmp tNeutroEI
		tNeutroEI:
			cmp fi3[di], 24h
			je regreso9
			mov al,fi3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI
		tNeutroED1:
			xor di, di
			jmp tNeutroED
		tNeutroED:
			cmp fi9[di], 24h
			je regreso9
			mov al,fi9[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED
		tNeutroM1:
			xor di, di
			jmp tNeutroM
		tNeutroM:
			cmp fi6[di], 24h
			je regreso9
			mov al,fi6[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM


		tNegro9:
			cmp di, 00h
			je tNegroEI1
			cmp di, 08h
			je tNegroED1
			jmp tNegroM1
		tNegroEI1:
			xor di, di
			jmp tNegroEI
		tNegroEI:
			cmp fi1[di], 24h
			je regreso9
			mov al,fi1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI
		tNegroED1:
			xor di, di
			jmp tNegroED
		tNegroED:
			cmp fi7[di], 24h
			je regreso9
			mov al,fi7[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED
		tNegroM1:
			xor di, di
			jmp tNegroM
		tNegroM:
			cmp fi4[di], 24h
			je regreso9
			mov al,fi4[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM


		tBlanco9:
			cmp di, 00h
			je tBlancoEI1
			cmp di, 08h
			je tBlancoED1
			jmp tBlancoM1
		tBlancoEI1:
			xor di, di
			jmp tBlancoEI
		tBlancoEI:
			cmp fi2[di], 24h
			je regreso9
			mov al,fi2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI
		tBlancoED1:
			xor di, di
			jmp tBlancoED
		tBlancoED:
			cmp fi8[di], 24h
			je regreso9
			mov al,fi8[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED
		tBlancoM1:
			xor di, di
			jmp tBlancoM
		tBlancoM:
			cmp fi5[di], 24h
			je regreso9
			mov al,fi5[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM

		celdaVacia9:
			cmp di, 00h
			je celdaVaciaEI1
			cmp di, 08h
			je celdaVaciaED1
			jmp celdaVaciaM1
		celdaVaciaEI1:
			xor di, di
			jmp celdaVaciaEI
		celdaVaciaEI:
			cmp td7[di], 24h
			je regreso9
			mov al,td7[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI
		celdaVaciaED1:
			xor di, di
			jmp celdaVaciaED
		celdaVaciaED:
			cmp td9[di], 24h
			je regreso9
			mov al,td9[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED
		celdaVaciaM1:
			xor di, di
			jmp celdaVaciaM
		celdaVaciaM:
			cmp td24[di], 24h
			je regreso9
			mov al,td24[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM
		celdaNegra9:
			cmp di, 00h
			je celdaNegraEI1
			cmp di, 08h
			je celdaNegraED1
			jmp celdaNegraM1
		celdaNegraEI1:
			xor di, di
			jmp celdaNegraEI
		celdaNegraEI:
			cmp td4[di], 24h
			je regreso9
			mov al,td4[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI
		celdaNegraED1:
			xor di, di
			jmp celdaNegraED
		celdaNegraED:
			cmp td15[di], 24h
			je regreso9
			mov al,td15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED
		celdaNegraM1:
			xor di, di
			jmp celdaNegraM
		celdaNegraM:
			cmp td18[di], 24h
			je regreso9
			mov al,td18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM
		celdaBlanca9:
			cmp di, 00h
			je celdaBlancaEI1
			cmp di, 08h
			je celdaBlancaED1
			jmp celdaBlancaM1
		celdaBlancaEI1:
			xor di, di
			jmp celdaBlancaEI
		celdaBlancaEI:
			cmp td5[di], 24h
			je regreso9
			mov al,td5[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI
		celdaBlancaED1:
			xor di, di
			jmp celdaBlancaED
		celdaBlancaED:
			cmp td14[di], 24h
			je regreso9
			mov al,td14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED
		celdaBlancaM1:
			xor di, di
			jmp celdaBlancaM
		celdaBlancaM:
			cmp td21[di], 24h
			je regreso9
			mov al,td21[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM
		regreso9:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector9
		final9:
			mov valorDi, di
			xor di, di
			jmp final9V
		final9V:
			cmp trCierra[di], 24h
			je final9U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final9V
		final9U:
			mov di, 00h
			jmp HtmlVector8
;---------------------------------------Vector8---------------------------------------------------
		HtmlVector8:
			xor di, di
			jmp inicio8
		inicio8:
			cmp trAbre[di], 24h
			je Detalle8
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio8
		Detalle8:
			xor di, di
			jmp verificarVector8
		verificarVector8:
			cmp di, 09h
			je final8
			mov valorDi, di
			cmp vf8[di], 24h
			je celdaVacia8
			cmp vf8[di], 4eh
			je celdaNegra8
			cmp vf8[di], 42h
			je celdaBlanca8
			cmp vf8[di], 45h ;E
			je tBlanco8
			cmp vf8[di], 43h ;C
			je tNegro8
			cmp vf8[di], 54h ;T
			je tNeutro8

		tNeutro8:
			cmp di, 00h
			je tNeutroEI18
			cmp di, 08h
			je tNeutroED18
			jmp tNeutroM18
		tNeutroEI18:
			xor di, di
			jmp tNeutroEI8
		tNeutroEI8:
			cmp fi12[di], 24h
			je regreso8
			mov al,fi12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI8
		tNeutroED18:
			xor di, di
			jmp tNeutroED8
		tNeutroED8:
			cmp fi18[di], 24h
			je regreso8
			mov al,fi18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED8
		tNeutroM18:
			xor di, di
			jmp tNeutroM8
		tNeutroM8:
			cmp fi15[di], 24h
			je regreso8
			mov al,fi15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM8


		tNegro8:
			cmp di, 00h
			je tNegroEI18
			cmp di, 08h
			je tNegroED18
			jmp tNegroM18
		tNegroEI18:
			xor di, di
			jmp tNegroEI8
		tNegroEI8:
			cmp fi10[di], 24h
			je regreso8
			mov al,fi10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI8
		tNegroED18:
			xor di, di
			jmp tNegroED8
		tNegroED8:
			cmp fi16[di], 24h
			je regreso8
			mov al,fi16[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED8
		tNegroM18:
			xor di, di
			jmp tNegroM8
		tNegroM8:
			cmp fi13[di], 24h
			je regreso8
			mov al,fi13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM8


		tBlanco8:
			cmp di, 00h
			je tBlancoEI18
			cmp di, 08h
			je tBlancoED18
			jmp tBlancoM18
		tBlancoEI18:
			xor di, di
			jmp tBlancoEI8
		tBlancoEI8:
			cmp fi11[di], 24h
			je regreso8
			mov al,fi11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI8
		tBlancoED18:
			xor di, di
			jmp tBlancoED8
		tBlancoED8:
			cmp fi17[di], 24h
			je regreso8
			mov al,fi17[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED8
		tBlancoM18:
			xor di, di
			jmp tBlancoM8
		tBlancoM8:
			cmp fi14[di], 24h
			je regreso8
			mov al,fi14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM8


		celdaVacia8:
			cmp di, 00h
			je celdaVaciaEI18
			cmp di, 08h
			je celdaVaciaED18
			jmp celdaVaciaM18
		celdaVaciaEI18:
			xor di, di
			jmp celdaVaciaEI8
		celdaVaciaEI8:
			cmp td29[di], 24h
			je regreso8
			mov al,td29[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI8
		celdaVaciaED18:
			xor di, di
			jmp celdaVaciaED8
		celdaVaciaED8:
			cmp td30[di], 24h
			je regreso8
			mov al,td30[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED8
		celdaVaciaM18:
			xor di, di
			jmp celdaVaciaM8
		celdaVaciaM8:
			cmp td1[di], 24h
			je regreso8
			mov al,td1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM8
		celdaNegra8:
			cmp di, 00h
			je celdaNegraEI18
			cmp di, 08h
			je celdaNegraED18
			jmp celdaNegraM18
		celdaNegraEI18:
			xor di, di
			jmp celdaNegraEI8
		celdaNegraEI8:
			cmp td25[di], 24h
			je regreso8
			mov al,td25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI8
		celdaNegraED18:
			xor di, di
			jmp celdaNegraED8
		celdaNegraED8:
			cmp td26[di], 24h
			je regreso8
			mov al,td26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED8
		celdaNegraM18:
			xor di, di
			jmp celdaNegraM8
		celdaNegraM8:
			cmp td3[di], 24h
			je regreso8
			mov al,td3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM8
		celdaBlanca8:
			cmp di, 00h
			je celdaBlancaEI18
			cmp di, 08h
			je celdaBlancaED18
			jmp celdaBlancaM18
		celdaBlancaEI18:
			xor di, di
			jmp celdaBlancaEI8
		celdaBlancaEI8:
			cmp td28[di], 24h
			je regreso8
			mov al,td28[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI8
		celdaBlancaED18:
			xor di, di
			jmp celdaBlancaED8
		celdaBlancaED8:
			cmp td27[di], 24h
			je regreso8
			mov al,td27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED8
		celdaBlancaM18:
			xor di, di
			jmp celdaBlancaM8
		celdaBlancaM8:
			cmp td2[di], 24h
			je regreso8
			mov al,td2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM8
		regreso8:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector8
		final8:
			mov valorDi, di
			xor di, di
			jmp final8V
		final8V:
			cmp trCierra[di], 24h
			je final8U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final8V
		final8U:
			mov di, 00h
			jmp HtmlVector7
;---------------------------------------Vector7---------------------------------------------------
		HtmlVector7:
			xor di, di
			jmp inicio7
		inicio7:
			cmp trAbre[di], 24h
			je Detalle7
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio7
		Detalle7:
			xor di, di
			jmp verificarVector7
		verificarVector7:
			cmp di, 09h
			je final7
			mov valorDi, di
			cmp vf7[di], 24h
			je celdaVacia7
			cmp vf7[di], 4eh
			je celdaNegra7
			cmp vf7[di], 42h
			je celdaBlanca7
			cmp vf7[di], 45h ;E
			je tBlanco7
			cmp vf7[di], 43h ;C
			je tNegro7
			cmp vf7[di], 54h ;T
			je tNeutro7

		tNeutro7:
			cmp di, 00h
			je tNeutroEI17
			cmp di, 08h
			je tNeutroED17
			jmp tNeutroM17
		tNeutroEI17:
			xor di, di
			jmp tNeutroEI7
		tNeutroEI7:
			cmp fi12[di], 24h
			je regreso7
			mov al,fi12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI7
		tNeutroED17:
			xor di, di
			jmp tNeutroED7
		tNeutroED7:
			cmp fi18[di], 24h
			je regreso7
			mov al,fi18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED7
		tNeutroM17:
			xor di, di
			jmp tNeutroM7
		tNeutroM7:
			cmp fi15[di], 24h
			je regreso7
			mov al,fi15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM7


		tNegro7:
			cmp di, 00h
			je tNegroEI17
			cmp di, 08h
			je tNegroED17
			jmp tNegroM17
		tNegroEI17:
			xor di, di
			jmp tNegroEI7
		tNegroEI7:
			cmp fi10[di], 24h
			je regreso7
			mov al,fi10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI7
		tNegroED17:
			xor di, di
			jmp tNegroED7
		tNegroED7:
			cmp fi16[di], 24h
			je regreso7
			mov al,fi16[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED7
		tNegroM17:
			xor di, di
			jmp tNegroM7
		tNegroM7:
			cmp fi13[di], 24h
			je regreso7
			mov al,fi13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM7


		tBlanco7:
			cmp di, 00h
			je tBlancoEI17
			cmp di, 08h
			je tBlancoED17
			jmp tBlancoM17
		tBlancoEI17:
			xor di, di
			jmp tBlancoEI7
		tBlancoEI7:
			cmp fi11[di], 24h
			je regreso7
			mov al,fi11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI7
		tBlancoED17:
			xor di, di
			jmp tBlancoED7
		tBlancoED7:
			cmp fi17[di], 24h
			je regreso7
			mov al,fi17[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED7
		tBlancoM17:
			xor di, di
			jmp tBlancoM7
		tBlancoM7:
			cmp fi14[di], 24h
			je regreso7
			mov al,fi14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM7



		celdaVacia7:
			cmp di, 00h
			je celdaVaciaEI17
			cmp di, 08h
			je celdaVaciaED17
			jmp celdaVaciaM17
		celdaVaciaEI17:
			xor di, di
			jmp celdaVaciaEI7
		celdaVaciaEI7:
			cmp td29[di], 24h
			je regreso7
			mov al,td29[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI7
		celdaVaciaED17:
			xor di, di
			jmp celdaVaciaED7
		celdaVaciaED7:
			cmp td30[di], 24h
			je regreso7
			mov al,td30[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED7
		celdaVaciaM17:
			xor di, di
			jmp celdaVaciaM7
		celdaVaciaM7:
			cmp td1[di], 24h
			je regreso7
			mov al,td1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM7
		celdaNegra7:
			cmp di, 00h
			je celdaNegraEI17
			cmp di, 08h
			je celdaNegraED17
			jmp celdaNegraM17
		celdaNegraEI17:
			xor di, di
			jmp celdaNegraEI7
		celdaNegraEI7:
			cmp td25[di], 24h
			je regreso7
			mov al,td25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI7
		celdaNegraED17:
			xor di, di
			jmp celdaNegraED7
		celdaNegraED7:
			cmp td26[di], 24h
			je regreso7
			mov al,td26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED7
		celdaNegraM17:
			xor di, di
			jmp celdaNegraM7
		celdaNegraM7:
			cmp td3[di], 24h
			je regreso7
			mov al,td3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM7
		celdaBlanca7:
			cmp di, 00h
			je celdaBlancaEI17
			cmp di, 08h
			je celdaBlancaED17
			jmp celdaBlancaM17
		celdaBlancaEI17:
			xor di, di
			jmp celdaBlancaEI7
		celdaBlancaEI7:
			cmp td28[di], 24h
			je regreso7
			mov al,td28[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI7
		celdaBlancaED17:
			xor di, di
			jmp celdaBlancaED7
		celdaBlancaED7:
			cmp td27[di], 24h
			je regreso7
			mov al,td27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED7
		celdaBlancaM17:
			xor di, di
			jmp celdaBlancaM7
		celdaBlancaM7:
			cmp td2[di], 24h
			je regreso7
			mov al,td2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM7
		regreso7:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector7
		final7:
			mov valorDi, di
			xor di, di
			jmp final7V
		final7V:
			cmp trCierra[di], 24h
			je final7U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final7V
		final7U:
			mov di, 00h
			jmp HtmlVector6
;---------------------------------------Vector6---------------------------------------------------
		HtmlVector6:
			xor di, di
			jmp inicio6
		inicio6:
			cmp trAbre[di], 24h
			je Detalle6
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio6
		Detalle6:
			xor di, di
			jmp verificarVector6
		verificarVector6:
			cmp di, 09h
			je final6
			mov valorDi, di
			cmp vf6[di], 24h
			je celdaVacia6
			cmp vf6[di], 4eh
			je celdaNegra6
			cmp vf6[di], 42h
			je celdaBlanca6
			cmp vf6[di], 45h ;E
			je tBlanco6
			cmp vf6[di], 43h ;C
			je tNegro6
			cmp vf6[di], 54h ;T
			je tNeutro6

		tNeutro6:
			cmp di, 00h
			je tNeutroEI16
			cmp di, 08h
			je tNeutroED16
			jmp tNeutroM16
		tNeutroEI16:
			xor di, di
			jmp tNeutroEI6
		tNeutroEI6:
			cmp fi12[di], 24h
			je regreso6
			mov al,fi12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI6
		tNeutroED16:
			xor di, di
			jmp tNeutroED6
		tNeutroED6:
			cmp fi18[di], 24h
			je regreso6
			mov al,fi18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED6
		tNeutroM16:
			xor di, di
			jmp tNeutroM6
		tNeutroM6:
			cmp fi15[di], 24h
			je regreso6
			mov al,fi15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM6


		tNegro6:
			cmp di, 00h
			je tNegroEI16
			cmp di, 08h
			je tNegroED16
			jmp tNegroM16
		tNegroEI16:
			xor di, di
			jmp tNegroEI6
		tNegroEI6:
			cmp fi10[di], 24h
			je regreso6
			mov al,fi10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI6
		tNegroED16:
			xor di, di
			jmp tNegroED6
		tNegroED6:
			cmp fi16[di], 24h
			je regreso6
			mov al,fi16[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED6
		tNegroM16:
			xor di, di
			jmp tNegroM6
		tNegroM6:
			cmp fi13[di], 24h
			je regreso6
			mov al,fi13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM6


		tBlanco6:
			cmp di, 00h
			je tBlancoEI16
			cmp di, 08h
			je tBlancoED16
			jmp tBlancoM16
		tBlancoEI16:
			xor di, di
			jmp tBlancoEI6
		tBlancoEI6:
			cmp fi11[di], 24h
			je regreso6
			mov al,fi11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI6
		tBlancoED16:
			xor di, di
			jmp tBlancoED6
		tBlancoED6:
			cmp fi17[di], 24h
			je regreso6
			mov al,fi17[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED6
		tBlancoM16:
			xor di, di
			jmp tBlancoM6
		tBlancoM6:
			cmp fi14[di], 24h
			je regreso6
			mov al,fi14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM6

		celdaVacia6:
			cmp di, 00h
			je celdaVaciaEI16
			cmp di, 08h
			je celdaVaciaED16
			jmp celdaVaciaM16
		celdaVaciaEI16:
			xor di, di
			jmp celdaVaciaEI6
		celdaVaciaEI6:
			cmp td29[di], 24h
			je regreso6
			mov al,td29[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI6
		celdaVaciaED16:
			xor di, di
			jmp celdaVaciaED6
		celdaVaciaED6:
			cmp td30[di], 24h
			je regreso6
			mov al,td30[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED6
		celdaVaciaM16:
			xor di, di
			jmp celdaVaciaM6
		celdaVaciaM6:
			cmp td1[di], 24h
			je regreso6
			mov al,td1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM6
		celdaNegra6:
			cmp di, 00h
			je celdaNegraEI16
			cmp di, 08h
			je celdaNegraED16
			jmp celdaNegraM16
		celdaNegraEI16:
			xor di, di
			jmp celdaNegraEI6
		celdaNegraEI6:
			cmp td25[di], 24h
			je regreso6
			mov al,td25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI6
		celdaNegraED16:
			xor di, di
			jmp celdaNegraED6
		celdaNegraED6:
			cmp td26[di], 24h
			je regreso6
			mov al,td26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED6
		celdaNegraM16:
			xor di, di
			jmp celdaNegraM6
		celdaNegraM6:
			cmp td3[di], 24h
			je regreso6
			mov al,td3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM6
		celdaBlanca6:
			cmp di, 00h
			je celdaBlancaEI16
			cmp di, 08h
			je celdaBlancaED16
			jmp celdaBlancaM16
		celdaBlancaEI16:
			xor di, di
			jmp celdaBlancaEI6
		celdaBlancaEI6:
			cmp td28[di], 24h
			je regreso6
			mov al,td28[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI6
		celdaBlancaED16:
			xor di, di
			jmp celdaBlancaED6
		celdaBlancaED6:
			cmp td27[di], 24h
			je regreso6
			mov al,td27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED6
		celdaBlancaM16:
			xor di, di
			jmp celdaBlancaM6
		celdaBlancaM6:
			cmp td2[di], 24h
			je regreso6
			mov al,td2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM6
		regreso6:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector6
		final6:
			mov valorDi, di
			xor di, di
			jmp final6V
		final6V:
			cmp trCierra[di], 24h
			je final6U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final6V
		final6U:
			mov di, 00h
			jmp HtmlVector5
;---------------------------------------Vector5---------------------------------------------------
		HtmlVector5:
			xor di, di
			jmp inicio5
		inicio5:
			cmp trAbre[di], 24h
			je Detalle5
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio5
		Detalle5:
			xor di, di
			jmp verificarVector5
		verificarVector5:
			cmp di, 09h
			je final5
			mov valorDi, di
			cmp vf5[di], 24h
			je celdaVacia5
			cmp vf5[di], 4eh
			je celdaNegra5
			cmp vf5[di], 42h
			je celdaBlanca5
			cmp vf5[di], 45h ;E
			je tBlanco5
			cmp vf5[di], 43h ;C
			je tNegro5
			cmp vf5[di], 54h ;T
			je tNeutro5

		tNeutro5:
			cmp di, 00h
			je tNeutroEI15
			cmp di, 08h
			je tNeutroED15
			jmp tNeutroM15
		tNeutroEI15:
			xor di, di
			jmp tNeutroEI5
		tNeutroEI5:
			cmp fi12[di], 24h
			je regreso5
			mov al,fi12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI5
		tNeutroED15:
			xor di, di
			jmp tNeutroED5
		tNeutroED5:
			cmp fi18[di], 24h
			je regreso5
			mov al,fi18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED5
		tNeutroM15:
			xor di, di
			jmp tNeutroM5
		tNeutroM5:
			cmp fi15[di], 24h
			je regreso5
			mov al,fi15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM5


		tNegro5:
			cmp di, 00h
			je tNegroEI15
			cmp di, 08h
			je tNegroED15
			jmp tNegroM15
		tNegroEI15:
			xor di, di
			jmp tNegroEI5
		tNegroEI5:
			cmp fi10[di], 24h
			je regreso5
			mov al,fi10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI5
		tNegroED15:
			xor di, di
			jmp tNegroED5
		tNegroED5:
			cmp fi16[di], 24h
			je regreso5
			mov al,fi16[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED5
		tNegroM15:
			xor di, di
			jmp tNegroM5
		tNegroM5:
			cmp fi13[di], 24h
			je regreso5
			mov al,fi13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM5


		tBlanco5:
			cmp di, 00h
			je tBlancoEI15
			cmp di, 08h
			je tBlancoED15
			jmp tBlancoM15
		tBlancoEI15:
			xor di, di
			jmp tBlancoEI5
		tBlancoEI5:
			cmp fi11[di], 24h
			je regreso5
			mov al,fi11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI5
		tBlancoED15:
			xor di, di
			jmp tBlancoED5
		tBlancoED5:
			cmp fi17[di], 24h
			je regreso5
			mov al,fi17[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED5
		tBlancoM15:
			xor di, di
			jmp tBlancoM5
		tBlancoM5:
			cmp fi14[di], 24h
			je regreso5
			mov al,fi14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM5


		celdaVacia5:
			cmp di, 00h
			je celdaVaciaEI15
			cmp di, 08h
			je celdaVaciaED15
			jmp celdaVaciaM15
		celdaVaciaEI15:
			xor di, di
			jmp celdaVaciaEI5
		celdaVaciaEI5:
			cmp td29[di], 24h
			je regreso5
			mov al,td29[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI5
		celdaVaciaED15:
			xor di, di
			jmp celdaVaciaED5
		celdaVaciaED5:
			cmp td30[di], 24h
			je regreso5
			mov al,td30[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED5
		celdaVaciaM15:
			xor di, di
			jmp celdaVaciaM5
		celdaVaciaM5:
			cmp td1[di], 24h
			je regreso5
			mov al,td1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM5
		celdaNegra5:
			cmp di, 00h
			je celdaNegraEI15
			cmp di, 08h
			je celdaNegraED15
			jmp celdaNegraM15
		celdaNegraEI15:
			xor di, di
			jmp celdaNegraEI5
		celdaNegraEI5:
			cmp td25[di], 24h
			je regreso5
			mov al,td25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI5
		celdaNegraED15:
			xor di, di
			jmp celdaNegraED5
		celdaNegraED5:
			cmp td26[di], 24h
			je regreso5
			mov al,td26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED5
		celdaNegraM15:
			xor di, di
			jmp celdaNegraM5
		celdaNegraM5:
			cmp td3[di], 24h
			je regreso5
			mov al,td3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM5
		celdaBlanca5:
			cmp di, 00h
			je celdaBlancaEI15
			cmp di, 08h
			je celdaBlancaED15
			jmp celdaBlancaM15
		celdaBlancaEI15:
			xor di, di
			jmp celdaBlancaEI5
		celdaBlancaEI5:
			cmp td28[di], 24h
			je regreso5
			mov al,td28[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI5
		celdaBlancaED15:
			xor di, di
			jmp celdaBlancaED5
		celdaBlancaED5:
			cmp td27[di], 24h
			je regreso5
			mov al,td27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED5
		celdaBlancaM15:
			xor di, di
			jmp celdaBlancaM5
		celdaBlancaM5:
			cmp td2[di], 24h
			je regreso5
			mov al,td2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM5
		regreso5:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector5
		final5:
			mov valorDi, di
			xor di, di
			jmp final5V
		final5V:
			cmp trCierra[di], 24h
			je final5U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final5V
		final5U:
			mov di, 00h
			jmp HtmlVector4
;---------------------------------------Vector4---------------------------------------------------
		HtmlVector4:
			xor di, di
			jmp inicio4
		inicio4:
			cmp trAbre[di], 24h
			je Detalle4
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio4
		Detalle4:
			xor di, di
			jmp verificarVector4
		verificarVector4:
			cmp di, 09h
			je final4
			mov valorDi, di
			cmp vf4[di], 24h
			je celdaVacia4
			cmp vf4[di], 4eh
			je celdaNegra4
			cmp vf4[di], 42h
			je celdaBlanca4
			cmp vf4[di], 45h ;E
			je tBlanco4
			cmp vf4[di], 43h ;C
			je tNegro4
			cmp vf4[di], 54h ;T
			je tNeutro4

		tNeutro4:
			cmp di, 00h
			je tNeutroEI14
			cmp di, 08h
			je tNeutroED14
			jmp tNeutroM14
		tNeutroEI14:
			xor di, di
			jmp tNeutroEI4
		tNeutroEI4:
			cmp fi12[di], 24h
			je regreso4
			mov al,fi12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI4
		tNeutroED14:
			xor di, di
			jmp tNeutroED4
		tNeutroED4:
			cmp fi18[di], 24h
			je regreso4
			mov al,fi18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED4
		tNeutroM14:
			xor di, di
			jmp tNeutroM4
		tNeutroM4:
			cmp fi15[di], 24h
			je regreso4
			mov al,fi15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM4


		tNegro4:
			cmp di, 00h
			je tNegroEI14
			cmp di, 08h
			je tNegroED14
			jmp tNegroM14
		tNegroEI14:
			xor di, di
			jmp tNegroEI4
		tNegroEI4:
			cmp fi10[di], 24h
			je regreso4
			mov al,fi10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI4
		tNegroED14:
			xor di, di
			jmp tNegroED4
		tNegroED4:
			cmp fi16[di], 24h
			je regreso4
			mov al,fi16[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED4
		tNegroM14:
			xor di, di
			jmp tNegroM4
		tNegroM4:
			cmp fi13[di], 24h
			je regreso4
			mov al,fi13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM4


		tBlanco4:
			cmp di, 00h
			je tBlancoEI14
			cmp di, 08h
			je tBlancoED14
			jmp tBlancoM14
		tBlancoEI14:
			xor di, di
			jmp tBlancoEI4
		tBlancoEI4:
			cmp fi11[di], 24h
			je regreso4
			mov al,fi11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI4
		tBlancoED14:
			xor di, di
			jmp tBlancoED4
		tBlancoED4:
			cmp fi17[di], 24h
			je regreso4
			mov al,fi17[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED4
		tBlancoM14:
			xor di, di
			jmp tBlancoM4
		tBlancoM4:
			cmp fi14[di], 24h
			je regreso4
			mov al,fi14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM4



		celdaVacia4:
			cmp di, 00h
			je celdaVaciaEI14
			cmp di, 08h
			je celdaVaciaED14
			jmp celdaVaciaM14
		celdaVaciaEI14:
			xor di, di
			jmp celdaVaciaEI4
		celdaVaciaEI4:
			cmp td29[di], 24h
			je regreso4
			mov al,td29[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI4
		celdaVaciaED14:
			xor di, di
			jmp celdaVaciaED4
		celdaVaciaED4:
			cmp td30[di], 24h
			je regreso4
			mov al,td30[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED4
		celdaVaciaM14:
			xor di, di
			jmp celdaVaciaM4
		celdaVaciaM4:
			cmp td1[di], 24h
			je regreso4
			mov al,td1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM4
		celdaNegra4:
			cmp di, 00h
			je celdaNegraEI14
			cmp di, 08h
			je celdaNegraED14
			jmp celdaNegraM14
		celdaNegraEI14:
			xor di, di
			jmp celdaNegraEI4
		celdaNegraEI4:
			cmp td25[di], 24h
			je regreso4
			mov al,td25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI4
		celdaNegraED14:
			xor di, di
			jmp celdaNegraED4
		celdaNegraED4:
			cmp td26[di], 24h
			je regreso4
			mov al,td26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED4
		celdaNegraM14:
			xor di, di
			jmp celdaNegraM4
		celdaNegraM4:
			cmp td3[di], 24h
			je regreso4
			mov al,td3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM4
		celdaBlanca4:
			cmp di, 00h
			je celdaBlancaEI14
			cmp di, 08h
			je celdaBlancaED14
			jmp celdaBlancaM14
		celdaBlancaEI14:
			xor di, di
			jmp celdaBlancaEI4
		celdaBlancaEI4:
			cmp td28[di], 24h
			je regreso4
			mov al,td28[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI4
		celdaBlancaED14:
			xor di, di
			jmp celdaBlancaED4
		celdaBlancaED4:
			cmp td27[di], 24h
			je regreso4
			mov al,td27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED4
		celdaBlancaM14:
			xor di, di
			jmp celdaBlancaM4
		celdaBlancaM4:
			cmp td2[di], 24h
			je regreso4
			mov al,td2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM4
		regreso4:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector4
		final4:
			mov valorDi, di
			xor di, di
			jmp final4V
		final4V:
			cmp trCierra[di], 24h
			je final4U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final4V
		final4U:
			mov di, 00h
			jmp HtmlVector3
;---------------------------------------Vector3---------------------------------------------------
		HtmlVector3:
			xor di, di
			jmp inicio3
		inicio3:
			cmp trAbre[di], 24h
			je Detalle3
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio3
		Detalle3:
			xor di, di
			jmp verificarVector3
		verificarVector3:
			cmp di, 09h
			je final3
			mov valorDi, di
			cmp vf3[di], 24h
			je celdaVacia3
			cmp vf3[di], 4eh
			je celdaNegra3
			cmp vf3[di], 42h
			je celdaBlanca3
			cmp vf3[di], 45h ;E
			je tBlanco3
			cmp vf3[di], 43h ;C
			je tNegro3
			cmp vf3[di], 54h ;T
			je tNeutro3

		tNeutro3:
			cmp di, 00h
			je tNeutroEI13
			cmp di, 08h
			je tNeutroED13
			jmp tNeutroM13
		tNeutroEI13:
			xor di, di
			jmp tNeutroEI3
		tNeutroEI3:
			cmp fi12[di], 24h
			je regreso3
			mov al,fi12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI3
		tNeutroED13:
			xor di, di
			jmp tNeutroED3
		tNeutroED3:
			cmp fi18[di], 24h
			je regreso3
			mov al,fi18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED3
		tNeutroM13:
			xor di, di
			jmp tNeutroM3
		tNeutroM3:
			cmp fi15[di], 24h
			je regreso3
			mov al,fi15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM3


		tNegro3:
			cmp di, 00h
			je tNegroEI13
			cmp di, 08h
			je tNegroED13
			jmp tNegroM13
		tNegroEI13:
			xor di, di
			jmp tNegroEI3
		tNegroEI3:
			cmp fi10[di], 24h
			je regreso3
			mov al,fi10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI3
		tNegroED13:
			xor di, di
			jmp tNegroED3
		tNegroED3:
			cmp fi16[di], 24h
			je regreso3
			mov al,fi16[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED3
		tNegroM13:
			xor di, di
			jmp tNegroM3
		tNegroM3:
			cmp fi13[di], 24h
			je regreso3
			mov al,fi13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM3


		tBlanco3:
			cmp di, 00h
			je tBlancoEI13
			cmp di, 08h
			je tBlancoED13
			jmp tBlancoM13
		tBlancoEI13:
			xor di, di
			jmp tBlancoEI3
		tBlancoEI3:
			cmp fi11[di], 24h
			je regreso3
			mov al,fi11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI3
		tBlancoED13:
			xor di, di
			jmp tBlancoED3
		tBlancoED3:
			cmp fi17[di], 24h
			je regreso3
			mov al,fi17[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED3
		tBlancoM13:
			xor di, di
			jmp tBlancoM3
		tBlancoM3:
			cmp fi14[di], 24h
			je regreso3
			mov al,fi14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM3


		celdaVacia3:
			cmp di, 00h
			je celdaVaciaEI13
			cmp di, 08h
			je celdaVaciaED13
			jmp celdaVaciaM13
		celdaVaciaEI13:
			xor di, di
			jmp celdaVaciaEI3
		celdaVaciaEI3:
			cmp td29[di], 24h
			je regreso3
			mov al,td29[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI3
		celdaVaciaED13:
			xor di, di
			jmp celdaVaciaED3
		celdaVaciaED3:
			cmp td30[di], 24h
			je regreso3
			mov al,td30[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED3
		celdaVaciaM13:
			xor di, di
			jmp celdaVaciaM3
		celdaVaciaM3:
			cmp td1[di], 24h
			je regreso3
			mov al,td1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM3
		celdaNegra3:
			cmp di, 00h
			je celdaNegraEI13
			cmp di, 08h
			je celdaNegraED13
			jmp celdaNegraM13
		celdaNegraEI13:
			xor di, di
			jmp celdaNegraEI3
		celdaNegraEI3:
			cmp td25[di], 24h
			je regreso3
			mov al,td25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI3
		celdaNegraED13:
			xor di, di
			jmp celdaNegraED3
		celdaNegraED3:
			cmp td26[di], 24h
			je regreso3
			mov al,td26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED3
		celdaNegraM13:
			xor di, di
			jmp celdaNegraM3
		celdaNegraM3:
			cmp td3[di], 24h
			je regreso3
			mov al,td3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM3
		celdaBlanca3:
			cmp di, 00h
			je celdaBlancaEI13
			cmp di, 08h
			je celdaBlancaED13
			jmp celdaBlancaM13
		celdaBlancaEI13:
			xor di, di
			jmp celdaBlancaEI3
		celdaBlancaEI3:
			cmp td28[di], 24h
			je regreso3
			mov al,td28[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI3
		celdaBlancaED13:
			xor di, di
			jmp celdaBlancaED3
		celdaBlancaED3:
			cmp td27[di], 24h
			je regreso3
			mov al,td27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED3
		celdaBlancaM13:
			xor di, di
			jmp celdaBlancaM3
		celdaBlancaM3:
			cmp td2[di], 24h
			je regreso3
			mov al,td2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM3
		regreso3:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector3
		final3:
			mov valorDi, di
			xor di, di
			jmp final3V
		final3V:
			cmp trCierra[di], 24h
			je final3U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final3V
		final3U:
			mov di, 00h
			jmp HtmlVector2
;---------------------------------------Vector2---------------------------------------------------
		HtmlVector2:
			xor di, di
			jmp inicio2
		inicio2:
			cmp trAbre[di], 24h
			je Detalle2
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio2
		Detalle2:
			xor di, di
			jmp verificarVector2
		verificarVector2:
			cmp di, 09h
			je final2
			mov valorDi, di
			cmp vf2[di], 24h
			je celdaVacia2
			cmp vf2[di], 4eh
			je celdaNegra2
			cmp vf2[di], 42h
			je celdaBlanca2
			cmp vf2[di], 45h ;E
			je tBlanco2
			cmp vf2[di], 43h ;C
			je tNegro2
			cmp vf2[di], 54h ;T
			je tNeutro2

		tNeutro2:
			cmp di, 00h
			je tNeutroEI12
			cmp di, 08h
			je tNeutroED12
			jmp tNeutroM12
		tNeutroEI12:
			xor di, di
			jmp tNeutroEI2
		tNeutroEI2:
			cmp fi12[di], 24h
			je regreso2
			mov al,fi12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI2
		tNeutroED12:
			xor di, di
			jmp tNeutroED2
		tNeutroED2:
			cmp fi18[di], 24h
			je regreso2
			mov al,fi18[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED2
		tNeutroM12:
			xor di, di
			jmp tNeutroM2
		tNeutroM2:
			cmp fi15[di], 24h
			je regreso2
			mov al,fi15[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM2


		tNegro2:
			cmp di, 00h
			je tNegroEI12
			cmp di, 08h
			je tNegroED12
			jmp tNegroM12
		tNegroEI12:
			xor di, di
			jmp tNegroEI2
		tNegroEI2:
			cmp fi10[di], 24h
			je regreso2
			mov al,fi10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI2
		tNegroED12:
			xor di, di
			jmp tNegroED2
		tNegroED2:
			cmp fi16[di], 24h
			je regreso2
			mov al,fi16[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED2
		tNegroM12:
			xor di, di
			jmp tNegroM2
		tNegroM2:
			cmp fi13[di], 24h
			je regreso2
			mov al,fi13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM2


		tBlanco2:
			cmp di, 00h
			je tBlancoEI12
			cmp di, 08h
			je tBlancoED12
			jmp tBlancoM12
		tBlancoEI12:
			xor di, di
			jmp tBlancoEI2
		tBlancoEI2:
			cmp fi11[di], 24h
			je regreso2
			mov al,fi11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI2
		tBlancoED12:
			xor di, di
			jmp tBlancoED2
		tBlancoED2:
			cmp fi17[di], 24h
			je regreso2
			mov al,fi17[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED2
		tBlancoM12:
			xor di, di
			jmp tBlancoM2
		tBlancoM2:
			cmp fi14[di], 24h
			je regreso2
			mov al,fi14[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM2



		celdaVacia2:
			cmp di, 00h
			je celdaVaciaEI12
			cmp di, 08h
			je celdaVaciaED12
			jmp celdaVaciaM12
		celdaVaciaEI12:
			xor di, di
			jmp celdaVaciaEI2
		celdaVaciaEI2:
			cmp td29[di], 24h
			je regreso2
			mov al,td29[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI2
		celdaVaciaED12:
			xor di, di
			jmp celdaVaciaED2
		celdaVaciaED2:
			cmp td30[di], 24h
			je regreso2
			mov al,td30[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED2
		celdaVaciaM12:
			xor di, di
			jmp celdaVaciaM2
		celdaVaciaM2:
			cmp td1[di], 24h
			je regreso2
			mov al,td1[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM2
		celdaNegra2:
			cmp di, 00h
			je celdaNegraEI12
			cmp di, 08h
			je celdaNegraED12
			jmp celdaNegraM12
		celdaNegraEI12:
			xor di, di
			jmp celdaNegraEI2
		celdaNegraEI2:
			cmp td25[di], 24h
			je regreso2
			mov al,td25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI2
		celdaNegraED12:
			xor di, di
			jmp celdaNegraED2
		celdaNegraED2:
			cmp td26[di], 24h
			je regreso2
			mov al,td26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED2
		celdaNegraM12:
			xor di, di
			jmp celdaNegraM2
		celdaNegraM2:
			cmp td3[di], 24h
			je regreso2
			mov al,td3[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM2
		celdaBlanca2:
			cmp di, 00h
			je celdaBlancaEI12
			cmp di, 08h
			je celdaBlancaED12
			jmp celdaBlancaM12
		celdaBlancaEI12:
			xor di, di
			jmp celdaBlancaEI2
		celdaBlancaEI2:
			cmp td28[di], 24h
			je regreso2
			mov al,td28[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI2
		celdaBlancaED12:
			xor di, di
			jmp celdaBlancaED2
		celdaBlancaED2:
			cmp td27[di], 24h
			je regreso2
			mov al,td27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED2
		celdaBlancaM12:
			xor di, di
			jmp celdaBlancaM2
		celdaBlancaM2:
			cmp td2[di], 24h
			je regreso2
			mov al,td2[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM2
		regreso2:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector2
		final2:
			mov valorDi, di
			xor di, di
			jmp final2V
		final2V:
			cmp trCierra[di], 24h
			je final2U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final2V
		final2U:
			mov di, 00h
			jmp HtmlVector1
;---------------------------------------Vector1---------------------------------------------------
		HtmlVector1:
			xor di, di
			jmp inicio1
		inicio1:
			cmp trAbre[di], 24h
			je Detalle1
			mov al,trAbre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp inicio1
		Detalle1:
			xor di, di
			jmp verificarVector1
		verificarVector1:
			cmp di, 09h
			je final1
			mov valorDi, di
			cmp vf1[di], 24h
			je celdaVacia1
			cmp vf1[di], 4eh
			je celdaNegra1
			cmp vf1[di], 42h
			je celdaBlanca1
			cmp vf1[di], 45h ;E
			je tBlanco11
			cmp vf1[di], 43h ;C
			je tNegro11
			cmp vf1[di], 54h ;T
			je tNeutro11

		tNeutro11:
			cmp di, 00h
			je tNeutroEI111
			cmp di, 08h
			je tNeutroED111
			jmp tNeutroM111
		tNeutroEI111:
			xor di, di
			jmp tNeutroEI11
		tNeutroEI11:
			cmp fi21[di], 24h
			je regreso1
			mov al,fi21[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroEI11
		tNeutroED111:
			xor di, di
			jmp tNeutroED11
		tNeutroED11:
			cmp fi27[di], 24h
			je regreso1
			mov al,fi27[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroED11
		tNeutroM111:
			xor di, di
			jmp tNeutroM11
		tNeutroM11:
			cmp fi24[di], 24h
			je regreso1
			mov al,fi24[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNeutroM11


		tNegro11:
			cmp di, 00h
			je tNegroEI111
			cmp di, 08h
			je tNegroED111
			jmp tNegroM111
		tNegroEI111:
			xor di, di
			jmp tNegroEI11
		tNegroEI11:
			cmp fi19[di], 24h
			je regreso1
			mov al,fi19[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroEI11
		tNegroED111:
			xor di, di
			jmp tNegroED11
		tNegroED11:
			cmp fi25[di], 24h
			je regreso1
			mov al,fi25[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroED11
		tNegroM111:
			xor di, di
			jmp tNegroM11
		tNegroM11:
			cmp fi22[di], 24h
			je regreso1
			mov al,fi22[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tNegroM11


		tBlanco11:
			cmp di, 00h
			je tBlancoEI111
			cmp di, 08h
			je tBlancoED111
			jmp tBlancoM111
		tBlancoEI111:
			xor di, di
			jmp tBlancoEI11
		tBlancoEI11:
			cmp fi20[di], 24h
			je regreso1
			mov al,fi20[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoEI11
		tBlancoED111:
			xor di, di
			jmp tBlancoED11
		tBlancoED11:
			cmp fi26[di], 24h
			je regreso1
			mov al,fi26[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoED11
		tBlancoM111:
			xor di, di
			jmp tBlancoM11
		tBlancoM11:
			cmp fi23[di], 24h
			je regreso1
			mov al,fi23[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp tBlancoM11

		celdaVacia1:
			cmp di, 00h
			je celdaVaciaEI11
			cmp di, 08h
			je celdaVaciaED11
			jmp celdaVaciaM11
		celdaVaciaEI11:
			xor di, di
			jmp celdaVaciaEI111
		celdaVaciaEI111:
			cmp td10[di], 24h
			je regreso1
			mov al,td10[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaEI111
		celdaVaciaED11:
			xor di, di
			jmp celdaVaciaED111
		celdaVaciaED111:
			cmp td8[di], 24h
			je regreso1
			mov al,td8[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaED111
		celdaVaciaM11:
			xor di, di
			jmp celdaVaciaM111
		celdaVaciaM111:
			cmp td23[di], 24h
			je regreso1
			mov al,td23[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaVaciaM111
		celdaNegra1:
			cmp di, 00h
			je celdaNegraEI11
			cmp di, 08h
			je celdaNegraED11
			jmp celdaNegraM11
		celdaNegraEI11:
			xor di, di
			jmp celdaNegraEI111
		celdaNegraEI111:
			cmp td13[di], 24h
			je regreso1
			mov al,td13[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraEI111
		celdaNegraED11:
			xor di, di
			jmp celdaNegraED111
		celdaNegraED111:
			cmp td11[di], 24h
			je regreso1
			mov al,td11[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraED111
		celdaNegraM11:
			xor di, di
			jmp celdaNegraM111
		celdaNegraM111:
			cmp td19[di], 24h
			je regreso1
			mov al,td19[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaNegraM111
		celdaBlanca1:
			cmp di, 00h
			je celdaBlancaEI11
			cmp di, 08h
			je celdaBlancaED11
			jmp celdaBlancaM11
		celdaBlancaEI11:
			xor di, di
			jmp celdaBlancaEI111
		celdaBlancaEI111:
			cmp td12[di], 24h
			je regreso1
			mov al,td12[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaEI111
		celdaBlancaED11:
			xor di, di
			jmp celdaBlancaED111
		celdaBlancaED111:
			cmp td6[di], 24h
			je regreso1
			mov al,td6[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaED111
		celdaBlancaM11:
			xor di, di
			jmp celdaBlancaM111
		celdaBlancaM111:
			cmp td22[di], 24h
			je regreso1
			mov al,td22[di]
			mov bufferHTML[si],al
			inc si
			inc di
			xor al, al
			jmp celdaBlancaM111
		regreso1:
			mov di, valorDi
			inc di
			;inc si
			jmp verificarVector1
		final1:
			mov valorDi, di
			xor di, di
			jmp final1V
		final1V:
			cmp trCierra[di], 24h
			je final1U
			mov al,trCierra[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp final1V
		final1U:
			mov di, 00h
			jmp ponerfinTabla
		ponerfinTabla:
			xor di, di
			xor al, al
			jmp ponerfinTabla1
		ponerfinTabla1:
			cmp finTabla[di], 24h
			je etiquetahora
			mov al, finTabla[di]
			mov bufferHTML[si], al
			inc si
			inc di
			jmp ponerfinTabla1
;*************************************************************************************************
;Para la hora
;*************************************************************************************************
		etiquetahora:
			;mov bufferHTML[si], 0ah
			;inc si
			xor di,di
			xor ax,ax
			jmp horah1
		horah1:
			cmp h1abre[di],24h
			je obtenerHora
			mov al,h1abre[di]
			mov bufferHTML[si],al
			inc si
			inc di
			mov valorSi,si
			jmp horah1
		obtenerHora:
			xor cx, cx
		    xor dx, dx
		    xor ax,ax  
		    mov si, 7
		    mov ah, 2ah               
		    int 21h                   
		    mov al, dl ;obtener dia
		    aam  
		    add ah, 30h 
		    mov horayF[si], ah
		    inc si 
		    add al, 30h
		    mov horayF[si], al
		    inc si
		    mov horayF[si], 47
		    inc si
		    mov al, dh  ;obtener mes
		    aam  
		    add ah, 30h 
		    mov horayF[si], ah
		    inc si 
		    add al, 30h
		    mov horayF[si], al
		    inc si
		    mov horayF[si], 47
		    inc si
		    mov horayF[si], 50
		    inc si
		    mov horayF[si], 48
		    inc si
		    mov horayF[si], 32
		    inc si
			xor cx, cx    
		    xor dx, dx 
		    mov ah, 2ch
		 	int 21h 
		    inc si
		    inc si
		    inc si
		    inc si 

		    mov al, ch    ; obtener hora 
		    aam  
		    add ah, 30h 
		    mov horayF[si], ah
		    inc si 
		    add al, 30h
		    mov horayF[si], al
		    inc si
		    mov horayF[si], 4dh
		    inc si
		    mov horayF[si],58
		    inc si  
		    
		    mov al, cl    ;obtener minutos
		    aam  
		    add ah, 30h 
		    mov horayF[si], ah
		    inc si 
		    add al, 30h
		    mov horayF[si], al
		    inc si
		    mov horayF[si], 53h
		    inc si
		    mov horayF[si],58
		    inc si

    		mov al, dh    ;obtener segundos
		    aam  
		    add ah, 30h 
		    mov horayF[si], ah
		    inc si 
		    add al, 30h
		    mov horayF[si], al
		    inc si
		    mov horayF[si], 24h
		    jmp guardarHora
		 guardarHora:
		 	mov si,valorSi
		 	xor di,di
		 	xor ax,ax
		 	jmp ponerhora
		 ponerhora:	
		 	cmp horayF[di], 24h
		 	je ponerfinh
		 	mov al,horayF[di]
		 	mov bufferHTML[si],al
		 	inc si 
		 	inc di
		 	jmp ponerhora
		ponerfinh:
			xor di,di
			xor ax,ax
			jmp ponerfinh1
		ponerfinh1:
			cmp h1cierra[di], 24h
			je finalArchivoHTML
			mov al,h1cierra[di]
			mov bufferHTML[si],al
			inc si
			inc di 
			jmp ponerfinh1
;--------------------------------Colocar final HTML-----------------------------------------------
		finalArchivoHTML:
			xor di, di
			jmp finalArchivoHTML1
		finalArchivoHTML1:
			cmp finHT[di], 24h
			je finalHTML2
			mov al, finHT[di]
			mov bufferHTML[si], al
			xor al, al
			inc si
			inc di
			jmp finalArchivoHTML1
		finalHTML2:
			cmp si, 5000h
			je finalHTML
			mov bufferHTML[si], 20h
			inc si 
			jmp finalHTML2
		finalHTML:
			xor si, si 
			xor di, di 
			limpiarContenido handlerE
  			crearArchivo aHtml, handlerE
  			escribirArchivo handlerE, bufferHTML
  			cerrar handlerE
  			limpiarContenido bufferHTML
  			limpiarContenido handlerE
  			cmp finalJuego, 01h
  			je finalPorPass
  			cmp finalJuego, 00h
  			je inicio
  		crearhtml:
			xor ax,ax
			mov ah,3ch
			mov cx,0
			mov dx,offset aHtml
			int 21h
			jc errorCrear
			mov bx,ax
			mov ah,3eh
			int 21h
			jmp escribirhtml_1
		escribirhtml_1:
			mov si,SIZEOF bufferHTML
			mov ah,3dh
			mov al,01h
			mov dx,offset aHtml
			int 21h
			jc errorCrear
			mov bx,ax
			mov cx,si
			mov dx,offset bufferHTML
			mov ah,40h
			int 21h
			jc errorCrear
			mov ah,3eh
			int 21h
			jmp inicio
;*************************************************************************************************
;*************************************************************************************************

		salida:
			print msj2
			salir
	main endp

	
end main
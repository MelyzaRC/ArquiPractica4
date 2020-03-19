;----------------------------------------------------------------------------------------
;Melyza Alejandra Rodriguez Contreras
;201314821
;Practica 4
;Arquitectura de computadoras y Ensambladores 1
;----------------------------------------------------------------------------------------

;----------------------------------------------------------------------------------------
;archivos externos 
;----------------------------------------------------------------------------------------
include m4.asm

;----------------------------------------------------------------------------------------
;modelo 
;----------------------------------------------------------------------------------------
.model small

;----------------------------------------------------------------------------------------
;segmento de pila
;----------------------------------------------------------------------------------------
.stack 100h

;----------------------------------------------------------------------------------------
;segmento de dato
;----------------------------------------------------------------------------------------
.data
	;variables
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
	msj2		db 0ah, 0dh,	"   ******** Saliendo ********", 0ah, '$'
	msj3		db 0ah, 0dh,	"   ******** Posicion incorrecta ********", 0ah, '$'
	msj4		db 0ah, 0dh,	"   No se pudo crear el archivo!!", 0ah, '$'
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
	aHtml		db "practica4.html",0
	bufferHTML	db 5000h	dup('$')
	htmlEnca    db "<html>", 0ah, 09h, "<head>",  0ah, 09h, 09h, "<title>Practica 4 ARQUI 1</title>", 0ah, 09h, "</head>", 0ah, 09h, "<body>",'$'
	decTabla	db 0ah, 09h, 09, "<table width=", 22h,"700", 22h, " height=", 22h, "700", 22h, 3bh ," border=", 22h, "25", 22h ," cellspacing=", 22h, "2", 22h, " cellpadding=", 22h, "2", 22h," bgcolor=", 22h, "#000000", 22h, ">", '$'
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


	trCierra	db 0ah, 09h, 09h, 09h, "</tr>", '$'
	tablaCierra	db 0ah, 09h, 09, "</table>", '$'
	finHTML 	db 0ah, 09h, "</body>",0ah,"</html",'$'

	valorSi		dw 00h
	valorDi		dw 00h

;----------------------------------------------------------------------------------------
;segmento de codigo
;----------------------------------------------------------------------------------------
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
  			llenarPosiciones vf1, vf2, vf3, vf4, vf5, vf6, vf7, vf8, vf9, bufferIn
  			limpiarContenido bufferIn
  			jmp menuinicial
  		errorAbrir:
  			print cErrorAbrir
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
  			jg salida
  		comandoShow:
  			jmp reporteHTML
  		comandoSave:
  			limpiarContenido handlerE
  			print cGuardar
  			print cNombre
  			obtenerRuta nombreAr
  			crearArchivo nombreAr, handlerE
  			pasarInformacion bufferIn, vf1, vf2, vf3, vf4, vf5, vf6, vf7, vf8, vf9
  			escribirArchivo handlerE, bufferIn
  			cerrar handlerE
  			limpiarContenido bufferIn
  			limpiarContenido nombreAr
  			limpiarContenido handlerE
  			jmp inicio
  		errorCrear:
  			print msj4
  			jmp menuinicial
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
  		escribir1:
  			ponerPiedraC1 vf1, vf2, cntTurno, movimiento
  			limpiarBuffer movimiento
  			jmp cambioturno
  		escribir2:
  		escribir3:
  		escribir4:
  		escribir5:
  		escribir6:
  		escribir7:
  		escribir8:
  		escribir9:
  		determinarPos:

  		movimientoIncorrecto:
  			print msj3
  			getChar
  			jmp inicio
  		cambioturno:
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
		salidaPass:
			;sale cuando dos veces se ha pasado de turno
			jmp salida
		;******************************************************************************************************************
		;******************************************************************************************************************
		reporteHTML:
			xor si, si
			xor di, di
		escribirEncabezado:
			cmp si, 300h
			je declararTabla
			cmp htmlEnca[si], 024h
			je declararTabla
			mov al,htmlEnca[si]
			mov bufferHTML[si],al
			inc si
			jmp escribirEncabezado
		declararTabla:
			cmp si, 300h
			je HtmlVector9
			cmp decTabla[di], 024h
			je HtmlVector9
			mov al,decTabla[di]
			mov bufferHTML[si],al
			inc si
			inc di
			jmp declararTabla
		;---------------------------------------Vector9------------------------------------
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
		;---------------------------------------Vector8------------------------------------
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
			;---------------------------------------Vector7------------------------------------
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
			;---------------------------------------Vector6------------------------------------
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
		;---------------------------------------Vector5------------------------------------
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
			;---------------------------------------Vector4------------------------------------
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
			;---------------------------------------Vector3------------------------------------
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
			;----------------------------Vector2--------------------------------------
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
			;---------------------------------------Vector1------------------------------------
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
			jmp finalHTML
		finalHTML:
			limpiarContenido handlerE
  			crearArchivo aHtml, handlerE
  			escribirArchivo handlerE, bufferHTML
  			cerrar handlerE
  			limpiarContenido bufferHTML
  			limpiarContenido handlerE
  			jmp inicio
		;******************************************************************************************************************
		;******************************************************************************************************************
		salida:
			print msj2
			salir
	main endp
end main
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
  			print cShow
  			jmp salida
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

		salida:
			print msj2
			salir
	main endp
end main
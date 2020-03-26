;----------------------------------------------------------------------------------------
;conservar y recuperar registros
;----------------------------------------------------------------------------------------
pushear macro
	push ax
	push bx
	push cx
	push dx
	push si
	push di
endm

popear macro
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
endm

;----------------------------------------------------------------------------------------
;salida del programa
;----------------------------------------------------------------------------------------
salir macro
	MOV ah,4ch
	int 21h
endm

;----------------------------------------------------------------------------------------
;imprimir una cadena
;----------------------------------------------------------------------------------------
print macro buffer
	LOCAL IMPRIMIR
		IMPRIMIR:
		mov   ax, @data 
	   	mov   ds,ax          
		mov   ah,09   
	   	lea   dx, buffer 
	   	int   21h    
endm

;----------------------------------------------------------------------------------------
;recibir un caracter de teclado (SOLO uN CARACTER)
;----------------------------------------------------------------------------------------
getChar macro
	LOCAL ETIQUETA
	ETIQUETA:
		MOV ah, 01h
		int 21h
endm

;----------------------------------------------------------------------------------------
;limpiar pantalla
;----------------------------------------------------------------------------------------
limpiarPantalla macro
	LOCAL LIMPIAR
	LIMPIAR:
		mov ah, 0                               
		mov al, 03h
	    int 10h 
endm

;----------------------------------------------------------------------------------------
;obtener texto de teclado
;----------------------------------------------------------------------------------------
limpiarBuffer macro buffer
	LOCAL limpiarB, final
	xor si, si
	limpiarB:
		cmp buffer[si], 24h
		je final
		mov buffer[si], 24h
		inc si
		jmp limpiarB
	final:
		xor si, si
	;nada
endm

limpiarContenido macro buffer
	LOCAL limpiar, final
	xor si, si
	limpiar:
		cmp si, SIZEOF buffer
		je final
		mov buffer[si], 24h
		inc si
		jmp limpiar
	final:
endm

llenarPosiciones macro v1, v2, v3, v4, v5, v6, v7, v8, v9, contenido, cntTurno
	LOCAL final, llenar, llenarV1, llenarV2, llenarV3, llenarV4, llenarV5, llenarV6, llenarV7, llenarV8, llenarV9
	xor si, si
	xor di, di
	llenar:
		cmp si, 09h
		jl llenarV1
		cmp si, 12h
		jl llenarV2
		cmp si, 1bh
		jl llenarV3
		cmp si, 24h
		jl llenarV4
		cmp si, 2Dh
		jl llenarV5
		cmp si, 36h
		jl llenarV6
		cmp si, 3fh
		jl llenarV7
		cmp si, 48h
		jl llenarV8
		cmp si, 51h
		jl llenarV9
		jmp final
	llenarV1:
		mov al, contenido[si]
		mov v1[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV2:
		mov al, contenido[si]
		mov v2[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV3:
		mov al, contenido[si]
		mov v3[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV4:
		mov al, contenido[si]
		mov v4[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV5:
		mov al, contenido[si]
		mov v5[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV6:
		mov al, contenido[si]
		mov v6[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV7:
		mov al, contenido[si]
		mov v7[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV8:
		mov al, contenido[si]
		mov v8[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV9:
		mov al, contenido[si]
		mov v9[di],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	final:
		mov al, contenido[si]
		mov cntTurno, al
endm

;----------------------------------------------------------------------------------------
;obtener texto de teclado para movimiento
;----------------------------------------------------------------------------------------
obtenerTexto macro buffer
	LOCAL obtenerChar, FinOT, FinOT2, salida
	limpiarBuffer buffer
	xor si, si
	print buffer
	obtenerChar:
		getChar
		cmp al, 0dh
		je FinOT2
		mov buffer[si], al
		inc si
		cmp si, 04h
		je FinOT
		jmp obtenerChar
	FinOT:
		getChar
		mov al, 24h
		mov buffer[si], al
		jmp salida
	FinOT2:
		mov al, 24h
		mov buffer[si], al
	salida:
		xor si, si
endm

;----------------------------------------------------------------------------------------
;obtener texto de teclado para nombre de archivo
;----------------------------------------------------------------------------------------
obtenerTextoNombre macro buffer
	LOCAL obtenerChar, FinOT
	xor si, si 
	obtenerChar:
	getChar
	cmp al, 0dh	
	je FinOT
	mov buffer[si], al
	inc si
	jmp obtenerChar
	FinOT:
	mov al, 24h
	mov buffer[si], al
endm


;----------------------------------------------------------------------------------------
;Manejo de archivos
;----------------------------------------------------------------------------------------
obtenerRuta macro buffer
	LOCAL obtenerChar, FinOT
	xor si, si 
	obtenerChar:
	getChar
	cmp al, 0dh	
	je FinOT
	mov buffer[si], al
	inc si
	jmp obtenerChar
	FinOT:
	mov al, 00h
	mov buffer[si], al
endm

abrir macro buffer, handler
	mov ah, 3dh
	mov al, 00h
	mov dx, offset buffer
	int 21h
	jc errorAbrir
	mov handler,ax
endm

cerrar macro handler
	mov ah, 3eh
	mov bx, handler
	int 21h
endm

leerArchivo macro handler, buffer11, num
	mov si, 00h
	mov ah, 3fh
	mov bx, handler
	mov cx, SIZEOF buffer11
	lea dx, buffer11
	
	int 21h
	jc errorLeer
endm

crearArchivo macro buffer, handler
	mov   ax,@data
	mov ds, ax
	mov ah, 3ch
	mov cx, 00h
	lea dx, buffer
	int 21h
	jc errorCrear
	mov handler, ax
endm

escribirArchivo macro handler, buffer
	mov ah, 40h
	mov bx, handler
	mov cx, SIZEOF buffer
	lea dx, buffer
	int 21h
	jc errorCrear
endm

pasarInformacion macro contenido, v1, v2, v3, v4, v5, v6, v7, v8, v9, cntTurno
	LOCAL final, llenar, llenarV1, llenarV2, llenarV3, llenarV4, llenarV5, llenarV6, llenarV7, llenarV8, llenarV9, final2, final3
	xor si, si
	xor di, di
	llenar:
		cmp si, 09h
		jl llenarV1
		cmp si, 12h
		jl llenarV2
		cmp si, 1bh
		jl llenarV3
		cmp si, 24h
		jl llenarV4
		cmp si, 2Dh
		jl llenarV5
		cmp si, 36h
		jl llenarV6
		cmp si, 3fh
		jl llenarV7
		cmp si, 48h
		jl llenarV8
		cmp si, 51h
		jl llenarV9
		xor di, di
		jmp final
	llenarV1:
		mov al, v1[di]
		mov contenido[si],al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV2:
		mov al, v2[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV3:
		mov al, v3[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV4:
		mov al, v4[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV5:
		mov al, v5[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV6:
		mov al, v6[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV7:
		mov al, v7[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV8:
		mov al, v8[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	llenarV9:
		mov al, v9[di]
		mov contenido[si], al 
		xor al, al
		inc si
		inc di
		cmp di, 09h
		jl llenar
		mov di, 00h
		jmp llenar
	final:
		cmp cntTurno, 4eh
		je final2
		mov contenido[si], 42h
		jmp final3
	final2:
		mov contenido[si], 4eh
		jmp final3
	final3:
endm

;----------------------------------------------------------------------------------------
;Manejo de tablero
;----------------------------------------------------------------------------------------
mostrarTablero macro vector, tablero1, tablero2, espacio, numero, salto, ints, cEspacio, fblancas, fnegras
	;tablero
	dibujarVector vector, tablero1, tablero2, espacio, numero, salto, ints, cEspacio, fblancas, fnegras
endm


dibujarVector macro vector, tablero1, tablero2, espacio, numero, salto, ints, cEspacio, fblancas, fnegras
	LOCAL INICIO, LLENAR, LLENO1, LLENO2, FINAL, LLENO3, LLENO4, LLENO5, LLENO6, LLENO7
	INICIO:
	print numero
		print espacio
		mov si, 0
	LLENAR:
		cmp si, 08h
		jg FINAL 
		cmp vector[si], 24h
		je LLENO1
		jne LLENO3
	LLENO1:
		cmp si, 00h
		je LLENO2
		print tablero1
		print ints
		inc si
		jmp LLENAR
	LLENO2:
		print ints
		inc si
		jmp LLENAR
	LLENO3:
		cmp vector[si], 42h ;blanco
		je LLENO4
		cmp vector[si], 4eh ;negro
		je LLENO5
	LLENO4:
		cmp si, 00h
		je LLENO6
		print tablero1
		print fblancas
		inc si
		jmp LLENAR
	LLENO5:
		cmp si, 00h
		je LLENO7
		print tablero1
		print fnegras
		inc si
		jmp LLENAR
	LLENO6:
		print fblancas
		inc si
		jmp LLENAR
	LLENO7:
		print fnegras
		inc si
		jmp LLENAR
	FINAL:
		print espacio
		print numero
		print salto
		xor si, si	
endm

;----------------------------------------------------------------------------------------
;limpiar vectores
;----------------------------------------------------------------------------------------
limpiarTablero macro v1, v2, v3, v4, v5, v6, v7, v8, v9
	LOCAL limpiar, salida
	xor si, si
	limpiar:
	mov v9[si], 024h
	mov v8[si], 024h
	mov v7[si], 024h
	mov v6[si], 024h
	mov v5[si], 024h
	mov v4[si], 024h
	mov v3[si], 024h
	mov v2[si], 024h
	mov v1[si], 024h
	cmp si, 8
	je salida
	inc si
	jmp limpiar
	salida: 
endm	

;----------------------------------------------------------------------------------------
;poner piedra
;----------------------------------------------------------------------------------------
ponerPiedraC1 macro v1, ficha, movimiento
	LOCAL E1, E2, E3, E4, E5, E6, E7, E8, E9, sal
	xor si, si
	xor al, al
	xor di, di
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
		mov si, 0
		mov al, ficha
		mov si, 0
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	E2:
		mov si, 0
		mov al, ficha
		mov si, 1
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal

	E3:
		mov si, 0
		mov al, ficha
		mov si, 2
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	E4:
		mov si, 0
		mov al, ficha
		mov si, 3
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	E5:
		mov si, 0
		mov al, ficha
		mov si, 4
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	E6:
		mov si, 0
		mov al, ficha
		mov si, 5
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	E7:
		mov si, 0
		mov al, ficha
		mov si, 6
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	E8:
		mov si, 0
		mov al, ficha
		mov si, 7
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	E9:
		mov si, 0
		mov al, ficha
		mov si, 8
		cmp v1[si], 24h			;tiene que ser $, si no, esta ocupada
 		jne posOcupada
		mov v1[si], al
		mov si, 0
		jmp sal
	sal:
		xor si, si
		xor al, al
		xor di, di
endm

;----------------------------------------------------------------------------------------
;Libertades de una posicion a la derecha
;----------------------------------------------------------------------------------------
libertadesDerechaVerificar macro vector, posicion, cntTurno
	LOCAL p1,p2,p3,p4,p5,p6,p7,p8,p9 
	xor si, si
	cmp posicion, 01h
	je p1
	cmp posicion, 02h
	je p2
	cmp posicion, 03h
	je p3
	cmp posicion, 04h
	je p4
	cmp posicion, 05h
	je p5
	cmp posicion, 06h
	je p6
	cmp posicion, 07h
	je p7
	cmp posicion, 08h
	je p8
	cmp posicion, 09h
	je p9
	p1:
		xor si, si
		mov si, 01h
		cmp vector[si], 24h 
		je p2
		mov al, cntTurno
		cmp vector[si], al
		je p2
		jmp retorno
	p2:
		xor si, si
		mov si, 02h
		cmp vector[si], 24h 
		je p3
		mov al, cntTurno
		cmp vector[si], al
		je p3
		jmp retorno
	p3:
		xor si, si
		mov si, 03h
		cmp vector[si], 24h 
		je p4
		mov al, cntTurno
		cmp vector[si], al
		je p4
		jmp retorno
	p4:
		xor si, si
		mov si, 04h
		cmp vector[si], 24h 
		je p5
		mov al, cntTurno
		cmp vector[si], al
		je p5
		jmp retorno
	p5:
		xor si, si
		mov si, 05h
		cmp vector[si], 24h 
		je p6
		mov al, cntTurno
		cmp vector[si], al
		je p6
		jmp retorno
	p6:
		xor si, si
		mov si, 06h
		cmp vector[si], 24h 
		je p7
		mov al, cntTurno
		cmp vector[si], al
		je p7
		jmp retorno
	p7:
		xor si, si
		mov si, 07h
		cmp vector[si], 24h 
		je p8
		mov al, cntTurno
		cmp vector[si], al
		je p8
		jmp retorno
	p8:
		xor si, si
		mov si, 08h
		cmp vector[si], 24h 
		je sumLibDerecha
		mov al, cntTurno
		cmp vector[si], al
		je sumLibDerecha
		jmp retorno
	p9:
		jmp retorno
endm


;----------------------------------------------------------------------------------------
;Libertades de una posicion a izquierda
;----------------------------------------------------------------------------------------
libertadesIzquierdaVerificar macro vector, posicion, cntTurno
	LOCAL p1,p2,p3,p4,p5,p6,p7,p8,p9 
	xor si, si
	cmp posicion, 01h
	je p1
	cmp posicion, 02h
	je p2
	cmp posicion, 03h
	je p3
	cmp posicion, 04h
	je p4
	cmp posicion, 05h
	je p5
	cmp posicion, 06h
	je p6
	cmp posicion, 07h
	je p7
	cmp posicion, 08h
	je p8
	cmp posicion, 09h
	je p9
	p1:
		jmp retorno
	p2:
		xor si, si
		mov si, 00h
		cmp vector[si], 24h 
		je sumLibIzquierda
		mov al, cntTurno
		cmp vector[si], al
		je sumLibIzquierda
		jmp retorno
	p3:
		xor si, si
		mov si, 01h
		cmp vector[si], 24h 
		je p2
		mov al, cntTurno
		cmp vector[si], al
		je p2
		jmp retorno
	p4:
		xor si, si
		mov si, 02h
		cmp vector[si], 24h 
		je p3
		mov al, cntTurno
		cmp vector[si], al
		je p3
		jmp retorno
	p5:
		xor si, si
		mov si, 03h
		cmp vector[si], 24h 
		je p4
		mov al, cntTurno
		cmp vector[si], al
		je p4
		jmp retorno
	p6:
		xor si, si
		mov si, 04h
		cmp vector[si], 24h 
		je p5
		mov al, cntTurno
		cmp vector[si], al
		je p5
		jmp retorno
	p7:
		xor si, si
		mov si, 05h
		cmp vector[si], 24h 
		je p6
		mov al, cntTurno
		cmp vector[si], al
		je p6
		jmp retorno
	p8:
		xor si, si
		mov si, 06h
		cmp vector[si], 24h 
		je p7
		mov al, cntTurno
		cmp vector[si], al
		je p7
		jmp retorno
	p9:
		xor si, si
		mov si, 07h
		cmp vector[si], 24h 
		je p8
		mov al, cntTurno
		cmp vector[si], al
		je p8
		jmp retorno
endm


;----------------------------------------------------------------------------------------
;contar puntos de color negro
;----------------------------------------------------------------------------------------
conteoN macro vector, puntosN
	LOCAL conteo, conteo2, conteo3, final
	xor si, si 
	conteo:
		cmp si, 09h
		je final
		cmp vector[si], 4eh
		je conteo2
		cmp vector[si], 43h
		je conteo2
		jmp conteo3
	conteo2:
		inc puntosN
		inc si 
		jmp conteo
	conteo3:
		inc si 
		jmp conteo
	final:
		xor si, si
endm

;----------------------------------------------------------------------------------------
;contar puntos de color blanco
;----------------------------------------------------------------------------------------
conteoB macro vector, puntosB
	LOCAL conteo, conteo2, conteo3, final
	xor si, si 
	conteo:
		cmp si, 09h
		je final
		cmp vector[si], 42h
		je conteo2
		cmp vector[si], 45h
		je conteo2
		jmp conteo3
	conteo2:
		inc puntosB
		inc si 
		jmp conteo
	conteo3:
		inc si 
		jmp conteo
	final:
		xor si, si
endm

;----------------------------------------------------------------------------------------
;verifica si una posicion tiene libertades o es territorio neutro
;----------------------------------------------------------------------------------------
libertadesPos macro posx, vector
	LOCAL final, opc1, opc2, opc3, siL, opc11, opc12, opc13, opc21, opc22, opc23, opc31, opc32, opc33, final2, final1, final8
	mov si, posx
	cmp vector[si], 4eh
	je final8
	cmp vector[si], 42h
	je final8
	;cmp vector[si], 43h
	;je final8
	;cmp vector[si], 45h
	;je final8
	;cmp vector[si], 54h
	;je final8
	;limpio libertades
	mov libertadesA, 00h
	mov libertadesB, 00h
	mov libertadesI, 00h
	mov libertadesD, 00h
	;calculo libertades 
	call verificarLibertadesArriba
	call verificarLibertadesAbajo
	call verificarLibertadesIzquierda
	call verificarLibertadesDerecha
	mov ax, 00h
	add ax, libertadesA
	add ax, libertadesB
	add ax, libertadesI
	add ax, libertadesD

	mov si, posx
	cmp si, 00h
	je opc1
	cmp si, 08h
	je opc2
	jmp opc3
	opc1:
		mov di, posx
		cmp di, 00h
		je opc11
		cmp di, 08h
		je opc12
		jmp opc13
	opc11:
		cmp ax, 00h
		je final
		jg siL 
	opc13:
		cmp ax, 02h
		jg final
		jmp siL
	opc12:
		cmp ax, 00h
		je final
		jg siL 


	opc2:
		mov di, posx
		cmp di, 00h
		je opc21
		cmp di, 08h
		je opc22
		jmp opc23
	opc21:
		cmp ax, 00h
		je final
		jg siL 
	opc23:
		cmp ax, 00h
		je final
		jmp siL
	opc22:
		cmp ax, 00h
		je final
		jg siL 


	opc3:
		mov di, posx
		cmp di, 00h
		je opc31
		cmp di, 08h
		je opc32
		jmp opc33
	opc31:
		cmp ax, 00h
		je final
		jg siL 
	opc33:
		cmp ax, 00h
		je final
		jmp siL
	opc32:
		cmp ax, 00h
		je final
		jg siL 

	siL:
		mov vector[si], 54h
		jmp final2
	final:
		cmp cntTurno, 4eh
		je final1
		mov vector[si], 43h
		jmp final2
	final1:
		mov vector[si], 45h
		jmp final2
	final2:
		xor si, si
	final8:
		xor si, si
endm
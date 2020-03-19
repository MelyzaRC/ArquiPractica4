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
		cmp si, 05h
		je final
		mov buffer[si], 24h
		inc si
		jmp limpiarB
	final:
	;nada
endm

limpiarContenido macro buffer
	LOCAL limpiar, final
	xor si, si
	limpiar:
		mov buffer[si], 24h
		cmp si, SIZEOF buffer
		je final
		inc si
		jmp limpiar
	final:
endm

llenarPosiciones macro v1, v2, v3, v4, v5, v6, v7, v8, v9, contenido
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
;obtener ruta de teclado para nombre de archivo
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
	mov cx, num
	mov dx, offset buffer11
	
	int 21h
	jc errorLeer
endm

crearArchivo macro buffer, handler
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

pasarInformacion macro contenido, v1, v2, v3, v4, v5, v6, v7, v8, v9
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
endm

;----------------------------------------------------------------------------------------
;Mostrar Tablero
;----------------------------------------------------------------------------------------
mostrarTablero macro vector, tablero1, tablero2, espacio, numero, salto, ints, cEspacio, fblancas, fnegras
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
ponerPiedraC1 macro v1, v2, ficha, movimiento
	LOCAL E1, E2, E3, E4, E5, E6, E7, E8, E9, sal
	xor si, si
	xor al, al
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
	jmp sal
	E1:
		mov si, 0
		mov al, ficha
		mov si, 0
		mov v1[si], al
		mov si, 0
		jmp sal
	E2:
		mov si, 0
		mov al, ficha
		mov si, 1
		mov v1[si], al
		mov si, 0
		jmp sal

	E3:
		mov si, 0
		mov al, ficha
		mov si, 2
		mov v1[si], al
		mov si, 0
		jmp sal
	E4:
		mov si, 0
		mov al, ficha
		mov si, 3
		mov v1[si], al
		mov si, 0
		jmp sal
	E5:
		mov si, 0
		mov al, ficha
		mov si, 4
		mov v1[si], al
		mov si, 0
		jmp sal
	E6:
		mov si, 0
		mov al, ficha
		mov si, 5
		mov v1[si], al
		mov si, 0
		jmp sal
	E7:
		mov si, 0
		mov al, ficha
		mov si, 6
		mov v1[si], al
		mov si, 0
		jmp sal
	E8:
		mov si, 0
		mov al, ficha
		mov si, 7
		mov v1[si], al
		mov si, 0
		jmp sal
	E9:
		mov si, 0
		mov al, ficha
		mov si, 8
		mov v1[si], al
		mov si, 0
		jmp sal
	sal:
endm



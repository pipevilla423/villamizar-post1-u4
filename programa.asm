
; ==========================================
; ARQUITECTURA DE COMPUTADORES
; UNIDAD 4 - POST-CONTENIDO
; PARTE 1 - PASO 7
;
; Estudiante: William Felipe Villamizar Soler
; Codigo: 1152498
; ==========================================

BITS 16

; ==========================================
; CONSTANTES
; ==========================================


CR          EQU 0Dh
LF          EQU 0Ah
TERMINADOR  EQU 24h
ITERACIONES EQU 5
ANCHO_LINEA EQU 40



; ==========================================
; SECCION .DATA
; Datos inicializados
; ==========================================

section .data

    bienvenida db "=== Laboratorio NASM - Unidad 4 ===", CR, LF, TERMINADOR

    separador db "----------------------------------------", CR, LF, TERMINADOR

    ; PASO 7: linea de 40 signos =
    ; TIMES repite el dato durante el ensamblado.
    linea_gruesa:
        TIMES ANCHO_LINEA DB '='
        DB CR, LF, TERMINADOR

    etiqueta_a db "Variable A (byte): ", TERMINADOR

    etiqueta_b db "Variable B (dword): ", TERMINADOR

    fin_msg db "Programa finalizado correctamente.", CR, LF, TERMINADOR

    ; Tipos de datos
    var_byte db 42
    var_word dw 1234h
    var_dword dd 0DEADBEEFh

    ; Tabla de cinco digitos
    tabla_bytes db 1, 2, 3, 4, 5

    etiqueta_tabla db "Tabla de bytes: ", TERMINADOR


; ==========================================
; SECCION .BSS
; Datos no inicializados
; ==========================================

section .bss

    buffer resb 80
    resultado resw 1


; ==========================================
; SECCION .TEXT
; Codigo ejecutable
; ==========================================

section .text

global main

..start:
main:

    ; Inicializar segmento de datos
    mov ax, seg bienvenida
    mov ds, ax


    ; ======================================
    ; IMPRIMIR BIENVENIDA
    ; ======================================

    mov ah, 09h
    mov dx, bienvenida
    int 21h

    mov dx, separador
    int 21h


    ; ======================================
    ; IMPRIMIR ETIQUETA Y CARACTER
    ; ======================================

    mov ah, 09h
    mov dx, etiqueta_a
    int 21h

    ; Valor 42 + 30h = ASCII 'Z'
    mov al, [var_byte]
    add al, 30h

    mov ah, 02h
    mov dl, al
    int 21h

    ; Nueva linea
    mov ah, 02h
    mov dl, CR
    int 21h

    mov dl, LF
    int 21h


    ; ======================================
    ; RECORRER TABLA CON LOOP
    ; ======================================

    mov ah, 09h
    mov dx, etiqueta_tabla
    int 21h

    lea si, tabla_bytes
    mov cx, ITERACIONES

imprimir_tabla:

    mov al, [si]
    add al, 30h

    mov ah, 02h
    mov dl, al
    int 21h

    ; Espacio entre elementos
    mov ah, 02h
    mov dl, 20h
    int 21h

    inc si
    loop imprimir_tabla


    ; ======================================
    ; SALTO DE LINEA
    ; ======================================

    mov ah, 02h
    mov dl, CR
    int 21h

    mov dl, LF
    int 21h


    ; ======================================
    ; MENSAJE FINAL
    ; ======================================

    mov ah, 09h
    mov dx, fin_msg
    int 21h


    ; ======================================
    ; PASO 7: LINEA GENERADA CON TIMES
    ; ======================================

    mov ah, 09h
    mov dx, linea_gruesa
    int 21h


    ; ======================================
    ; TERMINAR PROGRAMA
    ; ======================================

    mov ax, 4C00h
    int 21h

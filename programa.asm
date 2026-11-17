
; ==========================================
; ARQUITECTURA DE COMPUTADORES
; UNIDAD 4 - POST-CONTENIDO
; PARTE 1 - PASOS 3 Y 4
;
; Estudiante: William Felipe Villamizar Soler
; Codigo: 1152498
; ==========================================

BITS 16

; ==========================================
; CONSTANTES - EQU
; ==========================================

CR          EQU 0Dh
LF          EQU 0Ah
TERMINADOR  EQU 24h
ITERACIONES EQU 5


; ==========================================
; SECCION .DATA
; Datos inicializados
; ==========================================

section .data

    bienvenida db "=== Laboratorio NASM - Unidad 4 ===", CR, LF, TERMINADOR

    separador db "----------------------------------------", CR, LF, TERMINADOR

    etiqueta_a db "Variable A (byte): ", TERMINADOR

    etiqueta_b db "Variable B (dword): ", TERMINADOR

    fin_msg db "Programa finalizado correctamente.", CR, LF, TERMINADOR

    ; Tipos de datos
    var_byte db 42
    var_word dw 1234h
    var_dword dd 0DEADBEEFh

    ; Tabla de cinco digitos
    tabla_bytes db 1, 2, 3, 4, 5

    ; Mensaje para identificar la tabla
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

    ; Inicializar el segmento de datos
    mov ax, seg bienvenida
    mov ds, ax


    ; ======================================
    ; FUNCION 09h - IMPRIMIR BIENVENIDA
    ; ======================================

    mov ah, 09h
    mov dx, bienvenida
    int 21h

    ; Imprimir separador
    mov ah, 09h
    mov dx, separador
    int 21h


    ; ======================================
    ; FUNCION 09h - IMPRIMIR ETIQUETA
    ; ======================================

    mov ah, 09h
    mov dx, etiqueta_a
    int 21h


    ; ======================================
    ; FUNCION 02h - IMPRIMIR CARACTER
    ; ======================================

    ; Cargar el valor de var_byte
    mov al, [var_byte]

    ; Convertir sumando 30h
    ; 42 + 48 = 90 = ASCII 'Z'
    ; Es una demostracion, no convierte
    ; el numero 42 a texto decimal.
    add al, 30h

    ; Imprimir el caracter almacenado en AL
    mov ah, 02h
    mov dl, al
    int 21h


    ; ======================================
    ; IMPRIMIR SALTO DE LINEA
    ; ======================================

    mov ah, 02h
    mov dl, CR
    int 21h

    mov ah, 02h
    mov dl, LF
    int 21h


    ; ======================================
    ; FUNCION 09h - ETIQUETA DE TABLA
    ; ======================================

    mov ah, 09h
    mov dx, etiqueta_tabla
    int 21h


    ; ======================================
    ; RECORRER TABLA CON LOOP
    ; ======================================

    ; SI apunta al inicio de la tabla
    lea si, tabla_bytes

    ; Cantidad de elementos
    mov cx, ITERACIONES

imprimir_tabla:

    ; Leer el byte actual
    mov al, [si]

    ; Convertir digito numerico a ASCII
    add al, 30h

    ; Imprimir caracter
    mov ah, 02h
    mov dl, al
    int 21h

    ; Imprimir espacio
    mov ah, 02h
    mov dl, 20h
    int 21h

    ; Avanzar al siguiente elemento
    inc si

    ; Repetir hasta que CX sea cero
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
    ; FINALIZAR PROGRAMA
    ; ======================================

    mov ax, 4C00h
    int 21h

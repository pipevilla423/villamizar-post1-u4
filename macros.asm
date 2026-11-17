
; ==========================================
; ARQUITECTURA DE COMPUTADORES
; UNIDAD 4 - POST-CONTENIDO
; PARTE 2: MACROS Y CONTROL DE FLUJO
;
; Estudiante: William Felipe Villamizar Soler
; Codigo: 1152498
;
; Archivo: macros.asm
; Biblioteca de macros reutilizables
; ==========================================


; ==========================================
; MACRO 1: FINALIZAR PROGRAMA DOS
; ==========================================

; Termina el programa con codigo de salida 0.

%macro fin_dos 0

    mov ax, 4C00h
    int 21h

%endmacro


; ==========================================
; MACRO 2: IMPRIMIR NUEVA LINEA
; ==========================================

; Imprime retorno de carro (CR)
; y salto de linea (LF).

%macro nueva_linea 0

    mov ah, 02h
    mov dl, 0Dh
    int 21h

    mov ah, 02h
    mov dl, 0Ah
    int 21h

%endmacro


; ==========================================
; MACRO 3: IMPRIMIR CADENA
; ==========================================

; %1 = etiqueta de una cadena
; terminada con el caracter '$'.

%macro print_str 1

    mov ah, 09h
    mov dx, %1
    int 21h

%endmacro


; ==========================================
; MACRO 4: IMPRIMIR CARACTER
; ==========================================

; %1 = caracter ASCII o registro.

%macro print_char 1

    mov ah, 02h
    mov dl, %1
    int 21h

%endmacro


; ==========================================
; MACRO 5: LEER CARACTER
; ==========================================

; Lee un caracter desde teclado sin eco.
; El resultado se almacena en AL.

%macro leer_char 0

    mov ah, 07h
    int 21h

%endmacro


; ==========================================
; MACRO 6: REPETIR CADENA CON LOOP
; ==========================================

; %1 = etiqueta de la cadena
; %2 = numero de repeticiones
;
; Utiliza CX como contador.
; %%ciclo es una etiqueta local unica
; para cada expansion de la macro.
;
; Requiere un numero positivo de repeticiones.

%macro repetir_str 2

    mov cx, %2

%%ciclo:

    mov ah, 09h
    mov dx, %1
    int 21h

    loop %%ciclo

%endmacro


; ==========================================
; MACRO 7: IMPRIMIR DIGITO DECIMAL
; ==========================================

; Imprime un valor de 0 a 9
; almacenado en AL.
;
; Preserva AX mediante PUSH y POP.

%macro print_digito 0

    push ax

    ; Conservar el nibble inferior.
    and al, 0Fh

    ; Convertir el digito a ASCII.
    add al, 30h

    ; Imprimir el caracter.
    mov ah, 02h
    mov dl, al
    int 21h

    ; Restaurar AX.
    pop ax

%endmacro


; ==========================================
; MACRO 8: BLOQUE DECORATIVO CON %REP
; ==========================================

; %1 = cantidad de repeticiones
;
; %rep duplica las instrucciones durante
; el preprocesamiento de NASM.
;
; No utiliza CX ni LOOP.
;
; Requiere que el programa principal
; defina la etiqueta separador_corto.

%macro bloque_decorativo 1

    %rep %1

        print_str separador_corto

    %endrep

%endmacro


; ==========================================
; FIN DE LA BIBLIOTECA DE MACROS
; ==========================================

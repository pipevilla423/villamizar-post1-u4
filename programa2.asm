
; ==========================================
; ARQUITECTURA DE COMPUTADORES
; UNIDAD 4 - POST-CONTENIDO
; PARTE 2 - PROGRAMA INTEGRADOR FINAL
;
; Estudiante: William Felipe Villamizar Soler
; Codigo: 1152498
;
; Macros, LOOP, CMP, JE, JG, JLE,
; procedimientos, CALL y RET
; ==========================================

BITS 16

; Biblioteca de macros
%include "macros.asm"


; ==========================================
; SECCION .DATA
; ==========================================

section .data

    titulo db "=== Macros y Control de Flujo ===", 0Dh, 0Ah, 24h

    linea_a db "[Linea A] Primera impresion", 0Dh, 0Ah, 24h

    linea_b db "[Linea B] Segunda impresion", 0Dh, 0Ah, 24h

    msg_suma db "Resultado de la suma 1+2+3: ", 24h

    msg_mayor db "El valor mayor es: ", 24h

    msg_iguales db "Los valores son iguales.", 0Dh, 0Ah, 24h

    msg_menor_igual db "AX es menor o igual: ", 24h

    msg_mayor2 db "AX es mayor: ", 24h

    separador_corto db "---", 0Dh, 0Ah, 24h

    msg_fin db "Fin del programa.", 0Dh, 0Ah, 24h


; ==========================================
; SECCION .BSS
; ==========================================

section .bss

    valor_a resw 1
    valor_b resw 1


; ==========================================
; SECCION .TEXT
; ==========================================

section .text

global main

..start:
main:

    ; Inicializar segmento de datos
    mov ax, seg titulo
    mov ds, ax


    ; ======================================
    ; 1. ENCABEZADO
    ; ======================================

    print_str titulo


    ; ======================================
    ; 2. MACRO REPETIR_STR CON LOOP
    ; ======================================

    ; Imprimir Linea A tres veces
    repetir_str linea_a, 3


    ; ======================================
    ; 3. SUMA CON LOOP Y CALL/RET
    ; ======================================

    print_str msg_suma

    ; Suma: 1 + 2 + 3 = 6
    mov cx, 3

    call sumar_serie

    ; Imprimir el resultado
    print_digito

    nueva_linea


    ; ======================================
    ; 4. COMPARACION AX > BX
    ; ======================================

    ; Comparar 9 contra 4
    mov ax, 9
    mov bx, 4

    call comparar_e_imprimir


    ; ======================================
    ; 5. COMPARACION DE IGUALDAD
    ; ======================================

    ; Comparar 5 contra 5
    mov ax, 5
    mov bx, 5

    call comparar_e_imprimir


    ; ======================================
    ; 6. EXTENSION CON %REP
    ; ======================================

    ; Tres copias del separador ---
    ; generadas durante el ensamblado.
    bloque_decorativo 3


    ; ======================================
    ; 7. EXTENSION CON JLE
    ; ======================================

    ; Comparar AX = 3 contra BX = 8
    mov ax, 3
    mov bx, 8

    call comparar_menor_o_igual


    ; ======================================
    ; 8. MENSAJE FINAL
    ; ======================================

    print_str msg_fin

    ; Finalizar programa
    fin_dos


; ==========================================
; PROCEDIMIENTO 1: SUMAR_SERIE
; ==========================================

; Entrada: CX = N, N mayor que cero
; Salida: AX = suma de 1 hasta N
; Preserva CX utilizando la pila.

sumar_serie:

    push cx

    ; Inicializar acumulador
    xor ax, ax

.paso:

    ; Sumar el valor del contador
    add ax, cx

    ; Repetir mientras CX no sea cero
    loop .paso

    ; Restaurar contador original
    pop cx

    ret


; ==========================================
; PROCEDIMIENTO 2: COMPARAR_E_IMPRIMIR
; ==========================================

; Entrada: AX y BX
; Utiliza CMP, JE y JG.
; Valores utilizados: 0 a 9.

comparar_e_imprimir:

    ; Preservar registros
    push ax
    push bx

    ; Comparar AX contra BX
    cmp ax, bx

    ; Saltar si son iguales
    je .son_iguales

    ; Saltar si AX es mayor
    jg .ax_mayor


    ; ======================================
    ; CASO: BX ES MAYOR
    ; ======================================

    print_str msg_mayor

    ; Copiar valor de BX a AL
    mov al, bl

    print_digito
    nueva_linea

    jmp .fin_comp


.ax_mayor:

    ; ======================================
    ; CASO: AX ES MAYOR
    ; ======================================

    ; Preservar AX durante impresion
    push ax

    print_str msg_mayor

    pop ax

    ; Imprimir valor original de AX
    print_digito

    nueva_linea

    jmp .fin_comp


.son_iguales:

    ; ======================================
    ; CASO: VALORES IGUALES
    ; ======================================

    print_str msg_iguales


.fin_comp:

    ; Restaurar los registros
    pop bx
    pop ax

    ret


; ==========================================
; PROCEDIMIENTO 3:
; COMPARAR_MENOR_O_IGUAL
; ==========================================

; Entrada: AX y BX
; Utiliza CMP y JLE.
; Reutiliza macros de macros.asm.

comparar_menor_o_igual:

    ; Preservar registros
    push ax
    push bx

    ; Comparacion con signo
    cmp ax, bx

    ; Saltar si AX es menor o igual
    jle .menor_o_igual


    ; ======================================
    ; CASO: AX ES MAYOR
    ; ======================================

    ; Preservar AX al imprimir texto
    push ax

    print_str msg_mayor2

    pop ax

    print_digito

    jmp .fin_cmp2


.menor_o_igual:

    ; ======================================
    ; CASO: AX ES MENOR O IGUAL
    ; ======================================

    ; Preservar AX al imprimir texto
    push ax

    print_str msg_menor_igual

    pop ax

    print_digito


.fin_cmp2:

    nueva_linea

    ; Restaurar registros
    pop bx
    pop ax

    ret

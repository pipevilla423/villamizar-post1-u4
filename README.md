
# villamizar-post2-u4

## Descripción

Laboratorio de la Unidad 4 de Arquitectura de Computadores.

El proyecto está dividido en dos partes:

- Parte 1: Programa NASM con segmentos, directivas y salida DOS.
- Parte 2: Macros con parámetros y control de flujo.

Ambas partes se desarrollan mediante lenguaje ensamblador
NASM para DOS de 16 bits.

## Prerrequisitos

- DOSBox 0.74 o superior.
- NASM 2.14 o superior.
- ALINK.
- Entorno DPMI compatible, cuando sea necesario.

## Compilación y ejecución

Comandos para ensamblar y enlazar el programa de la Parte 1:

```text
nasm -f obj programa.asm -o programa.obj
alink programa.obj -oEXE -o programa.exe -entry main
```

Ejecutar `programa.exe` dentro de DOSBox.

## Estado del proyecto

- Parte 1: En desarrollo.
- Parte 2: Pendiente.

## Autor

William Felipe Villamizar Soler

Ingeniería de Sistemas — Séptimo semestre

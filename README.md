
# villamizar-post1-u4

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

## Decisión técnica 1 — Uso de EQU frente a %define

**Estrategia seleccionada: EQU para la constante ANCHO_LINEA.**

En el desarrollo del programa se eligió la directiva EQU para definir ANCHO_LINEA, ya que representa un valor numérico fijo utilizado por TIMES para generar una línea de 40 caracteres. EQU permite crear un símbolo cuyo valor se resuelve durante el ensamblado y no puede redefinirse posteriormente. Esto aporta mayor claridad y permite que NASM interprete la constante como una expresión numérica.

Por otra parte, %define funciona mediante el preprocesador, sustituyendo el identificador por el texto asociado antes de que el ensamblador procese el código. Aunque también puede utilizarse para representar números, una sustitución textual mal definida podría generar expresiones ambiguas o resultados inesperados al combinarse con operaciones aritméticas.

Por esta razón, EQU resulta más conveniente para ANCHO_LINEA, especialmente si posteriormente se utiliza en comparaciones o cálculos. Sin embargo, %define sería útil para reutilizar literalmente una cadena de texto, como el encabezado del laboratorio, evitando escribir el mismo mensaje en diferentes partes del programa.

## Decisión técnica 2 — TIMES en .data frente a RESB en .bss

**Estrategia seleccionada: TIMES en la sección .data.**

Para generar la línea decorativa del programa se eligió utilizar TIMES en la sección .data, debido a que su contenido es fijo y se conoce desde el momento del ensamblado. Esta directiva permite repetir el carácter "=" utilizando una constante que determina el ancho de la línea, lo que facilita modificar su longitud posteriormente sin necesidad de escribir o eliminar manualmente varios caracteres dentro de una cadena.

Una alternativa válida sería reservar 40 bytes con RESB en la sección .bss y utilizar un bucle LOOP para llenarlos durante la ejecución. Sin embargo, esta solución requeriría instrucciones adicionales para inicializar cada posición de memoria, aun cuando el contenido de la línea siempre es el mismo.

Por esta razón, TIMES resulta más conveniente para este programa, ya que los caracteres quedan definidos desde el ensamblado y disponibles cuando se carga el ejecutable. Esto evita ejecutar un bucle de inicialización cada vez que inicia el programa, reduce el trabajo necesario durante el arranque y mantiene el código más sencillo. La alternativa con RESB sería más apropiada si la línea necesitara generarse o modificarse dinámicamente durante la ejecución.
# Quadro_SCIntro
## SuperCollider: curso introductorio

!Bienvenido al repositorio del curso introductorio al lenguaje de programación SuperCollider!

Aquí encontrarás material útil para seguir el curso además del código de cada lección. El material disponible es absolutamente gratuito y puede ser usado y modificado sin ninguna restricción. 

## Contenidos

1. Hola mundo!

Este módulo está dedicado a explicar a fondo por qué y cómo esta simple expresión funciona:

```js
"hola mundo!".postln;
```

2. Variables

Aprende por qué es útil abreviar objetos mediante variables:

```js
var pi = 3.141592653589;
```

3. Arrays

¿Cómo crear un contenedor en el que alojar varios objetos?

```js
var contenedor = [1, 3.14, "hola mundo", { 10.postln }, [1,2,3] ];
```

4. Funciones

Es momento de encapsular instrucciones...

```js
var func = {|x, y| var resultado = x + y; resultado };
```
5. Loops

Repetir algo cientos de veces es sumamente tedioso... para eso tenemos computadoras!

```js
100.do{|i| i.postln };
```
6. Osciladores

Es momento de hacer un poco de ruido!

```js
{ WhiteNoise.ar(0.1) }.play; 
```
7. Modulación

El arte de modificar parámetros con generadores...

```js
{ SinOsc.ar(220 + SinOsc.ar(2.0, 0, 10.0)) }.play; 
```
8. Síntesis aditiva

Sumando ondas sinusoides...

```js
{ var n = 5; var sins = n.collect{|i| SinOsc.ar(100 + ((i+1) * 100), 0, 1/n) }; sins.sum }.play; 
```




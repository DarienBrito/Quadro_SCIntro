# Quadro_SCIntro
## SuperCollider: curso introductorio

¡Bienvenid@ al repositorio del curso introductorio al lenguaje de programación SuperCollider!

Aquí encontrarás material útil para seguir el curso además del código de cada lección. El material disponible es absolutamente gratuito y puede ser usado y modificado sin ninguna restricción. Encuentra en la sección de contenidos pequeños fragmentos que sirven de síntesis de lo visto en cada capítulo. Para descargar todo el material en un archivo ZIP haz click [aquí]().

## Contenidos

1. [Código de cada módulo](https://github.com/DarienBrito/Quadro_SCIntro/tree/master/codigo_modulos)

Encontrarás aqui archivos con todo el código que hemos visto en los vídeos del tutorial.

2. [Transcripciones](https://github.com/DarienBrito/Quadro_SCIntro/tree/master/transcripciones)

Si quieres tener un documento con una transcripción de lo que vimos en los vídeos, puedes acceder a esta carpeta y descargar los archivos

3. [Información preliminar](https://github.com/DarienBrito/Quadro_SCIntro/tree/master/info_preliminar_LaTeX)

El archivo PDF con información preliminar sobre el curso fue generado usando LaTeX, un lenguaje de programación para archivos de texto en alta calidad. Encontrarás aquí el código fuente para generar este texto además del PDF final.

4. [Sonidos de introducción]()

Cada módulo en nuestro tutorial tiene su propio sonido introductorio. Encontrarás aquí el código con el que generé esos sonidos.

## Temas

Estos son los temas que hemos visto en el tutorial. Añado un poco de código para refrescarte la memoria. Todas estas líneas son directamente ejecutables.

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
9. Síntesis substractiva

Menos es más...

```js
{var ruido = WhiteNoise.ar(0.5); var filtro = LPF.ar(ruido, LFSaw.kr(0.5).range(20, 1000)); filtro }.play;
```
10. Envolventes

Controlando parámetros con funciones de forma 

```js
{var env = EnvGen.kr(Env.perc(0.001, 1.0), doneAction:2); SinOsc.ar(440) * env }.play;
```
11. SynthDefs

Creando un instrumento re-utilizable

```js
(
SynthDef(\sinusoide, { |freq = 220, amp = 0.5|
	var sin = SinOsc.ar(freq);
	var env = EnvGen.kr(Env.perc(0.01, 1), doneAction: 2);
	var sonido = sin * env;
	sonido = sonido * amp;
	Out.ar(0, sonido ! 2);
}).add;
)

Synth(\sinusoide, [\freq, 400, \amp, 0.6]);
Synth(\sinusoide, [\freq, 700, \amp, 0.6]);
```
12. Rutinas 

```js
fork{ inf.do{|i| i.postln; 1.wait; } };
```

13. Bonus

Un pequeño programa de música generativa
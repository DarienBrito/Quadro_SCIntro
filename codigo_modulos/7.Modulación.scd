/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

7. Modulación
__________________________________________________________________________*/

Recuerda:

cmd + enter -> ejecutar línea de código
cmd + shift + p -> borrar consola
cmd + d -> ayuda

//-------------------------------------
cmd + b -> iniciar el servidor de audio
cmd + . -> apagar el sonido
//-------------------------------------

(cmd = ctrl en Windows)

























/*
Hemos visto como generar sonido con osciladores. ¿Qué quiere decir "modular"?

Modular simplemente quiere decir alterar un parámetro específico con algun valor o serie de valores continuo.

El método más básico de modulación se denomina "modulación de amplitud" o "amplitude modulation (AM)" en inglés.
Esto consiste en controlar la amplitud de un oscilador con otro oscilador:
*/
{ SinOsc.ar(440, mul: SinOsc.kr(2, mul: 0.5, add: 0.5)) }.play;

/*
Observa que:

1. Nuestro primer oscilador es audible (ar), nuestro segundo oscilador controla la frequencia del primero (kr)
ar -> audio rate (rango audible)
kr -> control rate (rango de control)

Esta distinción es significativa en el código fuente de SuperCollider, en donde cada método esta optimizado para su tarea respectiva.

2. El oscilador kr tiene una frecuencia de 2, lo que quiere decir que oscila 2 veces por segundo.

3. La amplitud de todo oscilador por defecto va de -1.0 a 1.0. Esto implica que para controlar la amplitud del primer oscilador de modo que vaya de 0 a 1, tenemos que escalar y compensar nuestro oscilador kr.

Para entender esto, observa el anexo ch7.1 en el repositorio. También lo podemos entender de la siguiente manera:
*/

-1 * 0.5; // -0.5
1 * 0.5; // 0.5

// Esto ocurre al mutiplicar nuestro oscilador de control por 0.5. Ahora su rango es de -0.5 a 0.5. Pero lo que queremos es que vaya de 0.0, a 1.0, por tanto, tenemos que compensarlo a fin de mover este rango:

-0.5 + 0.5; // 0
0.5 + 0.5; // 1

// Voilá, ahora hemos escalado y compensado la señal al rango deseado:
{ SinOsc.ar(440, mul: SinOsc.kr(2, mul: 0.5, add: 0.5)) }.play;

// Otra forma, quizás más intuitiva de hacer lo mismo es usar el método "range"
{ SinOsc.ar(440, mul: SinOsc.kr(2).range(0, 1)) }.play; // Explícitamente de 0 a 1

/*
¿Entiendes por qué cambiamos nuestro oscilador de modulación al rango 0 a 1?
*/






















/*
Un tipo de modulación de amplitud muy económico y variado al generar sonidos es multiplicar una señal por otra con alta frequencia. Esto suele llamarse "ring modulation" debido a que en los equipos de síntesis analógica el circuito para producir esta operación tenía una forma circular. En síntesis digital el nombre es insubstancial pero ha perdurado para definir este tipo de modulación.
*/

{ SinOsc.ar(440, mul: SinOsc.ar(120)) }.play; // "ring modulation" con 2 ondas sinusoides
{ SinOsc.ar(440) * SinOsc.ar(120) }.play; // otra forma de escribir lo mismo

// Usando otras ondas:
{ SinOsc.ar(120) * Pulse.ar(520, 0.5) * 0.25 }.play;
{ SinOsc.ar(1000) * Saw.ar(100) * 0.25 }.play;

// Las bandas sonoras que se forman con esta operación equivalen a (x + y) y (x - y). Por ejemplo, con frequencias 440 y 120, como en nuestro ejemplo inicial, las bandas resultantes son:
440 - 120; // 320hz
440 + 120; // 560hz















// Pensemos ahora en lo siguiente: queremos controlar la frecuencia de un oscilador con otro oscilador. A esto se le llama "modulación de frecuencia":
{ SinOsc.ar(320 + SinOsc.kr(0.5, mul: 10.0)) }.play

/*
Nuestro primer oscilador es audible (ar), nuestro segundo oscilador controla la frequencia del primero (kr). El oscilador kr tiene una amplitud de 10.0, lo que quiere decir que su rango va desde -10.0 a +10.0

En suma, el segundo oscilador modula al primero, y va del rango -10 a 10 cada 2 segundos.
*/

{ SinOsc.ar(320 + SinOsc.kr(0.5, mul: 10.0)) }.play // 320 + (-10 a 10) cada 2 segundos.
{ SinOsc.ar(320 + SinOsc.kr(1.0, mul: 10.0)) }.play // 320 + (-10 a 10) cada segundo.
{ SinOsc.ar(320 + SinOsc.kr(4.0, mul: 10.0)) }.play // 320 + (-10 a 10) 4 veces por segundo.

// ¿Notas el efecto que tiene esta modulación?

























// Veamos ahora 2 tipos más de generadores:
Line.kr(start: valor de inicio, end: valor de llegada, dur: duracion, mul: amplitud, add: compensación, doneAction: qué hacer cuando arribamos al valor de llegada)

XLine.kr(lo mismo pero de forma exponencial)

// Modular la frequencia de una onda sinusoide linearmente, desde 2000hz a 100hz
{ SinOsc.ar(Line.kr(start: 2000, end: 100, dur: 5, mul: 1, add: 0, doneAction: 2)) }.play

// Modular la frequencia de una onda sinusoide exponencialmente, desde 2000hz a 100hz
{ SinOsc.ar(XLine.kr(start: 2000, end: 100, dur: 5, mul: 1, add: 0, doneAction: 2)) }.play

// Gráficos de lo que occurre con la frequencia
Env([2000, 100],[5],\lin).plot(name:\linear);

Env([2000, 100],[5],\exp).plot(name:\exponencial);

// doneAction es importante en este caso porque termina el proceso una vez se cumple la instrucción. Cuando programamos audio, es importante tener cuidado con limpiar la memoria de lo que no necesitamos. El uso de memoria se puede ver en la parte inferior derecha, con los valores porcentuales. Veremos esto con más profundidad en el capítulo 10.

























// No es necesario escribir lo que los parámetros son, podemos hacer lo mismo sin nombres pasamos los parámetros en el orden adecuado:
{ SinOsc.ar(Line.kr(2000, 100, 5, 1, 0, 2)) }.play

// Si queremos saltar parámetros y dejar los que saltamos en sus valores por defecto, entonces si que necesitamos especificar el parámetro en cuestión
{ SinOsc.ar(Line.kr(2000, 100, 5, doneAction: 2)) }.play

// Si presionamos la tecla TAB en el espacio para parámetros, podemos automáticamente obtener los nombres de los parámetros.
Line.kr()

























/*
Ejemplo de modulación usando "Sample and Hold"

Es importante tener siempre en mente que cuando tratamos con computadores, estamos siempre en realidad lidiando con números.

Vamos a utilizar números al azar para generar frequencias que puedan ser audibles. Antes que nada, sin embargo, entendamos un poco lo que son números al azar...
*/

1.0.rand; // Método para obtener números al azar en el rango de 0.0 a 1.0

rrand(1, 10); // Método para obtener números al azar en el rango de 1 a 10.0

// El ruido blanco, no es sino la representación ideal audible de todas las frecuencias con amplitudes correspondientes a números al azar en el rango de 0.0 a 1.0

{ WhiteNoise.ar(0.1) }.play;

// Sabiendo esto, podemos generar frequencias con ruido blanco para una onda sinusoide:
{ SinOsc.ar(Latch.kr(WhiteNoise.kr(1), Impulse.kr(10)) * 200 + 200 )}.play

// Hemos utilizado en este caso dos nuevos UGens: Latch e Impulse

Latch.kr(in: fuente que samplear ,trig: señal que determina cuándo samplear);
Impulse.kr(freq: 10); // Un oscilador que genera impulsos


























// Para enteder todo esto un poco mejor, utilicemos un osciloscopio:

{ SinOsc.kr(30) }.scope;
{ Saw.kr(30) }.scope;
{ VarSaw.kr(30) }.scope;
{ Impulse.kr(30) }.scope;
{ WhiteNoise.kr(1) }.scope;

// Podemos de esta manera observar las formas que cada onda tiene

























/*

Ejemplo de modulación de fase

Esta técnica es una forma simple de obtener un resultado equivalente a FM (frequency modulation)
o "frecuencia modulada". Mediante esta técnica es posible obtner una gran variedad tímbrica mediante simplemente modulando la fase de una onda.

*/

// Modulación de fase en un oscilador sinusoidal:
{ SinOsc.ar(300, SinOsc.ar(200), 1) }.play;

// Modulación de fase usando rudio browniano
{ SinOsc.ar(300, SinOsc.ar(BrownNoise.kr(1).range(100, 800)), 1) }.play;

/*
El ruido browniano (llamado también ruido borracho), es un algoritmo que produce números al azar que están cerca uno del otro en base a un intervalo o "step".

El rudio blanco en cambio, es un algoritmo en el que todos los valores tienen la misma probabilidad de occurir.

Las siguientes línea son solamente para ilustración. No es necesario comprenderlas.
*/

// ruido browniano
Pbrown(0, 1, step: 0.125).asStream.nextN(100).plot(name: \rudioBrowniano);
// ruido blanco
Pwhite(0, 1).asStream.nextN(100).plot(name: \ruidoBlanco);

// ¿Puedes apreciar la diferencia?








































/*

Señales multicanales

En SuperCollider, es sumamente sencillo producir señales stereo, cuadrafónicas, octofónicas y demás. Este proceso es llamado "Multichannel expansion" o "Expansión multicanal". Lo único que tenemos que hacer es pasar un array de frecuencias o amplitudes a un UGen y automáticamente el servidor asignará canales sucesivos a la señal

*/

// Cmd + m invoca el mezclador de SuperCollider

// Canales 0 y 1 (stereo)
{ PinkNoise.ar([0.1, 0.1]) }.play;

// Canales 0, 1, 2, 3 (cuadrafónico)
{ PinkNoise.ar([0.1, 0.1, 0.1, 0.1]) }.play;

// Canales 0 y 1 (stereo), canal 1 con menor amplitud
{ SinOsc.ar([440, 441], 0, [0.15, 0.01]) }.play;

// Canales 0 y 1 (stereo), con misma amplitud, y desviación de 1 hz en frecuencia
{ SinOsc.ar([440, 441], 0, 0.1) }.play;

// Canales 0 y 1 (stereo), canal 1 modulado
{ SinOsc.ar([440, 440 + SinOsc.ar(2, 0, 10)], 0, 0.1) }.play;

























/*
Otro método de generar señales multicanal, es creando copias de la señal.
Esto puede ser conseguido mediante el uso del operador "!", que crea un array
*/

1 ! 2; // crear un array que contiene dos 1
"hola" ! 10; // un array con 10 "hola"
{SinOsc.ar(440) ! 2}.play; // Una onda sinusoide en 2 canales



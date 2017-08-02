/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

10. Envolventes (Envelopes)
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
Cuando queremos moldear sonidos, necesitamos alguna forma de control para parámetros establecidos.
 Para este propósito, usamos "envelopes" o envolventes, que son curvas de control definidas con secuencias de arrays.

El generador para envolventes en SuperCollider es "EnvGen", mientras que el envolvente en sí es "Env". De ahora en adelante me referiré a envolventes con el anglicismo "envelopes", pues el nombre en castellano es my inusual.

Cuando creamos un envelope a ser usado en una señal, necesitamos definir una serie de:
- valores (los puntos por donde vamos a pasar)
- tiempo (el tiempo en el que atravesar dichos puntos)
- curvas (el tipo de interpolación a usar)

Observemos como crear estos valores en un objeto "Env" y hagamos un gráfico del resultado:
*/

// Parámetros importantes
Env(levels: valores, times: tiempos, curve: curvas);

// Aqui un envelope que va de 0 a 1 en 5 segundos con interpolación linear
Env([0, 1], [5], [\lin]).plot;

// Un envelope que va de 0.001 a 1 en 2.5 segundos y de 1 a 0.001 en 2.5 segundos con interpolación exponencial (curvas exponenciales nunca pueden tener un valor de 0 absoluto)
Env([0.001, 1, 0.001], [2.5, 2.5], ['exp']).plot;

// Un envelope que va de 0 a 1, de 1 a 0.5, se mantiene en 0.5 y luega va a 0 en 0.25, 0.25, 0.25, 0.25 segundos respectivamente, con una curva linear. Este es el envelope 'clásico':
// ataque, decaimiento, sostenimiento y relajación
Env([0, 1, 0.5, 0.5, 0.0], [0.25, 0.25, 0.25, 0.25], [\lin]).plot;

// La regla general es: [niveles], [duraciones], [curvas]
// Si hay 5 niveles, necesitas 4 duraciones y 4 curvas, o si todas las duraciones o curvas son iguales, puedes pasar 1 único valor respectivamente:
Env([0, 1, 0.5, 0.5, 0.0], 0.25, \lin).plot;



















// Existen, por conveniencia, envelopes pre-definidos:
Env.perc(attackTime: ataque, releaseTime: relajacion);
Env.triangle(dur: duración, level: nivel);
Env.asr(attackTime: ataque, sustainLevel: sostenimiento, releaseTime: relajación);
Env.adsr(attackTime: ataque, decayTime: decaimiento, sustainLevel: sostenimiento, releaseTime: relajación);
Env.circle(levels: niveles, times: tiempos)

// Los valores para "curve" o curva en todos estos envelops son bipolares, es decir, pueden ser positivos o negativos. A más o menos valor, más dramática es la curvatura:
Env.perc(attackTime: 0.001, releaseTime: 1, curve: -4).plot;
Env.perc(attackTime: 0.001, releaseTime: 1, curve: -10).plot;
Env.perc(attackTime: 0.001, releaseTime: 1, curve: 4).plot;
Env.perc(attackTime: 0.001, releaseTime: 1, curve: 10).plot;
// Explora un poco estos envelopes y familiarizate con sus parámetros.






















/*
El siguiente paso es usar generadores.

Los generadores nos permiten crear un objecto apto de interactuar con osciladores y al cual le podemos dar un acción a ejecutar cuando ha sido completado
*/
EnvGen.kr(Env.perc(0.001, 1), doneAction: 2); // "2" significa liberar la memoria de un synth (generador de sonido)
// nos vamos a limitar a usar doneAction: "0" (no hacer nada) y doneAction: "2" (liberar) en nuestro tutorial

// Evaluar esta línea no produce ningún sonido. El modo de usar este generador es multiplicándolo por una señal.





















// Generemos ahora sonidos con nuestros envelopes!
{ SinOsc.ar(440, 0, 1) * EnvGen.kr(Env.perc(0.001, 1), doneAction: 2) }.play;
{ SinOsc.ar(440, 0, 1) * EnvGen.kr(Env([0, 1, 0.5, 0.5, 0], [0.001, 0.1,0.25, 2], \lin), doneAction: 2) }.play;
{ SinOsc.ar(440, 0, 1) * EnvGen.kr(Env.triangle(2, 1), doneAction: 2) }.play;
{ SinOsc.ar(440, 0, 1) * EnvGen.kr(Env([0,1,0,1,0,1,0], 0.1), doneAction: 2) }.play;

/*
Todos estos synths se liberan a sí mismos de la memoria, gracias a doneAction: 2
Observa lo que ocurre en el monitor del lado inferior derecho, en los porcentajes, y en s(ynths) cuando usamos doneAction: 0
*/
{ SinOsc.ar(440, 0, 1) * EnvGen.kr(Env.perc(0.001, 1), doneAction: 0) }.play; // evalúa esto varias veces...

/*
Verás que la memoria y los synths en uso incrementan y se mantienen, pese a que nada suena.
Esto es un desperdicio de memoria, por esta razón, usamos doneAction: 2 cuando tenemos sonidos temporales.
De otro modo, tenemos que liberar esta memoria usando cmd + .
*/






















// Recuerdas cómo modular una onda? Podemos usar envelopes para hacerlo...
{ SinOsc.ar(EnvGen.kr(Env([100, 2000, 250], [0.25, 0.1], \exp), doneAction: 2)) }.play;

// Deconstrucción de este "one liner":
(
{
	var frecEnv = Env([100, 2000, 250], [0.25, 0.1], \exp); // de 100 a 2000 hz en 0.25secs y a 250hz en 0.1secs
	var gen = EnvGen.kr(frecEnv, doneAction: 2); // pasamos el envelope al generador de envelopes
	var sin = SinOsc.ar(freq: gen); // modular la frecuencia con el generador
	sin
}.play;
)

/*
Sin embargo, ¿notas algo en este ejemplo? ...el sonido hace un click al final... ¿por qué?

La razón es que estamos liberando el synth al terminar la modulación de frecuencia en 250hz pero no cambiamos nunca la amplitud del sonido. Cortamos la señal de 1.0 a 0.0 en seco, sin ninguna transición. Esto crea el click.

La solución es modular también la amplitud de forma que el sonido termine cuando esta es 0 y no cuando la frecuencia es 250hz.
*/
(
{
	var frecEnv = Env([100, 2000, 250], [0.25, 0.1], \exp); // envelope de frecuencia
	var ampEnv = Env([0, 1, 0], [0.25, 0.1], \lin); // envelope de amplitud
	var genFreq = EnvGen.kr(frecEnv, doneAction: 0); // generador de envelope para frecuencia
	var genAmp = EnvGen.kr(ampEnv, doneAction: 2); // generador de envelope para amplitud
	var sin = SinOsc.ar(freq: genFreq, mul: genAmp); // modular la frecuencia y la amplitud con los generadores
	sin
}.play;
)
/* Nota que usamos doneAction: 0 para la frecuencia, porque no nos importa que este generador se libere. En su lugar, hemos asignado doneAction al generador para la amplitud, de modo que se libere cuando la amplitud es 0.
Esto evita el click inicial
*/

// Otra forma de obtener lo mismo, es multiplicar el Envelope por la señal:
(
{
	var frecEnv = Env([100, 2000, 250], [0.25, 0.1], \exp);
	var ampEnv = Env([0, 1, 0], [0.25, 0.1], \lin);
	var genFreq = EnvGen.kr(frecEnv, doneAction: 0);
	var genAmp = EnvGen.kr(ampEnv, doneAction: 2);
	var sin = SinOsc.ar(freq: genFreq) * genAmp; // <- multiplicar la señal cambia la amplitud
	sin
}.play;
)






















/*
¿Puedes crear una onda sinusoide que vaya de 100 a 2000hz exponencialmente en 10 segundos pero que aparece y desaparece en 12 segundos?
*/














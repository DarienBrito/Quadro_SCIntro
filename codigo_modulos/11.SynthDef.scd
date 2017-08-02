/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

9. SynthDef(Envelopes)
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
¿Qué sucede si programamos un sonido y queremos re-utilizarlo luego, teniendo flexibildad en sus parámetros?

¿No sería conveniente contar con algún modo de crear definiciones de instrumentos sonoros a fin de formar una librería con la cual componer música o diseñar sonidos?

En SuperCollider, este concepto se realiza con la Clase "SynthDef". Es una definición de síntesis o, en palabras más simples, un instrumento musical.

Imaginemos un sonido... digamos que queremos un instrumento capaz de generar sonidos de espectro rico y percusivos:
*/
(
{
	var frec = 300; // frecuencia, prueva varios valores
	var lim = 500; // límite para el filtro, prueba varios valores
	var durEnv = 2; // duración del sonido, prueva varios valores
	var osc = Saw.ar(frec) * SinOsc.ar(1200); // modulación
	var filtro = LPF.ar(osc, lim); // filtro
	var env = EnvGen.kr(Env.perc(0.01, durEnv), doneAction: 2);
	filtro * env;
}.play;
)

// ¿Esto no es terriblemente intuitivo verdad?

//Podríamos crear en su lugar una función para tener más fácil acceso:
(
~sonido = {| frec = 300, frecMod = 1200, lim = 500, durEnv = 2| // por defecto
	{
		var osc = Saw.ar(frec) * SinOsc.ar(frecMod); // modulación
		var filtro = LPF.ar(osc, lim); // filtro
		var env = EnvGen.kr(Env.perc(0.01, durEnv), doneAction: 2);
		filtro * env;
	}.play;
};
)

// Varias sonidos con el mismo instrumento
~sonido.(320, 1200, 1000, 2);
~sonido.(320, 900, 5000, 2);
~sonido.(1320, 1200, 1000, 2);
~sonido.(320, 600, 1000, 0.1);

// El problema con esto es que la función final no nos dice demasiado. ¿Qué pasa si luego vemos nuestro código y no recordamos el orden de los valores? Tenemos que revisar la definición de la función otra vez y esto puede ser tedioso. Para resolver esto y añadir ademas una serie muy útil de funciones, existe la Clase SynthDef, que esta específicamente diseñada para hacer lo que estamos tratando de obtener:

(
SynthDef(\mySonido, { | frec = 220, frecMod = 1200, lim = 500, durEnv = 2, amp = 0.5 |
	var osc = Saw.ar(frec) * SinOsc.ar(frecMod); // modulación
	var filtro = LPF.ar(osc, lim); // filtro
	var env = EnvGen.kr(Env.perc(0.01, durEnv), doneAction: 2);
	var final = filtro * env;
	Out.ar(0, final); // Out nos permite determinar por qué bus sale la señal.
}).add; // add añade nuestro instrumento al Servidor de modo que pueda ser usado
)

// Para activar nuestro sonido, tenemos que usar Synth
//De esta forma, es mucho más conveniente saber qué parámetros estamos usando.
Synth(\mySonido, [\frec, 220, \frecMod, 1000, \lim, 12000, \durEnv, 1, \amp, 0.5]);

// Si no pasamos un valor específico para un parámetro, SuperCollider usa el valor por defecto
Synth(\mySonido, [\frec, 220, \frecMod, 400]); // modulando solo frecuencias
Synth(\mySonido, [\durEnv, 0.2]); // modulando solo duración

// ¿Preguntas? Veamos un ejemplo más simple:






















/*
- Synthdef necesita un nombre, en este caso "sin", el nombre puede ser una String o un símbolo. Los símbolos se crean con el prefijo \ o poniendo una palabra entre comillas singulares ' '
*/

// Por conveniencia, se acostumbre usar \ ya que es más rápido de escribir
SynthDef(\sin, { | freq = 320, envDur = 0.5 |
	var sin = SinOsc.ar(freq) * EnvGen.kr(Env.perc(0.01, envDur), doneAction: 2);
	Out.ar(0, sin); // Out es necesario en SynthDefs ya que determina el bus de salida a usar.
}).add; // add es necesario para que la definición exista en el servidor

// Esto bien podría escribirse:
SynthDef('sin', {etc})
// o
SynthDef("sin", {etc})

// Un poco más sobre Out.ar()...


//antes de empezar evalua las siguientes líneas en orden
s.quit; // apagar el servidor
s.options.numOutputBusChannels = 8; // activar 8 canales de salida
s.boot; // iniciar el servidor
// y finalmente presiona cmd + m que llama al mezclador

// Observa ahora lo que ocurre cuando definimos diferentes buses para esta señal:
(
var out = 0; // prueba diferentes valores en orden ascendente y observa el mezclador
{Out.ar(out, PinkNoise.ar(0.15))}.play;
)

// Como puedes ver, la señal es asignada a un bus de salida diferente. Si tuvieras por ejemplo un sistema cuadrafónico, podrías enviar la señal de audio a cada parlante individualmente.

// Cuando una señal es multicanal, Out asigna automáticamente los canales en secuencia partiendo del canal especificado. Por ejemplo la señal estéreo:
(
var out = 0;
{Out.ar(out, PinkNoise.ar([0.15, 0.15]))}.play; // estéreo
)
// empieza en el bus de salida 0 y automáticamente continua al canal 1

// Lo mismo ocurre si creamos una señal cuadrafónica:
(
var out = 0; // // prueba diferentes valores en orden ascendente y observa el mezclador
{Out.ar(out, PinkNoise.ar([0.15, 0.15, 0.15, 0.15]))}.play; // cuadrafónica
)
























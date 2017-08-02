/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

9. Síntesis Substractiva
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
Síntesis substractiva es el proceso de esculpir sonidos mediante reducción de frecuencias.
¡La mejor forma de explicar en qué consiste la síntesis substractiva es utilizando ruido!
Aqui una lista de UGens que generan ruidos de diversos tipos:
*/
WhiteNoise.ar(mul: amplitud); // ruido blanco, todo el espectro tiene el mismo poder
PinkNoise.ar(mul: amplitud); // ruido rosa, el espectro decae en poder 3db por cada octava
GrayNoise.ar(mul: amplitud); // rudio gris, se obtiene mediante modulación de bits
BrownNoise.ar(mul: amplitud); // ruido browniano, el espectro decae en poder 6db por octava
ClipNoise.ar(mul: amplitud); // rudio binario, los valores del espectro son 1 o -1

























/*
Al realizar síntesis substractiva usamos filtros. Estos se encargan de descartar frecuencias no deseadas en el espectro sonoro. A diferencia de síntesis aditiva esta técnica consiste en reducir el contenido de una señal.

Aqui una lista de los filtros más comunes:
*/

// Low Pass Filter (descarta agudos)
LPF.ar(in: señal, freq: límite, mul: amplitud);

// Hi Pass Filter (descarta graves)
HPF.ar(in: señal, freq: límite, mul: amplitud);

// Band Pass Filter (descarta frecuencias fuera de la banda especificada)
BPF.ar(in: señal, freq: límite, rq: ancho de banda, mul: amplitud);

// Notch Filter (descarta frecuencias dentro de la banda especificada)
Notch.ar(in: señal, freq: límite, rq: ancho de banda, mul: amplitud)

// Resonant Filter (filtro resonante en la banda especificada)
Resonz.ar(in: señal, freq: límite, bwr: ancho de banda, mul: amplitud)


























// Presiona cmd + alt + m para visualizar el espectro o evalua esta línea:
FreqScope.new(400, 200, 0, server: s); // Usar el Spectroscopio

// Ejemplos con cada filtro. Usa el mouse para modular la frecuencia
{ LPF.ar(WhiteNoise.ar(1), MouseX.kr(100, 20000)) * 0.25; }.play; // descarta agudos
{ HPF.ar(WhiteNoise.ar(1), MouseX.kr(100, 20000)) * 0.25; }.play; // descarta graves
{ BPF.ar(WhiteNoise.ar(1), MouseX.kr(100, 20000), 0.5) * 0.25; }.play;// descarta fuera de banda
{ Notch.ar(WhiteNoise.ar(1), MouseX.kr(100, 20000), 1) * 0.25; }.play; // descarga dentro de banda
{ Resonz.ar(WhiteNoise.ar(1), MouseX.kr(100, 20000), 0.1) * 0.25; }.play; // banda resonante



























// Realicemos ahora un programa simple modulando las frecuencias con osciladores
({
	var modFrec = VarSaw.kr(0.15).range(20, 15000); // onda triangular en el rango 20 a 15000
	var modBanda = SinOsc.ar(30).range(0.1, 2.0);
	var filtro = Resonz.ar(WhiteNoise.ar(1), modFrec, modBanda);
	var amp = 0.5;
	filtro * amp;
}.play
)























/*
Podemos moldear nuestros sonidos usando bandas específicas usando resonadores.
Recuerdas el objeto Klang? DynKlank es muy similar:
*/
DynKlank.ar(
	specificationsArrayRef: array de arrays [frecuencias, amplitudes, tiempo de resonancia],
	input: sonido al que filtrar,
	freqscale: escalador para las frecuencias,
	freqoffset: compensación para las frecuencias,
	decayscale: escalador para el tiempo de resonancia
)


























// Usando resonadores con ruido blanco
(
{
	var ruido = WhiteNoise.ar(1);
	var frecs = [300, 500, 800, 1600];
	var amps = [1, 1, 1, 1];
	var resonanciasT = [1, 1, 1, 1];
	var resonador = DynKlank.ar(`[frecs, amps, resonanciasT], ruido * 0.25);
	resonador * 0.015;
}.play;
)


























// Usando resonadores con impulsos al azar
(
{
	var impulsos = Dust.ar(40); // UGen, produce impulsos al azar
	var frecs = [300, 500, 800, 1600];
	var amps = [1, 1, 1, 1];
	var resonanciasT = [1, 1, 1, 1];
	var resonador = DynKlank.ar(`[frecs, amps, resonanciasT], impulsos * 0.25);
	resonador * 0.15;
}.play;
)



























(
// Reciclando las funciones que escribimos en el capítulo 8
~genVals = {|n|
	var frecs = n.collect{|i| rrand(200, 12000) }; // frecuencias al azar entre 80 y 12000hz
	var amps = n.collect{|i| 1.0.rand }; // valores al azar entre 0.0 y 1.0
	var resonanciaT = n.collect{|i| 1.0.rand }; // array de tiempos de resonancia al azar
	[frecs, amps, resonanciaT];
};

~resonadores = { | numero_resonadores, densidad = 40 |
	{
		var impulsos = Dust.ar(densidad);
		var valores = ~genVals.(numero_resonadores);
		var resonador = DynKlank.ar(`valores, impulsos * 0.25);
		resonador * 0.15;
	}.play;
};
)

~resonadores.(10, 20); // 10 resonadores, densidad 20
~resonadores.(1, 60); // 1 resonador, densidad 60
~resonadores.(40, 10);



























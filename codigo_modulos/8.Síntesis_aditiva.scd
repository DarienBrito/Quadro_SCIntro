/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

8. Síntesis Aditiva
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
Síntesis aditiva es el proceso de crear sonidos mediante superposición de ondas.

En teoría del sonido digital, cualquier sonido puede ser representado como una serie de sinusoides. Sintetizemos por ejemplo unos cuantos sonidos haciendo uso exclusivo de SinOsc y lo que hasta ahora hemos aprendido.
*/

(
{
	var n = 8; // numero de frecuencias deseadas
	var intervalo = 100; // intervalo entre frecuencias
	var amplitud = 1/n; // 1 sobre el total de osciladores
	var frecuencias = n.collect{|i| (i+1) * intervalo }; // calcular array de frecuencias del 100 al 1000
	var osciladores = frecuencias.collect{|frecuencia| SinOsc.ar(frecuencia) * amplitud };
	osciladores.sum; //Sumar todos los osciladores del array
}.play
)

/*
Observa que escalamos la amplitud de cada oscilador por (1 / total de osciladores) para evitar exceder 1.0. De otro modo, la señal se distorsionaría.

Prueba cambiando el valor para el número de frecuencias deseadas por otros valores...

Reto: Crees que puedes hacer que esta señal se convierta en stereo?
*/

























// Existe un UGen que genera un banco de ondas sinusoides, semejante al que acabamos de crear:
Klang.ar(
	specificationsArrayRef: array de arrays [frecuencias, amplitudes, fases],
	freqscale: escalador para frecuencias,
	freqoffset: compensación
);

// Generemos un sonido usando este UGen
({
	var frecuencias = [100, 200, 400, 800, 1600];
	var amplitudes = [1.0, 0.5, 0.25, 0.125] * 0.125; // escalar para el volumen
	var fases = [0,0,0,0];
	Klang.ar(`[frecuencias, amplitudes, fases]); // nótese el uso de " ` "
}.play;
)

/*
El símbolo ` le dice al interprete que al pasar el array no estamos pidiendo expansión multicanal, sino que estamos pasando un array de valores. Esto es importante pero es un rareza. No existen solo otros muy aislados casos en donde este símbolo es necesario.
*/

























/*
Podemos escribir ahora un generador para síntesis aditiva. Vamos a utilizar variables globales para hacer nuestro código re-utilizable en cualquier contexto. Recuerda que creamos estas variables con el símbolo ~
*/

(
// Función para generar valores al azar.
~genVals = {|n|
	var frecs = n.collect{|i| rrand(80, 12000) }; // frecuencias al azar entre 80 y 12000hz
	var amps = n.collect{|i| 1.0.rand }; // valores al azar entre 0.0 y 1.0
	var fases = n.collect{|i| 0.0 }; // array de fases en 0.0
	[frecs, amps, fases];
};
)

~genVals.value(10); // prueba


























// Ahora que tenemos esta función, la podemos usar en combinación con Klang
({
	var valores = ~genVals.value(10); // generar 10 valores distintos
	var sins = Klang.ar(`valores); // nótese el uso de " ` "
	sins = sins * 0.21; // escalar para reducir la amplitud
}.play;
)

/*
Cada vez que evaluamos esta expresión, tenemos un resultado distinto. Sin embargo tenemos
que cancelar el sonido manualmente con "cmd + ." cada vez que queremos otra evaluación... ¿no sería cómodo hacerlo automáticamente...?
*/

























/*
Añadamos ahora el UGen XLine que vimos en el capítulo "Modulación" para controlar la amplitud general del oscilador de modo que tenga una duración exacta y termine automáticamente. Ten en cuenta que curvas exponenciales no pueden terminar en 0.0 sino en un valor próximo (en el ejemplo, 0.001)
*/
({
	var valores = ~genVals.value(10);
	var sin = Klang.ar(`valores) * XLine.kr(1, 0.001, 1, doneAction: 2);
	sin = sin * 0.25;
}.play;
)
























// Hagamos ahora esta señal estéreo, y encapsulémosla en otra función, de modo que podamos usarla con mayor facilidad:
(
~bancoSins = { |numValores|
	{
		var valores = ~genVals.value(numValores);
		var sins = Klang.ar(`valores ! 2) * XLine.kr(1, 0.001, 1, doneAction: 2);
		sins * 0.25; // escalar para amplitud general
	}.play;
};
)
// Prueba los resultados con un número de frecuencias distinto...
~bancoSins.value(1);
~bancoSins.value(5);
~bancoSins.value(10);

/*
¿Puedes entender esta función claramente? Si no, revisa los conceptos previos, pronto haremos experimentos con música generativa y es fundamental entender los pasos que hemos tomado.
*/

// A propósito, un atajo para evaluar una función es omitir la palabra "value". Lo siguiente funciona:
~bancoSins.(10);


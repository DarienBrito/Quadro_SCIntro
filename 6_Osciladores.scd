/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

6. Osciladores
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
Hasta ahora hemos visto aspectos de programación, ¡pero lo que nos interesa realmente es hacer sonidos!

Antes que nada tenemos que iniciar el servidor, para hacerlo podemos:
*/

// Presionar cmd + b

Server.default.boot; // o evaluar esta línea.

s.boot; // o evaluar esta otra línea ("s" es un atajo para Server.default)

// Por esta razón, por regla general, es mejor no usar nunca la variable global "s", pues de otro modo, pierde su asignación automática para Server.default























// Una vez el servidor es inicializado, tratemos lo siguiente:
{ SinOsc.ar(320) }.play;

// Suena?

// cmd + . para apagar el sonido

























/*
¿Qué sucedió? Pues hemos utilizado una onda sinusoide con una frecuencia de 320hz.

En SC, se les llama UGens a los generadores de valores, sean estos osciladores o generadores de otro tipo.
*/

{ SinOsc.ar(320) }.play;

// Analicemos el cuerpo de la línea previa:
función{ oscilador.velocidad(argumentos del oscilador) }.play;

/*

El rango se refiere a la velocidad del oscilador. Si es algo que queremos escuchar, tiene que ser ar, si es en cambio un oscilador que vamos a usar para controlar algo más, entonces es kr

ar (audio rate) velocidad de audio
kr (control rate) velocidad de control

En general, el oído humano es capaz de distinguir frecuencias en el rango 20 a 20000hz

La amplitud de un oscilador audible es bipolar, es decir que va desde -mul a +mul
*/























// veamos ahora que otros argumentos soporta nuestro oscilador:
{ SinOsc.ar(freq: 320, phase: 0, mul: 1, add: 0) }.play;

/*
 freq = frecuencia de las oscilaciones por segundo
 phase = fase de la onda
 mul = amplitud de la onda
 add = compensación de la onda
*/

/*

"mul" tiene que ser máximo 1.0 si es una onda que vamos a escuchar. El valor 1 para mul quiere decir que la onda va desde -1.0 a 1.0, un valor mul de 2 quiere decir que va de -2.0 a 2.0

"add" se usa solamente en casos en los que queremos que la onda vaya en un rango específico, por ejemplo cuando es una onda de control

*/

// De momento, vamos a usar solamente los parámetros freq y mul

























// Otros osciladores:
Saw
Pulse
VarSaw
WhiteNoise
PinkNoise
GrayNoise

// Puedes experimentar por tu cuenta con estos osciladores? Si usas audífonos, ¡ten cuidado con el volumen!
























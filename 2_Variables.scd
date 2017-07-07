/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

2. Variables
__________________________________________________________________________*/

Recuerda:

cmd + enter -> ejecutar línea de código
cmd + shift + p -> borrar consola
cmd + d -> ayuda

(cmd = ctrl en Windows)



























// Variables son abreviaciones para un objecto. Se crean con el prefijo var
// Los paréntesis delimitan el contexto en el cual la variable es válida
(
var x = 1.0;
x.postln;
)






















// Existe un distinción importante entre declarar y asignar una variable.
// Declarar implica que la variable existe
// Asignar define un valor para la variable
(
var x; // Declaración de la variable x (existe pero no tiene nada dentro)
x = 10; // Asignación del valor 10 para la variable x (ahora x equivale a 10)
x.postln;
)


























// En este ejemplo, tenemos 2 variables de diferentes valores. Podemos usar esas
// variables para realizar operaciones
(
var x = 20;
var y = 30;
x.postln;
y.postln;
(x + y).postln;
)

























/*
Las variables son muy útiles porque nos ahorran el trabajo de re-escribir objetos
y nos permiten re-utilizar dichos objetos con una única identificación. Existen
variables predefinidas en SuperCollider, como el número PI
*/
(
var pi = 3.1415926535898; // resulta en un error
)

pi; // funciona porque pi ya está definida de antemano en SuperCollider


























/*
Una variable puede ser cualquier palabra siempre y cuando no empieze con una letra mayúscula o un número y siempre que no contenga caracteres especiales, como tildes.
*/

(
var parangaricutirimicuaro = 1;
parangaricutirimicuaro;
)

(
var Parangaricutirimicuaro = 1; // error. Mayúsculas son reservadas para Clases
parangaricutirimicuaro;
)

(
var 1Parangaricutirimicuaro = 1; // error. No puede iniciar con un número
parangaricutirimicuaro
)























/*
En SuperCollider existen 2 tipos de variables: locales y globales
*/























// Locales: requieren un contexto delimitado por paréntesis
(
var local = 1;
local.postln;
)

local; // error porque local no está definida en este contexto



























// Globales: funcionan en cualquier lugar independientemente del contexto

~global = 2;
~global.postln;

(
var local = 1;
local.postln;
~global.postln;
)


























// Existen variables globables predefinidas en SuperCollider. Estos son las letras del abecedario: a,b,c...z

a = 1;
b = 2;
z = 10;
a + b + z; // esta operación nos devuelve el resultado

























// Todo en SuperCollider es un objeto, por tanto, todo puede ser asignado a una variable.

a = 1; //número íntegro (integer)
b = 2.0 //número decimal (float)
c = "¡hola mundo!" // string
d = 'a' // caracter
e = { "¡hola mundo!".postln }; // función
f = a; // una variable puede tener el valor de otra variable
g = []; // array

// Existen muchos más objetos. En este curso introductorio, nos enfocaremos solamente en
// los previamente descritos.
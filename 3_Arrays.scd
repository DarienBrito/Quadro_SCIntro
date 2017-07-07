/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

3. Arrays
__________________________________________________________________________*/

Recuerda:

cmd + enter -> ejecutar línea de código
cmd + shift + p -> borrar consola
cmd + d -> ayuda

(cmd = ctrl en Windows)


























// Arrays son contenedores para varios objetos
x = [1,2,3,4];

























// Un Array puede contener cualquier tipo de objeto (incluso otro array)
// No todos los miembros de un array tienen que ser iguales.
x = [ 1, 2.0, "hola", {10.postln}, [1,2,3] ];
























// Los objetos dentro de un array pueden ser accedidos con un índice, es decir un número que describe la posición del objeto en el array. Recuerda que en programación, siempre contamos desde 0!

x = [1,2,3,4]; // cómo acceder al primer objeto?
x[0]; // el primer objeto tiene como índice 0
// Como accederías al número 4?

























/*
Existen varias formas en las que podemos crear un array. SuperCollider es un lenguaje muy versátil y conciso, usado para hacer música en tiempo real. Abreviar instrucciones es altamente deseable en este contexto.

Aquí algunas formas de crear un array cuyos miembros son los números de 0 al 9. No es necesario que entiendas de momento como todo esto funciona, lo importante es saber que
existen varias formas de hacer lo mismo en todo lenguaje de programación.
*/

x = [0,1,2,3,4,5,6,7,8,9]; // manualmente
y = (0..9); // con un loop abreviado
z = Array.fill(10,{|i| i }); // con un método de la clase Array
w = 10.collect{|i| i}; // con un método de Collection
t = Array(10) ; 10.do{|i| t.add(i)}; t; // con 3 instrucciones
























/*
Veamos ahora algunos métodos de la clase Array
*/
x = [1,2,3];
x.reverse;
x.scramble
x.pyramid
x.mirror;
x.stutter(2);
x.rotate(1);
x.wrapAt(3);

// ¿Cómo saber qué métodos existen para una determinada clase?
// Selecciona la clase Array y presiona cmd + d
Array

// Vemos ahora la página de ayuda para la clase Array. Si vamos a la sección "Instance Methods" encontraremos todos métodos para una instancia de la clase Array, entre ellos, los que hemos visto ahora. Experimenta un poco con estos métodos y mira si puedes entender como funcionan.

























/*
Ahora, ¿qué es una Clase y qué es una Instancia?

Una Clase, en pocas palabras, es la definición abstracta en la que un objeto se basa.

Una Instancia, en cambio, es uno de los objetos que pertenecen a una Clase.

Por ejemplo, imaginemos un gato. Un gato es un felino de 4 patas, mamífero, con una cola, dos orejas y bigotes. Esta es nuestra definición de la clase "Gato". Ahora, una instancia de un gato puede ser uno de color blanco, mientras que otra instancia puede ser otro gato de color negro. Ambos comparten la misma definición esencial de un Gato, pero tienen propiedades individuales.

En programación orientada a objetos, como en SuperCollider, los objetos se modelan de acuerdo a este concepto.
*/

// En concreto, una instancia de un array es:
x = [1,2,3];
// otra instancia es:
y = [10,20,30];
// y la Clase es:
Array

// Existen métodos para Clases y existen métodos para instancias.
Array.series(10,0,1); // Crea los números del 0 al 9
[1,2,3].series(10,0,1); // Error, porque esta es una instancia de array, no la clase Array

// Usando los archivos de ayuda, puedes experimentar con métodos de Clase para Array
// y métodos para instancias?
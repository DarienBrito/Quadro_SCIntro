/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

4. Funciones
__________________________________________________________________________*/

Recuerda:

cmd + enter -> ejecutar línea de código
cmd + shift + p -> borrar consola
cmd + d -> ayuda

(cmd = ctrl en Windows)

























// Una función es la definición de una serie de instrucciones encapsuladas en un objeto reutilizable.

(
var hola = { "¡hola mundo!".postln; }; // una función se define con { }
hola; // la variable hola es una función que al ser ejecutada imprime "¡hola mundo!"
)

// Cómo ejecutar la función?
(
var hola = { "¡hola mundo!".postln; };
hola.value; // .value es el método para ejecutar la función
)

























// Creemos ahora una función con una variable global que podemos reutilizar
f = { "desorden".scramble }; // randomizar el orden de la palabra "desorden" en cada ejecución
f.value; // evaluar múltiples veces para resultados distintos

























/*

El verdadero poder de una función es obvio cuando introducimos argumentos...

Argumentos son puertas mediante las cuales pasamos valores que son usados dentro de una
función.

Imaginemos que necesitamos un programa que divida CUALQUIER numero por 2 y lo multiplique luego por el valor de PI. Podemos encapsular la parte invariable de este algoritmo dentro de la función y crear una puerta para la parte variable, definiendo así una función reutilizable.
*/

// los argumentos se crean con la palabra clave: arg
f = {arg x; x / 2 * pi }; // nuestra función. Recuerda: el valor pi esta predefinido en SC

f.value(10); // Evaluar para 10
f.value(0.5); // Evaluar para 0.5
f.value(100);

























// Otro modo de escribir lo mismo
(
f = { arg x;
	x / 2 * pi;
};
)

// Esta sintaxis es preferible cuando las funciones son más complejas ya que de esta manera las instrucciones tienen más claridad
f.value(10);
f.value(0.5);
f.value(100);

























// Una última abreviación
(
f = { | x | // estos símbolos | | son la abreviación de "arg" y ";"
	x / 2 * pi;
};
)
f.value(10);
f.value(50);

























// Orden de ejecución

1 + 2 * 3; // ¿Qué resultado esperas? ¿9 o 7?

// En SuperCollider, el orden de ejecución es de izquierda a derecha, no existe le jerarquía aritmética habitual. Por ende, como buena práctica es mejor siempre ser específicos usando paréntesis.

(1 + 2) * 3; // 9
1 + (2 * 3); // 7





















// Múltiples argumentos: una función puede tener cuantos argumentos se deseen y pueden ser cualquier palabra siempre y cuando no empiezen con mayúsculas o números.
(
f = { arg nombre, apellido, edad;
	var n, a, e;
	n = "Mi nombre es: %".format(nombre); //el método format substituye % por un objeto dado
	a = "Mi apellido es: %".format(apellido);
	e = "Mi edad es %".format(edad);
	n.postln;
	a.postln;
	e.postln;
};
)

f.value("Darien", "Brito", 29);
f.value("Nikola", "Tesla", 87);



























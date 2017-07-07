/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

1. Hola mundo!
__________________________________________________________________________*/

Recuerda:

cmd + enter -> ejecutar línea de código
cmd + shift + p -> borrar consola
cmd + d -> ayuda

(cmd = ctrl en Windows)



















// El programa en cuestión:
"¡hola mundo!".postln;























¡hola mundo!; // qué ocurre si ejecutamos esta línea?
























"¡hola mundo!"; // y esta?
























/*
Solamente la segunda es una expresión valida. Vemos que nos devuelve ¡hola mundo! en la consola.
La primera no lo es porque no es patrón reconocible del lenguage. Todas las palabras son Strings y se definen dentro de " ".

Todo en SuperCollider es un objeto y un objeto siempre nos devuelve a sí mismo. Esto quiere decir que al ejecutar "hola mundo" estamos evaluando el objeto y como resultado nuestra consola nos muestra el objeto en sí: "hola mundo"
*/

























"¡hola mundo!".class; // ¿a qué clase pertenece este objeto?
























/*
Cuando queremos que un objeto haga algo usamos un punto y la instrucción deseada. La terminología adecuada es que estamos invocando un método del objecto. Por tanto la expresión:
*/

"¡hola mundo!".postln;

/*
imprime "hola mundo" en la consola, porque postln es un método válido de la clase String, a la que "hola mundo" pertenece. De igual forma, la expresión:
*/

"¡hola mundo!".class;

/*
imprime String en la consola, porque estamos pidiéndole al objeto "hola mundo" que ejecute el método class. Incidentalmente, todos los objectos en SuperCollider tienen un método class:
*/

1.class;
1.0.class;

/*
El ; en varios lenguajes de programación, marca el final de una instrucción. Cuando hay más de una instrucción, el ; es necesario.

¿Suena todo muy confuso o directamente ininteligible? ¡Por supuesto! lo estamos aprendiendo. Poco a poco, todo esto tendrá sentido.
*/

/


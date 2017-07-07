/*________________________________________________________________________

Quadro - plataforma para el conocimiento descentralizado
Introducción a SuperCollider
por Darien Brito

"http://cursos.darienbrito.com/works/supercollider-curso-introductorio/"

5. Loops
__________________________________________________________________________*/

Recuerda:

cmd + enter -> ejecutar línea de código
cmd + shift + p -> borrar consola
cmd + d -> ayuda

(cmd = ctrl en Windows)

























/*
Las máquinas son excepcionales en el hecho de que pueden realizar tareas repetitivas sin errores y sin límite, aparte de la capacidad de memoria máxima o entropía que experimentan.

Para aprovecharnos de esta capacidad, podemos usar bucles de ejecución, o "loops".

Existen varias formas de escribir loops:
*/

// 1. For loop (no muy idiomático en SuperCollider)
for(0, 9, {arg i; i.postln; }); //imprime los números de 0 al 9

// 2. While loop, un loop condicional, no muy idiomático tampoco
(
var i = 0;
while({i < 10}, {i.postln; i = i + 1; }); //imprime los números de 0 al 9
)

// 3. Iteración sobre Collection o número íntegro. La forma más idiomática en SC
10.do{arg i; i.postln }; //imprime los números de 0 al 9

























// Nos vamos a enfocar en la forma más idiomática de hacer loops, muy rara vez otra forma de escribir tendrá más sentido o será necesaria.

// El cuerpo de este loop es:
numero de iteraciones .do funcion{argumento;  acción  };

// En esta línea de código estamos diciendo:
"Haremos algo diez veces. Crea una puerta llamada i, por esta puerta pasan los numeros del 0 al número especificado, que en esta caso es diez. Cada vez que un nuevo número pasa se imprime"
10.do{arg i; i.postln }; //imprime los números de 0 al 9

// El nombre de argumento es irrelevante, puede ser:
10.do{arg num; num.postln };

// Recuerdas que hay una forma abreviada de crear un argumento?
10.do{| num | num.postln };

























// Ahora, hay algo interesante sobre esta construcción, pues nos permite iterar arrays
(
var miArray = [1,29,13,24];
miArray.do{|elemento| elemento.postln };
)

/*
Vemos que con este loop podemos acceder todos los elementos de un array cómodamente.

Con un segundo argumento, podemos llevar ademas la cuenta del número de iteración en la que estamos.
*/

(
var miArray = [1,29,13,24];
miArray.do{|elemento, cuenta| cuenta.postln; elemento.postln; };
)
// El resultado es:
//-----------------------------------------
0 // cuenta 0
1 // el elemento en la posición 0 del array
1 // cuenta 1
29 // el elemento en la posición 1 del array
2 // cuenta 2
13 // el elemento en la posición 2 del array
3 // cuenta 3
24 // el elemento en la posición 3 del array

// Ten en cuenta que SIEMPRE en un loop de este tipo, el PRIMER ELEMENTO REPRESENTA EL ELEMENTO y el SEGUNDO ARGUMENTO REPRESENTA LA CUENTA. Ambos argumentos pueden llamarse como sea, no hay nada especial acerca del nombre que se les dé.

























// Pongamos lo aprendido hasta este momento en práctica. Utilizando la función que escribimos en el la lección 4:

// Una función que divide cualquier número por 2 y lo multiplica por PI
(
f = { | x |
	(x / 2) * pi;
};
)

// Una serie de numeros en un array para utilizar con la función
x = [10,20,30,100,2,5,60,30];

// Un loop iterando sobre el array
x.do{|i| f.value(i).postln; }; //Recuerda, i es un argumento por el cual pasa cada elemento


























// Aquí otra forma de escribir lo mismo, dentro de un contexto local, quizás es así más claro:
(
var miArray = [10,20,30,100,2,5,60,30];
var func = {arg num;
	(num / 2) * pi;
};
miArray.do{arg elemento; func.value(elemento).postln; };
)

























// Con este conocimiento, podemos finalmente comenzar a hacer sonidos!











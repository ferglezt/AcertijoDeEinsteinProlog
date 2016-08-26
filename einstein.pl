%Definiendo el dominio de cada caracteristica
nacionalidad(X) :- member(X, [britanico, sueco, danes, noruego, aleman]).
color(X) :- member(X, [azul, amarilla, blanca, roja, verde]).
bebida(X) :- member(X, [agua, cerveza, leche, cafe, te]).
mascota(X) :- member(X, [pez, perro, pajaro, caballo, gato]).
cigarro(X) :- member(X, [brends, prince, pallmall, bluemaster, dunhill]).


%Definicion de la lista que conforma a una persona
persona([Nac, Col, Mas, Beb, Cig]) :- nacionalidad(Nac), color(Col), bebida(Beb), mascota(Mas), cigarro(Cig).

%Reglas para asignar elementos a una lista Persona
tiene(X, Persona) :- nacionalidad(X), Persona = [X, _, _, _, _].
tiene(X, Persona) :- color(X), Persona = [_, X, _, _, _].
tiene(X, Persona) :- mascota(X), Persona = [_, _, X, _, _].
tiene(X, Persona) :- bebida(X), Persona = [_, _, _, X, _].
tiene(X, Persona) :- cigarro(X), Persona = [_, _, _, _, X].

%Regla para corroborar coincidencias y añadirlas a una lista
tiene_lo_mismo(A, B, Grupo) :- tiene(A, Persona), tiene(B, Persona), member(Persona, Grupo).

%Otras Reglas
primer_casa(A, Grupo) :- tiene(A, Persona), Grupo = [Persona, _, _, _, _].
casa_de_enmedio(A, Grupo) :- tiene(A, Persona), Grupo = [_, _, Persona, _, _].
izquierda_de(A, B, Grupo) :- tiene(A, Persona1), tiene(B, Persona2), nextto(Persona1, Persona2, Grupo).
vecinos(A, B, Grupo) :- izquierda_de(A, B, Grupo); izquierda_de(B, A, Grupo).

%Solucion acorde a las pistas dadas

solucion(Grupo) :-
Grupo = [_, _, _, _, _], 

tiene_lo_mismo(britanico, roja, Grupo),
tiene_lo_mismo(sueco, perro, Grupo),
tiene_lo_mismo(danes, te, Grupo),
izquierda_de(verde, blanca, Grupo),
tiene_lo_mismo(verde, cafe, Grupo),
tiene_lo_mismo(pajaro, pallmall, Grupo),
tiene_lo_mismo(dunhill, amarilla, Grupo),
casa_de_enmedio(leche, Grupo),
primer_casa(noruego, Grupo),
vecinos(brends, gato, Grupo),
vecinos(dunhill, caballo, Grupo),
tiene_lo_mismo(bluemaster, cerveza, Grupo),
tiene_lo_mismo(aleman, prince, Grupo),
vecinos(noruego, azul, Grupo),
vecinos(brends, agua, Grupo),

maplist(persona, Grupo),
flatten(Grupo, Items),
is_set(Items).

tiene_pez :- solucion(X), member([Nac, _, pez, _, _], X), write(Nac), nl.

muestra_todo :- solucion(X), member(Y, X), write(Y), nl.


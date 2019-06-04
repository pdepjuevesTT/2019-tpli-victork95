padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(marge, bart).
padre(marge, lisa).
padre(marge, maggie).
padre(abraham, homero).
padre(abraham, herb).
padre(yuma, abraham).

hermanos(Hermano1, Hermano2):-
 padre(Padre, Hermano1),
 padre(Padre, Hermano2),
 Hermano1 \= Hermano2.

abuelo(Abuelo, Nieto):-
 padre(Padre, Nieto),
 padre(Abuelo, Padre).
 
pareja(Padre, Madre):-
 padre(Padre, Hijo),
 padre(Madre, Hijo),
 Padre \= Madre.
  
tio(Tio, Sobrino):-
 hermanos(Tio, Padre),
 padre(Padre, Sobrino).
 
primo(Persona1, Persona2):-
 padre(Padre1, Persona1),
 padre(Padre2, Persona2),
 hermanos(Padre1, Padre2),
 Persona1 \= Persona2.
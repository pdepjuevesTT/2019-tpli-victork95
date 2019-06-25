rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

%cocina(persona, plato, experiencia)
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5). 
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

inspeccionSatisfactoria(Restaurante):-
 trabajaEn(Restaurante, _),
 rata(_, Restaurante).
 
chef(Empleado, Restaurante):-
 trabajaEn(Restaurante, Empleado),
 cocina(Empleado, _, _).

chefcito(Rata):-
 rata(Rata, Restaurante),
 trabajaEn(Restaurante, linguini).

cocinaBien(Persona, Plato):-
 cocina(Persona, Plato, Experiencia),
 Experiencia > 7.

cocinaBien(remy, Plato):-
 cocina(_, Plato, _).

encargadoDe(Encargado, Plato, Restaurante):-
 cocina(Encargado, Plato, Experiencia),
 chef(Encargado, Restaurante),
 forall((cocina(OtroEncargado, Plato, OtraExperiencia), Encargado \= OtroEncargado, chef(OtroEncargado, Restaurante)), Experiencia >= OtraExperiencia).

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).

saludable(Plato):-
 plato(Plato, entrada(ListaDeIngredientes)),
 length(ListaDeIngredientes, Numero),
 Calorias is Numero * 15,
 Calorias < 75.

saludable(Plato):-
 plato(Plato, principal(Guarnicion, MinutosDeCoccion)),
 caloriasDeGuarnicion(Guarnicion, CaloriasGuarnicion),
 Calorias is CaloriasGuarnicion + 5 * MinutosDeCoccion,
 Calorias < 75.

saludable(Plato):-
 plato(Plato, postre(Calorias)),
 Calorias < 75.
saludable(Plato):-
 plato(Plato, postre(_)),
 grupo(Plato).
 
caloriasDeGuarnicion(papasFritas, 50).
caloriasDeGuarnicion(pure, 20).
caloriasDeGuarnicion(ensalada, 0).

grupo(hola).

especialista(Restaurante, Plato):-
 forall(chef(Empleado,Restaurante), cocinaBien(Empleado, Plato)).

criticaPositiva(Restaurante, antonEgo):-
 inspeccionSatisfactoria(Restaurante),
 especialista(Restaurante, ratatouille).

criticaPositiva(Restaurante, christophe):-
 inspeccionSatisfactoria(Restaurante),
 findall(Chef, chef(Chef, Restaurante), ListaDeChefs),
 length(ListaDeChefs, CantidadDeChefs),
 CantidadDeChefs > 3.
 
criticaPositiva(Restaurante, cormillot):-
 inspeccionSatisfactoria(Restaurante),
 forall((chef(Empleado, Restaurante), cocina(Empleado, Plato, _), plato(Plato, Tipo)), (saludable(Plato), tieneZanahoria(Tipo))).
 
tieneZanahoria(postre(_)).
tieneZanahoria(principal(_, _)).
tieneZanahoria(entrada(ListaDeIngredientes)):-
 member(zanahoria, ListaDeIngredientes).

 
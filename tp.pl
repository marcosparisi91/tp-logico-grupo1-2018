% 1. 2. 3. )

provieneDe(pan, trigo).
provieneDe(jamon, cerdo).
provieneDe(leche, vaca).
provieneDe(queso, leche).
provieneDe(fondeau, queso).

esAnimal(vaca).
esAnimal(cerdo).

esLacteo(Alimento) :- 
    provieneDe(Alimento,leche).

tieneGluten(Alimento) :- 
        provieneDe(Alimento,trigo).
        
esDerivadoDeAnimal(Alimento) :-
    esAnimal(Algo),
    provieneDe(Alimento,Algo).

    
esDerivadoDeAnimal(Alimento) :-
    provieneDe(Alimento,Derivado),
    esDerivadoDeAnimal(Derivado).


% 4. 5. )

%Primera forma
%%sandwichJQ(jamon).
%%sandwichJQ(queso).
%%sandwichJQ(pan).
%%wokVegetales(arroz).
%%wokVegetales(pan).
%%wokVegetales(zanahoria).
%%wokVegetales(cebolla).
%%wokVegetales(morron).

%Segunda forma
%%plato(sandwichJQ(jamon, queso, pan)).
%%plato(wokVegetales(arroz,pan,cebolla,zanahoria,morron)).

%Tercera forma
plato(sandwichJQ, jamon).
plato(sandwichJQ, queso).
plato(sandwichJQ, pan).
plato(wokVegetales, arroz).
plato(wokVegetales, pan).
plato(wokVegetales, cebolla).
plato(wokVegetales, zanahoria).
plato(wokVegetales, morron).


veganos(Plato):-
    forall(plato(Plato,Alimento), not(esDerivadoDeAnimal(Alimento)) ).

celiacos(Plato):-
    forall(plato(Plato, Alimento), not(tieneGluten(Alimento)) ).

analia(Plato):-veganos(Plato).

benito(Plato):-celiacos(Plato).

claudia(Plato).
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
sandwichJQ(jamon).
sandwichJQ(queso).
sandwichJQ(pan).
wokVegetales(arroz).
wokVegetales(pan).
wokVegetales(zanahoria).
wokVegetales(cebolla).
wokVegetales(morron).

veganos(Alimento) :- not(esDerivadoDeAnimal(Alimento)).

celiacos(Alimento) :- not(tieneGluten(Alimento)).

omnivoros(Alimento).



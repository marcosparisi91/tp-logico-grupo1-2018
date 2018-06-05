% 1. 2. 3. )

provieneDe(pan, trigo).
provieneDe(jamon, cerdo).
provieneDe(leche, vaca).
provieneDe(queso, leche).
provieneDe(fondeau, queso).

esAnimal(vaca).
esAnimal(cerdo).

esLacteo(Alimento) :- 
    esDerivadoDe(Alimento,leche).

tieneGluten(Alimento) :- 
    esDerivadoDe(Alimento,trigo).
        
esDerivadoDeAnimal(Alimento) :-
    esAnimal(Algo),
    esDerivadoDe(Alimento,Algo).
    
esDerivadoDe(Alimento,AlimentoDelQueDeriva):-
	provieneDe(Alimento,AlimentoDelQueDeriva).

esDerivadoDe(Alimento,AlimentoDelQueDeriva):-
	provieneDe(Alimento,AlimentoDelQueProviene),
	AlimentoDelQueProviene \= AlimentoDelQueDeriva,
	provieneDe(AlimentoDelQueProviene,AlimentoDelQueDeriva).


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

% 6 , 7. )

esRecomendable(dietaVegana,hipertension).
esRecomendable(dietaVegana,colesterolAlto).

esRecomendable(dietaCeliaca,intoleranteAlGluten).
esRecomendable(dietaCeliaca,obesidad).

diagnostico(analia,diagnosticoDePrevension( enfermedad(obesidad,5) ) ).
diagnostico(benito,diagnosticoDePrevension( enfermedad(hipertension,4) ) ).
diagnostico(claudia,diagnosticoCritico( enfermedad(colesterol,3) ) ).

correRiesgo(Persona):- 
	diagnostico(Persona,Diagnostico) , 
	esPeligroso(Diagnostico).

esPeligroso(diagnosticoDePrevension( enfermedad(_,Nivel))):- mayorA10( Nivel * 2 ).
esPeligroso(diagnosticoCritico( enfermedad(_,Nivel))):- mayorA10( Nivel * 5 ).

mayorA10(X):- X > 10 .

%diagnosticoDePrevension( enfermedad(obesidad,5) )
%diagnosticoDePrevension( enfermedad(hipertension,4) )
%diagnosticoCritico( enfermedad(colesterol,3) )

%peligrosidad(diagnosticoDePrevension( enfermedad(hipertension,4) )).
%esPeligroso(diagnosticoDePrevension( enfermedad(hipertension,4) )).

:- begin_tests(es_lacteo_fondeau).
test(es_lacteo_fondeau):- esLacteo(fondeau).
:- end_tests(es_lacteo_fondeau).

:- begin_tests(diagnostico_prevencion_obesidad_5_da_10).
test(diagnostico_prevencion_obesidad_5_da_10):- diagnosticoDePrevension(analia,enfermedad(obesidad,5),Peligrosidad) , Peligrosidad is 10.
:- end_tests(diagnostico_prevencion_obesidad_5_da_10).

:- begin_tests(diagnostico_prevencion_hipertension_4_da_8).
test(diagnostico_prevencion_hipertension_4_da_8):- diagnosticoDePrevension(benito,enfermedad(hipertension,4),Peligrosidad) , Peligrosidad is 8.
:- end_tests(diagnostico_prevencion_hipertension_4_da_8).

:- begin_tests(diagnostico_critico_colesterol_3_da_15).
test(diagnostico_critico_colesterol_3_da_15):- diagnosticoCritico(claudia,enfermedad(colesterol,3),Peligrosidad) , Peligrosidad is 15.
:- end_tests(diagnostico_critico_colesterol_3_da_15).


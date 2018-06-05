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

esVegano(Plato):-
    forall(plato(Plato,Alimento), not(esDerivadoDeAnimal(Alimento)) ).

esCeliaco(Plato):-
    forall(plato(Plato, Alimento), not(tieneGluten(Alimento)) ).

aplicaDieta(dietaVegana):-
	forall(plato(Plato,Alimento), not(esDerivadoDeAnimal(Alimento)) ).

aplicaDieta(dietaCeliaca):-
    forall(plato(Plato, Alimento), not(tieneGluten(Alimento)) ).

analia(Plato):-veganos(Plato).
benito(Plato):-celiacos(Plato).
claudia(Plato).

% 6 , 7. )

esRecomendable(dietaVegana,enfermedad(hipertension,_)).
esRecomendable(dietaVegana,enfermedad(colesterol,_)).

esRecomendable(dietaCeliaca,enfermedad(intoleranciaAlGluten,_)).
esRecomendable(dietaCeliaca,enfermedad(obesidad,_)).

diagnostico(analia,diagnosticoDePrevension( enfermedad(obesidad,5) ) ).
diagnostico(benito,diagnosticoDePrevension( enfermedad(hipertension,4) ) ).
diagnostico(claudia,diagnosticoCritico( enfermedad(colesterol,3) ) ).

correRiesgo(Persona):- 
	diagnostico(Persona,Diagnostico) , 
	esPeligroso(Diagnostico).

esPeligroso(diagnosticoDePrevension( enfermedad(_,Nivel))):- mayorIgualA10( Nivel * 2 ).
esPeligroso(diagnosticoCritico( enfermedad(_,Nivel))):- mayorIgualA10( Nivel * 5 ).

mayorIgualA10(X):- X >= 10 .

recomendarPlatos(Persona,PlatosRecomendados):-
	diagnostico(Persona,Diagnostico) ,
	obtenerDietaRecomendable(Diagnostico,DietaRecomendable).
	obtenerPlatosQueCumpleConLaDieta(DietaRecomendable,PlatosRecomendados).

obtenerDietaRecomendable(diagnosticoDePrevension( enfermedad(Enfermedad,_)),DietaRecomendable):-
	esRecomendable( DietaRecomendable , enfermedad(Enfermedad,_) ).

obtenerDietaRecomendable(diagnosticoCritico( enfermedad(Enfermedad,_)),DietaRecomendable):-
	esRecomendable( DietaRecomendable , enfermedad(Enfermedad,_) ).

obtenerPlatosQueCumpleConLaDieta(dietaVegana,Plato):- esVegano(Plato).
obtenerPlatosQueCumpleConLaDieta(dietaCeliaca,Plato):- esCeliaco(Plato).

:- begin_tests(es_lacteo_fondeau).
test(es_lacteo_fondeau):- esLacteo(fondeau).
:- end_tests(es_lacteo_fondeau).

:- begin_tests(diagnostico_prevencion_obesidad_5_da_10_es_peligroso).
test(diagnostico_prevencion_obesidad_5_da_10_es_peligroso):- esPeligroso(diagnosticoDePrevension( enfermedad(obesidad,5) )).
:- end_tests(diagnostico_prevencion_obesidad_5_da_10_es_peligroso).

:- begin_tests(diagnostico_prevencion_hipertension_4_da_8_no_es_peligroso).
test(diagnostico_prevencion_hipertension_4_da_8_no_es_peligroso,fail):- esPeligroso(diagnosticoDePrevension( enfermedad(hipertension,4) )).
:- end_tests(diagnostico_prevencion_hipertension_4_da_8_no_es_peligroso).

:- begin_tests(diagnostico_critico_colesterol_3_da_15_es_peligroso).
test(diagnostico_critico_colesterol_3_da_15_es_peligroso):- esPeligroso(diagnosticoCritico(claudia,enfermedad(colesterol,3)).
:- end_tests(diagnostico_critico_colesterol_3_da_15_es_peligroso).

:- begin_tests(corre_riesgo_analia).
test(corre_riesgo_analia_falso):- correRiesgo(analia).
:- end_tests(corre_riesgo_analia_falso).

:- begin_tests(corre_riesgo_benito_falso).
test(corre_riesgo_benito_falso,fail):- correRiesgo(benito).
:- end_tests(corre_riesgo_benito_falso).

:- begin_tests(corre_riesgo_claudia).
test(corre_riesgo_claudia):- correRiesgo(claudia).
:- end_tests(corre_riesgo_claudia).

:- begin_tests(dieta_para_diagnostico_de_prevension_de_obesidad_es_celiaca).
test(dieta_para_diagnostico_de_prevension_de_obesidad_es_celiaca):- obtenerDietaRecomendable(diagnosticoDePrevension( enfermedad(obesidad,5) ),DietaRecomendable) , DietaRecomendable is dietaCeliaca.
:- end_tests(dieta_para_diagnostico_de_prevension_de_obesidad_es_celiaca).

:- begin_tests(dieta_para_diagnostico_de_prevension_de_hipertension_es_celiaca).
test(dieta_para_diagnostico_de_prevension_de_hipertension_es_celiaca):- obtenerDietaRecomendable(diagnosticoDePrevension( enfermedad(hipertension,4) ),DietaRecomendable) , DietaRecomendable is dietaCeliaca.
:- end_tests(dieta_para_diagnostico_de_prevension_de_hipertension_es_celiaca).

:- begin_tests(dieta_para_diagnostico_critico_de_colesterol_es_vegana).
test(dieta_para_diagnostico_critico_de_colesterol_es_vegana):- obtenerDietaRecomendable(diagnosticoCritico( enfermedad(colesterol,3) ),DietaRecomendable) , DietaRecomendable is dietaVegana.
:- end_tests(dieta_para_diagnostico_critico_de_colesterol_es_vegana).
